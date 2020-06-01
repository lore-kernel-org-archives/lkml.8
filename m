Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7F9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 00:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545BE206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 00:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMtde9ZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgFAAZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 20:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbgFAAZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 20:25:26 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CADC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 17:25:26 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w1so7601084qkw.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 17:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kz5ZwOEUDJkALcMr7ODolUJ33dao0Jqn48aQY1x+fvo=;
        b=JMtde9ZVi4Xh+zrV7qA5+DDbcshUfkjeaSlLaG92QV5ZAvJ8Imr4JILwl+CrsOWBh5
         E8ma1CTQiCghwl/SMoUwdhLqAXPDlHwrnYfJLYSVyn90iZp9IzM5xRcTTIuVGHrKDLAo
         W8nYA/KDkkR//e3DgGfYye+4Ikkq82u3676C5sX1e8iBKpN3mYfbrwN1TU2Nos/DVoLU
         APijplTJSSzdEIgqvXKcaHvcs/LGP4OUXfB0W0hyarrKWsMyPunFty+7Q2YbfU+4dG2H
         kpQZZUZDXkr0rmDKMhhoFu8lfCR/eL1CXt+VXqjepkCjBN0j82X2U71AVyMwxAZ5zs9K
         USBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kz5ZwOEUDJkALcMr7ODolUJ33dao0Jqn48aQY1x+fvo=;
        b=AFJcjw4x7wciS232C0fmgCC+52W2v9bO01SKvQBRcY3DuekxJtDZHGJBynn9oUvXKj
         EDtDcVYll1wIQElFYnIKvUaDOmYY2bHZOyFybw4ehIQvHLrGbiJ1nVILCuaIZfpUMIFo
         mHX/CCBMgb1xAlngCv2hs/c2TtudTR50eY+WWUECteO/wB9lph406appGXlmNB1mQ/9L
         BXX/ub9FBXxbUR/aCTeGnX4OKm/3kr0rW02vNehbUDRTfgqzYZGav2d4lmX6X/rY8+8d
         RrW8R+xtekrbJwWuRMktfv5Ua+ModUPOAOsGM9KtGbxdzctH/7ghmE1JZKKRkv5oIvgN
         cCwA==
X-Gm-Message-State: AOAM533NaYUKgm/gy7Dg8Pk9FqS3yZYpt/57w5p0jlBtBWU4T2iiSZSp
        7XE7czrHC3vWmLRs0c6hR43+d0OY
X-Google-Smtp-Source: ABdhPJzjP660vRht6J3z9ESxCOhezGV36ibMpKltTC8hYcfK3U1Q3zPuyXcyIMeJVLzWB+Y6WfkMkA==
X-Received: by 2002:a37:ef08:: with SMTP id j8mr17850209qkk.442.1590971125701;
        Sun, 31 May 2020 17:25:25 -0700 (PDT)
Received: from smtp.gmail.com (CPE9050ca2539f3-CM9050ca2539f0.cpe.net.cable.rogers.com. [99.241.37.211])
        by smtp.gmail.com with ESMTPSA id p16sm11089868qkg.63.2020.05.31.17.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 17:25:24 -0700 (PDT)
Date:   Sun, 31 May 2020 20:25:20 -0400
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Sidong Yang <realwakka@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/vkms: Optimize compute_crc(), blend()
Message-ID: <20200601002520.hajvtpefi7yzvmuq@smtp.gmail.com>
References: <20200531131237.24781-1-realwakka@gmail.com>
 <CACvgo50SzjUe6usELF33qXW3BWZmH5U4ynPTBorZLDrG-Nx2Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uqybjdb5ptkemz4z"
Content-Disposition: inline
In-Reply-To: <CACvgo50SzjUe6usELF33qXW3BWZmH5U4ynPTBorZLDrG-Nx2Pw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uqybjdb5ptkemz4z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

First of all, thanks a lot for all your patch. And thanks Emil for your
feedback.

I have a suggestion here:

Emil:
Could you give me your Acked-by or maybe Reviewed-by for the writeback
series? With that, I can finally apply the series.

Sidong:
Secondly, after applying the writeback series, I would suggest you to
understand Emil's comments (he already provides the link) and prepare a
new patch based on that. Before you submit your patch, I recommend you
to test it with https://patchwork.freedesktop.org/series/68352/ and
kms_flip.

How about that?

Best Regards

On 05/31, Emil Velikov wrote:
> On Sun, 31 May 2020 at 14:12, Sidong Yang <realwakka@gmail.com> wrote:
> >
> > Optimize looping pixels in compute_crc() and blend(). Calculate
> > src_offset in start of looping horizontally and increase it.
> > It's better than calculating in every pixels.
> >
> When you say "optimize" have you observed any actual benefits of the
> patch - be that smaller binary, faster execution time, etc?
> If there are - mentioned them in the commit message. Otherwise, it
> doesn't optimise anything.
>=20
> A while back, I've suggested something similar [1] mostly for cosmetic
> purposes - doubt there's much benefits beyond that.
>=20
> HTH
> -Emil
> [1] https://patchwork.freedesktop.org/patch/365177/#comment_674314

--=20
Rodrigo Siqueira
https://siqueira.tech

--uqybjdb5ptkemz4z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl7USuoACgkQWJzP/com
vP9qrRAAnB7QXjC0la92oJUZ8yyl0o/C442cO+1HhwiRqrbRGs5Vs87vtzgZ0mDG
He5++yIGDNbnPp7eGQSa+9MVb3+/jmfzg7p+WVGLbxSZpQcO4ubR1cbaNVUctt8v
HboNRzPGulJgkky3srDRnGuVAc+2Vtq6SvlwqlK/SyB9eQIBT7EpL7Vw8RFL89zW
g9IwhXur7wQGkaqvPLgIqJgguGhVvHE++m9LcgMF8+oYWX9VlTkpfieO2YT9t+TO
YUqO2Qu/N6xPmcUXYEePXPrkktj+Sv/BREO8PyFIH4WY4o21ztWQ2LAuVb6elpbC
dL0F9JZILPZ96ScsjFErf/NqLXSThKw+S5JkKGYRVnelmf8f5QoC060CHQyDF55x
Uh5ULTbGSE4HmAotJUfOhKsxvBzalQnMrUdaxmNPwIaXd0eLQ1pqpwHPxcy+ndHz
/6LXNTAZiCSDSMBvZ9k8+zJ2blqmpbjo3cqXozC/4pqaZ3zCnDcUtqlpDZlzs34w
U8Nlv1/cdYg5ucWXHATqMoafj1J2PhYe4Z9lLXtdmAH2eDbiapn1ahdr58ATs7A1
BAuzzPMUQdqM2azwjzEh/qD06mVKEk8POtySyRjmKrOdBj8cX11AMpL+3obEQWJA
TDR1PX1KRXexuLe8dgwx4iwV6e0yL+J+NMxFn22d4xxvA28cpm4=
=cya/
-----END PGP SIGNATURE-----

--uqybjdb5ptkemz4z--
