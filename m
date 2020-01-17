Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2A5C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EF42083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WVIk9WZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAQMe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 07:34:56 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36374 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgAQMe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:34:56 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200117123455euoutp02b9b6bf92ca89e7e3a3167fe0c5b7a1a5~qrLDl61I01680516805euoutp02k
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 12:34:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200117123455euoutp02b9b6bf92ca89e7e3a3167fe0c5b7a1a5~qrLDl61I01680516805euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579264495;
        bh=F25q0dx4N/0otUjQDoHpV71xu06zNDNkTXl4Brete48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WVIk9WZ7igwbiY57pJGt76wHKXABLcMBN1KFBNH7qdPB/s9lvzn6i/1A2ZnSh7wqQ
         2zsCs3bWrB8WpSgwr46spkIuci3AnFVwuv2XhkF0C7bit2M3KbEYzEcQSZ3YAuf/tB
         QS7u/n9tUw0h1p4JBE4BMzJStkqSZOcMJVkOZZ4o=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200117123454eucas1p23c0c5069e2790d347ffc84f6a96d9f4d~qrLDOjdKY1731917319eucas1p2t;
        Fri, 17 Jan 2020 12:34:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 75.7F.60679.EE9A12E5; Fri, 17
        Jan 2020 12:34:54 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200117123454eucas1p1e8f0e527dc39f1e0993b14c7098002e4~qrLC-7z6u1979919799eucas1p1h;
        Fri, 17 Jan 2020 12:34:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200117123454eusmtrp1553c3f46c879c87089ac5ba875aed1da~qrLC-Ympv0166501665eusmtrp1u;
        Fri, 17 Jan 2020 12:34:54 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-0f-5e21a9eed3ce
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CB.C8.08375.EE9A12E5; Fri, 17
        Jan 2020 12:34:54 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200117123454eusmtip23bc56662ae3e42b6cbef4d1d8707c7be~qrLCkYGbi1301313013eusmtip2C;
        Fri, 17 Jan 2020 12:34:53 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 2/3] ARM: exynos_defconfig: Enable devfreq thermal
 integration
Date:   Fri, 17 Jan 2020 13:34:47 +0100
Message-Id: <20200117123448.13807-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200117123448.13807-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7djP87rvVirGGWydoGWxccZ6VovrX56z
        Wpw/v4Hd4vKuOWwWM87vY7JYe+QuuwObx6ZVnWwefVtWMXp83iQXwBzFZZOSmpNZllqkb5fA
        ldE206fgGnvF5xPzmBsYL7B1MXJySAiYSJxbcYGli5GLQ0hgBaPEydcX2SCcL4wSk26vgcp8
        ZpSYc+AUK0zL8i2f2EFsIYHljBL7F7LCdZx4vY4ZJMEmYCjR9bYLbIeIgLNEw9RGJpAiZoFt
        jBKvF8wE6xYWCJD48RyiiEVAVWL2iQdANgcHr4CtRMtmG4hl8hKrNxxgBglzCthJfLnkBxG+
        ziaxaoENSFhCwEVi1ZpiiLCwxKvjW9ghbBmJ05N7wO6XEGhmlHh4bi07hNPDKHG5aQYjRJW1
        xJ1zv8DWMgtoSqzfpQ8x01Fi90NNCJNP4sZbQZBiZiBz0rbpzBBhXomONiGIGWoSs46vg9t6
        8MIlZgjbQ+LT1W/Q4JzIKPHg9FamCYzysxB2LWBkXMUonlpanJueWmyUl1quV5yYW1yal66X
        nJ+7iREY/6f/Hf+yg3HXn6RDjAIcjEo8vAXLFOOEWBPLiitzDzFKcDArifDe7QUK8aYkVlal
        FuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvEwSnVwOg//esGF47E6yvfZ9op
        vn59iPfGrm2a376FTLvewFxtKhP8qUY3ZUV4hpL18jVFtW+eBhkteXi19LedUr3Qjchlkx28
        U1ROp9WKRzyNyt42u3IB00dR4aXzFvd1iqnaMPXML16tOO/JP4n6E5sWC2wSir5v80xrb4EM
        zzVe9507tzCah2hJ1CmxFGckGmoxFxUnAgDMv3E2+wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t/xe7rvVirGGbzYI2axccZ6VovrX56z
        Wpw/v4Hd4vKuOWwWM87vY7JYe+QuuwObx6ZVnWwefVtWMXp83iQXwBylZ1OUX1qSqpCRX1xi
        qxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl9E206fgGnvF5xPzmBsYL7B1
        MXJySAiYSCzf8om9i5GLQ0hgKaPEpFOLWSESMhInpzVA2cISf651gTUICXxilJj8uQrEZhMw
        lOh6CxEXEXCVOLSilxlkELPADkaJ7pYL7CAJYQE/iecLbjKD2CwCqhKzTzwAauDg4BWwlWjZ
        bAMxX15i9YYDzCBhTgE7iS+X/CBW2Ur0LLvBPIGRbwEjwypGkdTS4tz03GJDveLE3OLSvHS9
        5PzcTYzAgNx27OfmHYyXNgYfYhTgYFTi4S1YphgnxJpYVlyZe4hRgoNZSYT3bi9QiDclsbIq
        tSg/vqg0J7X4EKMp0EkTmaVEk/OB0ZJXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1
        tSC1CKaPiYNTqoGx7U2eye7JQl7tT/f/Y7aey/hIUX+yUKv62iuP9wd/PKv0ouVSVuva2au2
        HhTcus9v5fpz5eaPivLf+amkLrQ3Uj3n2c73NbdLsen7hqRV96XV9y09HXv2qvPJX/t1n2sf
        eaVZbJcmNOOUkq7iUp79avlPeNVmaxdZazFvF1ienyO9/XoAH6eEEktxRqKhFnNRcSIAVt6r
        Hl4CAAA=
X-CMS-MailID: 20200117123454eucas1p1e8f0e527dc39f1e0993b14c7098002e4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200117123454eucas1p1e8f0e527dc39f1e0993b14c7098002e4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200117123454eucas1p1e8f0e527dc39f1e0993b14c7098002e4
References: <20200117123448.13807-1-m.szyprowski@samsung.com>
        <CGME20200117123454eucas1p1e8f0e527dc39f1e0993b14c7098002e4@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panfrost driver provides a devfreq driver for the Mali GPU and allows to
scale GPU core frequency. Enable support for devfreq thermal integration
to enable cooling of GPU thermal zone by reducing GPU core frequency.

This fixes following warning during boot on Exynos5422-based Odroid XU4:

panfrost 11800000.gpu: [drm:panfrost_devfreq_init] Failed to register cooling device

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index c05263de08a5..d80dbdaf00f8 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -155,6 +155,7 @@ CONFIG_SENSORS_NTC_THERMISTOR=y
 CONFIG_SENSORS_PWM_FAN=y
 CONFIG_SENSORS_INA2XX=y
 CONFIG_CPU_THERMAL=y
+CONFIG_DEVFREQ_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
-- 
2.17.1

