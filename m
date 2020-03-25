Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB37C54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F84C2074D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0pW9HSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgCYFow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:44:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33019 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgCYFov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 01:44:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id f20so1180672ljm.0;
        Tue, 24 Mar 2020 22:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VCJjnDC7YcFnHUwAaqZugTYOL5Vd2ZqGA7nY4SOPq8g=;
        b=D0pW9HSRd3T2bIeDSEHq6UF5cq4pyyow6Cf8P88fd4FXZACHeV2KGmtieOSq2OfJxY
         Z4UZC04/FF7x29jZjjVm8216Zu1dwWEa1+2uCJfh2iAXZz/ynK2ao0V/HUthWp/E38Ip
         Aazu54zTVdv+5ejVW54J1PqfUi2rkHF02BttNce6ndikZ2wzgYjv5hUGpCfM2GPRPmgH
         JlqnDZZVyipplqGbr0eO9l+oHFOkMsq/TsWgVPm9j3gCfIMxy4FOXjZze/cZFXatOCqr
         KU/G98FcU/sKjgKoeNQECelJpQ7//8Dk1hyFs5chW9Pj2S8rWahIaWhm/HTRJjlOnR7d
         8ytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VCJjnDC7YcFnHUwAaqZugTYOL5Vd2ZqGA7nY4SOPq8g=;
        b=tGypZzznXQ7MB+Jg/yyr2SiFsq3e9xcEHuDpZboG+JkJ5C7hyuEOwfMD/FhTzVMJGc
         CYYtbw0RmRtxC54o1UhRHBUc6nP853eBG6Hlt3me48WjYxBCMJPdDAGohmo3yOnY0b2G
         EpFFTaQKmalHvrF4SyLKvh/s62hMQfOH/6MPopGiMHXQct4C29WkqJJlIevjpX3UlMFc
         96L8OCvLnSWb6wQWcyZ3TnAFiA98QiqtBuMxLjdNFfcMAmnyZCElhzNTy0OGVXDSvZX0
         Dkypwjm0Ey9Z4GfRB2zMn8lfO5k9mC4VqPu4H1XUQ/dKQPa+kpnfx/HGhFI87Cf94s0f
         b/OA==
X-Gm-Message-State: ANhLgQ14lckdb+7zadyVqqYhsl5+b5L3ZjBA8/XgCPgCKcsiBHX/FrgT
        2+Efa4FHcvWSYRwoG7uNqoU=
X-Google-Smtp-Source: APiQypJSdSdcqdutv/jQse/UnuwN06v0CvCoGCBqKh+kkMEi7fzh/lh1Q6J7PLPO2Qo99HXvngZIwQ==
X-Received: by 2002:a2e:b5d1:: with SMTP id g17mr811251ljn.139.1585115089376;
        Tue, 24 Mar 2020 22:44:49 -0700 (PDT)
Received: from localhost.localdomain ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id c5sm4690876lfg.82.2020.03.24.22.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:44:48 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] USB: serial: option: add Wistron Neweb D19Q1
Date:   Wed, 25 Mar 2020 06:44:19 +0100
Message-Id: <20200325054419.19128-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325054419.19128-1-paweldembicki@gmail.com>
References: <20200325054419.19128-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This modem is embedded on dlink dwr-960 router.
The oem configuration states:

T: Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 2 Spd=480 MxCh= 0
D: Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs= 1
P: Vendor=1435 ProdID=d191 Rev=ff.ff
S: Manufacturer=Android
S: Product=Android
S: SerialNumber=0123456789ABCDEF
C:* #Ifs= 6 Cfg#= 1 Atr=80 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E: Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E: Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E: Ad=84(I) Atr=03(Int.) MxPS= 10 Ivl=32ms
E: Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E: Ad=86(I) Atr=03(Int.) MxPS= 10 Ivl=32ms
E: Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E: Ad=88(I) Atr=03(Int.) MxPS= 8 Ivl=32ms
E: Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=(none)
E: Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=125us

Tested on openwrt distribution

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 8f6ed0cdddf4..8bfffca3e4ae 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1992,6 +1992,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x07d1, 0x3e01, 0xff, 0xff, 0xff) },	/* D-Link DWM-152/C1 */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x07d1, 0x3e02, 0xff, 0xff, 0xff) },	/* D-Link DWM-156/C1 */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x07d1, 0x7e11, 0xff, 0xff, 0xff) },	/* D-Link DWM-156/A3 */
+	{ USB_DEVICE_INTERFACE_CLASS(0x1435, 0xd191, 0xff),			/* Wistron Neweb D19Q1 */
+	  .driver_info = RSVD(1) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1690, 0x7588, 0xff),			/* ASKEY WWHC050 */
 	  .driver_info = RSVD(1) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2020, 0x2031, 0xff),			/* Olicard 600 */
-- 
2.20.1

