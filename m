Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DC1C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCE8206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="N4pq87+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbgBQPzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:55:17 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39664 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbgBQPzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:55:15 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200217155513euoutp01a4c4a028b5b7823e329fd641b24a6c3d~0O5zWhBwq2549925499euoutp016
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 15:55:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200217155513euoutp01a4c4a028b5b7823e329fd641b24a6c3d~0O5zWhBwq2549925499euoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581954913;
        bh=/MCPIp7JR90nH/q9PqMYouhBTbhTCPX9OW6qy3nNNL8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=N4pq87+bP6H3f2TnlO5D+v6w+CsW/H4/J94Klxzeh4WMv3udRqM21sH74Nc+Gha3y
         J131scv+fUUc9hWP7L2pRs6VAA2/ClBOQ++GkzTv5QZs/9iJjlrsK7pkYQ+1S3Luab
         VG68oHDAaMnKYGHi+ShTNrV/UBQUqg73oxdBCH88=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200217155513eucas1p18f1c83e6f03d828c0261131b26580bd2~0O5zKznIM2953229532eucas1p1e;
        Mon, 17 Feb 2020 15:55:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 62.65.60679.167BA4E5; Mon, 17
        Feb 2020 15:55:13 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200217155513eucas1p2f97cb31428fd50181a4fe16682322d8f~0O5y1JRIm0042400424eucas1p2E;
        Mon, 17 Feb 2020 15:55:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200217155513eusmtrp1b168aa000ee729f1d2adae6b6a64e790~0O5y0gCum0829708297eusmtrp1a;
        Mon, 17 Feb 2020 15:55:13 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-c2-5e4ab761cb96
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C2.17.08375.167BA4E5; Mon, 17
        Feb 2020 15:55:13 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200217155512eusmtip2bd7766ba51e8169a7dde89d471308b11~0O5ye6Uz32743127431eusmtip2N;
        Mon, 17 Feb 2020 15:55:12 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2] ARM: bcm2835_defconfig: add support for Raspberry Pi4
Date:   Mon, 17 Feb 2020 16:55:06 +0100
Message-Id: <20200217155506.5245-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsWy7djPc7qJ273iDPrnalhsenyN1eLyrjls
        FhNvb2C3WHvkLrvFtlnL2Sw2rbjB5sDmsfWWqcfmJfUefVtWMXpsPl3t8XmTXABrFJdNSmpO
        Zllqkb5dAlfGvDmnWAuaOSo+HHrO2MDYyN7FyMEhIWAi0Xnfp4uRi0NIYAWjxJ+u1SwQzhdG
        iWNL3rBBOJ8ZJY5v/Q3kcIJ1nNl1iQkisRyo6vkiZriWj1f3MYNUsQkYSnS97WID2SEikCex
        9lMySJhZoItR4ncbN0hYWMBT4uY6aZAwi4CqxPldnWCdvAI2Eq+mfWaC2CUvsXrDAWYI+wyb
        xOY9QhC2i8SGu91QcWGJV8e3sEPYMhKnJ/eAfSAh0Mwo8fDcWnYIp4dR4nLTDEaIKmuJO+d+
        gd3GLKApsX6XPkTYUaJp6hFWSLDwSdx4KwhxMp/EpG3TmSHCvBIdbVAnqEnMOr4Obu3BC5eg
        zvGQWPZ8FziohARiJX5+2Mg6gVFuFsKuBYyMqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3
        MQLj/vS/4192MO76k3SIUYCDUYmHN6DPK06INbGsuDL3EKMEB7OSCK+3OFCINyWxsiq1KD++
        qDQntfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUwWSYOTqkGRq11+68/64/dJKRb71+fwnDP
        u90oeE9m8LmzKuet2I+EffX8weKbaWbdu5zvgeBX1tcrPqQIXvmrtT6mIXESz5qkc98C+uyb
        vu5h2BN4g+XenbMmdpfzPjw8tktAijeo6e6Z2QeYxQS5t6aGTiravtdeaUNl1qF6neuXvq4N
        +f5wxaxv73vN9yuxFGckGmoxFxUnAgCiDBhp9wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsVy+t/xe7qJ273iDH7NELHY9Pgaq8XlXXPY
        LCbe3sBusfbIXXaLbbOWs1lsWnGDzYHNY+stU4/NS+o9+rasYvTYfLra4/MmuQDWKD2bovzS
        klSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MeXNOsRY0c1R8
        OPScsYGxkb2LkZNDQsBE4syuS0xdjFwcQgJLGSV2fbvGCJGQkTg5rYEVwhaW+HOtiw2i6BOj
        xMeju8CK2AQMJbregiQ4OUQECiROfvnGClLELNDDKHHqyDugsRwcwgKeEjfXSYPUsAioSpzf
        1ckMYvMK2Ei8mvaZCWKBvMTqDQeYJzDyLGBkWMUoklpanJueW2yoV5yYW1yal66XnJ+7iREY
        dNuO/dy8g/HSxuBDjAIcjEo8vAF9XnFCrIllxZW5hxglOJiVRHi9xYFCvCmJlVWpRfnxRaU5
        qcWHGE2Blk9klhJNzgdGRF5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4m
        Dk6pBkbnEp8v/LfKHp8v8KstkT4nuK7+7SmPa83Czzkllqz775kxsTBx4bFr9X+nijtqcjNM
        ODSrk2GGgnndtccRbM0HVPILDDb97T2amfko0qHzb/HERyFPX81bFfu8TqVaP6797vEQ/Zst
        22+/2HNTh19ekEHxE3ddZMqRz8LM4Zke9avPSK++4K7EUpyRaKjFXFScCAA+XfO+UAIAAA==
X-CMS-MailID: 20200217155513eucas1p2f97cb31428fd50181a4fe16682322d8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200217155513eucas1p2f97cb31428fd50181a4fe16682322d8f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200217155513eucas1p2f97cb31428fd50181a4fe16682322d8f
References: <CGME20200217155513eucas1p2f97cb31428fd50181a4fe16682322d8f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add drivers needed to boot Raspberry Pi4 board.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- added BCM2711_THERMAL
---
 arch/arm/configs/bcm2835_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 519ff58e67b3..38437541ea76 100644
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
@@ -96,9 +97,13 @@ CONFIG_SPI_BCM2835AUX=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_THERMAL=y
+CONFIG_BCM2711_THERMAL=y
 CONFIG_BCM2835_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
+CONFIG_MFD_SYSCON=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_GPIO=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_DRM=y
-- 
2.17.1

