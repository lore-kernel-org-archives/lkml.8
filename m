Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBBFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E14E420884
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN5WshoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgETIkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETIki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:40:38 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814E4C061A0E;
        Wed, 20 May 2020 01:40:38 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g9so2106449edr.8;
        Wed, 20 May 2020 01:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mb7QfRxby7AgnFGtGNkrt8n1Z+I09eWHoPbIYOvFSUE=;
        b=HN5WshoEENtUHC//XetSGUywgC89HQlw72WmFsFajL0zjP4iecy9anYCQDmaPm9hix
         KPOSOkCNCc/L0NW4e3jomLfGoetbPVX82wmYqhfZakf5R3eZS4RSh6M7B9yide9u2vif
         M2/wFct8hwORZ13KWjh/VOKY/BA8qMkKshiqJuETntg2YBxnxnb6kZxS3d50UPg+kRBh
         lRypteSzxfVmFELrbz0slgBzdOVEjsZAO6nKJ3eebyNbxmDaNxXk6qkGkB4f2vLUWDjw
         WhF7ATHumIOcOsWLZVaYmCpAu07w43byyjaC7cW20t/B/2VBMV37wNGI9n4pDCg1kKei
         yVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mb7QfRxby7AgnFGtGNkrt8n1Z+I09eWHoPbIYOvFSUE=;
        b=GJbdjZ/fL83HukxIOdP+6bqN8BnKk3pUXqxwNriZACr4VqKiJBYCRkALyEooq0NNei
         0dF2jshHuCVd0Cn+ezGRb3PoZtdCr6dO0mrYG55AYIHN5obh6pe62DsAG3aUZmO0+91w
         5rMo+YUAha2DjVm7riOTvM5/Z2huua9MJTxv1Aym+N44Hd/dL5ZPWEjhUNqPUoyJR49y
         pWBRJ0/xvhSPtxBUeyfXGsvyF/cIngdwHYuF7HsbqOmhuQ2eUvsHMro08p0rElt5wtcl
         kJAETrcDpTaZgM8rLl3T3e7WFw/iNH6kgZfEt74U0G+owMvhg05hePCck/GnGp5zySpA
         EvMw==
X-Gm-Message-State: AOAM530848JKShE8NwIFtscUn6/DLjOW4uRQYlTWVYs02EayiA/5AzJv
        nEZnaD4ceZ98XUYkOCTUB4A=
X-Google-Smtp-Source: ABdhPJzG8f0TXlz0Nk/rGokoWRdNIDyW+F+nvg3m8ouKjflMeFxwi9VxHDp+21mYUW9jqy10ZbmoTg==
X-Received: by 2002:a50:d0d7:: with SMTP id g23mr2455355edf.163.1589964037188;
        Wed, 20 May 2020 01:40:37 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id dh15sm1196510edb.35.2020.05.20.01.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 01:40:33 -0700 (PDT)
Date:   Wed, 20 May 2020 10:40:32 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     Stephen Warren <swarren@wwwdotorg.org>, robh+dt@kernel.org,
        robin.murphy@arm.com, devicetree@vger.kernel.org, talho@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        afaerber@suse.de, arnd@arndb.de, gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/4] dt-bindings: sram: add documentation for
 reserved-only flag
Message-ID: <20200520084032.GA2136208@ulmo>
References: <20200512144803.24344-1-ykaukab@suse.de>
 <20200512144803.24344-2-ykaukab@suse.de>
 <52f099e4-5c03-2141-f049-cd3adeb04c5b@wwwdotorg.org>
 <20200513104127.GA2309@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20200513104127.GA2309@suse.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2020 at 12:41:27PM +0200, Mian Yousaf Kaukab wrote:
