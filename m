Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E06C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA28620663
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ue53poOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgCYNtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:49:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36634 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgCYNtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:49:35 -0400
Received: by mail-lj1-f194.google.com with SMTP id g12so2536068ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=YDd4psw77+TjgR3LErHqB45pC2hCTAbwI5y4bLpGMCk=;
        b=ue53poOk145/0Go2c3Fb090mulEi4KObzB4Gg55MF1CvN6x6lHk2Qf8lPZ5p5R3+G2
         VP63zmjrCzKb82gf8jqzE7LJCcY3foHxfMdEijJbHSCvcWJLb0An2KtlnlYKqoF8gBtu
         ZM2ZexiOVhdnZg2Q8ll4+pRAHMR+Ez1aKDwmBNYhe6Nvsy5yNRJPt/igDUFQngqQ230s
         7FxB2+dbcgoOMjaWWt/4YXpHnhCdt+5z1W+vDSn3fbKYHcojeMuflvme0hVgs/EFyIqc
         gbWuWSFjkBuKobaUJ4xQCX8QcyxxNW29g1kVgr4YR3BYFqnKx39KEE+s3zCzKixeZeWO
         yEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=YDd4psw77+TjgR3LErHqB45pC2hCTAbwI5y4bLpGMCk=;
        b=mmCd2Td/NrQPno+9N/TWlECIW5tG3+kDSbLNrpHBQqUJ7yHzlYGxfXTHqUOv5FAh6t
         FEMS9wha6hxrl/kl2yweb26UEdSCDodG1GoiNXOD0bEFMUzTV9mf+SNwv92itMM5Pmk4
         iSV4hw4OXbxG7KjOl4I+N93c2h2Wv/+TY005Kqw9rBHLxbzq53+KPQQeJj+TKLK0Vk7X
         CSLNfbgrCs1+CQDaKWEy4ffuN/7ZuikXApAeCGvAvnJU4IvL8wSk90xKwiXx2b8P4MeS
         DzTzQ5iV6mcRYW1dMyjpbZmuqgPARPjsJlOsLoS9Y3W6BNzBoR1xOXMQFi1xIoJDenoJ
         jnxg==
X-Gm-Message-State: AGi0PuYUKoKL334aaS4SKBG8C/Ys4gzC6zUqoMUyanIBdOoeuykVq/pp
        JqA4vrnWFf5dItVWxqqBInc=
X-Google-Smtp-Source: APiQypIVWnohCBw6Laxl+KFUeZrUWln3GLJRYstirHtutpXWykkoScXzvviRjE1iqzvOz4cwkSo1ww==
X-Received: by 2002:a2e:a362:: with SMTP id i2mr2084950ljn.52.1585144172471;
        Wed, 25 Mar 2020 06:49:32 -0700 (PDT)
Received: from eldfell.localdomain ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id f2sm6420123ljn.101.2020.03.25.06.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 06:49:31 -0700 (PDT)
Date:   Wed, 25 Mar 2020 15:49:21 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Simon Ser <contact@emersion.fr>,
        "mjourdan@baylibre.com" <mjourdan@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 7/8] drm/fourcc: amlogic: Add modifier definitions
 for the Scatter layout
Message-ID: <20200325154921.2a87930c@eldfell.localdomain>
In-Reply-To: <b1386ef5-c3e3-c07b-5982-e3f02441b431@baylibre.com>
References: <20200325085025.30631-1-narmstrong@baylibre.com>
        <20200325085025.30631-8-narmstrong@baylibre.com>
        <JgBZ7eZYMgXRNu_-E4ItS1bud9mEe15xptZEX_XhsM_h8_iIZTOmPokEVxPJYwX0wP0pmb5p-ymubyyZP3kVbcfuDNdmM0__L8wBR5IykfE=@emersion.fr>
        <b1386ef5-c3e3-c07b-5982-e3f02441b431@baylibre.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/e3_VDQSNvzbMkOgJtm//89P"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e3_VDQSNvzbMkOgJtm//89P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Mar 2020 11:24:15 +0100
