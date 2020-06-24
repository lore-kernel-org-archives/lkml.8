Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5FDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D134D20707
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Gz061wWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390716AbgFXLly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 07:41:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58697 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390645AbgFXLlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 07:41:39 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200624114138euoutp023c5550f156c946e02c5427d5cb490c5e~beA7YluOV1752517525euoutp02G
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:41:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200624114138euoutp023c5550f156c946e02c5427d5cb490c5e~beA7YluOV1752517525euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592998898;
        bh=PLcfbVbE8i4C8d+Nje5jm1KODRXZ6RkpBF4pFp7dgN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gz061wWwnckgFshr7IHV/S56brednP/fCQN2DoCvt+lOLedpHvoWuBZeA3A9KsT3g
         YoA4EdOZ3Kab191G9YTSBCBfdMshslJW5od/RbI36r4UDd0Iz6ivjUmvsvNkR8UjIB
         sBtr/mLupNn0hGQfZWMj8+FCaH4cd42c3YYFkHGU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200624114137eucas1p23e078ad0759d9748c9282f41addeff25~beA7CGXw43078130781eucas1p2-;
        Wed, 24 Jun 2020 11:41:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 08.5A.06318.1FB33FE5; Wed, 24
        Jun 2020 12:41:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200624114137eucas1p13599d33a0c4a9abf7708bf8c8e77264b~beA6t-j1g1213312133eucas1p1o;
        Wed, 24 Jun 2020 11:41:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200624114137eusmtrp10d73154fb2485ece760b250727d8f1fe~beA6tUGSX0702007020eusmtrp1Q;
        Wed, 24 Jun 2020 11:41:37 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-3c-5ef33bf187fe
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 74.74.06314.1FB33FE5; Wed, 24
        Jun 2020 12:41:37 +0100 (BST)
