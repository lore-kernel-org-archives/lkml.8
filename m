Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6790DC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18619221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbBPE5Ob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgIKGfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 02:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgIKGfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 02:35:11 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EB0C061573;
        Thu, 10 Sep 2020 23:35:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so1232052pjg.1;
        Thu, 10 Sep 2020 23:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wjke6xRt47mn12598ew0laiNvuKExCKQGIW2cKSHnUg=;
        b=PbBPE5Ob7c/chvytAaKrSeeO+Mhc09S0LLsaC6RlGdf3uQ1ARZBZnyup1jdBpd0mFz
         N057WlNU8t13ttFWJRmI94sC2IjxRBn88IluhKj03ecwOtr/BstsOpK2lmT9i5AdzfRh
         pa3yG/DHi7clmbXkIJUqPOXeU9jogbKjECwRMEQkmQwMgC4PUO98QJMKbOwScHhhCKT2
         WaU+r+a+YyS0h1V8GBWUZpbrHG8Q+B4jtImIP4R8fO3r/S1eLurIL8/uD4w9Ae/EDqSy
         Sd0BHYzLajPiqMkNJRmibraT++hhKb6ByM7bXvm6XGYthsvbwpB652eqsj8Nn/gAAdiC
         hi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wjke6xRt47mn12598ew0laiNvuKExCKQGIW2cKSHnUg=;
        b=fZiTTKE64DIDelpLKau7NwfO00wWqsVraR9dRz43YJTvXctqzfZr6kI+xnJcVkD+j5
         7guBzrQWYH5jJTScWaUR3UtUcmTgjH0zFU8jFZtiJscnCPVQrAb+eAJ2fkkT5dUlBo6h
         LYIzx2GX96d0sAZeBU1F5jKCYEJa5nH/w88Dy3OV4MbKaXhk2ViVfPnQU44s0NZOUYAm
         5PGJJ7z+RWInt5EXTskLFUrL4+lm6qhfR11HKNRtAKZsKsm/Wz5L+ttn5Yy/BqgUSQgQ
         5KDD4e8fxRXu1G4q83WwjUtHMLtVvWH7nDIn14LsBJjqp761R0aX3+mAQ9CK18TFkVmo
         M0Vg==
X-Gm-Message-State: AOAM533AHXD3jBb4ZQMmfp4a+GOGBTcWM04kFklS0Nr6oe1eM7+Nl8Rk
        I3RnjoQRPCLaejIOpgdlIxk=
X-Google-Smtp-Source: ABdhPJwprJyvMMIpjSD2Q8zqC+1G+ch14JiMmnDxkySCzZJGA7yLiRVM7SmF8YHn/9QRRBCIef5zzA==
X-Received: by 2002:a17:90a:4cc6:: with SMTP id k64mr859288pjh.103.1599806110441;
        Thu, 10 Sep 2020 23:35:10 -0700 (PDT)
Received: from shane-XPS-13-9380.hsd1.ca.comcast.net ([2601:646:8800:1c00:54b8:5e43:7f25:9207])
        by smtp.gmail.com with ESMTPSA id j1sm844885pgp.93.2020.09.10.23.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 23:35:10 -0700 (PDT)
From:   Xie He <xie.he.0141@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Xie He <xie.he.0141@gmail.com>
Subject: [PATCH net-next] drivers/net/wan/x25_asy: Remove an unused flag "SLF_OUTWAIT"
Date:   Thu, 10 Sep 2020 23:35:03 -0700
Message-Id: <20200911063503.152765-1-xie.he.0141@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "SLF_OUTWAIT" flag defined in x25_asy.h is not actually used.
It is only cleared at one place in x25_asy.c but is never read or set.
So we can remove it.

Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
 drivers/net/wan/x25_asy.c | 2 --
 drivers/net/wan/x25_asy.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/wan/x25_asy.c b/drivers/net/wan/x25_asy.c
index 7ee980575208..5a7cf8bf9d0d 100644
--- a/drivers/net/wan/x25_asy.c
+++ b/drivers/net/wan/x25_asy.c
@@ -243,8 +243,6 @@ static void x25_asy_encaps(struct x25_asy *sl, unsigned char *icp, int len)
 	actual = sl->tty->ops->write(sl->tty, sl->xbuff, count);
 	sl->xleft = count - actual;
 	sl->xhead = sl->xbuff + actual;
-	/* VSV */
-	clear_bit(SLF_OUTWAIT, &sl->flags);	/* reset outfill flag */
 }
 
 /*
diff --git a/drivers/net/wan/x25_asy.h b/drivers/net/wan/x25_asy.h
index eb4a4216ee94..87798287c9ca 100644
--- a/drivers/net/wan/x25_asy.h
+++ b/drivers/net/wan/x25_asy.h
@@ -35,7 +35,6 @@ struct x25_asy {
 #define SLF_INUSE	0		/* Channel in use               */
 #define SLF_ESCAPE	1               /* ESC received                 */
 #define SLF_ERROR	2               /* Parity, etc. error           */
-#define SLF_OUTWAIT	4		/* Waiting for output		*/
 };
 
 
-- 
2.25.1

