Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F7FC433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592192072E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrUpjGKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgGOHWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbgGOHWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:22:46 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168C0C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 00:22:46 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o18so1085869eje.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 00:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e0z3WAln9/b8KJCeTvRzLMhQz+ybMeJAtGV4eeqp8+E=;
        b=HrUpjGKdTFo2vqkZLD2VO+BOxJ91VmGSZPLglU4+lha2IlEGKjCIIlE9bS06oXoPUi
         0nJbChuWBY8Ez/KMC/yiogy0uNjxr/rIXGhYzd+qduNqWzh3mV0cyu8pancaaP+sM1O1
         oUr3oCNgZL923aJML0+PfOBTPri4KtSUTY/P6LdgOZSH0sXgpvIWRQ2viGQwDQE+wQjZ
         IldsezdBsV2nMXI61zDJsarmFPg8Dom2vmO3pe0608dtAv0vWLHD8Ir5/SNgrojhqM58
         XBD6rNjSTYurAC8qj7HT5hSHUx6/6RTPLaSFqt9ofbvBYDkAhUni27KbhkNgA+baSFKc
         JQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e0z3WAln9/b8KJCeTvRzLMhQz+ybMeJAtGV4eeqp8+E=;
        b=fph39jDeAaDw+Pjxt7XDICX99N7UGk1i9lRu6jT8HSd42dnqRyEx/TDOO9xc/VKunq
         +LYIkDhAYnTNHiRQYZ7BJPXhNU9a1kV3rEEp+1T7FdH6UFgelsHtVXHLQosTbTfj794Z
         p+eki8UlOdmmVmzHXCR1JM719ynOMW8iTuecWEb2vtD63wClwqphpwFlKJtye3xtLuPN
         eUdbxbp6t7cGvhRQ3FO3Sj9NHjG4kdrzaCw6qJw3tmfxuWADr2WWIF+S1Un4a079cGHV
         QKS3KIs0resuumtMKNc3tuKcgrX0DHNQvSiDSkgpKP3iUrp75iC6p7b06Fr5GxOZ/QB9
         YHxg==
X-Gm-Message-State: AOAM530AUiXkDzcRgHJabERHUfcpKbBhfgpElj3GdgbBdJ3VY0CZpR0j
        EARAd1wbr4gRFdPAq1WPEyk=
X-Google-Smtp-Source: ABdhPJzqms5EVR7knQvKdSpFV2PDjrD3Ji5oiolEJuUqvMkBIcXFszIHetMOPmg/vrcZ4RV5qRH/yg==
X-Received: by 2002:a17:906:280c:: with SMTP id r12mr5190357ejc.105.1594797764816;
        Wed, 15 Jul 2020 00:22:44 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id cq7sm1274244edb.66.2020.07.15.00.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 00:22:43 -0700 (PDT)
Date:   Wed, 15 Jul 2020 09:22:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch.pl: Allow '+' in compatible strings
Message-ID: <20200715072242.GA321038@ulmo>
References: <20200714094141.147418-1-thierry.reding@gmail.com>
 <CAL_Jsq+c5+QFpdiNK4K=ROPAhxp=SMYS6iRFuJKooin=NbCiXw@mail.gmail.com>
 <8d7ebe02cfbff19f31f6ac1ce098f98d8ba1850a.camel@perches.com>
 <CAL_Jsq+HUUXRVoLN1OH3YXNYG=z4jyBJu_Z9qMb6L3K6vwXZiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+HUUXRVoLN1OH3YXNYG=z4jyBJu_Z9qMb6L3K6vwXZiA@mail.gmail.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2020 at 11:42:15AM -0600, Rob Herring wrote:
> On Tue, Jul 14, 2020 at 11:12 AM Joe Perches <joe@perches.com> wrote:
> >
> > On Tue, 2020-07-14 at 10:21 -0600, Rob Herring wrote:
> > > On Tue, Jul 14, 2020 at 3:41 AM Thierry Reding <thierry.reding@gmail.=
com> wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >
> > > > The current checks will interpret a '+' character as special because
> > > > they use regular expression matching. Escape the '+' character if it
> > > > appears in a compatible string.
> > >
> > > Ugg, looks like c6x really liked using '+'. Might need to be added in
> > > schema checks, too. Not sure offhand.
> >
> > These are the non alphanumeric characters used in .dts and .dtsi files
> > with 'compatible=3D' strings
> >
> > - 44115
> > , 32035
> > . 1131
> > _ 259
> > + 46
> > / 18
> > ) 5
> > ( 5
> >
> > So it looks like
> >
> >         "("
> >         ")"
> >
> > need to be added and escaped too
> >
> > ?
>=20
> No, those are 'regulator-compatible' AFAICT which is something else
> and deprecated.

Looks like we do need to escape the '.' character as well, although it
should be mostly harmless if we don't since '.' in the regex would also
match a literal '.' in the compatible string.

Thierry

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8Orr8ACgkQ3SOs138+
s6GTIQ/8D7AQ4ufdVorOZaawWFBkZehfkNBtNxxl8hk/80pZILMLHcqPLhlx2cfa
erlVP2/W4vdfd3DpJZ9NBnTu+1PpKMkYrhhF257v1crv/6Y1qro+TXzfOFDNqS7m
US0ed6NUZM1Jeo0DR/n0oj5+uvaVCSLNth1llL7dzGab+SNaJKYYisj/NbPNw/9W
7SgfEOg0uwY/3A2gvfFRteymaRdGs/iPpd0fXYlr+SEnw5akjwL4IS8/WLmRGfpC
9GcnUJCBhtSyy1jmZqc0wg46K1SDqHGh5sb8vKeaYGpUScZJGiXd4EdLDB3qFhjA
WOLSdDPV/nmmhC7TJ5dQ3iV2oxfQ/HBUnFZ82+lxD+2zQfDNUGsx3VI3nHtF9/e+
jhe1oJxYtsIs8p3mddFvAK44s2logaIfD3dQF0RlgX2q7PreqdhTxXTvT1Pgh0IN
mqCr6ZoeHVdZHaQF+6ntoXna1Mb/D9eDw6mPnJq9xP0qKOG4gJB136EorP/g58xy
kTRHArzFqVTw0cQvu15g/rgapwUjcmktUMcxWHueDImXX3utSUG02pu0eC8Nd9fJ
fpqTPoj96ycxbdA1EB0hfiXxdWPgRpt30KNvFfhOI+nQuT4VlP4Fk1GQi9jNzH4S
sOQqYQdEadtjheWZIKWMYG+tCmGV9K1ATAhyVN2AhAOEYbIImYQ=
=Irhq
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
