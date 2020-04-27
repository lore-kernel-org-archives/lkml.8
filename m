Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18009C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0C39206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X9uPTP7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgD0Hsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:48:51 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47685 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgD0Hsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:48:45 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200427074843euoutp02b1b66f122e8fb6f1addc72e9bb3d2491~JnbAhNnsp3150031500euoutp02B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 07:48:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200427074843euoutp02b1b66f122e8fb6f1addc72e9bb3d2491~JnbAhNnsp3150031500euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587973723;
        bh=NptijK1/HIp0K38QzwoqJLRCsrX1u62GvzSFR9MY2Hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X9uPTP7ldpn19CynyMU/nxnSZ6C3S9p1+LaWoROUeAckWkQPfEx2x9bPkDjn4ZkY9
         E4J1b/CyCoMVMmctTFyRVj89btcKTOKJkrN5e3khXnlnWxHXCfNjxPN8kDwwkzhZ+C
         IgGWQMpssoyTLwgVFfUsk+Rlspe9Ng3KIu/AEs9c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200427074843eucas1p25a1b709dfa8a5fd6bf5d00cce4f28125~JnbAOBbkV0174601746eucas1p2W;
        Mon, 27 Apr 2020 07:48:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 69.1D.60679.B5E86AE5; Mon, 27
        Apr 2020 08:48:43 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200427074842eucas1p2a37c7f854188cccf3b103b221a84e9f2~Jna-5r4pF0174701747eucas1p2f;
        Mon, 27 Apr 2020 07:48:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200427074842eusmtrp2f2f204876347a6b32634ed5989e0a5ad~Jna-5FsVD0599405994eusmtrp2i;
        Mon, 27 Apr 2020 07:48:42 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-48-5ea68e5b46ef
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 07.1A.07950.A5E86AE5; Mon, 27
        Apr 2020 08:48:42 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200427074842eusmtip245117b9499a9d31819a03e43b3b48d0d~Jna-gCziC0786807868eusmtip2R;
        Mon, 27 Apr 2020 07:48:42 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 2/4] mfd: wm8994: Fix unbalanced calls to
 regulator_bulk_disable()
