Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E775C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A51C20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ubtdx/PX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390658AbgFXLlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 07:41:39 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46707 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389161AbgFXLlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 07:41:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200624114135euoutp01f58b5864b90f70afb8e5c717a616b8ac~beA5HARSS2526625266euoutp01Y
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:41:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200624114135euoutp01f58b5864b90f70afb8e5c717a616b8ac~beA5HARSS2526625266euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592998895;
        bh=RQZIPEDae5sBrCjuNSqyiec+88v8icL7eS+ZK3s4ccs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Ubtdx/PXFsf8v5gS0rlfTxCXZncqrKUG3vgOfOzdVoacqRijX/SXLcavsyjQhNrGv
         u2ojmK3D3KBnEVT9ctOmDdLaIGgvRXdLuy+cubwTYH8wGO9TFAcoQ0YIxHPqMCgq2M
         sC67KkvpDeTLGsbwBQNnyQW6XaDXnXuCJ79AR8+s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200624114135eucas1p1d2d1344782eb32b1424918dbb461e3be~beA4s3JCr2487924879eucas1p1H;
        Wed, 24 Jun 2020 11:41:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EF.0F.05997.FEB33FE5; Wed, 24
        Jun 2020 12:41:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200624114134eucas1p2799e0ae76fcb026a0e4bcccc2026b732~beA4HuG1t3101431014eucas1p2d;
        Wed, 24 Jun 2020 11:41:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200624114134eusmtrp1a97633f77afa2a6d6213b0d387014a8e~beA4G6Cef0702007020eusmtrp1C;
        Wed, 24 Jun 2020 11:41:34 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-00-5ef33beff26a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F1.53.06017.EEB33FE5; Wed, 24
        Jun 2020 12:41:34 +0100 (BST)
