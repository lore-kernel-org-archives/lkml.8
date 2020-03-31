Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D89C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B8120842
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pviCpAua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbgCaXCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:02:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38070 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730589AbgCaXCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:02:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id f6so5003436wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 16:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YY0sp8ShqzeFlofZLZJagm3lCU31CAVQpLPrInq/x5I=;
        b=pviCpAuaMzU/xXujhH2Xy8gH0qohBwTA6FGzURsEGFnhOKIYxInfIPZ4cS1Hp4Qv+h
         wOG0xnH2EE2hdLe2kk8x2SOK5R/LRFy+94yjZaMDKCYqjv1EG7goDHnlexSYN5k2K5aC
         3MNl2yBT9XBN5LmfUf8NqiTTcCBLRkHA+AEdbr+67tKAsLnUerozJfvycYrjxoUD7ooo
         P0I5nvQsh3Rbql8zj053oLHC2YZ+TfaIST5gWEh8QA6l4y3c4tRJlr3igWzaAR9vy341
         sK2DfnIJjHQ3m/bchNoE/mPSROancQNn3isLXSTFK+Z5uS9ZLQ/uHgP6Q39ddauy0/4a
         pvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YY0sp8ShqzeFlofZLZJagm3lCU31CAVQpLPrInq/x5I=;
        b=dAqQow26xF6lg+mBNa/qhE+7LQRtFI8gsON79V/eZ/G3lUjBCqfDmN8mQi8+McZF+U
         UM0lFcqVuw5L7WCyu6l5po+5hhzwDODD8uAUMxuFlyR0k6RnJPmMk6X/p/OnscNOp1fW
         IgyHhT/c0CzEFPY6JyrfjeDYS04ey+MaHHEiQhF25/FdbyqfqU12vmV5tM53XE6qncP6
         MAassft7ABGWl5xV4hJ9suIKzfKGKS/h1tBcxIpZSl5LUWetLqGkC0IWNSPCwCWgbfrp
         atL4y2LecluBoRIvFQoxUzHPJ8kxYbWWpGY9rqz+LVHgVwZt86pANEX0pgWcAP5T2QBQ
         rULA==
X-Gm-Message-State: AGi0Pua71LYnCl2skVjEJyPYP0juYXd+IdUUOhaHkcnHN+SyLXQf5DVt
        asIw2XBCvhuWP1nem2fETmM=
X-Google-Smtp-Source: APiQypKZRwPxCO/GZk7vgkDa4fkv16X/Lw21cSltulKIXZE3IQtjL5YChiV5Wb1Rc3HDKmlpNeS0uA==
X-Received: by 2002:a1c:7216:: with SMTP id n22mr1115469wmc.41.1585695770147;
        Tue, 31 Mar 2020 16:02:50 -0700 (PDT)
Received: from localhost (p200300E41F4A9B0076D02BFFFE273F51.dip0.t-ipconnect.de. [2003:e4:1f4a:9b00:76d0:2bff:fe27:3f51])
        by smtp.gmail.com with ESMTPSA id t6sm124175wma.30.2020.03.31.16.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 16:02:48 -0700 (PDT)
Date:   Wed, 1 Apr 2020 01:02:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clocksource: Add debugfs support
Message-ID: <20200331230248.GB2967489@ulmo>
References: <20200331214045.2957710-1-thierry.reding@gmail.com>
 <CALAqxLXD78StqLMuaGqHqhSfS9L2FBfNCm6yDyWMZT_7iNX-wQ@mail.gmail.com>
 <20200331222535.GF2954599@ulmo>
 <CALAqxLWKP9Y9F+4hEpqfRyPYmQFAvyc1eBSArS1wpO+jeJK9rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <CALAqxLWKP9Y9F+4hEpqfRyPYmQFAvyc1eBSArS1wpO+jeJK9rw@mail.gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2020 at 03:44:25PM -0700, John Stultz wrote:
