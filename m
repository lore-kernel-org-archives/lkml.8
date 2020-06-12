Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58133C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 04:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36C1A20792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 04:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf1DfbLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgFLEvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 00:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgFLEvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 00:51:20 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54658C03E96F;
        Thu, 11 Jun 2020 21:51:20 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 23so3724514pfw.10;
        Thu, 11 Jun 2020 21:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qEcltWINzHe+8BVfVlc4B67wQVAfeHX3u+jFdSgACuo=;
        b=mf1DfbLPOs0apgGyDiShM5Rn4z3cpU2500uPpuCkCWKMlrgOlWrBUqCvyqxvRCeRtc
         uNx4R53Pvr5nShC8x3t3ikUFRMByTMzKp6U7x/6acdsHP2AydRd3G9SYSAY2YhY2yZA4
         Snm17laxhTA9ycHErAr3DRORgOwyl4BexFVXgRh5dYVUEyVFzpojm1PmfUZjEmThs9hL
         Zmjb+CQqsRQgrkuMORZ3tn8quCkeJAM9yUNjp6ObV+3kpcndGwziILfZnsasQRYLfPp7
         4St+94JGR3BNgG+A2CyzQtQGyTtJDz5ZxKJSidqZlYcunP1zrYNFBJLLZsZuSukmnvrH
         HKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qEcltWINzHe+8BVfVlc4B67wQVAfeHX3u+jFdSgACuo=;
        b=QKJ2+FCLukZ6x4VbXK9tegvpXHYq0E0MIoPE0vyaTYeWTQpMwbgN7urlkZN4TmXi6l
         CdOuvltbXxmpHaZRdnAuF9iuq7UEpB76n3BSiFFcc5Y8Gg0gdTOXM9KQWwqjwz7l3BfF
         kA7Ct8LZytI/tun7TppM09QhUdgngranRuj9fWj1WTQyZ3ql0Lw6xq2jy6KQWyWlP9j1
         /bKn6c6T7zRf0E8b0LoLnu9QMByr0AECsmk/L1M2Fz/V7zrcRumBXLAkLMfPTwUkay0t
         lc9oV3DJTAyC1ao9rumt1x7XDWsPle94GEZwZhp5BDkCg25QXMIuZacGBSyyfU+oTI63
         t/zQ==
X-Gm-Message-State: AOAM532Cx4Nrbm1Kok7c7ChsQuynfwKFzlTBBdSmrCH9a0Qnr4XQ/C3E
        QkR9HoELOoeELT0JJfVIh/DQcXgH44M=
X-Google-Smtp-Source: ABdhPJwECg9txIZ8crO6XdDjsScCDa2UinZnk7ESnwY3bgGBOGrKaOyg7aNkpbhzEUbfC52MeWNOzw==
X-Received: by 2002:a62:7841:: with SMTP id t62mr9638465pfc.273.1591937479518;
        Thu, 11 Jun 2020 21:51:19 -0700 (PDT)
Received: from sol.lan (220-235-122-244.dyn.iinet.net.au. [220.235.122.244])
        by smtp.gmail.com with ESMTPSA id b23sm3952216pgs.33.2020.06.11.21.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 21:51:18 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 2/2] gpiolib: cdev: fix file comment
Date:   Fri, 12 Jun 2020 12:50:34 +0800
Message-Id: <20200612045034.27425-3-warthog618@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200612045034.27425-1-warthog618@gmail.com>
References: <20200612045034.27425-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace file comment carried over from gpiolib.c with one more
appropriate for gpiolib-cdev.c.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 58011ba88a1d..17d5541d76a0 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -25,11 +25,10 @@
 #include "gpiolib.h"
 #include "gpiolib-cdev.h"
 
-/* Implementation infrastructure for GPIO interfaces.
+/* Character device interface to GPIO.
  *
- * The GPIO programming interface allows for inlining speed-critical
- * get/set operations for common cases, so that access to SOC-integrated
- * GPIOs can sometimes cost only an instruction or two per bit.
+ * The GPIO character device, /dev/gpiochipN, provides userspace an
+ * interface to gpiolib GPIOs via ioctl()s.
  */
 
 /*
-- 
2.27.0

