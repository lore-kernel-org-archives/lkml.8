Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D91FC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 674B82075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gWjASbmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgGMOnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:43:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53532 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbgGMOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:43:36 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200713144334euoutp02470b76ff453d30f86168cedd18c5251c~hVwNA4lsw2796527965euoutp02J
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 14:43:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200713144334euoutp02470b76ff453d30f86168cedd18c5251c~hVwNA4lsw2796527965euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594651414;
        bh=B440VBDLdLWidVVzamEgT8cxdzc8DwUiqZOX84CTZVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gWjASbmbzzb+8uuz9RTlTZQcDi0fhhyVDMZjKdKi8ug5c5H41YeN4+baOD8bEaITp
         jN6NXnKCX+xGKfkBvywaUqCug2WDiokHY/HLjkLKWMZAgZAVEqR8MWJMZIwtd/Qmu8
         hjx8xis0wpMsEZjgHD71J166gg88itkA3/ihSkWw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200713144334eucas1p27b8c28229a62306997a8cb3666d284a2~hVwMqhWLH0713507135eucas1p2p;
        Mon, 13 Jul 2020 14:43:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9E.E5.06456.6137C0F5; Mon, 13
        Jul 2020 15:43:34 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200713144333eucas1p1f393b280cda5eead4e7ca0a005c8a4db~hVwMVP1Mg0193801938eucas1p1I;
        Mon, 13 Jul 2020 14:43:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200713144333eusmtrp11e6d448603f5183dfba243d4ffaf27d4~hVwMUj-y90993409934eusmtrp1a;
        Mon, 13 Jul 2020 14:43:33 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-ba-5f0c73169e88
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 56.5A.06017.5137C0F5; Mon, 13
        Jul 2020 15:43:33 +0100 (BST)
