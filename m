Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DEDC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC38208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LS23U3Z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgCTWCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:02:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45348 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgCTWCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 18:02:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17so8082078ljk.12;
        Fri, 20 Mar 2020 15:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+Zpm7nv3KnXyXL/VwriXYdIco1W4Hfuzxxyjd9h2fs=;
        b=LS23U3Z2Mkkr/5FwWW3HzaKo/z4My76CU26gDQtzHZJEnhJSUg/GDsffGAd2GyqgMy
         /ALOaz7gGtJT/f66DMtS9HR0LJHnbWoOsYTZXzE0dm6SGgfWD9y8tYlppiKXpnPkXYFn
         SoQfdqmzzjFcD5bFuM4v/79ZGKNJ66GVNw9hN+vAdCZEcLD8b1YW1PbTzQ4YTxFAjVh0
         yoG7/fATCQ7+7pLOkbGXbKmq68ejNOpWfxXcksqpBzN/mq69iYf0dQkkn03yp7MTFpID
         w2MPo6pgI26ayky5Pz72YUdEyN0GfHbxji3yM+Yh7c5FngLa+/uuvEno5pZIQqG8/j3K
         qb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+Zpm7nv3KnXyXL/VwriXYdIco1W4Hfuzxxyjd9h2fs=;
        b=CbAurxoXDTtI0HFMPn8p7r0A4//0J3DQE/oO9JeA0dlSoZv9WbB1IXQoTezuDAMwaq
         UfUq+7i16Wjq/fm6dtHLM0VVb5bcKmIoXwyj+0fpmmorEArZfhKDLfWOgooKuE3KMCC0
         D9i8R9agW8aLNVJx2Qzf+NnZttDVEMKHtnbLTuGXVH074FD6QmpCf3rE4Macq1F0hYxQ
         0bvCD2NToMOjHzA0CXLTlWWctD2nQl64EsNv/sqRp3uJgKPjWncschrRRX9XSArwjBUR
         yTTx/hygqIbcrhTuOCCqGMnurmykpCyGhgE2IspAEkgusYFGKg9OWKP+9uzjmzWdKCeo
         bcuw==
X-Gm-Message-State: ANhLgQ3/n4kDSsE0jgW4IDnh+g4rV8MTlmk3B7DKnH9MFISLXVSvMtE1
        FuAgsC9+VmQX/T6gCREybaQ=
X-Google-Smtp-Source: ADFU+vvZxRjv8GWZ+M9ELg7WqLbW0kQbslk4JVDN+5DcpyRTtSgwK+mCqXqUZUyq8NDPeSA6Q2U+1w==
X-Received: by 2002:a05:651c:106:: with SMTP id a6mr6875085ljb.143.1584741739314;
        Fri, 20 Mar 2020 15:02:19 -0700 (PDT)
Received: from localhost.localdomain ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id j21sm3992416lji.93.2020.03.20.15.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 15:02:18 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] USB: serial: option: add Wistron Neweb D19Q1
Date:   Fri, 20 Mar 2020 23:01:54 +0100
Message-Id: <20200320220155.5609-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320220155.5609-1-paweldembicki@gmail.com>
References: <20200320220155.5609-1-paweldembicki@gmail.com>
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
index 49313a55e1f3..abc717b99204 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2022,6 +2022,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(6) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1690, 0x7588, 0xff),			/* ASKEY WWHC050 */
 	  .driver_info = RSVD(1) | RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1435, 0xd191, 0xff),			/* Wistron Neweb D19Q1 */
+	  .driver_info = RSVD(1) | RSVD(4) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
-- 
2.20.1

