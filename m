Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05143C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB01C20842
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2mM0Itj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbgCaW3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:29:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36566 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgCaW3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:29:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so28177224wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 15:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uRZ23LXUNrfOjs9QRxja22SVc97I8fqzt5BMXKTwjiw=;
        b=k2mM0ItjR/DNEqp4gNkJOUYNUbWGEEMg0d8av0rlmSSzognu0oBHUKPbGAz8fwDZRE
         6+CQVPcR1LJSacfqjZn5bDvQoEyasMucJBBykD3lh7vHGMrza9dIWtdwS/GQtt7yiXXi
         3uw7TtOVksCtrZsYf6iFzOzZvLteTNY2DtauARrsZcME+GFPgOSkA1dx4xTm9klgn3Rc
         o7hPY6CM+ZhVyVU+rsT7wGguJ9Tf+TSmlv9aVh70r3o0ksCkfsvCjiwq3BnwCvO7xnuN
         mWYf5/TKYkbeGujH28Q85UYDEPmP1bfHgOao48wIfafTQYsH9gMiaoq1u3MpCsu3dyaL
         jnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uRZ23LXUNrfOjs9QRxja22SVc97I8fqzt5BMXKTwjiw=;
        b=LkxdksxPoVaAdrH3NaIMw+mxzXBLS+4l8xUU5MGTV3oD9BW0rLRA+Dp2T45s6acCzQ
         mjVMzQmFFsjtsMChux8gn98GtUqDHhMKA7FmeC7adufYC5ymj/JHJpTpGGEpaBFj6dU0
         2UHoDlkpRCsViqEXeYGwvb5XUzP2CdCowhrpXLphufKuGqtXXeYGhC9M+e57eJMpdKGh
         A0IG2i2a/t9U33Cp8nkNrW1Sir3aqdngfL8omhJ8TCgQT5BdG/9gfsnPTc2K7vaz74J2
         OhXf73wb3UpgLRWg7Lgam+g2z8cE10A6X75PmgIU/B8laPut14tUCaxBsHS4MHFPJnvR
         bSSA==
X-Gm-Message-State: ANhLgQ1MmKfESCc7iGqD5swFw7HOp++f3LMTjJw4Y/vnrcXWs1/nIwLg
        icn3tyPy0WUBvYPwHdj3hd4=
X-Google-Smtp-Source: ADFU+vsML20UBDmgsE3X1VKhzfvkDUReCydEBFWc2ImTEoG9zs3U5nvoDwK8k7hNoVtp0bntODbnlw==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr21750755wrw.234.1585693759355;
        Tue, 31 Mar 2020 15:29:19 -0700 (PDT)
Received: from localhost (p200300E41F4A9B0076D02BFFFE273F51.dip0.t-ipconnect.de. [2003:e4:1f4a:9b00:76d0:2bff:fe27:3f51])
        by smtp.gmail.com with ESMTPSA id k15sm201296wrm.55.2020.03.31.15.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:29:18 -0700 (PDT)
Date:   Wed, 1 Apr 2020 00:29:17 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource: Add debugfs support
Message-ID: <20200331222917.GG2954599@ulmo>
References: <20200331214045.2957710-1-thierry.reding@gmail.com>
 <87lfnguqky.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hcut4fGOf7Kh6EdG"
Content-Disposition: inline
In-Reply-To: <87lfnguqky.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hcut4fGOf7Kh6EdG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2020 at 12:06:37AM +0200, Thomas Gleixner wrote:
> Thierry,
>=20
> Thierry Reding <thierry.reding@gmail.com> writes:
> > Add a top-level "clocksource" directory to debugfs. For each clocksource
> > registered with the system, a subdirectory will be added with attributes
> > that can be queried to obtain information about the clocksource.
>=20
> first of all this does tell what this patch does but omits the more
> important information about the WHY.
>=20
> What's even worse is that the changelog is blantantly wrong.
>=20
> > +static int clocksource_debugfs_counter_show(struct seq_file *s, void *=
data)
> > +{
> > +	struct clocksource *cs =3D s->private;
> > +
> > +	seq_printf(s, "%llu\n", cs->read(cs));
> > +
> > +	return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(clocksource_debugfs_counter);
> > +
> > +static void clocksource_debugfs_add(struct clocksource *cs)
> > +{
> > +	if (!debugfs_root)
> > +		return;
> > +
> > +	cs->debugfs =3D debugfs_create_dir(cs->name, debugfs_root);
> > +
> > +	debugfs_create_file("counter", 0444, cs->debugfs, cs,
> > +			    &clocksource_debugfs_counter_fops);
> > +}
>=20
> It does not provide any information about the clocksource, it provides
> an interface to read the counter - nothing else.

The counter is part of the information about a clocksource, isn't it?
But yes, frankly I had anticipated that I'd be adding more files here
and when I ended up not doing that I forgot to update the patch
description.

I can also add some information about what I intend to use this for,
though it'll be a bit boring because I really only want this as a way
of testing that I'm reading from the right registers and that these
counters are running. A debugfs interface seemed like a better and more
widely useful way to achieve that than implementing some one-off hack to
poll those registers.

Thierry

--hcut4fGOf7Kh6EdG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6DxD0ACgkQ3SOs138+
s6HkuxAAlwgwY2e7rYQWJQodxNzovwuKKrtvjx9h7RNTjeUkK2EHm92DctTTyiMN
3gj7AIyiohClC8+33mUgZDilowTl0x/W904NNQ5hRihgRiuKz49gDrSlCEmubdkO
ltduKgxMTCHBdNZvxipMNkKuDHl47pnJnCZX564PMirK6czMSmcucVHLHwji2SsH
ybGM9WkY5EJyAxZ8hdG8JdVMcm4lDHp4M5ayRwanbawN/NUINqWp0874RrCDFhn7
q5cWxjzoRFSyb+WSkY2YmcWdAegSZqw64oSafp477beis7UdsaPNGx3xc7aWKqvb
SlfoJkt6qbRVybayn/sJqT2WifbFuJvfVWyGYl/Lue6VAO962tVd2G3d+itY374B
4UoorBSakf8mOVRPwgb2lms/anhZTGAppJgUURYYPRf+Eck5kX+hAd+r5UIMzjPg
KRY9xLlJxMiSMdGCA0WkEP1wbgWma7etaZOWE29uvetv8Vz671yQmuAZ9IUOh7Hr
XxS0CE7k6b5SEdSzVSrp8IcCaxyODuOvcW0lJJQPgaDeDNIveuSKAgOjMrH2kj0R
8ikTWJwMgvNk3B2+1q4KzqJYdKoBeQNv++h3xku8xciDV0uohw8sEiZvWEdkN8xS
CfRViphg31zVHjOu2MgcdPJ4P6b9vtBZ1XaruCtLP8A4ufJ0qvw=
=pZ+S
-----END PGP SIGNATURE-----

--hcut4fGOf7Kh6EdG--
