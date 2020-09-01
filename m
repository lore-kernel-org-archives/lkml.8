Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCA3C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE7A221582
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974697;
	bh=su/76TCn6qViBS0aWPpZVwiMsbp5KTmEEehwTuWj/IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d5J48rIUyvO2sjE4FKuLVmVBBecQHAe9CbUWiqOMjpGxl6NafIxjKXCQ6eJqvVgpb
	 kjvr6I5I08y27pCYf2fsEwcKwWVl6kzJh9vvwm3CNI75LT2vfSIORCwSty5winmGN7
	 rNfXP+2zbUNWEhqNWt/qhf9rwwMYAHpGzi3toy3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbgIAPiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbgIAPgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:36:44 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C5E3205F4;
        Tue,  1 Sep 2020 15:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974604;
        bh=su/76TCn6qViBS0aWPpZVwiMsbp5KTmEEehwTuWj/IU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJNLjeDxxjPNlfpDqf3adVCpwswjoW0f5fIslQQTaklyK0ZYdw2FiEj/duUNU1hUT
         8clR3ElIZOSijqq7m8lPFKNlvZFG71yfuwFzskXCDkw/4j20LjWXEog09mKs3Hulkb
         66jE6R5KFlUCakXFlxN6v6g/fJumO6gEZJavbMPE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 017/255] blktrace: ensure our debugfs dir exists
Date:   Tue,  1 Sep 2020 17:07:53 +0200
Message-Id: <20200901151001.605590018@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

[ Upstream commit b431ef837e3374da0db8ff6683170359aaa0859c ]

We make an assumption that a debugfs directory exists, but since
this can fail ensure it exists before allowing blktrace setup to
complete. Otherwise we end up stuffing blktrace files on the debugfs
root directory. In the worst case scenario this *in theory* can create
an eventual panic *iff* in the future a similarly named file is created
prior on the debugfs root directory. This theoretical crash can happen
due to a recursive removal followed by a specific dentry removal.

This doesn't fix any known crash, however I have seen the files
go into the main debugfs root directory in cases where the debugfs
directory was not created due to other internal bugs with blktrace
now fixed.

blktrace is also completely useless without this directory, so
this ensures to userspace we only setup blktrace if the kernel
can stuff files where they are supposed to go into.

debugfs directory creations typically aren't checked for, and we have
maintainers doing sweep removals of these checks, but since we need this
check to ensure proper userspace blktrace functionality we make sure
to annotate the justification for the check.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/blktrace.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 588e8e3960197..1bd6563939e59 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -536,6 +536,18 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 #endif
 		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
 
+	/*
+	 * As blktrace relies on debugfs for its interface the debugfs directory
+	 * is required, contrary to the usual mantra of not checking for debugfs
+	 * files or directories.
+	 */
+	if (IS_ERR_OR_NULL(dir)) {
+		pr_warn("debugfs_dir not present for %s so skipping\n",
+			buts->name);
+		ret = -ENOENT;
+		goto err;
+	}
+
 	bt->dev = dev;
 	atomic_set(&bt->dropped, 0);
 	INIT_LIST_HEAD(&bt->running_list);
-- 
2.25.1



