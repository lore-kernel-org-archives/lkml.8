Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF5DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3441120838
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t6PkU2q3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e3pNxZN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgG2Ikd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2Ikc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:40:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286B5C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:40:32 -0700 (PDT)
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596012030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4LCjeGJpW4pRVYi1eLYqbWJFyRnJudboor6NQDbeb54=;
        b=t6PkU2q3bp2ma+U68h7q6mcQN2qiLxZo+KMZAWJm9VwrzUjWFebpTFrXhmY/wgsQ393EBV
        MELhUDf2jMs6eORs8NLADjRR1k0BvQ5Rsw9tceDhx4PfxOqcpy+siIQOWMj6H4ftu5fwxc
        uiDMO2/AjTxvjBo6SRLqv5uQm70PSM8pOZJfn9ogYeAAQq8n9cAdFGOmHyKHsjmYbTrVaz
        ymwbFAUuqi+KETvgZP+YG4/bKjRkr6GLmRBnitUbZN9x04fZ4jRZCWU10u4emOrA9BjUv0
        lzu9L3Na3EyL7VyFYMF3oUf/nDPAeHKTz/mRJSaFO/pkJZNt2SeR6jjD9Qckvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596012030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4LCjeGJpW4pRVYi1eLYqbWJFyRnJudboor6NQDbeb54=;
        b=e3pNxZN41wFtpnA4LNXpl9jFk14S3QKaJWjCnYR33VgZEMbp41vPWxmrC+PhOBv9HRgGL1
        8cZpvbWW9dinB/Bw==
To:     Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     alison.wang@nxp.com, Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level IRQ time accounting
In-Reply-To: <20200729033934.22349-1-alison.wang@nxp.com>
References: <20200729033934.22349-1-alison.wang@nxp.com>
Date:   Wed, 29 Jul 2020 10:40:29 +0200
Message-ID: <877dumbtoi.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi Alison,

On Wed Jul 29 2020, Alison Wang wrote:
> In the current arm64 defconfig, CONFIG_IRQ_TIME_ACCOUNTING is enabled as
> default. According to my tests on NXP's LayerScape and i.MX platforms,
> the system hangs when running the command "stress-ng --hrtimers 1" with
> CONFIG_IRQ_TIME_ACCOUNTING enabled. Disabling this option, the issue
> disappears. CONFIG_IRQ_TIME_ACCOUNTING causes serious performance impact
> when running hrtimer stress test at the same time.

I think instead of disabling the option for all arm64 devices, it might
be better to analyze the root-cause why the hrtimer test hangs when this
option is enabled.

+Cc hrtimer maintainers: Thomas and Anna-Maria

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAl8hNf0ACgkQeSpbgcuY
8KYpxQ//RjoQxUEmK/uS9tpUYaIyXBsdzn1QHI+DocwbnDs2kQZWBS6lEaibJsTN
U1f/ZVzo8kXCMKT4Nw0PZUF2RMKoD3+BM7Gvp9qIW8cOcISf+BkxVZDQzgLwdnny
9Mj6eeDD3JAkDYvWIlHfnG8t7x8yrTTVapEUsslv8qDwmzu8/GaAi7wIdSGRja+3
1XStS4ZO7IAdl1hxR6sFdkZKT4vxWc96F0V9Pv18MttddCvhs/S5EdeaBWWic2Rk
4fAxYPycj1HJORz0PIc05vFE6dglAMjrN5lKdq6w487eeDStBNJncjhyEPspJqSD
/ASSvXu4Ow65MAtEfzqJ8Iaw4SEi5Z3nF0iPeTNGAy2TnEHK5mGgSalVIf+mE7OT
cm2+mE62B3pOGRYWju8VXjay/scJ62NT6DZX+NWBsAcvoik0g16iUo+89wxmB2IN
OU7fBTm3y9tX7QpvLn5RjkEQsWdypeAshb3vQrhvefjbZ1pSpqbjEC/AOrHDVPSH
AUG/OrImA1PB1sUA5fjhD4GmJ6zGmFfwrRheEWqGJeDoBrVcmgO0OSIjVqY888G8
PcQV8j65TrCCrhYLX8N1WF+7pOHouWADGNVrtrWAo1D7Gr+7rNql7LebQxUyTzEU
sT2KRBxmrfkkJMFCGTVtFEM68dqXtnrWIXlA6lGRnAqEo/qNmh8=
=XV1c
-----END PGP SIGNATURE-----
--=-=-=--