Received: from AMDC3748.digital.local (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200624114136eusmtip2e30c14611d99889046fee0d88d874173~beA6ExH1q1775617756eusmtip2L;
        Wed, 24 Jun 2020 11:41:36 +0000 (GMT)
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
Subject: [RESEND PATCH v5 4/5] drm/bridge/sii8620: fix resource acquisition
 error handling
Date:   Wed, 24 Jun 2020 13:41:26 +0200
Message-Id: <20200624114127.3016-5-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624114127.3016-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUxTQRiFM70r1eqlJWGCW6wxcQVMiY5KFI0mN5oYt/hQFa1ygyitpAXc
        HhCpCAhYqo2IYoiiVUSBsigIgmWppAFFBAEh1YhLq7KEUhFFbXtd3r6c/5zzz0yGxsRWIoCO
        UsVyapUiWkoK8Yqmb62Lh1eOhAfrbq9APfdaCWTX1QNUkl1EIMObfhL9qsjC0IvRQRIlXS8i
        UcdXO4aaP3fgKDUrn0Kmt50Eaq+6QiKzoQaguw19FDJn7kS5TgMWxrDtnW0YO9h1mmJrXHk4
        W5nTR7GXUy4RrKkglWSf6J4L2NrcQoq1nbUI2NL8BDazrACwdRnncXbENHOzSC4MjeCio+I5
        ddCqvcIDje12MubmlKOtn6qpk2BgUhrwoSETAhsHywgPi5lbACa6Qnh2AjiQGpYGhG4eAbDg
        ewn4G6juOYXzAyOAd7Va8l8iL93XwyQzH06Udnt1P0YGz7XkUJ4AxozjsONMsnedhNkFHfde
        eVtxZi6s7//hNtG0iFkGJ57K+WWz4J3iOszDPgyCem0b8PRAZpiC+RdbCI8fMuvg2KiE90ug
        w1JG8TwdWs+n4zwnQNstLcZnUwAsL67E+MFK2Ns6Tnp6MPehi6qCeHkNvJDdA/j6KbDri/da
        mBv1FRcxXhbBlGQx754NbS3lfwr94Y1noyTPLLx2P0XAP9VZAEuM9ykdmJXzf1keAAXAn4vT
        KCM5jUzFHQnUKJSaOFVk4P7DShNwfzHrT8voA/Doxz4zYGggnSwqfj0cLiYU8ZpjSjOANCb1
        E61tsYaLRRGKY8c59eE96rhoTmMG02hc6i+SXbPvFjORiljuEMfFcOq/UwHtE3ASHFEOBCw3
        GuW1WSNbYra3vc9+s1H2bsbVtvFP4Z22apXO2WwAsvpM1Yp9J/rSH0s+mPTbbB8zXjY+JIYc
        iS56tXzOKWeMpVewY3HhJkfHmHxq9/SN4q3JG/S1Q0mrhXOWLgqUZoZaytc3PXsslexpSsv4
        vHBef4PLN+Fn6cFgv0Q/Ka45oFiyAFNrFL8BSXvZ814DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xe7ofrT/HGdx4rmpxa905VouXEw4z
        WmycsZ7VYurDJ2wW/7dNZLa48vU9m0Xz4vVsFle/v2S2OPnmKotF58Ql7BabHl9jtbi8aw6b
        xaGpexkt1h65y25xqC/aYu6XqcwOAh6Xr11k9nh/o5XdY++3BSweO2fdZfeY3TGT1WPTqk42
        jxMTLjF57J+7ht3jfvdxJo/NS+o9+rasYvQ40DuZxePzJrkA3ig9m6L80pJUhYz84hJbpWhD
        CyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jKOXX7IVLOOrOPd6D3sD4zvuLkZO
        DgkBE4k9t5pYuhi5OIQEljJK7Lp7mxUiIS6xe/5bZghbWOLPtS42iKJPjBLz2reCJdgENCX+
        br7JBmKLCBhL9J+dxQ5SxCzQxiox9/wTdpCEsECUxPU5D8GmsgioShx+8gcozsHBK2Au8fd8
        FMQCeYnVGw6AzeQUsJCY1HKREcQWAio5dH0x6wRGvgWMDKsYRVJLi3PTc4sN9YoTc4tL89L1
        kvNzNzECY2vbsZ+bdzBe2hh8iFGAg1GJh3fDg49xQqyJZcWVuYcYJTiYlUR4nc6ejhPiTUms
        rEotyo8vKs1JLT7EaAp000RmKdHkfGDc55XEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnN
        Tk0tSC2C6WPi4JRqYEzZe8Q4eu8nrqd1WpEmE1N8z54Wa39usfpn6/nT6wW/V7K5dzj/NErb
        Knlu5ZRPh9q72suuf7Jzmz3D/7hy5eOdDScOXfHbVJjYt91ku3Hi9lsrp35OsWH/NK1LwfeN
        23a7LzlMUbFRSVzHj0yS2zbviVSAeOf5KY45rTv3Sf/Z57zIsumZ0QElluKMREMt5qLiRAAc
        CbrgwwIAAA==
X-CMS-MailID: 20200624114137eucas1p13599d33a0c4a9abf7708bf8c8e77264b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200624114137eucas1p13599d33a0c4a9abf7708bf8c8e77264b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200624114137eucas1p13599d33a0c4a9abf7708bf8c8e77264b
References: <20200624114127.3016-1-a.hajda@samsung.com>
        <CGME20200624114137eucas1p13599d33a0c4a9abf7708bf8c8e77264b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error during resource acquisition driver should print error
message only in case it is not deferred probe, using probe_err helper
solves the issue. Moreover it records defer probe reason for debugging.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 92acd336aa89..2f825b2d0098 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -2299,10 +2299,8 @@ static int sii8620_probe(struct i2c_client *client,
 	INIT_LIST_HEAD(&ctx->mt_queue);
 
 	ctx->clk_xtal = devm_clk_get(dev, "xtal");
-	if (IS_ERR(ctx->clk_xtal)) {
-		dev_err(dev, "failed to get xtal clock from DT\n");
-		return PTR_ERR(ctx->clk_xtal);
-	}
+	if (IS_ERR(ctx->clk_xtal))
+		return probe_err(dev, ctx->clk_xtal, "failed to get xtal clock from DT\n");
 
 	if (!client->irq) {
 		dev_err(dev, "no irq provided\n");
@@ -2313,16 +2311,12 @@ static int sii8620_probe(struct i2c_client *client,
 					sii8620_irq_thread,
 					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
 					"sii8620", ctx);
-	if (ret < 0) {
-		dev_err(dev, "failed to install IRQ handler\n");
-		return ret;
-	}
+	if (ret < 0)
+		return probe_err(dev, ret, "failed to install IRQ handler\n");
 
 	ctx->gpio_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(ctx->gpio_reset)) {
-		dev_err(dev, "failed to get reset gpio from DT\n");
-		return PTR_ERR(ctx->gpio_reset);
-	}
+	if (IS_ERR(ctx->gpio_reset))
+		return probe_err(dev, ctx->gpio_reset, "failed to get reset gpio from DT\n");
 
 	ctx->supplies[0].supply = "cvcc10";
 	ctx->supplies[1].supply = "iovcc18";
-- 
2.17.1