> On Tue, May 12, 2020 at 01:45:28PM -0600, Stephen Warren wrote:
> > On 5/12/20 8:48 AM, Mian Yousaf Kaukab wrote:
> > > Add documentation for the new optional flag added for SRAM driver.
> >=20
> > > diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Docum=
entation/devicetree/bindings/sram/sram.yaml
> >=20
> > > +  reserved-only:
> > > +    description:
> > > +      The flag indicating, that only SRAM reserved regions have to b=
e remapped.
> > > +      remapping type is selected depending upon no-memory-wc as usua=
l.
> > > +    type: boolean
> >=20
> > This feels a bit like a SW flag rather than a HW description, so I'm not
> > sure it's appropriate to put it into DT.
>=20
> Reserved regions themselves are software descriptions, no? Then we have '=
pool'
> flag which is again a software flag and so on. This flag falls into same
> category and nothing out of ordinary.
> >=20
> > Are there any cases where the SW should map all of the SRAM, i.e. where
> > we wouldn't expect to set reserved-only? [...]
>=20
> Yes, here are a few examples:
> arch/arm/boot/dts/aspeed-g*.dtsi

Looking at the implementation of the sole user of this, which is in
drivers/fsi/fsi-master-ast-cf.c, it looks like this really should've
specified a partition because the driver basically goes on to allocate
a fixed 4 KiB region of memory anyway.

> arch/arm/boot/dts/at91*.dtsi

While these define SRAM nodes, I don't see them referenced anywhere.

> arch/arm/boot/dts/bcm7445.dtsi
> Then arch/arm/boot/dts/dra7.dtsi is an example where we should map everyt=
hing
> except the reserved region.

The driver currently maps everything, so if this relies on this
particular reserved region not being mapped then that's already broken
anyway.

> > [...] I'd expect reserved-only to be
> > the default, and perhaps only, mode of operation for the SRAM driver.
>=20
> It will break compatibility with existing dtbs.

Yes, that's a bit unfortunate. I think this driver may suffer from a
slightly ambiguous device tree binding and then people just trying to
fit it to their use-cases.

However, I think we could preserve DTB backwards-compatibility while at
the same time correcting course and establish some sort of consistency.

Looking at the examples that you've provided and others, there are two
classes of users: users that don't specify any partitions either use all
of the available SRAM exclusively or manually allocate some part of it,
whereas users that have specified partitions all seem to use only the
defined partitions.

Given that, I think what we could do is check if there are any child
nodes and if not, keep the existing behaviour of mapping the whole SRAM
area. For cases where child nodes exist we could decide to go with the
default that Stephen suggested and only map regions for which a child
node has been defined.

This should allow both categories of users to work the way that they
were probably expected to work.

Any thoughts?

Thierry

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7E7PsACgkQ3SOs138+
s6HYyxAAkPk+vwNmlH7ETZWk+tDpu9p1jU53hBHo7thEwHCr+xFIaNlJFGmXWpOO
62hcSRW2fLx8upTQ5D9z+/lB5q9G6Uu1vSWl3fLqDx7EkUBTo5V9llrbjUUmDNXJ
rkMC3yYYfSPeXcQhkh+INMS3njREgduS3mJff6MbG6P6KTYd/sM67J5QxAX1CD0u
rYH1mTanQW0CVRwY99yl1vIcYHL+PFNTDkQLt8zG2tvqTWYlHCbkNhHG2cQLFpoI
wAwxgmnsD3ebq3/5UEH/1ba0x9XaRwMtzj/hNnG1EhqlQlpywfbOofy/xTz4LCgv
Z1bBt6w2wvtAW665KtBUHPFVVqLdTmEiyAMyDfTcHeDUPuv6KjXTqZcFjTQ6cK/E
MT0vPgePDZZ1CGqWa4vb6vWpkEvkAiXz5Bj3tZLHVyuKKtzLSjaneURKx8xYe6IH
vrzQamDlLlooFHHM8vOLTKU0nA3vXgRN9bQZrrn4fZBMa+vUyM69xHuQ+/4l4VJg
Aa0U0edhlzaX3067VcWJhZc+1VZ4OSLpH/JKEQfl3dPPM04e+yXtYelwpqaUWPwh
tZ+vY6oS6MefZiXFvsskxbbHwhO71Sq7SCWdNrKE2qw5zFMx9LWskGFXGJehUIoT
l54CPDD33NfU2N3T0j0Y6Pr5kPjKnaZq8NJQxMYBr3oZJZ/ix7s=
=r/Os
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
