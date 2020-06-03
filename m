Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB57C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A68206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Nw3geqRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgFCMzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:55:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:42605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgFCMzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591188902;
        bh=jKHhJmHxQkXdYjjqXk9mEhOE3xfXnWx+KSdbHS6fj9k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Nw3geqRI9a2dEmwRZaSG+M1BrwTX5m93sKawmElLm+jte52w8YiIywgQTpXbprPvJ
         cGz90uNtZNHIjn+JhYJnJfeS1OWbKFriy+1EcwYx94GRrnX1rEyRwELoK/X+YmmLpr
         5hIjcKt75xNvId0e6KWo1PEpSC/TaQ2cUTXRTZtg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [93.196.61.25] ([93.196.61.25]) by
 msvc-mesg-gmx023.server.lan (via HTTP); Wed, 3 Jun 2020 14:55:02 +0200
MIME-Version: 1.0
Message-ID: <trinity-27e19b3a-887a-4609-b127-16a3c9d5b804-1591188902362@msvc-mesg-gmx023>
From:   crustyaw@gmx.de
To:     AGeissler <Andreas.Geissler@duagon.com>
Cc:     Andreas.Geissler@duagon.com, jth@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] MAINTAINERS: Update maintainer entries for MEN
 HW
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 3 Jun 2020 14:55:02 +0200
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200603071049.7309-1-Andreas.Geissler@duagon.com>
References: <20200603071049.7309-1-Andreas.Geissler@duagon.com>
X-Provags-ID: V03:K1:OZfTRwHrlU11uSF3KVx9NPRSy7XybGFpzC3kWTJHMLWe29Ht6TEVfwahibQrZYvYnwTeV
 4N6ZzC8lVY89trycprO9xsI9jXTIZF9VESpaIqixRoQXX7/WI8MyiSHuqVi1neTAieIJCcO0ay57
 0mbY2XHmeRWYKGGKMy5HonvdgWsOLNe0LaYEnmfZNspYDXY0gVo77dqOWax84p1+kg4JwPwzczTx
 1KLtVar+o8m0jkbPE6wNqEIqQc0NiQrb5jvsBGc0STdXoXVDaPACCucQTnMVyCOsoUf5lyi9KKHC
 q2U5Ptf8Tn2RbArqX6z/7U8
X-UI-Out-Filterresults: notjunk:1;V03:K0:YGZGAXjeuk4=:1AKlQFaMul5WI5hg6WhVrF
 vaqOBANniwkEUkJ5Ffx1i7QKEYjHINiJnBYArHrdo5h51p7T0dAzE29MUITsWx4b1cQWa9Wng
 pz/CJiGMSdf+uZFBHeb2BD4QZCphghXnxH2Zf1A6euMAotN9vEzh1Ibo9coQeetiDbJ35/Z6m
 W+ZClg0L3r18D+R4FJgbWLJqWFsZbTKvN1ovMvacvPAhgXoTrPlBbHMNrLdnAhKqLSiXfPpgH
 ri1sqvfvhgZaou//Vyheo02U+QLmKrNhEcSEoKvNRQWc87eXUSLGDFjACUatuPplJyRrtO83n
 fq3CrKyf38JkW2gWwx9ctHOp9FIYLvv5mLdcz3ePmOJ9c9xMlsAkr/+8h//ySrXq450ND16V1
 Pov97CaW8z9kAKBowllgpQtAEzFhfoSMtDosFOjjmUxmF0oaSc70kKJ3m89P7mO4Gw3B9QUSi
 LbT345ftw/kO87qveclg3fmXCpC9zm8GtvpeqQx0l2iBYJrYXtA3APbTthzKdLtapswrbq1Nl
 Q/BFbxaPyChtQ0VtvV/com1ywZ6cU1XSbZ8kSHXk3YUzLgPKzlOiWchuJ5wrg9rj+eYS78KSz
 rWAxdwYK1Cwe7YD8JONkjKB76jvEuypIM8vH6W8KqIzSJYQWWtSApZ0Y+HTA0QFvygy2F2ldl
 LWGPKyckyu/vs4vzhQ5wLNxsWRsAeREAqufK2CiDRy7b7jRZ2t8I3VjO0VQ5JKajZ+jQTB1QC
 NMxtP0cH0lLztiX4gYFY0a/2qVR3YYmdE0Wb/A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acker-by: Andreas Werner <crustyaw@gmx=2Ede>