Date:   Mon, 27 Apr 2020 09:48:30 +0200
Message-Id: <20200427074832.22134-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427074832.22134-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djP87rRfcviDPa+Y7a4cvEQk8XUh0/Y
        LK60bmK0uP/1KKPFtysdTBaXd81hs1h75C67xef3+1ktDr9pZ3Xg9NjwuYnNY+esu+wem1Z1
        snncubaHzWP6nP+MHn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJXxeuEk9oKdPBXbjq1kbWA8
        y9XFyMkhIWAicW75AZYuRi4OIYEVjBITn91nh3C+MEqcvb4DKvOZUeLRxylMMC2rzqyHSixn
        lNh6sxmhZfGF62wgVWwChhJdb7vAbBGBOInlixcwgRQxC/xilPj8aRPYKGGBEImeqW9ZQWwW
        AVWJnWd7WUBsXgFbiQ/9k9kg1slLrN5wgLmLkYODU8BOYuF0N5A5EgL97BJ9rx+wQtS4SGzr
        a4Y6T1ji1fEt7BC2jMT/nfOZIBqaGSUenlvLDuH0MEpcbprBCFFlLXHn3C82kA3MApoS63fp
        Q4QdJb637GEBCUsI8EnceCsIEmYGMidtm84MEeaV6GgTgqhWk5h1fB3c2oMXLjFD2B4STSf3
        MUMCaCKjRMeKL2wTGOVnISxbwMi4ilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzChnP53
        /MsOxl1/kg4xCnAwKvHwcmxfGifEmlhWXJl7iFGCg1lJhPdRxrI4Id6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4rzGi17GCgmkJ5akZqemFqQWwWSZODilGhjVFZY/6V0btvvaovYZBU9D3laat0Ul
        rt3y9vzKSvmbE3PMq1duDd0kIbvpn4if1OnidPuu0xEXpnqdeLf/kad3zezG/2xNQVHl1QLr
        lLPeeCqeLrmcOPPSPf7n779c0rvSdtpg25zJx+OnTjg8bVLhTCGjLdJt8nOKjA1WWc1z232f
        X1vAu3CLEktxRqKhFnNRcSIAFxfygCQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsVy+t/xe7pRfcviDF481LG4cvEQk8XUh0/Y
        LK60bmK0uP/1KKPFtysdTBaXd81hs1h75C67xef3+1ktDr9pZ3Xg9NjwuYnNY+esu+wem1Z1
        snncubaHzWP6nP+MHn1bVjF6fN4kF8AepWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hs
        HmtlZKqkb2eTkpqTWZZapG+XoJfxeuEk9oKdPBXbjq1kbWA8y9XFyMkhIWAiserMepYuRi4O
        IYGljBJHpi1nhkjISJyc1sAKYQtL/LnWxQZR9IlRYvXxJrAiNgFDia63IAlODhGBBIlDy1uY
        QYqYBf4xSrx7dBOsSFggSOJo/3VGEJtFQFVi59leFhCbV8BW4kP/ZDaIDfISqzccAKrn4OAU
        sJNYON0NJCwEVPLx+1vmCYx8CxgZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgQG97ZjP7fs
        YOx6F3yIUYCDUYmHl2P70jgh1sSy4srcQ4wSHMxKIryPMpbFCfGmJFZWpRblxxeV5qQWH2I0
        BbppIrOUaHI+MPLySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUw
        qlzeG/DZ547DtEvyKw52tHyPnrZp+4YXfhft6/cnPtr9MER5fRj78r6oSNnLU9dHtBxaMp/V
        7/mpj7+NjPoDuD4+PtosFBJ4u4d5Q9nL0zM/Tm1YGCPGcElMtdzwwGR5CeVVl5zZpI5yxTv+
        2f3x5pPE7ludL3oM+zTuaq7muqCxI6TgsM5/HiWW4oxEQy3mouJEAEjG7p+EAgAA
X-CMS-MailID: 20200427074842eucas1p2a37c7f854188cccf3b103b221a84e9f2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200427074842eucas1p2a37c7f854188cccf3b103b221a84e9f2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200427074842eucas1p2a37c7f854188cccf3b103b221a84e9f2
References: <20200427074832.22134-1-m.szyprowski@samsung.com>
        <CGME20200427074842eucas1p2a37c7f854188cccf3b103b221a84e9f2@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When runtime PM is enabled, regulators are being controlled by the
driver's suspend and resume callbacks. They are also unconditionally
enabled at driver's probe(), and disabled in remove() functions. Add
more calls to runtime PM framework to ensure that the device's runtime
PM state matches the regulators state:
1. at the end of probe() function: set runtime PM state to active, so
there will be no spurious call to resume();
2. in remove(), ensure that resume() is called before disabling runtime PM
management and unconditionally disabling the regulators.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/wm8994-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 737dede4a95c..69d973ec42bf 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -584,6 +584,7 @@ static int wm8994_device_init(struct wm8994 *wm8994, int irq)
 		goto err_irq;
 	}
 
+	pm_runtime_set_active(wm8994->dev);
 	pm_runtime_enable(wm8994->dev);
 	pm_runtime_idle(wm8994->dev);
 
@@ -603,7 +604,9 @@ static int wm8994_device_init(struct wm8994 *wm8994, int irq)
 
 static void wm8994_device_exit(struct wm8994 *wm8994)
 {
+	pm_runtime_get_sync(wm8994->dev);
 	pm_runtime_disable(wm8994->dev);
+	pm_runtime_put_noidle(wm8994->dev);
 	wm8994_irq_exit(wm8994);
 	regulator_bulk_disable(wm8994->num_supplies, wm8994->supplies);
 	regulator_bulk_free(wm8994->num_supplies, wm8994->supplies);
-- 
2.17.1