> On Tue, Mar 31, 2020 at 3:25 PM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> > On Tue, Mar 31, 2020 at 02:50:47PM -0700, John Stultz wrote:
> > > On Tue, Mar 31, 2020 at 2:40 PM Thierry Reding <thierry.reding@gmail.=
com> wrote:
> > > >
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >
> > > > Add a top-level "clocksource" directory to debugfs. For each clocks=
ource
> > > > registered with the system, a subdirectory will be added with attri=
butes
> > > > that can be queried to obtain information about the clocksource.
> > > >
> > >
> > > Curious, what's the need/planned use for this?  I know in the past
> > > folks have tried to get timekeeping internals exported to userland so
> > > they could create their own parallel userland timekeeping system,
> > > which I worry is a poor idea.
> >
> > This was meant to be purely for debugging purposes. That is as an easy
> > way to check that the code was working and that the counter is properly
> > updated.
> >
> > I certainly wasn't planning on implementing any userland on top of this.
> > Well, I guess it could be useful to use these values in test scripts
> > perhaps, since one of the clock sources exposed by one of the drivers I
> > have been working on is used across Tegra SoCs for hardware
> > timestamping. For that it might be interesting to be able to compare
> > those timestamp snapshots to something that I can read from userspace
> > during testing.
>=20
> So, other platforms do similar, but utilizing the ktime_get_snapshot()
> interface internally so drivers can share that SoC hardware
> timestamping logic and export that via driver interfaces in a cleanly
> abstracted way to userland, rather than exposing the timekeping
> internals.

The hardware timestamping functionality is going to be exposed by a
different driver. I was merely speculating that the debugfs interface
could be used to also read out the counter value for the TSC as a means
of correlating it to the values from the timestamping hardware. On
second thought that may not be very useful given the non-deterministic
delay between the hardware timestamp and the debugfs read.

Like I said, the original intent here was really only to make it easy to
inspect the clocksources. I can add more fields if that's deemed useful.
I can imagine that different engineers keep writing different test code
to verify clock sources and thought that this might be a good addition
to make this easier.

But if you have concerns that this might get abused for something
unintended I understand that, so if you think exposing this is a bad
idea, I'll just drop this patch.

Thierry

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6DzBQACgkQ3SOs138+
s6Fa8g//d0XkzrEDy6mQwpCMBed165K689BLOhV23gM/lzkJOQReVGjb6Bda6/VA
6N1/TMCh0pubncsnjGGeTO2q4TDwh++E8blSJPo+dI5Y7BSUXAVdDrMnd+Iag1In
5cT2X/KzlIx0yiylczNKdUPUpiJ5YXyYiF7esqJl6arteqXPaicK0za42Miogavz
1aDOyVsCnn9TX9GCi+pvoT/iuILKjtbkh0msUIr+1p+FEMz9YdFegrN2f4sfBMtn
ZTDU0ZKxHedk2pRX4yuqtXyX7Nn2KvuplZEl+bProw7v5nU12La+SDeC2bnGWBde
2b3dX4+9Tt0Nzi1OB9/M+Tw+qNQgvlU3LW4Rk8I0Om0sgpzjXfd8MnI7Fj6GPnt3
t1TtQ+Ok0Pm5GHoeU46SV+lzvGHJbri2e/096F3TWhF/WwOIb7AwHByMVp8Xnk73
/44CQG+OduoWGceBszUJmiSPkgKrMEfsdnCFH4BWtDdn2ALMLVOkICZyOMziO9RW
7TfgHpGGLSOL7HTiMDOLTYmUjW2OxyK3c5ri3LkVO8i8KP94Uz8DYOYSnO5hEArz
JPuG3jvoiuNAjPJVGzv9pAt0vY1MvN/18LGhAI1rqJhg5gfbJZ0BkeSVZoZed5jV
D6LMH5y0IfXlroiPYlCjKc9/QEeiePMxB7kwFPMADO3h3yDgriA=
=ckAh
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
