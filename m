Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E606C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7A320675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="AqejYmMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCILoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:44:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54878 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgCILoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:44:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id n8so5468166wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=J61S4igI7dpzhoY2RlAMjIDuMgx/6wd7UQAx9T95wvQ=;
        b=AqejYmMaT/JJ/x5Q0Ejsgl5uCwCU824vTZPGVMyyshJxFYfwu6zJAfLiX84TgHoHNh
         aV+c2SCl43KL7gvNEcH+xQCFVcQb2nkn4RqLnwGi0TjQUReTGYAoJJtE7QUEEqW3eBlP
         bAkr/JMfS4SiKwSIwZRNR5Meq2Zw45v+WD0yQ+ks1XGnwB/XoJbcnOlMqdFm7IFtPU6W
         HBgkmDJFNuduW49FIAJmRMCojc1R3bDdqS+9tM5lNgoZ97DaW8M+2SRJATJfTzONg3V6
         ch972gtcZ8/JhuYv98WANprH2hN9XgUI2fMo414jiI8jOTTJXDgJt200EWGVUbiJTTe5
         ex2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=J61S4igI7dpzhoY2RlAMjIDuMgx/6wd7UQAx9T95wvQ=;
        b=GqOoGhrIf6dB+SjWJK+JZM+XpfofDmauCfJBs43Hh1if450aRh7HPUKJOCKAI8OId4
         GmSe3oHf41cTjzbepHs2Dz1oXwFJLcWIrf4JYdN2CTLgGZhYFOrPcPRLd/GkQQcz9mch
         KGs0k/4gH60lRgz9yD/jcVNjQJb/k2V7AgQYkZKChNqFs02peJyjxBxIC/Tgq49rCoyz
         c4pDzyubw+Ma+Srgm/4O4+C+9f3lGFufQGEcHc0Ca0DLrZj/R821MlbE6KNJeRTaDw6q
         VgD5VWGY9M1TVO2H46Cpr5psRPkMyhbNKsTRX0cudKuZEReKRf0rVatGOxHKuaU5stIF
         iniQ==
X-Gm-Message-State: ANhLgQ0eYHeKd+v5HKKDbPZhUTpqFAEfs2VjDYFf7A0X0qI7Jku1PXna
        StJH4X3KfdUe9fHc1GaGbH/EVj5ej92n6w==
X-Google-Smtp-Source: ADFU+vuq2EMtVgA1xyTk6Y4qaPOk8zLsbH3BNn8EYlCfx/AERwDVP6GRwAgM1yQMVXyVyfcnxbnM+A==
X-Received: by 2002:a05:600c:2c06:: with SMTP id q6mr1098609wmg.69.1583754249142;
        Mon, 09 Mar 2020 04:44:09 -0700 (PDT)
Received: from [173.194.76.108] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id b16sm58127606wrq.14.2020.03.09.04.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 04:44:07 -0700 (PDT)
Subject: Re: [PATCH v3] microblaze: Replace setup_irq() by request_irq()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20200304005000.5067-1-afzal.mohd.ma@gmail.com>
From:   Michal Simek <monstr@monstr.eu>
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <955f28cf-f0b4-e616-1c95-23d157244fb5@monstr.eu>
Date:   Mon, 9 Mar 2020 12:43:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304005000.5067-1-afzal.mohd.ma@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="yF8MbjTisWV0VXr2QPXGpvyzOhrkhDnhn"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yF8MbjTisWV0VXr2QPXGpvyzOhrkhDnhn
Content-Type: multipart/mixed; boundary="Nnq5kcNMPenQ7UNPLELRuIDCvo2c97uLF";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
To: afzal mohammed <afzal.mohd.ma@gmail.com>, linux-kernel@vger.kernel.org
Message-ID: <955f28cf-f0b4-e616-1c95-23d157244fb5@monstr.eu>
Subject: Re: [PATCH v3] microblaze: Replace setup_irq() by request_irq()
References: <20200304005000.5067-1-afzal.mohd.ma@gmail.com>
In-Reply-To: <20200304005000.5067-1-afzal.mohd.ma@gmail.com>

--Nnq5kcNMPenQ7UNPLELRuIDCvo2c97uLF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04. 03. 20 1:49, afzal mohammed wrote:
> request_irq() is preferred over setup_irq(). Invocations of setup_irq()=

> occur after memory allocators are ready.
>=20
> Per tglx[1], setup_irq() existed in olden days when allocators were not=

> ready by the time early interrupts were initialized.
>=20
> Hence replace setup_irq() by request_irq().
>=20
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
>=20
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
> ---
> Hi microblaze maintainers,
>=20
> if okay w/ this change, please consider taking it thr' your tree, else =
please
> let me know.
>=20
> Regards
> afzal
>=20
> Link to v2 & v1,
> [v2] https://lkml.kernel.org/r/cover.1582471508.git.afzal.mohd.ma@gmail=
=2Ecom
> [v1] https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail=
=2Ecom
>=20
> v3:
>  * Split out from tree wide series, as Thomas suggested to get it thr'
> 	respective maintainers
>  * Modify pr_err displayed in case of error
>  * Re-arrange code & choose pr_err args as required to improve readabil=
ity
>  * Remove irrelevant parts from commit message & improve
> =20
> v2:
>  * Replace pr_err("request_irq() on %s failed" by
>            pr_err("%s: request_irq() failed"
>  * Commit message massage
>=20
>  arch/microblaze/kernel/timer.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/ti=
mer.c
> index a6683484b3a1..f8832cf49384 100644
> --- a/arch/microblaze/kernel/timer.c
> +++ b/arch/microblaze/kernel/timer.c
> @@ -161,13 +161,6 @@ static irqreturn_t timer_interrupt(int irq, void *=
dev_id)
>  	return IRQ_HANDLED;
>  }
> =20
> -static struct irqaction timer_irqaction =3D {
> -	.handler =3D timer_interrupt,
> -	.flags =3D IRQF_TIMER,
> -	.name =3D "timer",
> -	.dev_id =3D &clockevent_xilinx_timer,
> -};
> -
>  static __init int xilinx_clockevent_init(void)
>  {
>  	clockevent_xilinx_timer.mult =3D
> @@ -309,7 +302,8 @@ static int __init xilinx_timer_init(struct device_n=
ode *timer)
> =20
>  	freq_div_hz =3D timer_clock_freq / HZ;
> =20
> -	ret =3D setup_irq(irq, &timer_irqaction);
> +	ret =3D request_irq(irq, timer_interrupt, IRQF_TIMER, "timer",
> +			  &clockevent_xilinx_timer);
>  	if (ret) {
>  		pr_err("Failed to setup IRQ");
>  		return ret;
>=20


Applied.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--Nnq5kcNMPenQ7UNPLELRuIDCvo2c97uLF--

--yF8MbjTisWV0VXr2QPXGpvyzOhrkhDnhn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQbPNTMvXmYlBPRwx7KSWXLKUoMIQUCXmYr/wAKCRDKSWXLKUoM
IdUOAJ9Ig3uKifVWRRJ+g9t15rFkDQe8ngCfRvh1t2m5Zmmeo9KRpiuH4Urnjhk=
=M1dx
-----END PGP SIGNATURE-----

--yF8MbjTisWV0VXr2QPXGpvyzOhrkhDnhn--
