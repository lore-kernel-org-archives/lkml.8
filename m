Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4441C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FA72082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AqY+HzEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgBLKUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:20:25 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46371 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgBLKUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:20:25 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200212102023euoutp01de47a2d4d7c8efb364fffcc69703b368~yoHBZMIBT3150731507euoutp01b
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 10:20:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200212102023euoutp01de47a2d4d7c8efb364fffcc69703b368~yoHBZMIBT3150731507euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581502823;
        bh=nJIMo/hmctKSAepFMBORmUEOiA95WQ4W8/e/ZxU9jaM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=AqY+HzEvHjbhTHD5uuMNZrzwBjIQo6W//piVoKe9k/diB0hU8cdbj9+BFGF5V1RGp
         xQvPeucEsBH9Z5eAeW2NZokxtY+tVGWIXKg0jOfcMW4A/sj6JoElY1wqkdPzcw2xpH
         T3+8NNdWD8I9kHbLcV9cWoNpEoX9aR6HX4I2IvZw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200212102023eucas1p2555d9d8d2bc71e11a5b185788e5001ba~yoHBJn__T0070600706eucas1p2A;
        Wed, 12 Feb 2020 10:20:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 54.CC.60679.761D34E5; Wed, 12
        Feb 2020 10:20:23 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200212102022eucas1p1c49daf15d3e63eda9a56124bc4eafb57~yoHA3l_qw0607406074eucas1p1Y;
        Wed, 12 Feb 2020 10:20:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200212102022eusmtrp1d294fd0d12b2145c659cd794b3725792~yoHA2__-n1418814188eusmtrp1v;
        Wed, 12 Feb 2020 10:20:22 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-2b-5e43d167bc3c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7C.9E.08375.661D34E5; Wed, 12
        Feb 2020 10:20:22 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200212102022eusmtip2426b56ff9c670b9f841aa901adba3b19~yoHAd-Rsm1735217352eusmtip2a;
        Wed, 12 Feb 2020 10:20:22 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH] ARM: bcm2835_defconfig: add minimal support for Raspberry
 Pi4
Date:   Wed, 12 Feb 2020 11:20:09 +0100
Message-Id: <20200212102009.17428-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsWy7djPc7rpF53jDE7fFbDY9Pgaq8XlXXPY
        LCbe3sBusfbIXXaLbbOWs1lsWnGDzYHNY+stU4/NS+o9+rasYvTYfLra4/MmuQDWKC6blNSc
        zLLUIn27BK6M1kaVgh9sFZ8XtzE2MLawdTFyckgImEisnfsIyObiEBJYwSgxf9JeRgjnC6NE
        6+vtLBDOZ0aJ0/PnMsK0HJt3EaplOaPE9tuz2OBalp88wgJSxSZgKNH1tgsowcEhIpAnsfZT
        MkiYWaCLUeJ3GzeILSwQIPF77g12EJtFQFWi6fAtsAW8ArYSa688grpPXmL1hgPMIPMlBI6w
        SVy6cpIJIuEi0fb/LwuELSzx6vgWdghbRuL05B4WiIZmRomH59ayQzg9jBKXm2ZA/WAtcefc
        L7DrmAU0Jdbv0ocIO0o83baJHSQsIcAnceOtIMTRfBKTtk1nhgjzSnS0CUFUq0nMOr4Obu3B
        C5eYIWwPiaVXZoEtEhKIlXjT94J1AqPcLIRdCxgZVzGKp5YW56anFhvlpZbrFSfmFpfmpesl
        5+duYgTG/ul/x7/sYNz1J+kQowAHoxIPr8N0pzgh1sSy4srcQ4wSHMxKIrzijc5xQrwpiZVV
        qUX58UWlOanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTDueLjalfVej/7Vazs/
        +N0pv5nXOOmXz9Imganse+4ksZgevfznMaOGt4v7eb3a6lbdi/e6/s+UUZCrVHl3sTTjbeYs
        A3FtzZN7e06e4xXV2WazQkfEaf2EL+1SGW+di9nSb/+JkMvfNWt1Q/6DwwXuer9uZc6O9T12
        JKG4Qk034JjK+x8i0t1KLMUZiYZazEXFiQDEwgvT+QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsVy+t/xe7ppF53jDObdNbfY9Pgaq8XlXXPY
        LCbe3sBusfbIXXaLbbOWs1lsWnGDzYHNY+stU4/NS+o9+rasYvTYfLra4/MmuQDWKD2bovzS
        klSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M1kaVgh9sFZ8X
        tzE2MLawdTFyckgImEgcm3cRyObiEBJYyiixpXUOK0RCRuLktAYoW1jiz7UuqKJPjBKTuiew
        gyTYBAwlut52gU0SESiQOPnlGytIEbNAD6PEqSPvmEASwgJ+Ev+XPQCzWQRUJZoO32IEsXkF
        bCXWXnkEdYa8xOoNB5gnMPIsYGRYxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERh024793LyD
        8dLG4EOMAhyMSjy8DtOd4oRYE8uKK3MPMUpwMCuJ8Io3OscJ8aYkVlalFuXHF5XmpBYfYjQF
        Wj6RWUo0OR8YEXkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhgb
        BTyZJ/1S+JWsNo+nK2TuI37XNb1n7l0P/v9M6zJrOHPZ456T9l9atdW8hWf/4ytYO7fNNzdE
        bGvxGtkrkXv0nr2UKHx886BlwsQ50ibRMXuis5YFXr7xet3tdxxVMzbf0Hr9dfUdIb7i27UL
        j93YunrtQ85cx9v7n89iKTlVzuyWFarWKHlEiaU4I9FQi7moOBEAxg5WslACAAA=
X-CMS-MailID: 20200212102022eucas1p1c49daf15d3e63eda9a56124bc4eafb57
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200212102022eucas1p1c49daf15d3e63eda9a56124bc4eafb57
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200212102022eucas1p1c49daf15d3e63eda9a56124bc4eafb57
References: <CGME20200212102022eucas1p1c49daf15d3e63eda9a56124bc4eafb57@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add drivers for the minimal set of devices needed to boot Raspberry Pi4
board.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/configs/bcm2835_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 519ff58e67b3..b5e7c1bd95f2 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -72,6 +72,7 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_NETDEVICES=y
+CONFIG_BCMGENET=y
 CONFIG_USB_LAN78XX=y
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_SMSC95XX=y
@@ -99,6 +100,8 @@ CONFIG_THERMAL=y
 CONFIG_BCM2835_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_GPIO=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_DRM=y
-- 
2.17.1

