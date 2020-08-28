Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975F2C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F97C20825
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hGMCcT8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgH1NJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:09:42 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53890 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbgH1NHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:07:38 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200828130715euoutp010b4e82f23a33b08d8c003cc964676c41~vcHPTfz5V2226222262euoutp01_
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:07:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200828130715euoutp010b4e82f23a33b08d8c003cc964676c41~vcHPTfz5V2226222262euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598620035;
        bh=NnSR6KpXMzjkk1wzGR33M6iWIlXpcOAe3kk+qj+qB+4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=hGMCcT8PgBi3YIontvxdBk3nW7cA2o7WJu+mJWkHg1TXYiSvKP9HV3Y8jY3b/qHyB
         5FSA81gW74Dktpa796sr621xl9a+vU2sd+QQUnm3kbqg6oSSpAyaqRW3CJ6NKyhiuv
         7uvTDo/8+YJ8dJFWl2rKeTpVWmAQnv+Ta0yWBSnY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200828130715eucas1p246140a05e1cd43922fbd9bef628d20af~vcHO8U_G00754707547eucas1p2q;
        Fri, 28 Aug 2020 13:07:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 92.06.06456.381094F5; Fri, 28
        Aug 2020 14:07:15 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200828130714eucas1p26b45e68ee12ca6c31b0ebe62bf699ba7~vcHOjg-7B1068210682eucas1p2P;
        Fri, 28 Aug 2020 13:07:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200828130714eusmtrp13a412918e8e2928b42cccf3fe798a393~vcHOizK8z0481104811eusmtrp1V;
        Fri, 28 Aug 2020 13:07:14 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-80-5f490183fdc7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 79.CA.06314.281094F5; Fri, 28
        Aug 2020 14:07:14 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200828130714eusmtip14b2df8adfb89d3bb54984db5839e7ede~vcHOB5hcD1484014840eusmtip1h;
        Fri, 28 Aug 2020 13:07:14 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] clk: meson: g12a: mark fclk_div2 as CLK_IGNORE_UNUSED
Date:   Fri, 28 Aug 2020 15:07:07 +0200
Message-Id: <20200828130707.9045-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduzned1mRs94g2WvWS02zljPavHm0RFm
        i5/tW5gsFszmtvjYc4/V4vKuOWwWa4/cZbc4tugki8WhvmiLf9c2sjhweby/0cru8XTCZHaP
        Tas62Tw2L6n36NuyitHj8ya5ALYoLpuU1JzMstQifbsErow9K8+xFeziqOhd9Zm5gfEdWxcj
        J4eEgIlE24HVQDYXh5DACkaJWdOmMEI4Xxgl5m66xwLhfGaUWPa6nwWmZem+e6wQieWMEjN6
        JiG07D1yAayKTcBQouttF9gSEYEEid/f5jOBFDEL7GWSePToMiNIQljATaK7fyuYzSKgKjHj
        zSOwBl4BG4mVWzpYIdbJS6zecIAZpFlC4DWbxJQP15ghEi4SV7ach7pJWOLV8S3sELaMxOnJ
        PSwQDc2MEg/PrWWHcHoYJS43zWCEqLKWuHPuF9A6DqCbNCXW79KHCDtK3J28jwUkLCHAJ3Hj
        rSBImBnInLRtOjNEmFeio00IolpNYtbxdXBrD164BFXiIXFzYyhIWEggVuLi0jvMExjlZiGs
        WsDIuIpRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwYZz+d/zTDsavl5IOMQpwMCrx8O7Y
        5x4vxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8xotexgoJpCeW
        pGanphakFsFkmTg4pRoYfaP1lnvenrVVSvq5xirZLzprjiVXcO9jXpL5eeqMTaFGtxaG6ai1
        t0fM85/49NbEiLOtcw+vfxI649tqxif7DsS6ajQ1rw+tEDfWmib0TUXua8TiYvuQkt/mm1oy
        Gu8HJl3dclFwbZJE3g3fZQ4eWvJnzd8cNGCZ0/98bUf71P2m0gq80++IKrEUZyQaajEXFScC
        ANRsgI4UAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsVy+t/xu7pNjJ7xBjtfqVlsnLGe1eLNoyPM
        Fj/btzBZLJjNbfGx5x6rxeVdc9gs1h65y25xbNFJFotDfdEW/65tZHHg8nh/o5Xd4+mEyewe
        m1Z1snlsXlLv0bdlFaPH501yAWxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZG
        pkr6djYpqTmZZalF+nYJehl7Vp5jK9jFUdG76jNzA+M7ti5GTg4JAROJpfvusYLYQgJLGSXe
        byiBiMtInJzWwAphC0v8udYFVM8FVPOJUeLYmnPsIAk2AUOJrrddYINEBJIklp/dCVbELHCQ
        SWJC0wmwImEBN4nu/q2MIDaLgKrEjDePwBp4BWwkVm7pgNogL7F6wwHmCYw8CxgZVjGKpJYW
        56bnFhvqFSfmFpfmpesl5+duYgSG6bZjPzfvYLy0MfgQowAHoxIP74597vFCrIllxZW5hxgl
        OJiVRHidzp6OE+JNSaysSi3Kjy8qzUktPsRoCrR8IrOUaHI+MIbySuINTQ3NLSwNzY3Njc0s
        lMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwTntbkL7QX7Ku/+MkZlNznVTurFmze83Y/p88
        U3/p1e5nywXLJ3cWpPWxN/K8jE1/VOEVuORi1aEjpdNvOn28xmzYxSR3bKbwWgGGJ2d4nkn0
        bL/nFDZZ9PGGpmMxh1/v/hx1Sl8qZPO85IzFf7v2ChvNSOvV2apQ8zZ3p0vUQ+G1oRkzYmw8
        lViKMxINtZiLihMBIs7O42kCAAA=
X-CMS-MailID: 20200828130714eucas1p26b45e68ee12ca6c31b0ebe62bf699ba7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200828130714eucas1p26b45e68ee12ca6c31b0ebe62bf699ba7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200828130714eucas1p26b45e68ee12ca6c31b0ebe62bf699ba7
References: <CGME20200828130714eucas1p26b45e68ee12ca6c31b0ebe62bf699ba7@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CLK_IGNORE_UNUSED flag to the "fclk_div2" clock to fix boot hang on
the Hardkernel's Odroid N2 board (with bootloader booted from SD card and
kernel loaded via FTFP).

It looks that this clock is disabled by the generic unused clocks
scanning code before it gets enabled by the meson-gx-mmc driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Without this patch the only way to boot OdroidN2 board with mainline
kernel is to append clk_ignore_unused kernel parameter. I've build the
kernel from the default arm64's defconfig. The kernel is loaded via TFTP
using vendor's u-boot.
---
 drivers/clk/clk.c        | 5 +++++
 drivers/clk/meson/g12a.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 9803d44bb157..4106b6231be4 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -298,6 +298,7 @@ static struct clk_regmap g12a_fclk_div2 = {
 			&g12a_fclk_div2_div.hw
 		},
 		.num_parents = 1,
+		.flags = CLK_IGNORE_UNUSED,
 	},
 };
 
-- 
2.17.1

