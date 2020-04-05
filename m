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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389B1C2BA19
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 09:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BA02054F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 09:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="HKNN8jBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgDEJRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 05:17:11 -0400
Received: from mout.web.de ([212.227.17.12]:51553 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgDEJRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 05:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586078205;
        bh=LPWQ7SziA4eoJv2nsD+mwWWiIDzRTTmjMOUxFZ2RzRI=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=HKNN8jBajUi7CcIdLKHHnb42YGFZXPg8DK39V6xUsJ2VlKQrMCAUaRmuTqO/45mwj
         QL0UF6N66Bvix78CBFDsMBFr+2JbquSBsC7vH8H9HthPW/lwOMK7PLRfXgldQ1OoZo
         /G/d3iP6J/ITxtVVVW4O+SyQq7BFEIeFY6tpb+dY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.99.70]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lheqz-1iyajM38m9-00msy1; Sun, 05
 Apr 2020 11:16:45 +0200
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/imx: imx-tve: Delete an error message in imx_tve_bind()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <eb87043b-1881-da68-ba28-35406b6594ed@web.de>
Date:   Sun, 5 Apr 2020 11:16:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6qsXH7NcfUP3dj9efSiFBR4IvcL7RBxJ4jGCoOyyG98pKa+sZK2
 VDjdSbAjhvo+fzFl1CSrzhEJC55RX//yxW/Km3ZOMKjU2fZyg7b7eM4cmDpjeGZAiHKobZf
 qS/2pHly1EUkiR/8GDog3ZzDLm5jDjRfGTf3LFu320T5lE44ii//3tfkxHR/S8hjRSBGZff
 KrrH5OKrRP8xZE58awTpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6K9WHWRD+zY=:2/i1n7SGJLbhB0q883kLpt
 GsEBu6V+WrX75p/bVrtUBIbfAylC+hsTGGDV6nyC31p4J2OnUOUaqkVrPu9MGNdd33sgF3tTk
 0Ay+cNGyiORlgF17+V/eRmW8kpf5zFw7rBFRn4hKEsCqzMOmYL7GuL06SGIipS/s2vIUYXlRd
 3AdHaDv5erh8SY8Of3E1mkHrGO1p0Ekj/l8kmskCRSPi7v8621uDPi0nMoEKgGalPL1smeiPj
 J7UltiU4CTLbHz7455q5shHpQyi4a9/w+x+PRyL5LL6/Oub5oxuHul1mwtkMWGAXRhiDzBeuD
 C8kFKe58ux59cuasy/Dv3SiBZoaqcOV3gLgOVpJ3/CgcHaRqRrgtTODvwsKiUQeIBsczzOpo9
 r3RjmwQL8VLDP+Pmtu3FXKAgHuK+q751oYEUu7DnuSwEEB+V45svZmQ3DUfav/eoDM18Rhhe/
 GDohrhTAhcE+YZBHHOMRsd27WA0kEnJfIFQUZ4qlzmteY428pQkvTcxO5yQzj8nhu962cqKue
 XpmZ56wYn//YjAAjoxs0V2bmM502pIPTW0YOhqPcAeKAVxhiChqi9bySMJN70YJ76yXyZSvyc
 Jn0+fQ08gfwyxg7003zq0iR5uSPyWg78E35v13Oe0q0eEPETbTGL708RE/8ht1iFI8374i515
 zEPI45/1+ygPA10MUTLQZXRIhjYdJy2h9VSrl6Uf8z/mJN22+/Zjv9q8AMMiPMO4OWXbzHFUZ
 rwGWIAFcjroxk3vtoLhHUQpBtYqAx/NujEb1imgkxByXBlke+t6cnCoS1Eba/qXWuxUSTqZKq
 uwO2QW9mFYSBEMzU1gsla8g1akFQy5wQvmGfPKmy56yxC45vLufCAUxaGIRmioRYHub4PyiXW
 sKAqnuXdWKc6DCCoBSCFgefEylZ0jYQiQec6ghzOXhFEycoFuNluN+UTvmphZC21+AjGh9U+u
 Q420sU/sgn+gdd6mFg4PU82H/7uqfNnL//npSrKCsUBJLGREKwThjJ1Hy70ErHRpqwbm3oBFQ
 okTGmdnOPgjxtaYdbU+JLjgAl4h7r78HzJ74cqCVXSa/AB7JhbfG7w5RW2C5JJQcc+KaW++y8
 awiuMtBNbBX3AJJj37lATqAOjyqPI2ix4UxpVeRjvddlerBh6sufWH4qb4fsKFqO2/QGbbBcy
 ZQtMfmlsAd+26rmiH6fDGtONePqZ0UMF4kXrahpFth4vAUSgnaSOK9z0sNhWCRJJ5qNU6cdQ1
 bsOKyp2DcC/FWIzNW
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 5 Apr 2020 11:01:49 +0200

The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error already.
Thus omit a redundant message for the exception handling in the
calling function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/imx/imx-tve.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
index 5bbfaa2cd0f4..23adbb818d92 100644
=2D-- a/drivers/gpu/drm/imx/imx-tve.c
+++ b/drivers/gpu/drm/imx/imx-tve.c
@@ -598,10 +598,8 @@ static int imx_tve_bind(struct device *dev, struct de=
vice *master, void *data)
 	}

 	irq =3D platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (irq < 0)
 		return irq;
-	}

 	ret =3D devm_request_threaded_irq(dev, irq, NULL,
 					imx_tve_irq_handler, IRQF_ONESHOT,
=2D-
2.26.0

