Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E72DC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED14D2075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUmXEapx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgETI4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgETI4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:56:02 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F06CC061A0E;
        Wed, 20 May 2020 01:56:02 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id j21so2701057ejy.1;
        Wed, 20 May 2020 01:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=96IfJFZvOtyXH6lib4OBbgBYF/BhSdQpUwQHSXQYUKA=;
        b=OUmXEapxSMCqI9a/VkUPAwgDosVhgHEbTAJkc+Pahu4CT1bzc4gocK+Vjog0oNRdcp
         dbFzOo6VCLK4wrZAEBMFaP4pE3ogqucFC4PJ3ov2EaR+hYuUBFy2gsG/E7O/zBlhJRct
         JpJhtWDq+8Nypy4ZqSCMO9RTPlH0s1mHWVJq/tRZ7IwQWAGRCsaSlAOPtpbVvUPPwg4w
         aNoMPlL2bPHSAGCEqFUZ7nT38LJIg3NnJ6YS5XXGw97ImMsl+F5cmH9Sjtm63RSjcs0v
         uQ3wHbWSAFnx24811nT56462pIO64Q8guKBfWvr9fNOwAShRQK4sJTwY7CqsveKjZ8cv
         H9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=96IfJFZvOtyXH6lib4OBbgBYF/BhSdQpUwQHSXQYUKA=;
        b=J+7Y+pdLgnwBG9HCH32Ja93OmfQY7sx8TZpLyCTxAiji/jCuBeZpdoJ38kA1ug4i6L
         LmJVOsKsEADIGxcx6uD3+zgsTlDvWHxAY4vMrmgOdwkf9gq+qOmStdK527JBNa4AHcRT
         Z32re1r9klS+baJx5Tf+6t2WT8byP5S1xt/JTZImfBOJYd9BzUwydvLqFyJOTUaheKyX
         /7sh6jFMw9vqj0rd3J/bcvKrwkwt8Mm4LR98TkdS/6+WWNzPLQ9PzvGH4wkhHNY5ENZL
         g1Pg2B1NRxRQ9m1s4M+MqoL8fvcIRLgagpOA2TFGbtBuaYmGzXkbd64ljUT8XW66ykYI
         mm3g==
X-Gm-Message-State: AOAM532CMQlgRngerF4TyEVAx0CDRZXfIvR0CgKDprpKqnJsg1ZHe8Mw
        wratXngcQMWa1au94hSn5bc=
X-Google-Smtp-Source: ABdhPJwOPcuPd7Xhen76qhPqQyJqdpOgz5HQ1rwyjQv5Y+vbfiBrAmmlMDsSB4jQIRL7WTOoBljzSQ==
X-Received: by 2002:a17:906:b182:: with SMTP id w2mr2892631ejy.261.1589964960833;
        Wed, 20 May 2020 01:56:00 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id m5sm1370979ejk.27.2020.05.20.01.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 01:55:59 -0700 (PDT)
Date:   Wed, 20 May 2020 10:55:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Warren <swarren@wwwdotorg.org>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, robin.murphy@arm.com,
        devicetree@vger.kernel.org, talho@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, afaerber@suse.de,
        arnd@arndb.de, gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/4] dt-bindings: sram: add documentation for
 reserved-only flag
Message-ID: <20200520085558.GB2136208@ulmo>
References: <20200512144803.24344-1-ykaukab@suse.de>
 <20200512144803.24344-2-ykaukab@suse.de>
 <52f099e4-5c03-2141-f049-cd3adeb04c5b@wwwdotorg.org>
 <20200513104127.GA2309@suse.de>
 <efcc6b5e-423c-8ae1-8a46-d6a06c1a1bab@wwwdotorg.org>
 <20200519230326.GA827289@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <20200519230326.GA827289@bogus>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 05:03:26PM -0600, Rob Herring wrote:
> On Tue, May 19, 2020 at 10:16:43AM -0600, Stephen Warren wrote:
> > On 5/13/20 4:41 AM, Mian Yousaf Kaukab wrote:
> > > On Tue, May 12, 2020 at 01:45:28PM -0600, Stephen Warren wrote:
> > >> On 5/12/20 8:48 AM, Mian Yousaf Kaukab wrote:
> > >>> Add documentation for the new optional flag added for SRAM driver.
> > >>
> > >>> diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Doc=
umentation/devicetree/bindings/sram/sram.yaml
> > >>
> > >>> +  reserved-only:
> > >>> +    description:
> > >>> +      The flag indicating, that only SRAM reserved regions have to=
 be remapped.
> > >>> +      remapping type is selected depending upon no-memory-wc as us=
ual.
> > >>> +    type: boolean
> > >>
> > >> This feels a bit like a SW flag rather than a HW description, so I'm=
 not
