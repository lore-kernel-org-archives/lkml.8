Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DAEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7452B20714
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYBKWCsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbgCaWtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:49:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34548 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731255AbgCaWtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:49:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id c195so2143948wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 15:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zgt1uESpUWtghd1ufq6ryDrkORzZCgqG+MTqVl1OJU8=;
        b=dYBKWCsrRIrxOPPAvaqGuprsttjEf/m/+5i+hN0TKkXz9XhtDRigwZUpBdQFP+dH++
         gutqwG91SWJ1oAdHkeCnowVWYd9GjGbjOlsEnOIA+JF0g2n+MMTgRCUiqP4RuQDCNaao
         O2lY5bjdVKppObdYd8FMU5b6zonfU4BKmpuLTI0T4CIEISBoJgzLM1/Bl007rD3HGh3A
         GWn0sXHPWve0RnFW7uoIsLFsaw4cAEzPLjyNAdMvBiYBf9pxhGqe62IYCvvZVvUKawnN
         Fqsbz1G6Bw5zEqrX+j7UqSF+SZiSKKz70pCs0zELBGGFNHwpCz26J8I4TbS+/XrUhLB6
         GOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zgt1uESpUWtghd1ufq6ryDrkORzZCgqG+MTqVl1OJU8=;
        b=d/okxaHE702x3Uk0RqawKQFGES8QqDryzm4NpweNFMdr7QGOle+IpU7q439vQqiPzx
         50KYZDrMAWxyBHMsiANiBd7HVpwI0giPft8qj+m22V7JAhUo+PikNJmcGyTJh0Xt9wkD
         YrreD8Dk1P9cddpBWKQF9Y/BVl/qyKfhRcG8UM6r5YpxOKmq/Cs49ChUYzlJaKIyaoIs
         SbxPHGH054eJKq/ZNIbd3mydvnfhB2A7kOT54+4DF7ElPuhG/AqzQl2iClaYPl9+aYqr
         UYvNcimm8PI07sk2dbYMwj84D9vQnSPSSNiCJaT4ZPMC/8nJ9yOzhW0Aue7CX+MZfkZd
         lyoA==
X-Gm-Message-State: AGi0Pua0+rlIErgWorJy6jkqLpBlgaf1TyXjsesap6oDGEoBipsWT7U0
        zzuiVLZdkkeE9hvxHbo5Yzk=
X-Google-Smtp-Source: APiQypJaVgJ9oQBkUZlzCnvEtL1kpWcMkOHQRatPvmQ9gMsBk0+m0umgJTq4LA3jifn9mnBNqy89zg==
X-Received: by 2002:a05:600c:21d4:: with SMTP id x20mr1060188wmj.77.1585694952154;
        Tue, 31 Mar 2020 15:49:12 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id m5sm110490wmg.13.2020.03.31.15.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:49:10 -0700 (PDT)
Date:   Wed, 1 Apr 2020 00:49:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource: Add debugfs support
Message-ID: <20200331224910.GA2967489@ulmo>
References: <20200331214045.2957710-1-thierry.reding@gmail.com>
 <87lfnguqky.fsf@nanos.tec.linutronix.de>
 <20200331222917.GG2954599@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20200331222917.GG2954599@ulmo>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2020 at 12:29:17AM +0200, Thierry Reding wrote:
> On Wed, Apr 01, 2020 at 12:06:37AM +0200, Thomas Gleixner wrote:
> > Thierry,
> >=20
> > Thierry Reding <thierry.reding@gmail.com> writes:
> > > Add a top-level "clocksource" directory to debugfs. For each clocksou=
rce
> > > registered with the system, a subdirectory will be added with attribu=
tes
> > > that can be queried to obtain information about the clocksource.
> >=20
> > first of all this does tell what this patch does but omits the more
> > important information about the WHY.
> >=20
> > What's even worse is that the changelog is blantantly wrong.
> >=20
> > > +static int clocksource_debugfs_counter_show(struct seq_file *s, void=
 *data)
> > > +{
> > > +	struct clocksource *cs =3D s->private;
> > > +
> > > +	seq_printf(s, "%llu\n", cs->read(cs));
> > > +
> > > +	return 0;
> > > +}
> > > +DEFINE_SHOW_ATTRIBUTE(clocksource_debugfs_counter);
> > > +
> > > +static void clocksource_debugfs_add(struct clocksource *cs)
> > > +{
> > > +	if (!debugfs_root)
> > > +		return;
> > > +
> > > +	cs->debugfs =3D debugfs_create_dir(cs->name, debugfs_root);
> > > +
> > > +	debugfs_create_file("counter", 0444, cs->debugfs, cs,
> > > +			    &clocksource_debugfs_counter_fops);
> > > +}
> >=20
> > It does not provide any information about the clocksource, it provides
> > an interface to read the counter - nothing else.
>=20
> The counter is part of the information about a clocksource, isn't it?
> But yes, frankly I had anticipated that I'd be adding more files here
> and when I ended up not doing that I forgot to update the patch
> description.

Looking again, I suppose I could add a couple of the fields from struct
clocksource to this as well. The rating seems like it would be useful,
as well as perhaps the mult (and maxadj) and shift fields, which would
give users an easy way of converting the counter value to nanoseconds.
max_idle_ns, max_cycles and mask seem too low-level and are really only
useful for the kernel to deal with the clocksource.

"flags" might also be interesting.

Any other suggestions?

Thierry

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6DyOMACgkQ3SOs138+
s6Fu6w//WwiI/Wot1vrxQPuA8shfQvUV7ZJ9UYwMncWTSr/IXRHqQZ7EW3hck6mA
rBU3lhA6c1oLaeDNbExMV6gY97cwEYT7viHr9o5TqZqpSFqkXJKT4LWr/CyzNyO/
GlMftSZVz9KsAMyhmJ4zRaEtPO6BbrVB0QCmX5nAmIJawcfamnv0Zega6VQSW91d
ZlbDUr5NWdkRSkVS4hTTqS7nxxwexC96CZcPmoQAtwBiUqQZKBEf2JAyXOZcwkoQ
Tl4DjDZo0j75UvIDv6Bsnpe+1ICqoJDWSWNtQUwuW/0G4aPvaDT6kW++EW7JgbVN
mAment0A7HsBekPrfm2HOcSL+1JmRA1r24RL4IBKkcnfBg/EFgQ5K/SXh2fZbplG
mPNHb9yyT+o9Ye0Hr/RDSTGlXfx+X0RYhD5oJ8lyLsyy1M2XvEDUpTPRMHKTPM4m
dcT7268Iy2NaZFF5I/nl0crcXaDKg7ueASi67qZefmwoeakZ4RCyIGjeVAQFXY6J
SLDRTurFIqiqW+piP9qQ4QodhY2C+V6QvDe1Vxj9gvyuiFb6KJtoaMjA+KAvp4CV
4Nh2Q6uZzbeWfCopJkYoN6vSj/V9+dk7NhiAtYXJ/Ul6XlDR8zwJdys+EMU3HSoW
yt07oKwt3wGHoR4GMcerUV/z3CXPNzpPMVPNurzlflSfkSoylE8=
=u6ci
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
