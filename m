Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C613C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 07:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A5620702
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 07:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YkXHzbfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgGEH3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 03:29:45 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:58245 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgGEH3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 03:29:43 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200705072940epoutp03cbb8c2b1d177427e0af0e357e71fcb7a~eyrE3YMXB2897928979epoutp03G
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 07:29:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200705072940epoutp03cbb8c2b1d177427e0af0e357e71fcb7a~eyrE3YMXB2897928979epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593934180;
        bh=HCXrofelDS9SJIsUKOUl2fb+5VFxATXUSmCxo5+ME6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YkXHzbfFO3QhVEl9Vkm/Ro6DN/mrf3wpVfiGkRIR/no0Etg+ZSTkJ1E4byZVqgQNE
         9bkNjdgm04YzT+RqCw93OWJtfzk+H/OOxg9bFQYyrm/95uBqX6TviqvmAbAi3SkmX8
         jEp/PPz5OIJ4A0127ruSW7KQ+uq3DjovAzEbTHhI=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200705072940epcas5p3bdf73fe71b1a3dc73d743486cb915007~eyrEar5BZ0709407094epcas5p3A;
        Sun,  5 Jul 2020 07:29:40 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.DA.09467.461810F5; Sun,  5 Jul 2020 16:29:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200705072938epcas5p479f0d040ca34fd44b2ba893a199efb79~eyrDUeq5_1034110341epcas5p4M;
        Sun,  5 Jul 2020 07:29:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200705072938epsmtrp27740552f019671b8d43c346effbdcded~eyrDT1XiP1761217612epsmtrp2g;
        Sun,  5 Jul 2020 07:29:38 +0000 (GMT)
X-AuditID: b6c32a49-a29ff700000024fb-d8-5f018164af4f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.BD.08303.261810F5; Sun,  5 Jul 2020 16:29:38 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200705072937epsmtip14588e58cb12f7ebec4b2fde1bf2c716e~eyrCLcEy-0149301493epsmtip1N;
        Sun,  5 Jul 2020 07:29:37 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     krzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v1 2/2] arm64: dts: exynos: keep LDO12 always-on
Date:   Sun,  5 Jul 2020 12:39:18 +0530
Message-Id: <20200705070918.63531-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200705070918.63531-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCmlm5KI2O8wfMPrBYP5m1js5h/5Byr
        xfnzG9gtNj2+xmpxedccNosZ5/cxWbTuPcLuwO6xaVUnm8fmJfUefVtWMXp83iQXwBLFZZOS
        mpNZllqkb5fAlXHtzlXWgutsFUsW32BrYDzD2sXIySEhYCJx9e08RhBbSGA3o8STNdZdjFxA
        9idGiSXnZ7JBOJ8ZJVp3PmGG6Tg98QU7RGIXo8S9xU+hnBYmiYNL74BVsQloS9ydvoUJxBYR
        EJa4t3Q5WBGzwBFGiYbzL8ASwgIOEvfvdoIdwiKgKnFqyjk2EJtXwEZi1ubFLBDr5CVWbzgA
        NpRTwFZi6stnTBDxfewSbcd8IGwXialnuhghbGGJV8e3sEPYUhKf3+0FmskBZGdL9OwyhgjX
        SCyddwxqvL3EgStzWEBKmAU0Jdbv0gcJMwvwSfT+fsIE0ckr0dEmBFGtKtH87ipUp7TExO5u
        VogSD4kjbamQUJjAKLGy+zHbBEbZWQhDFzAyrmKUTC0ozk1PLTYtMMxLLdcrTswtLs1L10vO
        z93ECI50Lc8djHcffNA7xMjEwXiIUYKDWUmEt1ebMV6INyWxsiq1KD++qDQntfgQozQHi5I4
        r9KPM3FCAumJJanZqakFqUUwWSYOTqkGprIZqyUY29UEfle9nenhUx7zKvdvSdivSveIjtU8
        PS2z1W/9jDXWf7nLxvH/WcN1V+rTZIM+XjNWvRVwbteUEKef+0S57zBb/0qcv/EijzZ/j5Jn
        8E/VrQcr1jEfVtwxvfOwvOeezJuJq/XFKxU+fHD7cPLw8e+r485tt4tbKs7AdJbd/XYk+xb7
        uIcnsr54sSqeOuyRajD56YZJj8KfNXBW3/nRcfy5sXrBs6TVW8z+pKs+khIMT3jr2Kfv87rc
        e1F9EDvDnI3lT4qS2N4sOcLB1Hv7R9JcRsmfW7kmPTSRYdm//vQJk53XZjt9jdu7UnT236hT
        XNfnzmoXfv/iu1/1nM8uF//KnL5oq/d4/mUlluKMREMt5qLiRAC0WxAYYwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprELMWRmVeSWpSXmKPExsWy7bCSnG5SI2O8weYTRhYP5m1js5h/5Byr
        xfnzG9gtNj2+xmpxedccNosZ5/cxWbTuPcLuwO6xaVUnm8fmJfUefVtWMXp83iQXwBLFZZOS
        mpNZllqkb5fAlXHtzlXWgutsFUsW32BrYDzD2sXIySEhYCJxeuIL9i5GLg4hgR2MEi83T2KH
        SEhLXN84AcoWllj57zlUUROTxKUtXxlBEmwC2hJ3p29hArFFgIruLV0OVsQscIpRon/7ZrBu
        YQEHift3O8HWsQioSpyaco4NxOYVsJGYtXkxC8QGeYnVGw4wg9icArYSU18+AxsqBFTTP2s5
        8wRGvgWMDKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYKDTUtrB+OeVR/0DjEycTAe
        YpTgYFYS4e3VZowX4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvt11sI4IYH0xJLU7NTUgtQimCwT
        B6dUA9OlabdcN/VJNVhnXHl4ePI+ewaWs7bHCxrZrr3cF9y1ct3hh32qp3N4dwdYhPKsLKtX
        WenveOflysVipbtSP9X82s6UJ7LiUeeMBxvYT2SmhD52k78c/dQxbL703tLm1Zuj5SKTD+6s
        Cvq/XHV/1c0VDnwbbO1PC1ddlzXzSI69V/JgyZeZrFX6lfWb7FYs5oqU2DMznveVxoFNk1Ie
        svPf6L1x5NsFI9k4Y50/Iak+sxQeGlwO0PFUfex/u6ujcPK1iXfkBPa2Mb1wuq4W0FWQJuFj
        bz9l80WGqJk52mfPnXFMPn199Q39jczZLLN+Km9c9aPpamDP1ayOc1k9253UyzhqpoWJ5V0y
        V4yckq/EUpyRaKjFXFScCABi/LPcpQIAAA==
X-CMS-MailID: 20200705072938epcas5p479f0d040ca34fd44b2ba893a199efb79
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200705072938epcas5p479f0d040ca34fd44b2ba893a199efb79
References: <20200705070918.63531-1-alim.akhtar@samsung.com>
        <CGME20200705072938epcas5p479f0d040ca34fd44b2ba893a199efb79@epcas5p4.samsung.com>
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

