Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB03C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A28920707
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H/NO/4fO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390705AbgFXLlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 07:41:51 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46781 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389161AbgFXLlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 07:41:40 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200624114139euoutp0173280252ae527874e8f46b2128526240~beA8dPqP42562225622euoutp01F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:41:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200624114139euoutp0173280252ae527874e8f46b2128526240~beA8dPqP42562225622euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592998899;
        bh=X33emPDExizY8bpBUTV4hhXKJz6IkQyPKvGe23DV6IU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H/NO/4fOSF/d6Uwz3KYzsBNHnBO9He3xTGXWmYe1nj6t+ZN+r5hoZ8oO5wNzg8seF
         n6rQpkENbYQVrIxCC3RG9DwSpZWWDoa81UzzRt63zRFJ2SUHNV0M1YA+LXEmQYX+hX
         Qk21DJoQnnCtSocqEcAErMIg5zsVuSV+yL/JszuU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200624114139eucas1p17443dbd7bd4ab9da8e94ca361e9a7b57~beA8DzfVo0380603806eucas1p1c;
        Wed, 24 Jun 2020 11:41:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 99.5A.06318.2FB33FE5; Wed, 24
        Jun 2020 12:41:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200624114138eucas1p262505da3ad1067720080d20209ff32de~beA7bnkeo0284802848eucas1p2a;
        Wed, 24 Jun 2020 11:41:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200624114138eusmtrp18a17f57b5a73296f6d6bac1c769c480a~beA7a6fvi0702007020eusmtrp1S;
        Wed, 24 Jun 2020 11:41:38 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-40-5ef33bf2c735
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 06.53.06017.2FB33FE5; Wed, 24
        Jun 2020 12:41:38 +0100 (BST)
