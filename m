Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E8FC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3052464B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VGnKA1Zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgAQMe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 07:34:58 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40354 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgAQMe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:34:56 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200117123455euoutp011c16ae305da4080c792e80fed475ef98~qrLD_5msI1050610506euoutp01k
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 12:34:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200117123455euoutp011c16ae305da4080c792e80fed475ef98~qrLD_5msI1050610506euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579264495;
        bh=GMVdAIxOIz/ZFu0nmZbzF8NWVi08+hfhTOrhodCitKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VGnKA1ZuP6DZd/guz22YpjpuLj8I9jzgHWwpOnG+8kFttw5AhvW+Z8/+11vCzxALu
         JkTkwOsg/8vJZ75qloR++L/kZjXWGV8Tqj9TOPEYulNGQhzbazQLxAINM3hxJwdPpm
         FaJ5McWnB5SK98yh1Vc3TxB1GyUPS66jeR/B7IQc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200117123455eucas1p1000beb0a94cf8ae3436690e497d68d7a~qrLDpQh7-2170321703eucas1p1p;
        Fri, 17 Jan 2020 12:34:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E5.7F.60679.FE9A12E5; Fri, 17
        Jan 2020 12:34:55 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200117123454eucas1p28093460c40e4300d4a58f7809f614135~qrLDTg9P81728517285eucas1p20;
        Fri, 17 Jan 2020 12:34:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200117123454eusmtrp27236455864185b957cfb182188abad96~qrLDS8naY1254212542eusmtrp2v;
        Fri, 17 Jan 2020 12:34:54 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-11-5e21a9ef9266
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AD.69.07950.EE9A12E5; Fri, 17
        Jan 2020 12:34:54 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200117123454eusmtip2e9e2eac9c4ffa1501ad0d2ea4d052998~qrLC6qUaz1151011510eusmtip2C;
        Fri, 17 Jan 2020 12:34:54 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 3/3] ARM: multi_v7_defconfig: Enable devfreq thermal
 integration
Date:   Fri, 17 Jan 2020 13:34:48 +0100
Message-Id: <20200117123448.13807-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200117123448.13807-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7djPc7rvVyrGGby5z2qxccZ6VovrX56z
        Wpw/v4Hd4vKuOWwWM87vY7JYe+QuuwObx6ZVnWwefVtWMXp83iQXwBzFZZOSmpNZllqkb5fA
        lTFtwm+mgofsFTsuT2JvYLzN1sXIySEhYCJxddVLIJuLQ0hgBaPE6+1tzBDOF0aJBYfvsUA4
        nxklrl7azwjTcmHpRlaIxHJGiY6Zd1jhWr5PuMMCUsUmYCjR9bYLbImIgLNEw9RGJpAiZoFt
        QEsWzGQHSQgLBEk0f/kBZrMIqEr871wBtIKDg1fAVmL1NV6IbfISqzccYAYJcwrYSXy55Acy
        RkLgOpvEk/4JrBA1LhI7Nj+Fuk5Y4tXxLewQtozE/53zmSAamhklHp5byw7h9DBKXG6aAdVh
        LXHn3C82kA3MApoS63fpQ4QdJXYsmsgKEpYQ4JO48VYQJMwMZE7aNp0ZIswr0dEmBFGtJjHr
        +Dq4tQcvXGKGsD0kLjY/Y4KEz0RGiXUvW1gnMMrPQli2gJFxFaN4amlxbnpqsVFearlecWJu
        cWleul5yfu4mRmAiOP3v+JcdjLv+JB1iFOBgVOLhLVimGCfEmlhWXJl7iFGCg1lJhPduL1CI
        NyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUwWSYOTqkGxgYO1cVl3gb7
        v1Sqq8wN37pEpeyd68yj/07bMK8WCDA96O5Y2vrv0dPgIKmq7S+tlz9TXp5x0kTc6bHMntDP
        v5oUW2bYzlq27QbDe/YjV1out1SdKb7zd9OjpB5hxUMzM/y/b19k1hW4Li9TwPZv1iyp/Z/O
        zajfeHHF821PjdT65/259N3m4BMlluKMREMt5qLiRABES3LvAAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsVy+t/xe7rvVirGGTTs0rXYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLGef3MVmsPXKX3YHNY9OqTjaPvi2rGD0+b5ILYI7SsynKLy1JVcjILy6x
        VYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy5g24TdTwUP2ih2XJ7E3MN5m
        62Lk5JAQMJG4sHQjaxcjF4eQwFJGibu3P7BCJGQkTk5rgLKFJf5c6wJrEBL4xCjxdX8NiM0m
        YCjR9RYiLiLgKnFoRS8zyCBmgR2MEt0tF9hBEsICARJX7sxnBLFZBFQl/neuALI5OHgFbCVW
        X+OFmC8vsXrDAWaQMKeAncSXS34Qq2wlepbdYJ7AyLeAkWEVo0hqaXFuem6xkV5xYm5xaV66
        XnJ+7iZGYEhuO/Zzyw7GrnfBhxgFOBiVeHgLlinGCbEmlhVX5h5ilOBgVhLhvdsLFOJNSays
        Si3Kjy8qzUktPsRoCnTSRGYp0eR8YLzklcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1O
        TS1ILYLpY+LglGpg9L+T+SJdyLBJ4uJK5VnvGMO2ir7q5ozd/qXQzth7UemdG1ddZMqKNxzq
        n6z9fJbPSluJD7qHnP5vYl7EmF1vVZj8Z0N4zveMtudPv5lWbM+6K6YruuSChWbUg8JI/6wp
        L/7/+vGwe8GhkLzJ2vwTWXlvKSuqqrOd45ZWz5iwZH2imUl+BnuzEktxRqKhFnNRcSIAvnit
        EF8CAAA=
X-CMS-MailID: 20200117123454eucas1p28093460c40e4300d4a58f7809f614135
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200117123454eucas1p28093460c40e4300d4a58f7809f614135
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200117123454eucas1p28093460c40e4300d4a58f7809f614135
References: <20200117123448.13807-1-m.szyprowski@samsung.com>
        <CGME20200117123454eucas1p28093460c40e4300d4a58f7809f614135@eucas1p2.samsung.com>
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
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 80373fe0280d..cc7f9533b3ef 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -492,6 +492,7 @@ CONFIG_SENSORS_PWM_FAN=m
 CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_CPU_THERMAL=y
+CONFIG_DEVFREQ_THERMAL=y
 CONFIG_IMX_THERMAL=y
 CONFIG_ROCKCHIP_THERMAL=y
 CONFIG_RCAR_THERMAL=y
-- 
2.17.1

