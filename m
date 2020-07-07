Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCD6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3F7206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDNNtFX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgGGIP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGIP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:15:56 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2410C061755;
        Tue,  7 Jul 2020 01:15:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q17so2025206pls.9;
        Tue, 07 Jul 2020 01:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z3vMc4LhkvM4yfF4xOZK+pZlrg4hJ502eupJwkHg5Rc=;
        b=UDNNtFX98E/fTkhc2Afidv/EWSDyn0nLvUNCO+zlbg7W/OPb3QFkEvmJoc8RfbEqBV
         WB4zew9K5k+ZQ5i1MswUGRUfnZZlA/LixXwTR3M6rt23zQOHmJJ6i6qshGsSIdLVosOD
         rAZdeCGxliI6pRLJa2DB8QjoFAiUNGzDvYTUt6JcSBQkOnE2MplH0606l8RMZmHIVqTc
         mWEj1oUSoCR5JGyWun+ji8Ju9+9xr9SNo0g9+Rs8Aa0Q4FgLS+mDL+Q0hZWCoEGnnUTD
         u8X15EdjjZ5vM5oaPFbOsyoJBGkeWKTC8Z1eSumozr+pRMpx8hqVznNSBOmVyrBzk/9Z
         S0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=z3vMc4LhkvM4yfF4xOZK+pZlrg4hJ502eupJwkHg5Rc=;
        b=A41DzoHTGwJprmcOTHGCSvmBGL1n0cM2DcCVSLgNamgFJrpm/Y+MRv+X9s9H3YnEdP
         XFmz4Nf4uLOaXbyd1H73e00LUc74SDjkKwUxwJ7qu7IW2Ob9Khp2myP1gE71dY1UGtPT
         bDq+Heh+ucsPcb7uxUoRrZJVQPtTL8siBb7yamTzIoVo5B4rVikEpne+ymGg+7yprLyk
         8XBR2myDmZtvHsz01JIYcOTWb9liS25lI0yTvVMFwhB+4iLh49ZZ2Q/HLqj1qxM2UIXg
         TdQU+NJk+RxhSgJbmr6jG6UaxPD7y1BCcXN19vVcoDy1ZD9Cv8JsjsIphTmCZQX3KuLU
         Zmtg==
X-Gm-Message-State: AOAM533cQFUeavf9Db4i7sbcK+WGLkiUT/w7qsib28xtmlzXJCbWKnKb
        9yc9dVgS1ZFKRqPTSVX8oN4=
X-Google-Smtp-Source: ABdhPJxG1jalnbzXoi3kqMl/iSY7eOwvKfh1RA4pUNaLydQ9VUxO7IghTw6o/IsXk3VhlY59MFVmrw==
X-Received: by 2002:a17:90a:2e85:: with SMTP id r5mr3198189pjd.232.1594109755410;
        Tue, 07 Jul 2020 01:15:55 -0700 (PDT)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id n15sm1780763pjf.12.2020.07.07.01.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 01:15:54 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: option: add Quectel EG95 LTE modem
Date:   Tue,  7 Jul 2020 16:15:53 +0800
Message-Id: <20200707081553.1064456-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Quectel Wireless Solutions Co., Ltd. EG95 LTE modem

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=02 Dev#=  5 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=0195 Rev=03.18
S:  Manufacturer=Android
S:  Product=Android
C:  #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#=0x0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#=0x1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
I:  If#=0x3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/usb/serial/option.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 254a8bbeea67..a12ad91a7e0b 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -245,6 +245,7 @@ static void option_instat_callback(struct urb *urb);
 /* These Quectel products use Quectel's vendor ID */
 #define QUECTEL_PRODUCT_EC21			0x0121
 #define QUECTEL_PRODUCT_EC25			0x0125
+#define QUECTEL_PRODUCT_EG95			0x0195
 #define QUECTEL_PRODUCT_BG96			0x0296
 #define QUECTEL_PRODUCT_EP06			0x0306
 #define QUECTEL_PRODUCT_EM12			0x0512
@@ -1097,6 +1098,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC25),
 	  .driver_info = RSVD(4) },
+	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG95),
+	  .driver_info = RSVD(4) },
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_BG96),
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0xff, 0xff),
-- 
2.25.1

