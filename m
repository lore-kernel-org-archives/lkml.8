Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0C3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6179A224B0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6GpWyDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgGNNMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgGNNMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:12:44 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B037CC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:12:43 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id b15so17050436edy.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=viQtz8QsLsT9ah5/ms0xuhd7skme7zVZF+wsTnfPPnw=;
        b=G6GpWyDBJyFPZDTdR4U6SKf781zmijoV8LskQQD1PafanxCLMpkbBjH7OJ6E0WNLNL
         YLaU5NJfe4mRam8x+IKbkhL4i1u6s+nK894Q/nPpzKqvxtu6fHaNkNNS8LVKqHFV4Mqc
         gvD0NXj+VByxVKku9mPRah8Jpy006+Nv7wOF6fHt8m/D+O6QEBFC9z8eoszQvUrrFW7R
         NCHLvOwkOk6ekJwsB413Tq7aX1tawhwfj17h3W6qUmTGVd62a85gfO/wxuEpa5IpYnKw
         brlTL107sp5Ol2vTMcEXh5m8UQsyKHfmD4kt4UDgVUpyGlYEzh0KyEp8j+7RUOFpAfa1
         /atQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=viQtz8QsLsT9ah5/ms0xuhd7skme7zVZF+wsTnfPPnw=;
        b=J3+2jbfMW/mm7L47y6bFG9oGEAABuV2g9iSJyCtqJ6mx46M+Et1vhiKtIpO0YoYIhs
         D6+KWmm55l7VC1il6d7a1KsgWWAbyLazzAgxMLsbWEGSVAhpqlIdilZJXFAIrnZidoke
         pVxmAJPySwdcQD76xBw6jg2kx2+mhgr5ltTdV9ie8PUVsyEoG9Nxx22OMO+DT9Lr4hwn
         /yTozqPQ1Cm7uYjsl7jGCvkrzOm/jQM2lYCayjU/vgLmzyLNK4IFHfaZ/uJqRFnfIEUe
         GRBQITiXMLhRI0EE7yCDcAjPO6h2+jpFC+RrsIEoVLlFPgVqXWEqs+2PS0dKT/S3GLj6
         pvhA==
X-Gm-Message-State: AOAM531MGWLTx/OdwnZzQYLosLM8z0D83VJjxtRHRGzO/NsTxQbzUiE1
        XSHYwgDo0mmzLqvQ7siwl1I=
X-Google-Smtp-Source: ABdhPJxdba5lelv6zuTYUu8kztSW2dzIFW26yc/78uIoNRI7jBYKkTDuEZT2F4bvk8Czv6BvkbSAXA==
X-Received: by 2002:a05:6402:13d0:: with SMTP id a16mr4420774edx.269.1594732362444;
        Tue, 14 Jul 2020 06:12:42 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id b17sm12124031ejc.82.2020.07.14.06.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 06:12:41 -0700 (PDT)
Date:   Tue, 14 Jul 2020 15:12:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch.pl: Allow '+' in compatible strings
Message-ID: <20200714131239.GA162337@ulmo>
References: <20200714094141.147418-1-thierry.reding@gmail.com>
 <cd892c33922c477622ede83d80592e71098c4dc2.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <cd892c33922c477622ede83d80592e71098c4dc2.camel@perches.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2020 at 04:14:36AM -0700, Joe Perches wrote:
> On Tue, 2020-07-14 at 11:41 +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > The current checks will interpret a '+' character as special because
> > they use regular expression matching. Escape the '+' character if it
> > appears in a compatible string.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> Thanks
>=20
> > ---
> >  scripts/checkpatch.pl | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 4c820607540b..8104d0736e7f 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -3145,6 +3145,7 @@ sub process {
> >  			my $vp_file =3D $dt_path . "vendor-prefixes.yaml";
> > =20
> >  			foreach my $compat (@compats) {
> > +				$compat =3D~ s/\+/\\+/;
>=20
> This changes the @compats array for each line

I'm not overly familiar with the internals of Perl. I was assuming that
$compat would be a copy of each of the strings in @compats. From what
you're saying it sounds like it's more like a pointer to them instead.

Irrespective, does that do any harm, though? I suppose we could add an
extra local variable like we do for compat2 and compat3 and modify that
instead. That way the contents would perhaps remain unmodified.

Is that what you were suggesting?

Thierry

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8Nr0UACgkQ3SOs138+
s6FAsA/9GTh6tcM2IIBSctHuCvmXckubRzVGzlV+AqitZCSRGkpjSVyKMr9V/KoD
TSA4yynwNxxUfUOZycXW5oTNygkwo+cl9gkGDrRRXcfg0qg9ek+q5pfBZnNluPPg
BB0tMwp7dKbl8XYPJSk//XiImrnTzrVvMPO/wcq4PS/hYXWOzC0HlR2s44Asw1xP
Pxlk0n0XDCKvd1OzFQ93gziYvDtMFGt4YeYrTYEGapHeP71o6p9XZf/H9VE4EIRv
v6iOiJp06aXNLo/Wll4Oi8WV8k2s0blvpQoXgclmpasZ8deGw/qSZWsV8QIK7X6m
7nMUcIRk509O1AgBnJ2tCkpBOC78pixbAJWYAxb3khDWSGVhEQiX1R8V1qGZW6kJ
rMM0M5t1KIib7xyz8hDC+cSOVb7HNKk1Eb1t5vQHvjIZZSe9NvDq4idXiv4gpVce
nmcSRTvyLHn9NF8GU+ZYiO24okxKWocjMHlLTvLTpnjifs+SzlGcnWICsKupeMhz
Y4D66EBu0wAvs8mwILWesE5rXeImVKWMkcde/z3W4gB0IPaKep8wu497YC4qxqmr
NQGfcfJ8e1pHaNEhVN2Xzt/0M6EoR5d/KcvWnUL7X2Qzk5HnnisOafCxBuxkqTaJ
WxbLGoao0uiTQxxTIx6dkeZtuEqi4+6NeOXOLjhNS8XlUUMym5U=
=HDxT
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
