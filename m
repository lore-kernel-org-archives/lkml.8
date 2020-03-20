Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A0EC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE982078C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl0cpiBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgCTWCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:02:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33839 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTWCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 18:02:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id s13so8148618ljm.1;
        Fri, 20 Mar 2020 15:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JVLF7ZH3L5Q3n+P3OtFEZgJw0cHKvGqVmerntt7CosM=;
        b=Nl0cpiBnoOh7866ecwLvpa5MnFm2gNpT1Sr0IiUb1Di+hXR0i/vbfRnYg598mRuk5n
         OcapMsE1O7mkoDwpZl7wHoV3akVJZqQiquHTgVHIoPzhOF18d6/4nEhcdsuFz35XeIJ5
         coIAllaylBlOrfOoXLPNQOjmMI52/OqLwgM1VWpIp5nDEdF4lcSkJLNIQRncjf6ny/Go
         zySPRjCtfe4rOWDfliYUWvcgx15EXEYSeoAfXkdvJN9msIigPJ7nNdHbndXu/gU/mAFu
         cJgzx2SgtcNSReKfQqOtHQFYm+14kYtwZROM/bxN9I/244s+7gAQxMJaBtgn1unxV/tC
         8gJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JVLF7ZH3L5Q3n+P3OtFEZgJw0cHKvGqVmerntt7CosM=;
        b=rvEbccBgxOtl90j55uwHrx+M4A7fvpWwxMyntGyM8KZdP2SEceTngKtC/JRwqdBN2G
         1zotnEXiXdeY0kHINAXwpf8fMRWWdmKdXPfQEUXWyeHgfshrnF0tPv+c16WMpa6zLyM3
         eV5IeyYG0FC1C+hs1JJN6wM9LwdCLaiym9FpSFWqxhjy9QvoDBYgsEZDMIjFuO7n8CcW
         xgDk9oxEFJ6W0XX1SN3MnuH7HhRpa4COhJSJTo5k1H9htlN369Inyb4Rx40tHHspXVys
         yrPQBrEl4kBfJml2fekebmvnMFg1+2Vz/acFvIsV8102owP6ZMpIo0nXLwEADS1rZ8xF
         aBQw==
X-Gm-Message-State: ANhLgQ0o/SzBqlyF6q9Iv/Zhtfb/tZsAa+cGe9QZOgmZnneyeVdG4CTm
        /sayZWGoA3Qf3NjehXiM9ts=
X-Google-Smtp-Source: ADFU+vsojvRBnw5y3C4N+yBCJXK0/jgUbpozYmpcHiw1bm4Z24o/aj2tzLGzJYAgNMjjKECrpAHsZg==
X-Received: by 2002:a2e:90da:: with SMTP id o26mr6877330ljg.254.1584741727319;
        Fri, 20 Mar 2020 15:02:07 -0700 (PDT)
Received: from localhost.localdomain ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id j21sm3992416lji.93.2020.03.20.15.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 15:02:06 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Cezary Jackiewicz <cezary@eko.one.pl>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] USB: serial: option: add support for ASKEY WWHC050
Date:   Fri, 20 Mar 2020 23:01:52 +0100
Message-Id: <20200320220155.5609-1-paweldembicki@gmail.com>
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

Signed-off-by: Cezary Jackiewicz <cezary@eko.one.pl>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 0b5dcf973d94..2f17019d3810 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2018,6 +2018,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(4) | RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0105, 0xff),			/* Fibocom NL678 series */
 	  .driver_info = RSVD(6) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1690, 0x7588, 0xff),			/* ASKEY WWHC050 */
+	  .driver_info = RSVD(1) | RSVD(4) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
-- 
2.20.1

