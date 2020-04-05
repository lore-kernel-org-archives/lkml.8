Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD060C2D0F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 12:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9717720659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 12:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="KAubVv0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgDEMS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 08:18:57 -0400
Received: from mout.web.de ([212.227.17.12]:46943 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgDEMS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 08:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586089106;
        bh=Q5RSUdBxAuq3Pu0Is6KAfaOaMHcgrkIjqfGuQ0cJiDQ=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=KAubVv0AbUBupdEPKPoBx5XCZ+3/7aejCVkTn72IyJfm43BmImSN6UfNHIyM48XkE
         zuEfz3eyRMcNC5XNrzIZMMj6s2sHxSftKMAHqPQvAhoO7zdvHcMQdSpQTfcrhwKCBj
         IBfgwL/EvtyFU4YqoQ4c2hzu1S+Cu6BNF6wApebI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.99.70]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mcni1-1jcK8G2zkv-00Hzf2; Sun, 05
 Apr 2020 14:18:25 +0200
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/exynos: Delete an error message in three functions
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <57b725ed-f705-b5e1-0da6-3d16801c7c85@web.de>
Date:   Sun, 5 Apr 2020 14:18:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yxAjxBa23Kh2Wy8xweg0fTEFSRuPTdylWTMCAmjl+mPFViWxPlf
 8G83QYVy9DM4gpO5u+mfNtzKMsXZDCHQTLHW9ou14NopyXBpmehBoGKyZedWr+pMylO8vEI
 /ABdguiqIeJNipLfgzXBHwC42CTqihzIbdf21FdV+eZpX9ghftIj62DbUMWMSUsRxJGanCr
 XHLHXaQ06FxEPK4kMKDrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ss7mf0/IfsU=:WSCB+Y5HH0fDrGkZEbykLM
 QM/rKmMpUSe4F/cPiqw20uRU0YqP53IWhLXFVeHexb4P4aZK0a0eGH2izX2Di25xPYy665B5b
 ERUhYEyR+HxytGtngKILyA9OYeZVlVfFwg8QJdN9sBEpzlY5CWZuDoreZzzdFo3iiqoalpVkh
 OjHWmpf/CZvjNVe+PDiSoa+M2tVEIXnUOAb1XNOWw7qrr0lyee39kdYC5aPj+WrULIX7/wNSE
 vq6qxHqiEDhboIDlLPZYh8hZqSJJ1AXxvt/Nd2VUGZewGiIg8howyNnOJ3vl2z4QscXPy9Q/a
 RlSW2LE41fX/uq9OvxdJDPTbLWUV7H7b2FvvS7IgjpqNjDWRJLjj1X9aubmotIpqC+ON4xpIy
 KPv925EHV2+KgOeNvzYw04u3vQeX5lrMAKOXB3qfmQvMWjPpxhb7ZSGtJ3307xFipdKgS4L0z
 lDfP30r53TuPfsPLOgGO07rRzos4iQmEn4R06b15lBZDnpVaK8fOM9XxTYVhsqG25IgiNw/5d
 jLUdK0k+pshdoFLiUxhSzmXNog8vTdHHMoGvisK29K0dbKL0AVoZS2hu1TVJXMT3KrXfP96vp
 QkU4uX/CvKIdB4cNU4xTMO0r86TkCAaMM0/9DMgCsZrcKxGIAivx3Br2zyeyms/0F/eT3QacZ
 ucC+Jl3IdZYHbyy9jWX2i7lpps0t6c0+W0FUubPSB8i2OcgmmGzC4gDD0KMfML88IVllXbw4n
 8qXx/jorJ5rjl1iO+08bdNBkwWkzSh3PLJfuU6+uqNbGhTZeQCaWvnmNMYHuc33MlZEmkaOWH
 hDStB95DQV4KWMVCiKncjSFnqtkNrh6s70w4AAWmer+jbX1LLJY8CNDMRNxzDglWhrsKyyugB
 Z3HC+YNkPftL6YnXM6rXR2ClnAN5se0uVJ7eJ4hm3dxvXYVk8X6n12BYFAi5k4lkUzFTj/bUy
 k4ipbiiMBg+OJ0NWFMYKmWwLWZ4rNipN6xsfCGJmIuGuAbtgNXuapSGWT6wt9icMBWOuI5t0y
 BfcoEGRjFLC42FAKdDaf2bNi1Ljxa6Jj7U3gVCT+y3PsQJ+bLQUd3oURXgNLlhd77fvl0bgR0
 aTnKLlWOAfxIwhLs3BF3w/tmMIFfIiRpxtNvZJkI8mkT6DFEXpEZH4Fg97FtTyeDf3Iwca8BL
 Vdt3zd0GaPOGvjADqKpkjNoeii34vCfOQ8qixZ3EXM/ogyAKG+hWo/L4yUjRKlK84tIngBlIw
 nVUJSC5igMn5IutvE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 5 Apr 2020 14:10:09 +0200

The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error already.
Thus omit redundant messages for the exception handling in the
calling functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/exynos/exynos_drm_dsi.c     | 4 +---
 drivers/gpu/drm/exynos/exynos_drm_rotator.c | 4 +---
 drivers/gpu/drm/exynos/exynos_drm_scaler.c  | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exy=
nos/exynos_drm_dsi.c
index e080aa92338c..a00c6dd16c8a 100644
=2D-- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1813,10 +1813,8 @@ static int exynos_dsi_probe(struct platform_device =
*pdev)
 	}

 	dsi->irq =3D platform_get_irq(pdev, 0);
-	if (dsi->irq < 0) {
-		dev_err(dev, "failed to request dsi irq resource\n");
+	if (dsi->irq < 0)
 		return dsi->irq;
-	}

 	irq_set_status_flags(dsi->irq, IRQ_NOAUTOEN);
 	ret =3D devm_request_threaded_irq(dev, dsi->irq, NULL,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_rotator.c b/drivers/gpu/drm=
/exynos/exynos_drm_rotator.c
index dafa87b82052..2d94afba031e 100644
=2D-- a/drivers/gpu/drm/exynos/exynos_drm_rotator.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
@@ -293,10 +293,8 @@ static int rotator_probe(struct platform_device *pdev=
)
 		return PTR_ERR(rot->regs);

 	irq =3D platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (irq < 0)
 		return irq;
-	}

 	ret =3D devm_request_irq(dev, irq, rotator_irq_handler, 0, dev_name(dev)=
,
 			       rot);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_scaler.c b/drivers/gpu/drm/=
exynos/exynos_drm_scaler.c
index 93c43c8d914e..ce1857138f89 100644
=2D-- a/drivers/gpu/drm/exynos/exynos_drm_scaler.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
@@ -502,10 +502,8 @@ static int scaler_probe(struct platform_device *pdev)
 		return PTR_ERR(scaler->regs);

 	irq =3D platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (irq < 0)
 		return irq;
-	}

 	ret =3D devm_request_threaded_irq(dev, irq, NULL,	scaler_irq_handler,
 					IRQF_ONESHOT, "drm_scaler", scaler);
=2D-
2.26.0