> > >> sure it's appropriate to put it into DT.
> > >=20
> > > Reserved regions themselves are software descriptions, no? Then we ha=
ve 'pool'
> > > flag which is again a software flag and so on. This flag falls into s=
ame
> > > category and nothing out of ordinary.
> >=20
> > I suppose that's true to some extent. This is indeed a description of
> > the system environment presented to the SW that consumes the DT, which
> > is a bit more than pure HW description but still a description of
> > something imposed externally rather than describing something that's up
> > to the discretion of the consuming SW. So, go ahead.
> >=20
> > >> Are there any cases where the SW should map all of the SRAM, i.e. wh=
ere
> > >> we wouldn't expect to set reserved-only? [...]
> > >=20
> > > Yes, here are a few examples:
> > > arch/arm/boot/dts/aspeed-g*.dtsi
> > > arch/arm/boot/dts/at91*.dtsi
> > > arch/arm/boot/dts/bcm7445.dtsi
> > > Then arch/arm/boot/dts/dra7.dtsi is an example where we should map ev=
erything
> > > except the reserved region.
> > >=20
> > >> [...] I'd expect reserved-only to be
> > >> the default, and perhaps only, mode of operation for the SRAM driver.
> > >=20
> > > It will break compatibility with existing dtbs.
> > >=20
> > >> If we can't do that because some SW currently expects to be able to =
map
> > >> arbitrary portions of the SRAM, shouldn't that SW be fixed to tell t=
he
> > >> SRAM driver which parts it's using, hence still allowing the driver =
to
> > >> only map in-use portions?
> > >=20
> > > User doesn=E2=80=99t need sram driver in that case. It can use genall=
oc api directly.
> >=20
> > This sounds a bit odd. Without a driver for the reserved region, nothing
> > should be touching it, since otherwise there's no code that owns an
> > manages the region. If any code needs to consume the region, it should
> > obtain info about the region from some form of provider code that can
> > handle both the allocation and mapping. Anything else sounds like some
> > consumer code directly making use of DT nodes it doesn't own. But since
> > I'm not familiar enough with the SRAM driver and genalloc code that you
> > mention to fully understand the allocation paths I guess I won't object
> > for now, although it does still sound fishy.
>=20
> I'm fine with the concept, but I don't think a single flag is adequate.=
=20
> If there are reserved regions within the SRAM, then define child nodes=20
> to mark those regions reserved. I don't think you need a new flag. Just=
=20
> a 'reg' property and nothing else.

It sounds to me like there are two different interpretations of SRAM and
reserved regions. On one hand, as you suggest, we have one SRAM that's
made available as genalloc pool and then individual regions can be
marked as reserved so that they aren't added to that pool.

At the same time, each reserved region is also exposed as a separate
pool and that's in fact used by many consumers as a way of getting a
specific chunk of the SRAM for their own use (via phandle to the region
=66rom the consumer's device tree node).

In addition to that, the reserved region code doesn't actually fully do
its job because while the reserved region isn't actually added to the
"top-level" SRAM pool, the memory is still mapped. At the same time this
is something that we actually want because, like I mentioned, some of
the consumers do want to get at their SRAM chunks via references to the
partitions.

The problem that this patch series is really trying to solve is another
still: the complete SRAM is always mapped to kernel memory, irrespective
of whether any regions are marked reserved or not and that can cause
speculative accesses to memory outside of the defined regions.

Stephen's suggestion is to default to only mapping memory for which a
partition has been defined in the SRAM and assuming that all SRAM
outside of those partitions is off limits. I think that's a sensible
default and it's unambiguous.

But as Yousaf points out that would break compatibility with existing
device trees. Depending on how you interpret the bindings one could
argue that those device trees are buggy and should have partitions
defined (in the cases I've looked at they end up using a fixed region
anyway, so that could've just been made explicit in the device tree).

However, it also looks like all of the users that rely on the original
behaviour where they can just access the full pool are those that don't
define any reserved regions, whereas all users that do reserve regions
will actually use those reserved regions.

So I think we can make use of this by differentiating in the driver
between SRAM nodes with or without children and change the behaviour
accordingly. I think that has the big advantage that it makes things
work as (I think) most people would expect and doesn't further
complicate the binding with extra flags.

Thierry

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7E8JwACgkQ3SOs138+
s6FCbRAAu99Kz3Uxhw2U9xjzQlZtnWqUzDmY88C6asAaz9iRAWVA27FTlfDv/zR4
PEBc0v03dUILdc5trq4qoe67oO6zuHqQKOioGl88Id4k5YtAPaCTG+EHXNNyLWiI
Ey91iH6LNyCe8PRSUBGaN3sgGHoZfNlUlgWz7+GPG6CZ4oQttR8s1Nv2fCgl8LsW
pX1+cESlq8eg+PLrxD2MQuDGf9+9D6Arp6GNXq5wyF2qeQqNQKkUGSu/upRiZ5or
qIvSSbV7Z3oEypHHTkZQvVovyjY61CCyz5XbozOikAvUQ2WQQ/lm05N7/RwSJCNt
FiB/CzW9YACQR0UhHJ77fozuuoLM5qdpdMeqgmtedhNqco+6dmVKiZCal4tnubGN
WNXgx0bZwdfGRrYoV2yvlvHRUHnbJg1cWl0LWw/Qse5BfJa7gsSQYchbggOxjqMT
06LLEdOpiCP7e/S133aq9aey/uMZuZmmD90moRkA6q2OjoDCWho75EKHu0PSE1iV
gPQmcKiEW1jWMsA03kulNVQYfLK3O+O1Pmo3WDXEBRP308ra19vTyFEd3Q7PfC9B
p1SgjRSZTGAP4IPYkV0FwiWWqcak1tEvU75BpXLTcDmzD+npOp+MZLGc2qdAk3V7
FEmyCQH8pyRfgxGJtSKjXrgaxmSrjxLEykn0luglH8ooONwR6nY=
=Y1pM
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
