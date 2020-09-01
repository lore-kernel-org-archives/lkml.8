Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EBFC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385862100A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598973859;
	bh=tVS2ZQ+Ws0jCOq4RwVouKorzH4DD8uDRN4VgE2azIpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wi3gg0QfZp8Dw6C2gupabHMRR+NyqcJb4X18Aqgbc4Sj2S2oSvkz0orabur81y6ei
	 VbAKLRvglwbigJl7k/GOhVcvg4u1LkJ0xqHcNRDqmCYQAnuY2zw9TH7OljaIep1aHj
	 x8iZvY6nWAr4ZrKEplfMmuYQOSQ/cifaPmKmxPVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgIAPYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:24:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729154AbgIAPVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:21:53 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F64D20BED;
        Tue,  1 Sep 2020 15:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973712;
        bh=tVS2ZQ+Ws0jCOq4RwVouKorzH4DD8uDRN4VgE2azIpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gAzbxd/Ar9W1DejTQAF2YQE5zG7ExDbZRfAFAR+rmtJjWQTiuu7/MFJ8oltp50RKG
         hjcBHJi379HWzMKy10b4UykI9AplbPJtCdVABvoKFpXMRL9gqW+hs6da4JF9rReEFH
         QfISuZb4/UssaYhQ1/5bQM7p+iHRTjxClox56DgU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 017/125] blktrace: ensure our debugfs dir exists
Date:   Tue,  1 Sep 2020 17:09:32 +0200
Message-Id: <20200901150935.417995417@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
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



