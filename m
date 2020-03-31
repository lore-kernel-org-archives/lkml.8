Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54B0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC9A20787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSmdVsQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbgCaWZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:25:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53328 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaWZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:25:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id b12so4414285wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 15:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xSdN4Bu7ieJk7DdR7Vya+R+Xaggz1lTEs1MBPbcTcOI=;
        b=YSmdVsQY7GpEjZZCobn8nbd2aLkQj1YokvMnqgXsuyC6tu3cIJr+yV2hivG929M1Yt
         sZfyO2NXMM5jYmff/dH9NaKf5zzCs6pxaxgfAsbEV5/ukIw9TfaZRb3jo5h8raMXHEvD
         ej3KERt1t36GL8rFdQ+6P7fjhk0fqPLIvLnFVl3/0cN19+GSNXOMpLe4LwT8CLlDtX9o
         0eg8WUAjD7VsYL8GorPpIhNzGU/+Ple1Lvle0xvDVic6h/tgRPOHGT5HoXODE6TtbZe6
         R2J6J4IuWT1BGinEoNJTu2Ht4KgtYRyvKlZQfClRATHtVqjREfg0tu1KVjhWSl7kpj7X
         Y1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xSdN4Bu7ieJk7DdR7Vya+R+Xaggz1lTEs1MBPbcTcOI=;
        b=P9NzvVOf/5kVtWv7n9UJ/xgl1H/eCImUc4S81UtwDXPusBNDEdqy7+wIWw3ZJ1sPyR
         AJB4AmQTgr6v0C5enlZOUKIidKcBpTpYE7qcmknApBclFNdGz7keM/JBGq/OlxlOTFpw
         RYUr/JPie0VgFQvZo1eT7YcimU9bPqtwz+afvdbz0oNQ+YKrTCYpn1TJVk420oPjoHzS
         Y7PYqnlBHyaim8OFcLAJJjFRvM3wQPCJkD5+ppBl2dfhOYX5LLsmO8Ad15mHpG12txC6
         s1D0rpN0UKDAs/LF2l0d1N2rDGg7oTRiFSepDSa24fy4fEab+94HwtLQRd1rjkCg2J+8
         cPfg==
X-Gm-Message-State: AGi0PuZjrA//jq5IhGtnBA6bzBsCjjywYE1Cizsb6kM9cAGCcX27Th+A
        Uyx+OSdqwDPpZdhHKhWRvzg=
X-Google-Smtp-Source: APiQypK5u4bGsGrwHjCOm46og9UvvihBNPnQNe1CFDcp05IIiYuE4SY1mawbHnNh/4UrW0d1y7bJpg==
X-Received: by 2002:a1c:e055:: with SMTP id x82mr1032774wmg.20.1585693537091;
        Tue, 31 Mar 2020 15:25:37 -0700 (PDT)
Received: from localhost (p200300E41F4A9B0076D02BFFFE273F51.dip0.t-ipconnect.de. [2003:e4:1f4a:9b00:76d0:2bff:fe27:3f51])
        by smtp.gmail.com with ESMTPSA id d133sm22516wmd.34.2020.03.31.15.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:25:35 -0700 (PDT)
Date:   Wed, 1 Apr 2020 00:25:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clocksource: Add debugfs support
Message-ID: <20200331222535.GF2954599@ulmo>
References: <20200331214045.2957710-1-thierry.reding@gmail.com>
 <CALAqxLXD78StqLMuaGqHqhSfS9L2FBfNCm6yDyWMZT_7iNX-wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B0nZA57HJSoPbsHY"
Content-Disposition: inline
In-Reply-To: <CALAqxLXD78StqLMuaGqHqhSfS9L2FBfNCm6yDyWMZT_7iNX-wQ@mail.gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B0nZA57HJSoPbsHY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2020 at 02:50:47PM -0700, John Stultz wrote:
> On Tue, Mar 31, 2020 at 2:40 PM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Add a top-level "clocksource" directory to debugfs. For each clocksource
> > registered with the system, a subdirectory will be added with attributes
> > that can be queried to obtain information about the clocksource.
> >
>=20
> Curious, what's the need/planned use for this?  I know in the past
> folks have tried to get timekeeping internals exported to userland so
> they could create their own parallel userland timekeeping system,
> which I worry is a poor idea.

This was meant to be purely for debugging purposes. That is as an easy
way to check that the code was working and that the counter is properly
updated.

I certainly wasn't planning on implementing any userland on top of this.
Well, I guess it could be useful to use these values in test scripts
perhaps, since one of the clock sources exposed by one of the drivers I
have been working on is used across Tegra SoCs for hardware
timestamping. For that it might be interesting to be able to compare
those timestamp snapshots to something that I can read from userspace
during testing.

But that's about as far as I was planning on taking this. I agree that
basing some userland timekeeping system on a debugfs interface sounds
like a very bad idea.

Thierry

--B0nZA57HJSoPbsHY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6Dw14ACgkQ3SOs138+
s6El0w//ZaYlL011KCX6wqZ/tyPhYGHVzPc4xLPD3g1eceLbuIjBvAFE3/Wt8/mC
uL21Jb/fY26IuxvipG3cueMy42+mKGh0qEtH+TqdCcSxKyNEordzJ7/7PGEOxt1g
CW8UYNn1u14gr7T9tMe+9gQP5S36oWeycVECfs7kR/K2iR2W6q9fvJ1iLkzR7GZ5
u7Aq4IUDizBmSm0/ciweQz7lG6qtgwuVTQjrLrdeFDapvWvZQIvqxBJUdNhCiWrv
9eCZU96W+4Zz2TNej2DDqrZgEwUTirACNae8pNwh6mZXoQ3FX40cqPlNKmjWWndL
L5q2e1MG7HnTp/nDQ7/tDRRO2s4/ZznZyLRLXEaFctp4N4VW7ZzowVntvpXaDB+k
t2XmzbHwT9rx3NHEjoYD+8d4xsz6XWmxh9vjhJTnqN/mx1EsH1c2tltxfzn3bvez
WdQY3/E3/GWdAXfWX1XjQtUrSq0TqF34bLE7zVHkLJLV/fdKDOncC3CljZQpDVc+
JU3uG9ctluDjnh/wvOyhJzRa5Io/MpYQhBMh0yQdHUyW+1RFV4cKY0BdEBPeImnW
FAdjCgAxRgp4JEjbz5q//6KIk93G1utsFUVFqn6j/S5QU7ZUdSzGO/DQLO22dWqx
Jg35CbsEXx27HPhRAtZSqkb1l9sZR0nL01pxIUBmMCMLHOfqNBQ=
=LW0i
-----END PGP SIGNATURE-----

--B0nZA57HJSoPbsHY--
