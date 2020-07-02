Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38E0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86BAF208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EmGnkDPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbgGBOs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730032AbgGBOq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:46:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A4EC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:46:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so27094639wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kZQeJUz+ErJ6yE5aR4TJ6dhksayixlSTB2k3nGSWLOM=;
        b=EmGnkDPALpzLOYQpEWxWIHKjJi1QPdROlga7PolW9eoc2fctcHjv9A3rBSoQzpnGVp
         8PfqKc2hmGPJ7C4BmFS0/+f1wti/7JErmkD2W8yyRMjypPlwK6A36wVpTDLwyDQg87sw
         c0uu9+dF+Ug0g9aw3Q4mYqsHAtgNH8/XLOM5hiwW0CRDrWgad5eFiCp87XpG+pFKWWqx
         LuX983vQCmCEepm8sMhjowkgnJS7kOwY1pekRce9IZQL8MQQ4dn+hkHQkftKnTTGaDR5
         900F+B1dg7IZ5BbGwkWizO0a35THYtH7qGGs4CJRdyIVW0UbbSb2o9jXD5Xq0qGGeOk+
         KnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kZQeJUz+ErJ6yE5aR4TJ6dhksayixlSTB2k3nGSWLOM=;
        b=eEN5IUTf1KdKC/QdW2Hje05+RzrkFFVbko3Vl+Qy+iQl45spOM5tucFZjzV7/V43aP
         5eJ6PYifmJAUo0yKWrw9OmubU2VY1JSKBxBCcuVtQdyKmTW9UUHsJnb0Dl+tPricQ3hB
         yAL9HmAtLCZd4tyCFsrfbu9INmMTZOivsh7jMEF0nKZR2rHNjKJ4ZmSouDWzSTQsr+5j
         mhvZWADRtFtD2Han1fKrODXA40UQdXMswzKRDP05qf5292a4IcTJZJOuoX5FgfnhN7Co
         E0rYLG9deS3ZC969vDk9pdOCw80nVcl70xQ0eHi6i9Jb8u8xuCR/lfXZyU2D4TJsxV/s
         NMZw==
X-Gm-Message-State: AOAM533lhwOgDifQ41xYscRs/UqysSIDafI/8Ddfl2Pd31RC1r0b2Yv+
        6w3JNN3svN8vGvqx/WFzxINaZBo5aKQ=
X-Google-Smtp-Source: ABdhPJyxMg7EbHaZ/31OlfupBkIBsGFOwrld5FUmxjo0/JeKjE8jPmiIcgJijoZ9w17/iOlzpi1ktw==
X-Received: by 2002:a1c:b4c2:: with SMTP id d185mr30552951wmf.57.1593701215544;
        Thu, 02 Jul 2020 07:46:55 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:46:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        "by L. Wassmann" <LW@KARO-electronics.de>
Subject: [PATCH 19/30] usb: host: isp1362: Mark the many unused ISP1362_REG entries as __maybe_unused
Date:   Thu,  2 Jul 2020 15:46:14 +0100
Message-Id: <20200702144625.2533530-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would seem a shame to strip out all of the unused register entries,
since they can act as a fair source of documentation.  Instead, mark
them all as __maybe_unused to show the build system that this behaviour
is known and intentional.

