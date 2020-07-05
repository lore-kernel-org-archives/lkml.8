Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F4EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 07:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CE221D93
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 07:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qtzhYWv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgGEHSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 03:18:12 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:47443 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgGEHSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 03:18:11 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200705071808epoutp047c66446169d478ee0a89699ef9a2fe2e~eyg-0SdHR0593005930epoutp048
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 07:18:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200705071808epoutp047c66446169d478ee0a89699ef9a2fe2e~eyg-0SdHR0593005930epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593933488;
        bh=HCXrofelDS9SJIsUKOUl2fb+5VFxATXUSmCxo5+ME6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qtzhYWv7SLusFOZ6syqnY4naSYsTOo5ea0cJBm7lDJyt/88KqZCil2JMneAH8l+6+
         QNIePeZxG1VVjYwNFylSOrQzUvkad6+Rmn8LULjSZFiZ+/Lr5jTh2IfsmuwOutYCEe
         FxVtJo1sWBErSjNqmqaK5ZT/cX/CGUjxu61dSRIE=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200705071806epcas5p11f96c18a9a9505f3a8cce5c5aad47755~eyg_sijdp1567215672epcas5p1F;
        Sun,  5 Jul 2020 07:18:06 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.E6.09475.EAE710F5; Sun,  5 Jul 2020 16:18:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20200705071806epcas5p27abbd5b89689ab16328807bb5a213abf~eyg_R3ihG0437304373epcas5p2T;
        Sun,  5 Jul 2020 07:18:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200705071806epsmtrp17eafbad0b0f769f755e65319b2d71e7a~eyg_RL0Dc3273532735epsmtrp10;
        Sun,  5 Jul 2020 07:18:06 +0000 (GMT)
X-AuditID: b6c32a4b-39fff70000002503-1a-5f017eae1e6c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.9D.08303.EAE710F5; Sun,  5 Jul 2020 16:18:06 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200705071805epsmtip1e95df8d501caf7a85580551922f2060f~eyg9MAg_V0149301493epsmtip1l;
        Sun,  5 Jul 2020 07:18:05 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     rzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH 2/2] arm64: dts: exynos: keep LDO12 always-on
Date:   Sun,  5 Jul 2020 12:27:47 +0530
Message-Id: <20200705065747.63014-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200705065747.63014-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCmpu66OsZ4g8uHtCwezNvGZjH/yDlW
        i02Pr7FaXN41h81ixvl9TBate4+wW+x8/4HRgd1j06pONo/NS+o9+rasYvT4vEkugCWKyyYl
        NSezLLVI3y6BK+PanausBdfZKpYsvsHWwHiGtYuRg0NCwERif0tmFyMXh5DAbkaJBzfWMHcx
        cgI5nxglXq1xhEh8ZpT4dGMPWAKkYefaiUwQiV2MEt2bl0I5LUwSayc0MYFUsQloS9ydvgXM
        FhEQkjjQ8IsFpIhZ4AijRMP5F2AJYQFbif6/z8BsFgFViS+n/rOA2LwCNhKts66zQayTl1i9
        4QAzyK2cQPVX+t1B5kgI7GOXOLD4HgtEjYvEtY+rmCBsYYlXx7ewQ9hSEi/729gh/syW6Nll
        DBGukVg67xhUq73EgStzWEBKmAU0Jdbv0gcJMwvwSfT+fsIE0ckr0dEmBFGtKtH87ipUp7TE
        xO5uVgjbQ2LP3SPskGCYwCgx+8Ie1gmMsrMQpi5gZFzFKJlaUJybnlpsWmCcl1quV5yYW1ya
        l66XnJ+7iREc6VreOxgfPfigd4iRiYPxEKMEB7OSCG+vNmO8EG9KYmVValF+fFFpTmrxIUZp
        DhYlcV6lH2fihATSE0tSs1NTC1KLYLJMHJxSDUwB7/9UVO6xjmrJDX3j/feLTa1JmdDWd3aZ
        D6K6Ope5N25z/r/8npzdkl3ft91q/KO9/W7VLtVE3Yqd29SW918JrnfhaJr4qLDrYiWv9JKQ
        K7aapl9n13582KnaEbXo1w8no2/7gtizGQ6JdPqutNo5OXP1jh1crEn+p3Xirn91Z4t6LzT/
        WvJ5k+B9+qrPTN5nif8PkF2Q9GeKyuVpoeJnX1+MOv2iosd24vMT+xm0gyt+1t2reLnSyiD2
        YNNW3g9TZhdun2Hy4+F5e8d/mXfjdE/OOyRepW9k2pst19p7jEOrUW7S7Kn31/stNtOLrS2Y
        VJ474eXtc/uPqwXv3KR0Yt/psxM+yMsa3l9Rf+6IEktxRqKhFnNRcSIAb6qcj2MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsWy7bCSnO66OsZ4gzUP+C0ezNvGZjH/yDlW
        i02Pr7FaXN41h81ixvl9TBate4+wW+x8/4HRgd1j06pONo/NS+o9+rasYvT4vEkugCWKyyYl
        NSezLLVI3y6BK+PanausBdfZKpYsvsHWwHiGtYuRk0NCwERi59qJTF2MXBxCAjsYJWauhUlI
        S1zfOIEdwhaWWPnvOTtEUROTxLELy1lAEmwC2hJ3p29hArFFBIQkDjT8YgEpYhY4xSjRv30z
        WLewgK1E/99nYEUsAqoSX079B2vmFbCRaJ11nQ1ig7zE6g0HmLsYOTg4geqv9LuDhIWASr5d
        fM82gZFvASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4FDT0trBuGfVB71DjEwc
        jIcYJTiYlUR4e7UZ44V4UxIrq1KL8uOLSnNSiw8xSnOwKInzfp21ME5IID2xJDU7NbUgtQgm
        y8TBKdXApLdhsb6gdLO9W7Fc5B7WTx4MctGuPc9W5He/rTVbIL/SJHP1vK+X+FW/TDfOafQz
        iPU4Vvxmf03NQYMHvDwMZumLFWVigy5NvlP8qmUTQ1nLMbsbHNtv9FVurdoxR2IXX978rGv6
        vdGr7wZ3CUb+qQ53+S741ivCYttpke9HWYMuTnjxXMD+T/apjRNVlP65/jyXP1vnTob85Z5T
        +0MubMitVPrhMz9/TqzRTmmdH4d+VF5TSPx4NiAspF2de+vaGS8uPFOZoZCqPuPYiiuZ298E
        tKRdaH7bvMtKL7KvJN0//WjO4WfxjF1amyOig3Uj8rfmHs+5fTmg9ldcptwslcm1tV9FZk64
        5ZRocPSgEktxRqKhFnNRcSIANJ+58aQCAAA=
X-CMS-MailID: 20200705071806epcas5p27abbd5b89689ab16328807bb5a213abf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200705071806epcas5p27abbd5b89689ab16328807bb5a213abf
References: <20200705065747.63014-1-alim.akhtar@samsung.com>
        <CGME20200705071806epcas5p27abbd5b89689ab16328807bb5a213abf@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LDO12 on exynos7 supply power to VDDQ_UFS20_RESET,
in case this regulator is OFF, UFS host controller
can not send command to UFS device. To keep this supply
ON, set regulator-always-on property for this ldo.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index bb86950032d3..92fecc539c6c 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -194,6 +194,7 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1300000>;
 				regulator-enable-ramp-delay = <125>;
+				regulator-always-on;
 			};
 
 			ldo13_reg: LDO13 {
-- 
2.17.1