Received: from AMDC3748.digital.local (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200713144333eusmtip13cba26d8ef88fbfed56cb041248967a4~hVwLmbChd1900919009eusmtip1u;
        Mon, 13 Jul 2020 14:43:32 +0000 (GMT)
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
Subject: [PATCH v9 4/4] drm/bridge: lvds-codec: simplify error handling
Date:   Mon, 13 Jul 2020 16:43:24 +0200
Message-Id: <20200713144324.23654-5-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713144324.23654-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0gUURTGuTuzM+PiyrRKHiwyNyINzKT+uJJERdFUkIKlmJRtNVjkmuxo
        5RplL3XNbEskn2TrmmbmY9estpdtsRa2Wr7QyDSKYDOTfFRr9HAaq/+++53fOd+5l8sQKqfc
        j9mXlMLrkjSJakpBNjvcHcGzBc/4pWMmEr+sa5djl/ERwo2F9XJc8OYdhX81nydw9+QohU9W
        1FO456uLwE8/9pDYcN5MY8vbXjnuspVS2F5wD+HrjwdobM+Lw2UTBcQqluvqfUFwo32nae7e
        l3KSu108QHMl2UVyzlJjoLgnxk4Z96CsluYGz7TKOKv5GJfXVIO4lrP5JDdumRep3KYI38Mn
        7jvI60JW7lTsLbS+liWXKQ4bv7yWZaBeJgd5MMAuhy5zkSwHKRgVW43AVO2eOUwg+G58T4uU
        ih1HcPxEyN+OZ19bkARVITAPmql/HaXuKlKkKDYIflj7KVH7sMvgnLOYFiGCnSKhJytTLha8
        2fVQfNPxR5PsQpi6WzE9lmGULIYrQ4elNH+41tBCiLYHGwaX8mLEMcCO0FAxeZOUmLVQZCpF
        kvaGD61NtKTnQlt+7gxzDAarTxFSczaCGw23CamwAl61T1FiADG9dL1t5parYaq8RCbawHpB
        38gs0Sam5YXmi4RkKyE7UyXRATDovDEz0Bcqn09SkubAMdxBSM+Ti8BmcsqNyL/4f1g5QjXI
        l08VtAm8EJrEH1oiaLRCalLCkt0HtBY0/cnafraO3UKTnbvsiGWQ2lMJEZ7xKrnmoJCmtSNg
        CLWPco2zbYdKuUeTpud1B+J1qYm8YEdzGFLtq1xmcm1XsQmaFH4/zyfzur9VGePhl4E2z6t8
        mKEPLKpp9B7QG8LfbDJn2tbpvw0Fe230dXyKOho8XutY4RcbJ1AbDFsT/INc433D+T9icn82
        pAZmvVVYIrvnL7oaZv8MZaFu7RFrkz5q4vKFdH9tdIDVkNPh8skaSo+K3hKzoe5uSP8dd93S
        8Agq7aktGseu3jLr2ckF99WksFcTupjQCZrfsgv4t2ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsVy+t/xu7qixTzxBi3ftS1urTvHavFywmFG
        i40z1rNaTH34hM3i/7aJzBZXvr5ns2hevJ7N4ur3l8wWJ99cZbHonLiE3WLT42usFpd3zWGz
        ODR1L6PF2iN32S0O9UVbzP0yldlBwOPytYvMHu9vtLJ77P22gMVj56y77B6zO2ayemxa1cnm
        cWLCJSaP/XPXsHvc7z7O5LF5Sb1H35ZVjB4HeiezeHzeJBfAG6VnU5RfWpKqkJFfXGKrFG1o
        YaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXMWPzPaaCuVwVE77dY2pgvMbRxcjJ
        ISFgInHm+wFGEFtIYCmjxJ6WUoi4uMTu+W+ZIWxhiT/Xutggaj4xSnxeJwxiswloSvzdfBMs
        LiJgLNF/dhZ7FyMXB7NAG6vE3PNP2EESwgLuErO2H2MFsVkEVCV+7VkMtIyDg1fAQmLZgwqI
        +fISqzccYAYJcwpYSszvCwcxhYAqTrz1nMDIt4CRYRWjSGppcW56brGRXnFibnFpXrpecn7u
        JkZgTG079nPLDsaud8GHGAU4GJV4eCX8eeKFWBPLiitzDzFKcDArifA6nT0dJ8SbklhZlVqU
        H19UmpNafIjRFOiiicxSosn5wHjPK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQ
        WgTTx8TBKdXAmFkYWFG89Hq5hO2Mp1vPnVk56efMrDd7482rWXR3J8ROP/p1zqnQY+v3ej1O
        id92TVfI4dlSzeeWErIL80I3+XvOzPj3ZJ+b8yXtJ0sOvsxmd24LdzfN+bYwbDNH3uH3usJ/
        H7knNUXolx7dN2fWSr17ExdxLtefd3ThNl1+SbWfMsdvfVH5fkuJpTgj0VCLuag4EQCVaDmR
        vwIAAA==
X-CMS-MailID: 20200713144333eucas1p1f393b280cda5eead4e7ca0a005c8a4db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200713144333eucas1p1f393b280cda5eead4e7ca0a005c8a4db
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200713144333eucas1p1f393b280cda5eead4e7ca0a005c8a4db
References: <20200713144324.23654-1-a.hajda@samsung.com>
        <CGME20200713144333eucas1p1f393b280cda5eead4e7ca0a005c8a4db@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_err_probe code has following advantages:
- shorter code,
- recorded defer probe reason for debugging,
- uniform error code logging.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/lvds-codec.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lvds-codec.c b/drivers/gpu/drm/bridge/lvds-codec.c
index 24fb1befdfa2..f19d9f7a5db2 100644
--- a/drivers/gpu/drm/bridge/lvds-codec.c
+++ b/drivers/gpu/drm/bridge/lvds-codec.c
@@ -71,13 +71,9 @@ static int lvds_codec_probe(struct platform_device *pdev)
 	lvds_codec->connector_type = (uintptr_t)of_device_get_match_data(dev);
 	lvds_codec->powerdown_gpio = devm_gpiod_get_optional(dev, "powerdown",
 							     GPIOD_OUT_HIGH);
-	if (IS_ERR(lvds_codec->powerdown_gpio)) {
-		int err = PTR_ERR(lvds_codec->powerdown_gpio);
-
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "powerdown GPIO failure: %d\n", err);
-		return err;
-	}
+	if (IS_ERR(lvds_codec->powerdown_gpio))
+		return dev_err_probe(dev, PTR_ERR(lvds_codec->powerdown_gpio),
+				     "powerdown GPIO failure\n");
 
 	/* Locate the panel DT node. */
 	panel_node = of_graph_get_remote_node(dev->of_node, 1, 0);
-- 
2.17.1

