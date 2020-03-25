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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AFFC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3D220714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohyQ0IaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgCYFom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:44:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37496 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgCYFol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 01:44:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id j11so752564lfg.4;
        Tue, 24 Mar 2020 22:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PN2pEY+Kzbz4XFdCE928s35v5++Wy9Ykd/RxXGev44=;
        b=ohyQ0IaVVwTIOUP8Wrrjs6MbrHL4SxSXu6kuiAoH2a4S2UNj319FtMoCz0yKbZkNUS
         jagKrf3WLgcONvMPL8fK+mO15JIpo7DVYvu+FYesHrs9vI1jj/1kRFB06y4gZmw0cbL4
         0G85USaf0uachg+aNBsO3TH8x+pp7BMpV0GUZTngWYbAtoagtFPZIxVR5O/ow3O3MaqR
         ifRbBlZI2+kj+prnnIENQMaEXMtt4akYgjmR5wYhCrYbVU3acO9QCc9LYwMGMueT4eDN
         SRvcSUGUjoA34l/LsazWiEIXTL9TcRKlVXEL/rwMze4QI3O2L8SMNGHA5sTTFtgMFLJw
         aR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PN2pEY+Kzbz4XFdCE928s35v5++Wy9Ykd/RxXGev44=;
        b=n/H6WbBiQ7OQ6M8/68jQL4UE1JpbzjtQn2zCHjy6g1NlwZplR6p0pBDRVWU8P7jBt3
         m/KWW+DEGLl/VxqnyoI/R+/j6koF8UhK8n5wZDhxJemL/ptZ9eedRg4mFOeci69jOQwh
         gWCbZxnZtnu7/thl1+fSvwfVgsetDIarPC2ko9P8IjzfHEQZc7tlY6tLbTlqfObN6B+e
         Mpx/mEVqOk5MmC/FBKE0zn7+0YHsdVLGoeReXojc3vBS4pqww7IqzVRrJuDbhHztifcJ
         1kXE2o6NIpJrFva6BEHcMLMfZfdsJL8igiiHJ0gMl9W974LM8FyIGbazcgIwrZ0Ma733
         bNzA==
X-Gm-Message-State: ANhLgQ2TLSexn9EjigG0sfZpRRPwWUC7t4W6Nwl+EJhIom1KjDNxTXfE
        3h/s1ZIta3Wv7wN4DKO8w3o=
X-Google-Smtp-Source: ADFU+vuh0k4Bq4TAYo+XOlNmB+hpG5bs6sQqwD/bNueZp1wQ0NmtvvAsuW8dv+Bl7HFFSHrX/PjPyQ==
X-Received: by 2002:ac2:44bb:: with SMTP id c27mr1118265lfm.91.1585115079793;
        Tue, 24 Mar 2020 22:44:39 -0700 (PDT)
Received: from localhost.localdomain ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id c5sm4690876lfg.82.2020.03.24.22.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:44:38 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Cezary Jackiewicz <cezary@eko.one.pl>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] USB: serial: option: add support for ASKEY WWHC050
Date:   Wed, 25 Mar 2020 06:44:17 +0100
Message-Id: <20200325054419.19128-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASKEY WWHC050 is a mcie LTE modem.
The oem configuration states:

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1690 ProdID=7588 Rev=ff.ff
S:  Manufacturer=Android
S:  Product=Android
S:  SerialNumber=813f0eef6e6e
C:* #Ifs= 6 Cfg#= 1 Atr=80 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E:  Ad=88(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=(none)
E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=125us

Tested on openwrt distribution.

Co-Developed-by: Cezary Jackiewicz <cezary@eko.one.pl>
Signed-off-by: Cezary Jackiewicz <cezary@eko.one.pl>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 0b5dcf973d94..ec367a2f7fed 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1992,6 +1992,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x07d1, 0x3e01, 0xff, 0xff, 0xff) },	/* D-Link DWM-152/C1 */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x07d1, 0x3e02, 0xff, 0xff, 0xff) },	/* D-Link DWM-156/C1 */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x07d1, 0x7e11, 0xff, 0xff, 0xff) },	/* D-Link DWM-156/A3 */
+	{ USB_DEVICE_INTERFACE_CLASS(0x1690, 0x7588, 0xff),			/* ASKEY WWHC050 */
+	  .driver_info = RSVD(1) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2020, 0x2031, 0xff),			/* Olicard 600 */
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2020, 0x2060, 0xff),			/* BroadMobi BM818 */
-- 
2.20.1

