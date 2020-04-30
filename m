Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CC1C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77700208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Bk6N4M2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgD3QYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726405AbgD3QYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:24:49 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87200C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:24:48 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id y26so2115040ioj.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5ED1Vui6XgD5D+MLnl02qdB5ZH/iACgKyj0xoJaDnig=;
        b=Bk6N4M2lqEyGcGI8Uvtu3g+xtGkZUqcyveuPCwo11vlph2JWhs0eVV0Tc8zznvQfFk
         L451Tz98TXGyFsszgM2D4m2A/YQGBXdsX4ZWsQnTHMqE5VoJQ66OY+yPOhI8o7Lh9Zuy
         VyMuwMYwBFh8psrWX0xrt2fRJ7Nwxtua87OJ38Pc41wBZRXCp8kiMmCja8s8sihrl0PL
         pWAiCBrrivjKvgfwAfHhMJf/eUwG3WLPItByFOdPhLfMkxc5k9gKgC7McrveSVT0VUof
         nSze9M/RcOyUX9eBtHwtpdsAebtERiAPNhxIQHkJTOd3ZXPscq6S+v4sjxdv3eWVEa8g
         Y1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5ED1Vui6XgD5D+MLnl02qdB5ZH/iACgKyj0xoJaDnig=;
        b=Ja4p3+IpP/xmSYsFRJ4yNuejZgpeWwtYUwyMgOraUywpnx5YZesj4UVj6oUx6CNEIR
         +uz5aMjcrEcoN2pZcVrlF8hlrXSWlbxU9cmay68MOlZDrmsskH90piEs5qqhMLUiWdYu
         fI/rI0UBgJnlw0/HlQvT8dvpWwPpM3wWNCJ5pvYneh4gtUQCvRsA86k8obLBHzelZA23
         vYIB0s4dF3wQJ6LtRKTKeOE7W8avbcnrGstZG+qdObyhrbIaZ8Q+dOinetQqZScqffn+
         ciIOMDwBbBayMYQtBMixoxa2zNNrsEU1edkiSDuYq7ZRYb27U/OFADF0+ADhBIzdJSYm
         EZAw==
X-Gm-Message-State: AGi0PuY9X74RlEcMM9jXGZCeHfOat68TH4kFqqveKSneJviexFFVkGxA
        ZLwmCtl+UZmILnDs5YnkwQ5clciM0LrXTw==
X-Google-Smtp-Source: APiQypIfboGjT1YtQKw6V9pRF4rI3B1ag1uiJFYhCyHYuLxxvZobRbdi1+Oaq+AcE4Ic5IX1VPRj5Q==
X-Received: by 2002:a5e:c744:: with SMTP id g4mr2737373iop.20.1588263887593;
        Thu, 30 Apr 2020 09:24:47 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j29sm104414ila.53.2020.04.30.09.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 09:24:46 -0700 (PDT)
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] pipe: read/write_iter() handler should check for IOCB_NOWAIT
Message-ID: <273d8294-2508-a4c2-f96e-a6a394f94166@kernel.dk>
Date:   Thu, 30 Apr 2020 10:24:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pipe read/write only checks for the file O_NONBLOCK flag, but we should
also check for IOCB_NOWAIT for whether or not we should handle this read
or write in a non-blocking fashion. If we don't, then we will block on
data or space for iocbs that explicitly asked for non-blocking
operation. This messes up callers that explicitly ask for non-blocking
operations.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/pipe.c b/fs/pipe.c
index 16fb72e9abf7..5711e6bca12d 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -363,7 +363,8 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			break;
 		if (ret)
 			break;
-		if (filp->f_flags & O_NONBLOCK) {
+		if ((filp->f_flags & O_NONBLOCK) ||
+		    (iocb->ki_flags & IOCB_NOWAIT)) {
 			ret = -EAGAIN;
 			break;
 		}
@@ -566,7 +567,8 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
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

