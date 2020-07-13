Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A922CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C41120674
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U8VX1SUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgGMHl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMHl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:41:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB75C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bPajX5Treeh+4bzoV47DvWM3Nc4JTIylifw8GbEyYCY=; b=U8VX1SUmg6mZHS7Qi7ZHqI9e3w
        gp7+f4MM6XnAW2BsqGIbm9m/JQfNSMjepGbHUuF+cBPqmDvPDPHlY3r9OloxnqMLXZVFd9PDhrPej
        sZUJ/YLhMtpF9OO5EDlk/hXbV+RbuZGuFKFgXTK7a8vWjsH/yN41yH17btq+Hi+7RF0U5f9VAPgXO
        zrfiraxSyz7UPx5VLmZOQyyhJK8JsP+ytuFqqFlZvnC8GN/D95uKOWjOjCmY4qGwCHq5nj+4wB12J
        U0Cc/79e6qQrWY68vdotjpCvEMC8VRgEJIsQaQ3AwV/Sj88Pyn5Y1jtWX3HWKOpK3IjGLXmLkZK76
        1F3NSm5A==;
Received: from 089144201169.atnat0010.highway.a1.net ([89.144.201.169] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jut63-0000nj-6g; Mon, 13 Jul 2020 07:41:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] debugfs: add a proxy stub for ->read_iter
Date:   Mon, 13 Jul 2020 09:37:29 +0200
Message-Id: <20200713073729.875584-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200713073729.875584-1-hch@lst.de>
References: <20200713073729.875584-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs registrations typically go through a set of proxy ops to deal
with refcounting, which need to support every method that can be
supported.  Add ->read_iter to the proxy ops to prepare for seq_file to
be switch to ->read_iter.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/debugfs/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 8ba32c2feb1b73..dcd7bdaf67417f 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -231,6 +231,10 @@ FULL_PROXY_FUNC(read, ssize_t, filp,
 			loff_t *ppos),
 		ARGS(filp, buf, size, ppos));
 
+FULL_PROXY_FUNC(read_iter, ssize_t, iocb->ki_filp,
+		PROTO(struct kiocb *iocb, struct iov_iter *iter),
+		ARGS(iocb, iter));
+
 FULL_PROXY_FUNC(write, ssize_t, filp,
 		PROTO(struct file *filp, const char __user *buf, size_t size,
 			loff_t *ppos),
@@ -286,6 +290,8 @@ static void __full_proxy_fops_init(struct file_operations *proxy_fops,
 		proxy_fops->llseek = full_proxy_llseek;
 	if (real_fops->read)
 		proxy_fops->read = full_proxy_read;
+	if (real_fops->read_iter)
+		proxy_fops->read_iter = full_proxy_read_iter;
 	if (real_fops->write)
 		proxy_fops->write = full_proxy_write;
 	if (real_fops->poll)
-- 
2.26.2

