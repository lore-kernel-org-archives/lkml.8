Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DADC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A634B2063A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slj96URn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgDFKEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:04:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33608 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgDFKEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:04:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id g21so1356278wmh.0;
        Mon, 06 Apr 2020 03:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TDxVDF2XVyHK1LpPBZBlcR0MpokI9aaOMTXvOXm2QFs=;
        b=slj96URnwsKS5pPlbU8Zvbw/ymTmZPpymkHbhDerbD6rJvw0kYwQOb4QMhZIycJZLb
         xp3aIPbkdJFXYU8uX5u+yy5u/opWF2hrhj0BEWP9HsLE4h1ZylqCD8Vzg3w1spTCOkZv
         Id7azN7Qc/vONo33LjyAKXPxbPQWrY+Mld+W6h3ahI0DZGN5RTkQFMqjeDq3NIGsHv+h
         p1xahfhixL0fGOeH4yCOG+S8S//33UsuRSZ7lXQPJlpPx29QOTYMr4N50PRpuCvN214S
         nztGKNakCFDieyuV1KtLbs5Mg7HrQs29Czrz12UeiWiJA0erKVAoDE2MEVTEHh61d2fq
         27Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TDxVDF2XVyHK1LpPBZBlcR0MpokI9aaOMTXvOXm2QFs=;
        b=IwnnghIDQfM2CXD62g9OiT8J53cNHH1/2DmQ8CiSsccMFPU/Wvsqxbh5CvrPTRzN6G
         nXnENyCkDxsLZwOb2vryu54zxAtEXRl9up8a4zfAx3o6grmojmXlw/aaKCOce7CC//l0
         sHY59rhtPYpegq1J0dbv01+J2QbNgAHWQkuYCjT+RU+tck2mAV8xyNR7itd82pVLdW5h
         28lhzxSuwZR+P0vINTchJQIngoT+dx1TvvqpbszRFPdbAq4bR0xYd+kPHdhAwwuXwzd+
         LYkkywJAEgEV5ZEV66zr6UFOCX+1aBFNU3Sxw2lUSrYK3sanKUypNe/WFCzDiBlUmyOs
         c22A==
X-Gm-Message-State: AGi0Pub1eHhXyfvFq2QL4mLanUvug2sT4hzzUuOGU/3DcOkRc3y3j9HK
        xW8Zl5lQx/v6cCoEYWn0iB3N50Hq
X-Google-Smtp-Source: APiQypKnVE9KLirDRtYyYCwaK9z8EPYQ48t44bv9OTxySufX2aEFJDl57z7NIHlciCFzL4i5rBj+mw==
X-Received: by 2002:a1c:5605:: with SMTP id k5mr12809098wmb.83.1586167453487;
        Mon, 06 Apr 2020 03:04:13 -0700 (PDT)
Received: from localhost (pD9E51D62.dip0.t-ipconnect.de. [217.229.29.98])
        by smtp.gmail.com with ESMTPSA id r15sm27503137wra.19.2020.04.06.03.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 03:04:12 -0700 (PDT)
Date:   Mon, 6 Apr 2020 12:04:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] of: reserved-memory: Various improvements
Message-ID: <20200406100411.GB475759@ulmo>
References: <20200403185640.118569-1-thierry.reding@gmail.com>
 <CAL_JsqLsCHJOuYBdh33eouu3VhwYzv5XR5wop8QAAi4jXP2xcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <CAL_JsqLsCHJOuYBdh33eouu3VhwYzv5XR5wop8QAAi4jXP2xcQ@mail.gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 04, 2020 at 07:24:25PM -0600, Rob Herring wrote:
> On Fri, Apr 3, 2020 at 12:56 PM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Hi Rob, all,
> >
> > this is a set of patches that I've been working on to allow me to use
> > reserved memory regions more flexibly. One of the use-cases that I have
> > is an external memory controller driver that gets passed one or two
> > tables from firmware containing a set of EMC frequencies and the
> > corresponding register values to program for these frequencies.
> >
> > One of these tables is the "nominal" table and an optional second table
> > is "derated" and is used when the DRAM chips are overheating. I want to
> > be able to pass these tables as separate memory-region entries.
> >
> > So what this small patchset does is make the reserved-memory code adapt
> > to this situation better. On one hand, while the DT bindings currently
> > support multiple regions per device tree node, it's slightly unintuitive
> > to specify them. The first patch adds a memory-region-names property
> > that allows the DT to specify a "consumer" name for these regions much
> > like we do for things like clocks, resets or the reg property. At the
> > same time, a new alias for memory-region, named memory-regions, is
> > introduced to make this more consistent with other bindings.
>=20
> It's just not worth supporting both flavors (forever). I don't want to
> repeat gpio vs. gpios. Let's just stick with 'memory-region' and allow
> that to be more than one entry.

Alright, I'll drop the corresponding changes from the bindings and the
OF core then.

> I'm not a fan of *-names, but fine.

I suppose I could work without them, but I like the descriptiveness that
they add to the device tree. There are also cases where they can be very
essential. For example, what if a device can take two separate memory
regions. One case that we have on Tegra is the display controller that
can have a framebuffer and a color-conversion lookup table assigned to
it on boot. I think in this particular case both are actually always
there, but what if either of them was optional. Without -names it would
be impossible to describe the context if only one is provided in device
tree.

Thierry

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6K/pgACgkQ3SOs138+
s6EcBBAAknv2wjVaLqK8Fv5noZrIB4XtpJNVRyHSCdzsZ32kDSogdVHbSGnmgqdb
sGP6hAF8i6wZan9ZfAm3ZGcYTngPZPJVMI5EszlVW1WXtiXjpA963KSuVwg930H+
h8oPvchZ6DKOiHy90RaVt3wIyZA0CQwpCDukYMxjj7o2xzx+Ig7ywmaP+GkV6lUF
utXr68/po507c5JsgB9xc8THDnM1dOazLPrb3O0nG+WcmGeLuqZx8AVZnGZsM5Bb
khjmisr6O2YpATkGWO7ZJbRMKSQZOVgmkFxJB2NpuOKSU0z5PdlopYAh8OgCOjy0
e9HKoAaF0Ip7dlMaCKrEg3tifMCPQZ3o5UroATrDfVQagRCzing/UGqGSaftNkif
+yh8DiwKpttDEdsKK5Oipa6oCwViqCANXIFe443lYdlSH1qUMO2ow7Oi/DEIFeTB
6NjOKi2HQxrhqQ3BOc7PvAG/eUH+yBH3P9mUEwctFdTLvlQgsmIo97vA+wAnkL6o
nYP+wQLkehEV2WsHFJFFVZZbbATX0UjXyQH0QGCFGXK1vYw0KwJcwDU5V1k/+HFh
o0TonpcG28IksxcDuw4CcuH3MZbB0a+AvAPjjfewmCbx+L3hDWULJK2dl3YPRYtP
o1wNwBsuUDtHNREgj3KcZMBj3YgBEdryxTM6dHDtOa25Ze8SacM=
=98ej
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