Received: from AMDC3748.digital.local (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200624114137eusmtip2331767d1009f8c93f97e804d1503ae21~beA6uKWf32681426814eusmtip2k;
        Wed, 24 Jun 2020 11:41:37 +0000 (GMT)
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
Subject: [RESEND PATCH v5 5/5] drm/bridge: lvds-codec: simplify error
 handling code
Date:   Wed, 24 Jun 2020 13:41:27 +0200
Message-Id: <20200624114127.3016-6-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624114127.3016-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSaUhUURTHufPevPdmcOw5Cl4skyYKVNLElkuWWZi8D30QIggjbdKHijOO
        zLhkC0qay2g2ara45LiEYpo6LrnkwiSpyJh7JskUWai4YC6ppeX4tL79zv/8/+ccLpfCxAa+
        DRUcGs4qQ6UyCSHE69+tvT/yw23R92hJ3Bk09qqXj6Y0bwGqflrJR1lfJgj0pz4dQ0PL8wSK
        K6ok0PDPKQx1zwzjKDm9mES6ryN8NNiUSyB9VgtAFR3jJNKnXUV5S1mYB80MjvRjzPzofZJp
        WdHiTGP2OMnkJD3jM7qyZILp0gzwmLa8cpIxpnTymJriGCattgww7Q8ycWZRt99b5CM8HcDK
        giNZpbP7dWFQdXsuHtYluNlceDsWaCg1EFCQPgbrBlswNRBSYroUwPLWRT5XLAE421bC44pF
        ANW6WP5uZPlxH2FiMV0CYGL7iX+J5pzvwNQgaHu4UfNx22RFu8KHhmzSZMLodRwOJyZsT7Kk
        L8O1lYptE04fgs+ni3ETi+iTMP/DHOC22cGXVe2YiQU0ghnx/cA0CNJTJFztnsQ4kyfUaFN4
        HFvC6c5akuN9sCczFec4BhpL4zEunARgXVXjTtgNfupd37qC2jrPHlY2OXPyOTinNZImGdLm
        cHTWwiRjW5hR/wTjZBFMShBz7gPQaKjbGWgNX/QtE5yFgSuaC9z7pABY0t0FNMAu+/8uLQBl
        wJqNUMkDWZVrKBvlpJLKVRGhgU7+CrkObH2yns3O5QbQ+vuGHtAUkJiJqj4v+Ir50khVtFwP
        IIVJrETnDT2+YlGANPoWq1T4KSNkrEoP9lK4xFrkWjh1TUwHSsPZEJYNY5W7XR4lsIkFlnI7
        Y4F5mvNZb4vqPvb1cHac+6jEUdif1PGry83TX5LsnF8hveJiNl3rYMTvua0aLimGCC8zj40c
        v9QixcZEh/qu7I7D5tqkT6/tnrH6gkcyW7pAcTx1ydPrTbFjWIW/rdq9oSgKhICJbws1h93L
        4mwHLgoun0ozzIzlHpxrk+CqIKmLA6ZUSf8C5ER1kGADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xe7qfrD/HGXT1iVrcWneO1eLlhMOM
        FhtnrGe1mPrwCZvF/20TmS2ufH3PZtG8eD2bxdXvL5ktTr65ymLROXEJu8Wmx9dYLS7vmsNm
        cWjqXkaLtUfuslsc6ou2mPtlKrODgMflaxeZPd7faGX32PttAYvHzll32T1md8xk9di0qpPN
        48SES0we++euYfe4332cyWPzknqPvi2rGD0O9E5m8fi8SS6AN0rPpii/tCRVISO/uMRWKdrQ
        wkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY+OBOSwFJzgrdi+qbmCcwNHFyMkh
        IWAi8XXaBbYuRi4OIYGljBJf/81igUiIS+ye/5YZwhaW+HOtC6roE6PEmpsf2UASbAKaEn83
        3wSzRQSMJfrPzmIHKWIWaGOVmHv+CTtIQlggWOLEu4lgRSwCqhLzXi0B28ArYC4x//o7RogN
        8hKrNxwA28YpYCExqeUiWFwIqObQ9cWsExj5FjAyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/d
        xAiMrW3Hfm7Zwdj1LvgQowAHoxIP74YHH+OEWBPLiitzDzFKcDArifA6nT0dJ8SbklhZlVqU
        H19UmpNafIjRFOioicxSosn5wLjPK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQ
        WgTTx8TBKdXAaOazOerERIb2reoCy7V8Mk9z7j64vTIod/40I4O1qVVPzqkb/Kh2DTlflSp3
        /wNffOqkzyIPZ/2Vigj9KDNjYWjNfgatC8/fXVHfUlm98alIxrztrIbSJutUSq12S91VeMon
        MN93gXCv3DpHQ8ul2tP/zk6p2h2mfyVfevv6e3OM3/d4i/1WVmIpzkg01GIuKk4EAIHGSnLD
        AgAA
X-CMS-MailID: 20200624114138eucas1p262505da3ad1067720080d20209ff32de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200624114138eucas1p262505da3ad1067720080d20209ff32de
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200624114138eucas1p262505da3ad1067720080d20209ff32de
References: <20200624114127.3016-1-a.hajda@samsung.com>
        <CGME20200624114138eucas1p262505da3ad1067720080d20209ff32de@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using probe_err code has following advantages:
- shorter code,
- recorded defer probe reason for debugging,
- uniform error code logging.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/bridge/lvds-codec.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lvds-codec.c b/drivers/gpu/drm/bridge/lvds-codec.c
index 24fb1befdfa2..c76fa0239e39 100644
--- a/drivers/gpu/drm/bridge/lvds-codec.c
+++ b/drivers/gpu/drm/bridge/lvds-codec.c
@@ -71,13 +71,8 @@ static int lvds_codec_probe(struct platform_device *pdev)
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
+		return probe_err(dev, lvds_codec->powerdown_gpio, "powerdown GPIO failure\n");
 
 	/* Locate the panel DT node. */
 	panel_node = of_graph_get_remote_node(dev->of_node, 1, 0);
-- 
2.17.1