Gesendet mit der GMX Mail App

Am 03=2E06=2E20 um 09:10 schrieb AGeissler

> =EF=BB=BF[resend; because of missing cc]
>=20
> Remove Andreas Werner as Maintainer of the F21 BMC driver, as he is no
> longer with the company and add Andreas Geissler as additional
> Maintainer for all MEN Hardware=2E
>=20
> Acked-by: Johannes Thumshirn <jth@kernel=2Eorg>
> Acked-by: Andreas Werner <crustyaw@gmx=2Ede>
> Signed-off-by: AGeissler <Andreas=2EGeissler@duagon=2Ecom>
> ---
>  MAINTAINERS | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 68cd1b966b45=2E=2Eb3b45d2e9c8a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11044,19 +11044,21 @@ F:	include/uapi/mtd/
> =20
>  MEN A21 WATCHDOG DRIVER
>  M:	Johannes Thumshirn <morbidrsa@gmail=2Ecom>
> +M:	Andreas Geissler <andreas=2Egeissler@duagon=2Ecom>
>  L:	linux-watchdog@vger=2Ekernel=2Eorg
>  S:	Maintained
>  F:	drivers/watchdog/mena21_wdt=2Ec
> =20
>  MEN CHAMELEON BUS (mcb)
>  M:	Johannes Thumshirn <morbidrsa@gmail=2Ecom>
> +M:	Andreas Geissler <andreas=2Egeissler@duagon=2Ecom>
>  S:	Maintained
>  F:	Documentation/driver-api/men-chameleon-bus=2Erst
>  F:	drivers/mcb/
>  F:	include/linux/mcb=2Eh
> =20
>  MEN F21BMC (Board Management Controller)
> -M:	Andreas Werner <andreas=2Ewerner@men=2Ede>
> +M:	Andreas Geissler <andreas=2Egeissler@duagon=2Ecom>
>  S:	Supported
>  F:	Documentation/hwmon/menf21bmc=2Erst
>  F:	drivers/hwmon/menf21bmc_hwmon=2Ec
> @@ -11066,10 +11068,18 @@ F:	drivers/watchdog/menf21bmc_wdt=2Ec
> =20
>  MEN Z069 WATCHDOG DRIVER
>  M:	Johannes Thumshirn <jth@kernel=2Eorg>
> +M:	Andreas Geissler <andreas=2Egeissler@duagon=2Ecom>
>  L:	linux-watchdog@vger=2Ekernel=2Eorg
>  S:	Maintained
>  F:	drivers/watchdog/menz69_wdt=2Ec
> =20
> +MEN Z135 UART DRIVER
> +M:	Johannes Thumshirn <jth@kernel=2Eorg>
> +M:	Andreas Geissler <andreas=2Egeissler@duagon=2Ecom>
> +L:	linux-serial@vger=2Ekernel=2Eorg
> +S:	Maintained
> +F:	drivers/tty/serial/men_z135_uart=2Ec
> +
>  MESON AO CEC DRIVER FOR AMLOGIC SOCS
>  M:	Neil Armstrong <narmstrong@baylibre=2Ecom>
>  L:	linux-media@vger=2Ekernel=2Eorg
>=20
> base-commit: d6f9469a03d832dcd17041ed67774ffb5f3e73b3
> --=20
> 2=2E16=2E4
>=20
>=20
> MEN Mikro Elektronik GmbH
> Neuwieder Stra=C3=9Fe 1-7 90411 N=C3=BCrnberg
> Gesch=C3=A4ftsf=C3=BChrer: Dr=2E Michael Goldbach - Matthias Kamolz - Yi=
lmaz Kocak - Handelsregister AG N=C3=BCrnberg HRB 5540
>=20
>=20

