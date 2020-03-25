Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183CBC54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2A020714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1k3sdtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgCYFos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:44:48 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37073 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgCYFor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 01:44:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so1152093ljd.4;
        Tue, 24 Mar 2020 22:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WytxL680EIkmdkcboL7y8pL4166B4FDfuz4cMWklXYU=;
        b=t1k3sdtwe2yXfIbnHooH4KGViELLqPFO9hdxVmuFboEkxAIkIJZPoEJVoDPNAlL5lu
         Cfcj/RffJWp0Mn9vuUoJsbCKQqRueQ1Gp/14esa3gJjYqsSFUeqwa6kW/EieO2jDfV3h
         zPh23E0+VkHAImYXvEvFXlR33Oag/ikyV17nRUG1DXk43cnshJbwZ1CJnUdo9zthJBNi
         vNUGzsvZscaWMF2p7XyjtbwVsA5Goyz/UgJmjb3auF9QMFRxQxztYSIL0IgDpDzbhwDE
         Q/+kCRc8HKJlIRNcBWP4AaD1DF4r3pLGE9zzFqYkMW+OvJWAvdTkhC/73dhdoc6IuUfj
         J2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WytxL680EIkmdkcboL7y8pL4166B4FDfuz4cMWklXYU=;
        b=C9HY076CJdkCxiNe7z3HhVQ19j2G6I7qvcz97lVPThYdJuJrttND/fcBiwg6PpZcvN
         BpNysVM/xcBI4liiARxJxrP1KQMpjgPQ0hsOwd93JWQOvjQk+O5AIH/X40sIvu1Y/rl6
         9shsrUPE0ZBmnEcmxyXuL4iqwpyLKNF2RiQrsjdbODldu1sfbNL/0cGgIo1uLmMs/DkX
         +vHzk8ocVS2DJT1otsxG0J6BpaRmlzlLgy2Yc7CorXF5hmg7dW/J37DrXsAWnUqJpR+2
         ODGpRdTvMP5lN7G5rEVkPveIQgjYPwy0+Vh0emF3KGYUpLBW11f6TZT5UcloUUCRIsrJ
         EpyQ==
X-Gm-Message-State: ANhLgQ0lcRuS6SJ9zMmiT/bf29NVV0A+zYS0qYuyDsJpL8BN5EWqBMHD
        oBBR6b2Z+TtgldAKfb49oxY=
X-Google-Smtp-Source: APiQypKK9FXJLGsNuuEIBp9h9EAtU+maAWQovbwoqJ/dhKFXO7y0tBDlvYXlHQXH8aiZy2e3hXgD7w==
X-Received: by 2002:a2e:b558:: with SMTP id a24mr842951ljn.56.1585115085592;
        Tue, 24 Mar 2020 22:44:45 -0700 (PDT)
Received: from localhost.localdomain ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id c5sm4690876lfg.82.2020.03.24.22.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:44:45 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Cezary Jackiewicz <cezary@eko.one.pl>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] USB: serial: option: add BroadMobi BM806U
Date:   Wed, 25 Mar 2020 06:44:18 +0100
Message-Id: <20200325054419.19128-2-paweldembicki@gmail.com>
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

BroadMobi BM806U is an Qualcomm MDM9225 based 3G/4G modem.
Tested hardware BM806U is mounted on D-Link DWR-921-C3 router.

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=2020 ProdID=2033 Rev= 2.28
S:  Manufacturer=Mobile Connect
S:  Product=Mobile Connect
S:  SerialNumber=f842866cfd5a
C:* #Ifs= 5 Cfg#= 1 Atr=80 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E:  Ad=89(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Co-Developed-by: Cezary Jackiewicz <cezary@eko.one.pl>
Signed-off-by: Cezary Jackiewicz <cezary@eko.one.pl>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index ec367a2f7fed..8f6ed0cdddf4 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1996,6 +1996,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(1) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2020, 0x2031, 0xff),			/* Olicard 600 */
 	  .driver_info = RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x2020, 0x2033, 0xff),			/* BroadMobi BM806U */
+	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2020, 0x2060, 0xff),			/* BroadMobi BM818 */
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2020, 0x4000, 0xff) },			/* OLICARD300 - MT6225 */
-- 
2.20.1