Received: from AMDC3748.digital.local (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200624114134eusmtip2fcd2dc188e5e600a5bcc339d351b2f4b~beA3cE4oy2617526175eusmtip2J;
        Wed, 24 Jun 2020 11:41:34 +0000 (GMT)
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
Subject: [RESEND PATCH v5 0/5] driver core: add probe error check helper
Date:   Wed, 24 Jun 2020 13:41:22 +0200
Message-Id: <20200624114127.3016-1-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSWUwTURTN60xnhkJxLCS8IEtsYiIuoGLiRNS48DE/RhL/MKADjEBYbQGF
        GCEBCkXFIkFZTaMQdgplkRJRKEgxWARKK6gIBNSAIMgaCC4tU/Tv3LPccz8ugYg6+c5EeHQc
        K4lmIsWYAG3p2eg/vOCzHHhkdh5SH+r6+dSMogtQDfkqPpU3OY1Rf1pyEGp4dQGjUp+pMMq4
        PoNQb+aMKCXPKcUp9ZSJTxnaijFKm9cOqNruMZzSZl+hSlbykLMkbTANIvTCSDpOt68pUVpT
        OIbTRZkFfFpdJcfoXsUQj35VUoPT43d1PLqxNJnObqoCdMf9XJReVrv5Cf0Fp0LYyPAEVuJ1
        5pogrGS6ghcrE97q+nEoBSgFWcCGgORxuPRuGM8CAkJEVgCYpvuMcsMKgAWplRg3LAOoz1zD
        dyLd66VWoRzA1pVF/r+IekbGs7gw0gP+ahzFLNiR9IYP9IXbJQi5iUJjhoxvERxIGspfaLdN
        KLkPliu/bIeF5AlYp27ncXXusLq+A7GEITmEw/zaIqvgC7MVGYDDDnBW12S9zwX25d5DOZwM
        xyvSrOFMAJvrNQgn+MBP/ZvmZsJ8kgdUtXlx9DlYbBrhWWhI2sOR+d0WGjHDhy2PEY4WwkyZ
        iHPvheP6ZutCJ1g2sIpxmIa95a3bW0RkAFRV31EAt8L/VUoAqoATGy+NCmWlx6LZm55SJkoa
        Hx3qGRwTpQbmx+r7rVtpBW1bQVpAEkBsJ6yf+Bko4jMJ0sQoLYAEInYUntf3BYqEIUxiEiuJ
        uSqJj2SlWrCHQMVOQu+nMwEiMpSJYyNYNpaV7Kg8wsY5BcR9b7XbPxGvKWMaTJE1mtxqv5wL
        4Wk2BuZ28PPJLVfBZddLWbteZ7dVzA1t1E769AzYMsm2ySMtEW6mG13F4L2X+9egfZpaOW5I
        T+/s9Y9JKj/oeTI0p3N80T7j45NHNhfVdfJGl/7ipZiX6KDqtPKtbHSqoVIx/a3J3dd4vVQn
        RqVhzNEDiETK/AUnLONNVAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xe7rvrD/HGZx5amBxa905VouXEw4z
        WmycsZ7VYurDJ2wW/7dNZLa48vU9m0Xz4vVsFle/v2S2OPnmKotF58Ql7BabHl9jtbi8aw6b
        xaGpexkt1h65y25xqC/aYu6XqcwOAh6Xr11k9nh/o5XdY++3BSweO2fdZfeY3TGT1WPTqk42
        jxMTLjF57J+7ht3jfvdxJo/NS+o9+rasYvQ40DuZxePzJrkA3ig9m6L80pJUhYz84hJbpWhD
        CyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jLlPVjAVtPFWHH6n08C4gKuLkZND
        QsBE4sj3JWxdjFwcQgJLGSWe7JrICJEQl9g9/y0zhC0s8edaF1TRJ0aJbw8fM4Ek2AQ0Jf5u
        vskGYosIGEv0n53FDlLELNDGKjH3/BN2kISwgIdE555DYEUsAqoSyxc8BWvmFTCXWLdpLxPE
        BnmJ1RsOME9g5FnAyLCKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMFa2Hfu5ZQdj17vgQ4wC
        HIxKPLwbHnyME2JNLCuuzD3EKMHBrCTC63T2dJwQb0piZVVqUX58UWlOavEhRlOg5ROZpUST
        84FxnFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgbFL+iB3FIfC
        z5e9d+btff/Vr7MraK/0VCWO9hrxtGu+vqu0nS4J73k+N9KsIvinW2jY81/nL9j5Pxc5IK9m
        d/Pebym9SYJfbHb2TelaeC1A/kVX4b4A80b3z00qT5aEcT9pWL9Ga6Wz07/8CdpiO+/orkh8
        33HlmGCgpER2d1n/zhUO99Ke2yuxFGckGmoxFxUnAgBp9om8qwIAAA==
X-CMS-MailID: 20200624114134eucas1p2799e0ae76fcb026a0e4bcccc2026b732
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200624114134eucas1p2799e0ae76fcb026a0e4bcccc2026b732
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200624114134eucas1p2799e0ae76fcb026a0e4bcccc2026b732
References: <CGME20200624114134eucas1p2799e0ae76fcb026a0e4bcccc2026b732@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Recently I took some time to re-check error handling in drivers probe code,
and I have noticed that number of incorrect resource acquisition error handling
increased and there are no other propositions which can cure the situation.

So I have decided to resend my old proposition of probe_err helper which should
simplify resource acquisition error handling, it also extend it with adding defer
probe reason to devices_deferred debugfs property, which should improve debugging
experience for developers/testers.

In v5 I have also attached patch adding macro to replace quite frequent calls:
    probe_err(dev, PTR_ERR(ptr), ...)
with
    probe_err(dev, ptr, ...)

I have also added two patches showing usage and benefits of the helper.

My dirty/ad-hoc cocci scripts shows that this helper can be used in at least 2700 places
saving about 3500 lines of code.

Regards
Andrzej


Andrzej Hajda (5):
  driver core: add probe_err log helper
  driver core: add deferring probe reason to devices_deferred property
  drivers core: allow probe_err accept integer and pointer types
  drm/bridge/sii8620: fix resource acquisition error handling
  drm/bridge: lvds-codec: simplify error handling code

 drivers/base/base.h                  |  3 +++
 drivers/base/core.c                  | 20 ++++++++++++++++++++
 drivers/base/dd.c                    | 21 ++++++++++++++++++++-
 drivers/gpu/drm/bridge/lvds-codec.c  |  9 ++-------
 drivers/gpu/drm/bridge/sil-sii8620.c | 18 ++++++------------
 include/linux/device.h               | 26 ++++++++++++++++++++++++++
 6 files changed, 77 insertions(+), 20 deletions(-)

-- 
2.17.1

