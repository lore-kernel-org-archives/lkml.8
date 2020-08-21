Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6011C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA2920702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598029396;
	bh=tVS2ZQ+Ws0jCOq4RwVouKorzH4DD8uDRN4VgE2azIpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tdEC39bOzicVr6HfxuGQguN8QZExsSVf6yF43MACGwKCW8gw4oru+7zS9DGyw0Xos
	 uPTBv4kjr/XSn126tsDmRpUacgdoGMPtcbF+70cmvtflf059N3eZTBQG47zl3owE37
	 I09tJQkCQyRbNWMI9vdrgOLCyeMdClLYf4oV083U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgHURDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbgHUQS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:18:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D80B22CA1;
        Fri, 21 Aug 2020 16:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026699;
        bh=tVS2ZQ+Ws0jCOq4RwVouKorzH4DD8uDRN4VgE2azIpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SWSHaJnI9rOpVejrWmnHBggsik+R1eSmzi0syZhYa1vxR5KynjQrb8ZRcqvauozVr
         YwI4wDKraMxOvpJ5TN8r83WM/9YDLO3p93ZvqvTcFtRHT9GJW0jf1BkjhPD0PHShuw
         Etu3a+1oM7aYOzjvUaIj3uc8+cpImph3zjdI+fPQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 09/38] blktrace: ensure our debugfs dir exists
Date:   Fri, 21 Aug 2020 12:17:38 -0400
Message-Id: <20200821161807.348600-9-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161807.348600-1-sashal@kernel.org>
References: <20200821161807.348600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 7a4ca2deb39bc..1442f6152abc2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -529,6 +529,18 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!dir)
 		goto err;
 
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

