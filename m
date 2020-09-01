Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B17C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F2162087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bidouilliste.com header.i=@bidouilliste.com header.b="YrKuyRgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgIAGtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:49:33 -0400
Received: from mx.blih.net ([212.83.155.74]:46689 "EHLO mx.blih.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgIAGtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 02:49:32 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Sep 2020 02:49:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bidouilliste.com;
        s=mx; t=1598942569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nZvkdgfEsx8IUABfhx71Dpoxee70fmEUTqE8AA7jJGE=;
        b=YrKuyRgS7QNfdF7qc4hPTROgfFajA7Fk9Ph+iwvL4aPMHfAkWgKP6nOnmArJ1pn+u1TWq2
        Cd91ByVr7E2rDIilyqYa/3Zyd/93ANKbFJxeHCP+m8YDm64qxE65dqaI+MukDy6JM7NyRu
        rCmQsqbvJSUHjiMTKOj+S6geJCxe3A0=
Received: from amy.home (lfbn-idf2-1-1138-237.w90-92.abo.wanadoo.fr [90.92.20.237])
        by mx.blih.net (OpenSMTPD) with ESMTPSA id 8cb32919 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Sep 2020 06:42:49 +0000 (UTC)
Date:   Tue, 1 Sep 2020 08:42:49 +0200
From:   Emmanuel Vadot <manu@bidouilliste.com>
To:     =?ISO-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Chanho Min <chanho.min@lge.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/6] dt-bindings: Convert SP804 to Json-schema (and
 fix users)
Message-Id: <20200901084249.b72bb69d617cc32733432da1@bidouilliste.com>
In-Reply-To: <28acf821-fa6f-7259-ec1b-4810ca1ff48f@arm.com>
References: <20200828142018.43298-1-andre.przywara@arm.com>
        <CACRpkdZUrPeUbpNeCZcw8kq5k3egijAuh7R1_3TkbPz5wN+=Lw@mail.gmail.com>
        <28acf821-fa6f-7259-ec1b-4810ca1ff48f@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd13.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 16:44:28 +0100
Andr=E9 Przywara <andre.przywara@arm.com> wrote:

> On 28/08/2020 15:54, Linus Walleij wrote:
>=20
> Hi,
>=20
> > On Fri, Aug 28, 2020 at 4:20 PM Andre Przywara <andre.przywara@arm.com>=
 wrote:
> >=20
> >> This is the second attempt at converting the SP804 timer binding to ya=
ml.
> >> Compared to v1, I forbid additional properties, and included the prime=
cell
> >> binding. Also the clock-names property is now listed, although without
> >> further requirements on the names. Changelog below.
> >=20
> > The series:
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >=20
> >> I couldn't test any of those DT files on actual machines, but tried
> >> to make the changes in a way that would be transparent to at least the
> >> Linux driver. The only other SP804 DT user I could find is FreeBSD,
> >> but they seem to use a different binding (no clocks, but a
> >> clock-frequency property).
> >=20
> > That's annoying. I suppose FreeBSD just made that up and doesn't
> > even have a binding document for it?
>=20
> I couldn't find bindings at all in their git tree.

 That's because I don't merge the bindings in the main branch.

> I don't think they
> treat this very formally, it seems to be more use-case driven.
> Their SP804 driver does not know how to handle clock properties, so most
> of the DTs (in sys/gnu/dts, so apparently copied from Linux) would not
> work really well, because the driver assumes a hardcoded frequency of
> 1MHz by default.

 In addition to sys/gnu/dts we also have sys/dts/ which are our own DTs
before we used the Linux ones (a long time ago but some platform
weren't converted, they will just die sometime in the futur if nobody
takes care of them I guess).

> There is only one DT (Annapurna Alpine with Cortex-A15) that provides
> this clock-frequency property. The Linux DT does not mention the SP804
> in there at all, interestingly.

 I'm not familiar with this platform at all, it was done under
contract by Semihalf and I'm sure that if something fails and their
client starts to complain they will fix it.

> > In an ideal world I suppose we should go and fix FreeBSD but I have
> > no idea how easy or hard that is.
>=20
> It seems to be messy, at least in this case, and I guess unifying DTs
> means some work on drivers as well.

 I wouldn't worry about us on this case, this binding requirements
seems to have be done a long time ago before we had any clock framework
and if our drivers needs to be updated we will do it when we imports
DTS from whatever Linux version this will be merged in.

> But AFAIK most of the more modern platforms copy the DTs (and thus
> implicitly the bindings) from Linux, so there is probably much less
> deviation for many more relevant boards.

 Yes, I (and others) insist on using the DTs from Linux and not doing
any patches to it without sending them to the Linux ML.

> Cheers,
> Andre

 Cheers,

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


--=20
Emmanuel Vadot <manu@bidouilliste.com>
