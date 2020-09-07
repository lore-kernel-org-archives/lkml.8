Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73294C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3824421481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RJ5s9Maq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgIGP0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbgIGPVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:21:19 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC66AC061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 08:21:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q4so696970pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 08:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=dDm50BpVZuQLGYSLkY4kWAnKOu+NYX3j/JL82/yvZsw=;
        b=RJ5s9MaqhEHO5V2IfABHfKScBVvIYJl1uOESsM7TA208JtB/i5pnrUk2euFVdZxGtL
         SCLkhk/eIrtAkx1cLJKi22+NOfrmPt8QkuNR46/J1HRaTDtu9vJfUADlOkWbjk++iTYE
         bSkFWGf+ueXnY2ceeXi2ZlMTUPg4CCwa+AoxfIqrtJv7WGlvtpdjBdUxsiVe4N94hREX
         Jf+nv+PpTodpJOgDl6Y593FKFbDcoNzI15eNc2927OzNd0UzoaHGxt1n44c6sbh4zpg9
         6BSJ5eKGkCwCFAbSPTM4gECqlw7yqcIm53BmXklX/vWRaWdjxmxLGv1jRvE213dVfdOn
         BVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=dDm50BpVZuQLGYSLkY4kWAnKOu+NYX3j/JL82/yvZsw=;
        b=f3v/gW11o8t7t/wiu08Dfl3ksANUsqpzLuWRd9peS8X8HOT1SnYdPFgiXe5bIUh3UY
         ctuVGNPT9WQMH8bvqBM0e30baICZ+LLDz9Z5q0ysN59WyvDUxEA+NC2W/snJGDOtnsEr
         AKWw3BLupWxrHn35YMnqD+j8V1+PD/C/UVFuCO/e1tq0boeUI29rJgfGIDd1q+5PvpXG
         FsbSygjZw0A84OZW3VvO3/hcoD6U7+a/HEph/Uf3cStnQGihKXg3mLsjWQ+hvT87ObeM
         6nBv1W72+A4pkMnar3qoIsxCvivvBxI2zkT7hszjVzhVOLPrZ2pVS9cwV8EnLhoo/g0n
         E5/A==
X-Gm-Message-State: AOAM533RpmnUkG7bhn4THTJpqMWz+PXRyrqQRCwbPigGBQO7J62ncFam
        8Cy9ixiMP4l4JDr4FDdlyuTNBLQ2EJ+E4q/T
X-Google-Smtp-Source: ABdhPJzGXrFSoWODyKXpSqClx55jfJGJNH5FkVEzm0uYE4X+iByW1zd19ffrfKEOs/9XX5s+bReuUQ==
X-Received: by 2002:a17:90a:de17:: with SMTP id m23mr21430575pjv.51.1599492065082;
        Mon, 07 Sep 2020 08:21:05 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id f9sm2399964pjq.26.2020.09.07.08.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 08:21:04 -0700 (PDT)
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] pipe: honor IOCB_NOWAIT
Message-ID: <cedfa436-47a3-7cbc-1948-75d0e28cfdc5@kernel.dk>
Date:   Mon, 7 Sep 2020 09:21:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pipe only looks at O_NONBLOCK for non-blocking operation, which means that
io_uring can't easily poll for it or attempt non-blocking issues. Check for
IOCB_NOWAIT in locking the pipe for reads and writes, and ditto when we
decide on whether or not to block or return -EAGAIN.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

If this is acceptable, then I can add S_ISFIFO to the whitelist on file
descriptors we can IOCB_NOWAIT try for, then poll if we get -EAGAIN
instead of using thread offload.

diff --git a/fs/pipe.c b/fs/pipe.c
index 60dbee457143..3cee28e35985 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -82,6 +82,13 @@ void pipe_unlock(struct pipe_inode_info *pipe)
 }
 EXPORT_SYMBOL(pipe_unlock);
 
+static inline bool __pipe_lock_nonblock(struct pipe_inode_info *pipe)
+{
+	if (mutex_trylock(&pipe->mutex))
+		return true;
+	return false;
+}
+
 static inline void __pipe_lock(struct pipe_inode_info *pipe)
 {
 	mutex_lock_nested(&pipe->mutex, I_MUTEX_PARENT);
@@ -244,7 +251,12 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		return 0;
 
 	ret = 0;
-	__pipe_lock(pipe);
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!__pipe_lock_nonblock(pipe))
+			return -EAGAIN;
+	} else {
+		__pipe_lock(pipe);
+	}
 
 	/*
 	 * We only wake up writers if the pipe was full when we started
@@ -344,7 +356,8 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			break;
 		if (ret)
 			break;
-		if (filp->f_flags & O_NONBLOCK) {
+		if ((filp->f_flags & O_NONBLOCK) ||
+		    (iocb->ki_flags & IOCB_NOWAIT)) {
 			ret = -EAGAIN;
 			break;
 		}
@@ -432,7 +445,12 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	if (unlikely(total_len == 0))
 		return 0;
 
-	__pipe_lock(pipe);
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!__pipe_lock_nonblock(pipe))
+			return -EAGAIN;
+	} else {
+		__pipe_lock(pipe);
+	}
 
 	if (!pipe->readers) {
 		send_sig(SIGPIPE, current, 0);
@@ -554,7 +572,8 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			continue;
 
 		/* Wait for buffer space to become available. */
-		if (filp->f_flags & O_NONBLOCK) {
+		if ((filp->f_flags & O_NONBLOCK) ||
+		    (iocb->ki_flags & IOCB_NOWAIT)) {
 			if (!ret)
 				ret = -EAGAIN;
 			break;

-- 
Jens Axboe

