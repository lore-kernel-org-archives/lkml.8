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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A89C2D0F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 11:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4030A206F7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 11:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EnNmHyxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgDELfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 07:35:10 -0400
Received: from mout.web.de ([212.227.17.12]:44429 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgDELfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 07:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586086496;
        bh=xwgpbDc2i7sOHvO6OXNvOwVtlSJZvaKRRVhhOgOw6e4=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=EnNmHyxAEpM+FltqdN+dEx3CYjKYdQI/XfUr7DdDPS3W5gV6p418tEzg19KZzf6/0
         N84JFVTs59iJ7+OKjS3dc2ZqiihhSygUs5NduqafQVAP4ER+N+vuspljX5iIKACvPR
         4FXbrx9qfTwtdftEYHt+ZE4/I3ADJBSm8w+R49Uo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.99.70]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCImL-1jTcH03eIz-009AQY; Sun, 05
 Apr 2020 13:34:55 +0200
To:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/omap: dmm_tiler: Delete an error message in
 omap_dmm_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <89420027-bf29-3322-9d1d-f77cf4a8c35d@web.de>
Date:   Sun, 5 Apr 2020 13:34:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4CxUfNqhpzmv6gG2pCqJJGZvLUsPyzJ+y+jwgT4J8iz8av8uz/o
 XVjwm/dVXfSKKSe81t3Tb0UXHI1lcp302eB8/TLVdk5KcZrY1LV0sSNSWXSeWjq6/ws7ju/
 SzEgIjAJX8UVDoxFFXqikqvGhVwBcRrRgf176hqSn+N9EOq38M5YCFn6a5knRsCCZSjnGmA
 P9bZqiMNb7ykiiYb+Godg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2anMHRmEp2Q=:aT8BVr5L/ylamjccJEABly
 19Xhu65Kz3873BkXCHtFiBN8yxvE4qbdNEFHCEDUs9AEq9mVe7hmK40VsSVBqoa8l9Br1IDAH
 nTrdwfxI9zdE30mf+NhN5sQm6rdtXTl6bO7v3n5/DANJ/BlpAbgMo2XSBuk6bMsV3EusDjmIW
 oGtAsITu08TugULpj0Ai2axb0yuhG6bO6Dj0OvimVOCQjdiMuw+FoFNpUrK7jt79CoX9oZgRP
 ootr1IBzcpe2VuBxWVfNNxnuppRjh1n158epDmqwQeZI0Do3cAXsLtaCRPf7ianIjimkbaMEl
 p15p5yh61rlpGUDFHhrr34WAWTtTJvRXKWsuTNY61/Yw5p8008gWmRGE67juzXQa1Uqhqre2E
 +rwHObP8Zak+GhRRmciOuYn+oEtgWwJZh0kxai63d6Z/hQUm0gFua+i8rA0axlEA+DniMRpy6
 Xz/HDNiOt94TvWHflk65ylFsQ5Fy9UmXdJgUhJyRCrdasi4J1n+rFnq5NxgHrmAv3NPu7Pp4K
 cgym5T4dO2ksJYISVfUXJW/KLuw7PSSah/llFsbL6mzKkIpyAqzVB+oIpgU6aAvsFbM1QJ/PA
 xA6io68ZZr0FMMA4FC86HEKwcvVWQd3saPapDWrEP92YGB2eHGKi1ligpnWMeJ4ipl1nHTQ03
 PgJgVMcoZsh4lba6sjpL30ajPaheYxA5wjCP52iGYeP4nnTKRty/kLizaDJsCLttlAsQtfSlu
 eFlA2yR3gqHUZtehJDYSefymluG/RMu3iUyW7kl3ldh2yC13RdkP5ehMr2kF+WjAbD5fG3ENG
 n1PfbuEkcA95lD2k3u9B/94JXEdrQO4VNu2FgrloPBn7efJlMoAATzJWN9PyQ6fY42Udy2RFE
 GsOT7uTuv/RR9m1aDGbleJcpcl9lVnl/w2D+nZkrZ+6FKXE+zO/se4Dvp/kThfNqushu84tGD
 OiS9F9ka8eu/vokXiy0Ucnrjp7sOcy6jBpNJXYWPvGySoeCxW6MOaZM5chE9SbG5VLxGy51Nk
 evUOFW5Zb2zj0lcqMptBF4aXbVPjmrU+xbQg3pIBYrk387qOAAZrOldBLw4rah16ixEIcsM9F
 3cOSir8rHrZ+SqBtjpuhweAFi5KbJ0ZXLOJsaRAjRUSlm81wVCORWBWa6LKFiOkHeMvSnDQIp
 zRqStZC5lm7gPmSs7/3jQPNEEt/0OK/UNfLJ6ZKocB2tD82R+VdPkT8kr2rfYJt8EMH1rWgIG
 y8bKnczwzBer6CAvy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 5 Apr 2020 13:31:16 +0200

The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error already.
Thus omit a redundant message for the exception handling in the
calling function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/om=
apdrm/omap_dmm_tiler.c
index 42ec51bb7b1b..63553e97207e 100644
=2D-- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -820,10 +820,8 @@ static int omap_dmm_probe(struct platform_device *dev=
)
 	}

 	omap_dmm->irq =3D platform_get_irq(dev, 0);
-	if (omap_dmm->irq < 0) {
-		dev_err(&dev->dev, "failed to get IRQ resource\n");
+	if (omap_dmm->irq < 0)
 		goto fail;
-	}

 	omap_dmm->dev =3D &dev->dev;

=2D-
2.26.0