Neil Armstrong <narmstrong@baylibre.com> wrote:

> Hi,
>=20
> On 25/03/2020 10:04, Simon Ser wrote:
> > On Wednesday, March 25, 2020 9:50 AM, Neil Armstrong <narmstrong@baylib=
re.com> wrote:
> >  =20
> >> Amlogic uses a proprietary lossless image compression protocol and for=
mat
> >> for their hardware video codec accelerators, either video decoders or
> >> video input encoders.
> >>
> >> This introduces the Scatter Memory layout, means the header contains I=
OMMU
> >> references to the compressed frames content to optimize memory access
> >> and layout.
> >>
> >> In this mode, only the header memory address is needed, thus the conte=
nt
> >> memory organization is tied to the current producer execution and cann=
ot
> >> be saved/dumped neither transferrable between Amlogic SoCs supporting =
this
> >> modifier. =20
> >=20
> > I don't think this is suitable for modifiers. User-space relies on
> > being able to copy a buffer from one machine to another over the
> > network. It would be pretty annoying for user-space to have a blacklist
> > of modifiers that don't work this way.
> >=20
> > Example of such user-space:
> > https://gitlab.freedesktop.org/mstoeckl/waypipe/
> >  =20
>=20
> I really understand your point, but this is one of the use-cases we need =
solve.
> This is why I split the fourcc patch and added an explicit comment.
>=20
> Please point me a way to display such buffer, the HW exists, works like t=
hat and
> it's a fact and can't change.
>=20
> It will be the same for secure zero-copy buffers we can't map from usersp=
ace, but
> only the HW decoder can read/write and HW display can read.

The comparison to secure buffers is a good one.

Are buffers with the DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_SCATTER modifier
meaningfully mmappable to CPU always / sometimes / never /
varies-and-cannot-know?

Maybe this type should be handled similar to secure buffers, with the
exception that they are not actually secured but only mostly
inaccessible. Then again, I haven't looked at any of the secure buffer
proposals.


Thanks,
pq

--Sig_/e3_VDQSNvzbMkOgJtm//89P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAl57YWEACgkQI1/ltBGq
qqdFJQ//cD3K85nsCGKhXDmSyQzaQzhmiNbd/rn5U392CpaELlvtHKVFtGggN5zp
l5MIb/EjYgZUHG220KklqCiZAzk+RLTmZnQPZmXPAnKobeeJLIGwHhKFBTozKG8t
9NLG8Gp1brFA7xVz63SSmZTUWFw4LP+HnMRIPPEGEpx6J4J3MJ8ikC+Utcvcs8yZ
1Be4E8s6cLRxcJPt4Q8PwhTNXtwdPxBL8aGhYB93Ptu30fGACCmUKCCtNyEo7PN+
qK2+eyZh3kB6Ktujsi+QqWgxtzIWtRH67ezkp3TlrqfFDQ8kH5guzfFfjb6coXW9
evJLwTgHoU/WZaOve3WVajKqfJdCbzzKFqBjaIeeA8RTWyWwHeBDpFA/G859H1OQ
zd03sTrUz+uOl/k9ZpyG7dvReAijUA450FQe+c59lDWwWV94tRwbrFbjI3yh7R5q
pl1bpuCFj5BVA74GEc8VzSNuqmqnqDltkiVAJ2BDi2heB5+2Pt+xZQlXz4rY4Ynl
y9VLeSXlDxS7eJwsYjN9i3ra182eddULpxbdbdxPF7OVhpG2Wdhr7BFzdiNakBCM
V7P7YUwFTOoNhiotZEKVpAnCQ7tIQgDxWRD/va+m6EmMhnjh0jDzb7nKz2a9y1FN
UTiMucJoHEe0bxz94KaioKsNKAZQf7cNK1aUPkPF5qH+ORGgdVc=
=oJGl
-----END PGP SIGNATURE-----

--Sig_/e3_VDQSNvzbMkOgJtm//89P--