Fixes the following kernel build warning(s):

 In file included from drivers/usb/host/isp1362-hcd.c:96:
 drivers/usb/host/isp1362.h:59:22: warning: ‘ISP1362_REG_OTGALTTMR’ defined but not used [-Wunused-const-variable=]
 59 | static isp1362_reg_t ISP1362_REG_##name = addr
 | ^~~~~~~~~~~~
 drivers/usb/host/isp1362.h:199:1: note: in expansion of macro ‘ISP1362_REG’
 199 | ISP1362_REG(OTGALTTMR, 0x6C, REG_WIDTH_16, REG_ACCESS_RW);
 | ^~~~~~~~~~~
 drivers/usb/host/isp1362.h:59:22: warning: ‘ISP1362_REG_OTGTIMER’ defined but not used [-Wunused-const-variable=]
 59 | static isp1362_reg_t ISP1362_REG_##name = addr
 | ^~~~~~~~~~~~
 drivers/usb/host/isp1362.h:198:1: note: in expansion of macro ‘ISP1362_REG’
 198 | ISP1362_REG(OTGTIMER, 0x6A, REG_WIDTH_16, REG_ACCESS_RW);
 | ^~~~~~~~~~~
 drivers/usb/host/isp1362.h:59:22: warning: ‘ISP1362_REG_OTGINTENB’ defined but not used [-Wunused-const-variable=]
 59 | static isp1362_reg_t ISP1362_REG_##name = addr
 | ^~~~~~~~~~~~
 drivers/usb/host/isp1362.h:197:1: note: in expansion of macro ‘ISP1362_REG’
 197 | ISP1362_REG(OTGINTENB, 0x69, REG_WIDTH_16, REG_ACCESS_RW);
 | ^~~~~~~~~~~
 drivers/usb/host/isp1362.h:59:22: warning: ‘ISP1362_REG_OTGINT’ defined but not used [-Wunused-const-variable=]
 59 | static isp1362_reg_t ISP1362_REG_##name = addr
 | ^~~~~~~~~~~~
 drivers/usb/host/isp1362.h:196:1: note: in expansion of macro ‘ISP1362_REG’
 196 | ISP1362_REG(OTGINT, 0x68, REG_WIDTH_16, REG_ACCESS_RW);
 | ^~~~~~~~~~~
 drivers/usb/host/isp1362.h:59:22: warning: ‘ISP1362_REG_OTGSTATUS’ defined but not used [-Wunused-const-variable=]
 59 | static isp1362_reg_t ISP1362_REG_##name = addr
 | ^~~~~~~~~~~~
 drivers/usb/host/isp1362.h:195:1: note: in expansion of macro ‘ISP1362_REG’
 195 | ISP1362_REG(OTGSTATUS, 0x67, REG_WIDTH_16, REG_ACCESS_R);
 | ^~~~~~~~~~~
 drivers/usb/host/isp1362.h:59:22: warning: ‘ISP1362_REG_OTGCONTROL’ defined but not used [-Wunused-const-variable=]
 59 | static isp1362_reg_t ISP1362_REG_##name = addr
 | ^~~~~~~~~~~~
 drivers/usb/host/isp1362.h:194:1: note: in expansion of macro ‘ISP1362_REG’
 194 | ISP1362_REG(OTGCONTROL, 0x62, REG_WIDTH_16, REG_ACCESS_RW);
 | ^~~~~~~~~~~
 drivers/usb/host/isp1362.h:59:22: warning: ‘ISP1362_REG_HCATLPORT’ defined but not used [-Wunused-const-variable=]
 59 | static isp1362_reg_t ISP1362_REG_##name = addr
 | ^~~~~~~~~~~~
 drivers/usb/host/isp1362.h:183:1: note: in expansion of macro ‘ISP1362_REG’
 183 | ISP1362_REG(HCATLPORT, 0x44, REG_WIDTH_16, REG_ACCESS_RW);
 | ^~~~~~~~~~~
 drivers/usb/host/isp1362.h:59:22: warning: ‘ISP1362_REG_HCINTLPORT’ defined but not used [-Wunused-const-variable=]
 59 | static isp1362_reg_t ISP1362_REG_##name = addr
 | ^~~~~~~~~~~~
 drivers/usb/host/isp1362.h:175:1: note: in expansion of macro ‘ISP1362_REG’
 175 | ISP1362_REG(HCINTLPORT, 0x43, REG_WIDTH_16, REG_ACCESS_RW);
 | ^~~~~~~~~~~
 drivers/usb/host/isp1362.h:59:22: warning: ‘ISP1362_REG_HCISTL1PORT’ defined but not used [-Wunused-const-variable=]
 59 | static isp1362_reg_t ISP1362_REG_##name = addr
 | ^~~~~~~~~~~~
 drivers/usb/host/isp1362.h:171:1: note: in expansion of macro ‘ISP1362_REG’
 171 | ISP1362_REG(HCISTL1PORT, 0x42, REG_WIDTH_16, REG_ACCESS_RW);
 | ^~~~~~~~~~~
 drivers/usb/host/isp1362.h:59:22: warning: ‘ISP1362_REG_HCISTL0PORT’ defined but not used [-Wunused-const-variable=]
 59 | static isp1362_reg_t ISP1362_REG_##name = addr
 | ^~~~~~~~~~~~
 drivers/usb/host/isp1362.h:170:1: note: in expansion of macro ‘ISP1362_REG’
 170 | ISP1362_REG(HCISTL0PORT, 0x40, REG_WIDTH_16, REG_ACCESS_RW);
 | ^~~~~~~~~~~
 drivers/usb/host/isp1362.h:59:22: warning: ‘ISP1362_REG_HCINTDIS’ defined but not used [-Wunused-const-variable=]
 59 | static isp1362_reg_t ISP1362_REG_##name = addr
 | ^~~~~~~~~~~~
 drivers/usb/host/isp1362.h:77:1: note: in expansion of macro ‘ISP1362_REG’
 77 | ISP1362_REG(HCINTDIS, 0x05, REG_WIDTH_32, REG_ACCESS_RW);
 | ^~~~~~~~~~~

Cc: "by L. Wassmann" <LW@KARO-electronics.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/isp1362.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/isp1362.h b/drivers/usb/host/isp1362.h
index 4c49688a069d1..9bbfcc3fdd3cc 100644
--- a/drivers/usb/host/isp1362.h
+++ b/drivers/usb/host/isp1362.h
@@ -56,7 +56,7 @@ typedef const unsigned char isp1362_reg_t;
 #define ISP1362_REG_NO(r)		(r)
 
 #define ISP1362_REG(name, addr, width, rw) \
-static isp1362_reg_t ISP1362_REG_##name = addr
+static isp1362_reg_t __maybe_unused ISP1362_REG_##name = addr
 
 #define REG_ACCESS_TEST(r)		do {} while (0)
 #define REG_WIDTH_TEST(r, w)		do {} while (0)
-- 
2.25.1

