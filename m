Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5005AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F605221E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI7r9ukb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGNGki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgGNGkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:40:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A503C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 23:40:37 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id z5so7169763pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 23:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3NcepYXJwFF3WgKgaGPyijwPZJiB3MMeaKr78lJ+A4I=;
        b=EI7r9ukbfTkCsk1sAtJ/9Iyf9J6ci86JDSYqWkVPoKBRyy4ynw3xQVbliSjQq6PSIZ
         Z+nodyMo4csU0EJ5ev4qjCaSb+QU8h0rOAoIiyO7RgufqmGbArf95eoEb3hxXA/tTRBJ
         oJOBsFZ/A+DMgHoHe8PmRRBRE7i11Ne6/qyzojdxs0xRNJxlGMSZJIfpXVVc/8ErDwCM
         Asa1BSOSTrGjaBPgyvPyxPcafjAm+84W5rScQzc4LtCV6fLUe4hEW8nuvxRwWqlCddC2
         uebANy49HDIZL2JpZGuaS4dDKJwbl4oSYa3zXH94i9NDkb/mcdeSt1WbtB0S49e99v+4
         fVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3NcepYXJwFF3WgKgaGPyijwPZJiB3MMeaKr78lJ+A4I=;
        b=deQP5HygKjlIeld9jEx+FKGH8vnkuVXXfEvt1o1ouAVCQwWsFLFZc3pjOIDhu9xdyQ
         /oFY5saDFQgaY0I3LWeow+I5njme5htRJY8WG8dD6Hiq0eBWS0wzAjBq62vHqdq6SxHX
         2tZLqax9DBWta5AmJbJkBBn5D93iBIMKaAKiu57pydxK7hBaHkEyFxolRjufeixAzXqy
         LpKTc3zg8ASKsAQ8+dZ6LH6SzH/QRPJXQPt2H9YmTfHUPY1Dkj36y8rg9NTP89/5Si/G
         Qku2tAZlJM6UzB+QwEsiz3p46WgAycLpi+1w44FrMhHcrbEli9ehr1O/IUjn3uXlMp5C
         doXQ==
X-Gm-Message-State: AOAM531BQqYuoBgoOYanKrelAb9mbiBM+I3KSFMAZiKwVaWPH8BANjr2
        eM5PXbh5E/s8rrVM+yz/dLE=
X-Google-Smtp-Source: ABdhPJxM2m1GnRxucU0Lu/dwd6Np5WlUWjEua0RFKCYWsEy/diEB5ZqBER66PsnJLmPmOY/4C7rFqg==
X-Received: by 2002:a63:6c49:: with SMTP id h70mr2272535pgc.150.1594708836823;
        Mon, 13 Jul 2020 23:40:36 -0700 (PDT)
Received: from blackclown ([103.88.82.220])
        by smtp.gmail.com with ESMTPSA id d12sm624036pfh.196.2020.07.13.23.40.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jul 2020 23:40:35 -0700 (PDT)
Date:   Tue, 14 Jul 2020 12:10:22 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>, manishc@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4/6] staging: qlge: qlge_main: Simplify while statements.
Message-ID: <20200714064022.GA12651@blackclown>
References: <cover.1594642213.git.usuraj35@gmail.com>
 <1bb472c5595d832221fd142dddb68907feeeecbe.1594642213.git.usuraj35@gmail.com>
 <20200713141235.GT2549@kadam>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20200713141235.GT2549@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2020 at 05:12:35PM +0300, Dan Carpenter wrote:
> On Mon, Jul 13, 2020 at 05:50:14PM +0530, Suraj Upadhyay wrote:
> > Simplify while loops into more readable and simple for loops.
> >=20
>=20
> I don't think either is more clear that the other.  Walter Harms hates
> count down loops and he's not entirely wrong...
>=20
> regards,
> dan carpenter

Hi Dan,
	Thanks for your response.
Should I send a v2 of this patch or not ??
Also do you have any problems with the other two patches doing the same
thing in different files ??
I am all ears.

Thanks,

Suraj Upadhyay.


--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8NU0wACgkQ+gRsbIfe
746kFxAAtdVK+rUtDy2uROVKhtZQrW+MVwW43Z4Mi4n3pqVUkx5TwspN32mxphWg
B5AeptVoAP8AJdq7NdvcEXBoUNBhpD1g/u0hpXAJvpn835Ia0jFul8lIfBZp+3O3
SEQMOEI/Sn8QolbCwRiDLhoNWVbcZ9uwHUMZmtNKNq3n7ki6o5tIj7HnbMmLtOSV
4jD/Mk077tHDTmV3k1IXMm1PoJKP91HEkfGZFjLjGIN3TLik3x7ekzbWu0RWbzqO
2c3EMwwXhNIxuFTZis/aPFV6iuPFf3Gyn2+4eqr9m9ifvgw9SC7xCbhbF5aWk+bf
BYh6zgDVhHtQ2K7G/hawGujQZAoJsL04mZ7Uz25goRVLzJYMs7l5Qd+yR4/cfZlX
xsG5jPCIDcPLOQ3DlsFF/tyeR2MsVFvLaNNes0a1IIcZ+CGVlsoAFZGUskrdJIU3
bQZjumYRkhy8ML3wBocHT+sYuVV/RRdligxUROVbTWJwAFCnYDBUcTkCuk/tXk/C
hJdUBx3Xw3eyPI4PLnasPZeK4Eb6KwixKJennGDj/aRTrn/XCqXYq2OlYNx76V74
gNahmgCTf8wDoLlo0wQAuoMX1bs9dPgvvwTs3sfzmHpOshkvfZtiFJrdxITV9U7p
/ZtJiI573At8nmEuUarUsOjY0QAS0xtUejTke5whhjPUgyYemlw=
=YJV2
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
