Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F23C55183
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CE5206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b="fCsBAAz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgDUNJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:09:45 -0400
Received: from enterprise01.smtp.diehl.com ([193.201.238.219]:14101 "EHLO
        enterprise01.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgDUNJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=diehl.com; i=@diehl.com; q=dns/txt; s=default;
  t=1587474581; x=1619010581;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kw+nuYFqwHi/+sMdeAJ7EOgIaOWWOEHS7HNoEqJhP/4=;
  b=fCsBAAz2ct7QA2bOOaMifWqedBmmCTZI9iEtpAW6WaXXeKtArXKg6gta
   xf6ya1VHjp0/2TbnlE4CcxZZ/YCGSFEgWt4hIS1KRpX51CiJeXnb1w0hI
   Hge263ZLnrUsE3UC62ogaVFTA13f8lMJT7alqTd/dxIJMoXPP+OlsfCNs
   lR8GeczCq5V6+wMkHPasT7YOxJ+JwLGDyl05W2d4kWqOusVpeRgsBHkTB
   bkZoUO6rNEzDktLW2CZ0Q4X4PSYVO+LJQyhzbX/QyBi9xUWSpcbnjDr8H
   Oec1pXWbItCErw7NC1S+l2jwtIeB7Fca+FgH/dd9zgNiBnYM/ytazFT0F
   A==;
IronPort-SDR: pLTHyHopIZBaVBHpFj6OWKek5VaEyk2cQRCKEfRujjVa1GtPhzVrsiWF8yMWsLX1TCYmVlM/9K
 KQQzPkK3AcwQ==
From:   Denis Osterland-Heim <denis.osterland@diehl.com>
To:     "dmurphy@ti.com" <dmurphy@ti.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "jacek.anaszewski@gmail.com" <jacek.anaszewski@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Denis Osterland-Heim" <denis.osterland@diehl.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v5 1/3] leds: pwm: check result of led_pwm_set() in
 led_pwm_add()
Thread-Topic: [PATCH v5 1/3] leds: pwm: check result of led_pwm_set() in
 led_pwm_add()
Thread-Index: AQHWF94ON6Wnsc90u0OmrEelu7nAJQ==
Date:   Tue, 21 Apr 2020 13:09:14 +0000
Message-ID: <20200421130644.16059-2-Denis.Osterland@diehl.com>
References: <20200421130644.16059-1-Denis.Osterland@diehl.com>
In-Reply-To: <20200421130644.16059-1-Denis.Osterland@diehl.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-TrailerSkip: 1
X-GBS-PROC: PkB65aL1SqtESF35r/jQn2UYU/2HsH9z4KRTZJ+K/+xpyH+PC5zJpKM693q9Uoj7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

led_pwm_set() now returns an error when setting the PWM fails.

Signed-off-by: Denis Osterland-Heim <Denis.Osterland@diehl.com>
---
 drivers/leds/leds-pwm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 6c8a724aac51..ef7b91bd2064 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -91,15 +91,21 @@ static int led_pwm_add(struct device *dev, struct led=
_pwm_priv *priv,
 	pwm_init_state(led_data->pwm, &led_data->pwmstate);
=20
 	ret =3D devm_led_classdev_register(dev, &led_data->cdev);
-	if (ret =3D=3D 0) {
-		priv->num_leds++;
-		led_pwm_set(&led_data->cdev, led_data->cdev.brightness);
-	} else {
+	if (ret) {
 		dev_err(dev, =22failed to register PWM led for %s: %d=5Cn=22,
 			led->name, ret);
+		return ret;
 	}
=20
-	return ret;
+	ret =3D led_pwm_set(&led_data->cdev, led_data->cdev.brightness);
+	if (ret) {
+		dev_err(dev, =22failed to set led PWM value for %s: %d=22,
+			led->name, ret);
+		return ret;
+	}
+
+	priv->num_leds++;
+	return 0;
 }
=20
 static int led_pwm_create_fwnode(struct device *dev, struct led_pwm_priv=
 *priv)
--=20
2.26.2



Diehl Connectivity Solutions GmbH
Gesch=E4ftsf=FChrung: Horst Leonberger
Sitz der Gesellschaft: N=FCrnberg - Registergericht: Amtsgericht
N=FCrnberg: HRB 32315
_________________________________________________________________________=
__________________________

Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-M=
ail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhal=
ten haben. Bitte loeschen Sie in diesem Fall die Nachricht.
Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung=
 und/oder Publikation dieser E-Mail ist strengstens untersagt.
- Informationen zum Datenschutz, insbesondere zu Ihren Rechten, erhalten =
Sie unter https://www.diehl.com/group/de/transparenz-und-informationspfli=
chten/

The contents of the above mentioned e-mail is not legally binding. This e=
-mail contains confidential and/or legally protected information. Please =
inform us if you have received this e-mail by
mistake and delete it in such a case. Each unauthorized reproduction, dis=
closure, alteration, distribution and/or publication of this e-mail is st=
rictly prohibited.=20
- For general information on data protection and your respective rights p=
lease visit https://www.diehl.com/group/en/transparency-and-information-o=
bligations/
