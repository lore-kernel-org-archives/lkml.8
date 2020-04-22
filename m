Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729EBC55181
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 06:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F4812070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 06:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587535382;
	bh=RyobVlYLDlwPdEUHFbysd50nKsdxrBAn3YN9DXUsA+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=aP71HEzLeUgYkqS0+PmixXN0LQ5H97mQ5bY58m0NuRs4yTUQCFmlBODySv6WHOrHI
	 MylEeBGIIBI/HJJiXOnsX31Z8bSP2ZyicHEGCEGGKfXec7Fin0jgzPPB6n7uZbV1EO
	 3N7/pWfBgZX03GlYEEI7LDeAhDEvMSDLSGyvVDfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgDVGDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 02:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgDVGDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 02:03:01 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DC2C03C1A6;
        Tue, 21 Apr 2020 23:03:00 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u15so974227ljd.3;
        Tue, 21 Apr 2020 23:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:acked-by
         :signed-off-by:date:message-id:mime-version;
        bh=RyobVlYLDlwPdEUHFbysd50nKsdxrBAn3YN9DXUsA+c=;
        b=CuEqA7g+zZ54dw9bCjayhgv9A2u9MTQNCyt6TyWzFiFMsGJTNLVLxPxjfv8uHI7dQo
         MC32G8uIM4f5rC1H5sgtFomew636iL82jvLXqaEF1Mn6oSVKztw1QsOEAPPrMKZ9jFGT
         1wGb16v8CYMvHlnWKfl+sXm5JvhTxP2qfzeYdNUQJdTXsb7uZjoEeL+wg32naJhmfrrk
         +yhgeue6gQFbxbcm2X8FYAXR+xbgTRsFnEhq2dapuvkCuUTAjd1qoAUrX8cKrVQhino/
         WB/nHYjmLrpXDhTnnBxrfxXVrB5pdKhJa7AT6hMVN3vafe8XnX2hut2D90jo0gUWJRjd
         H30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :acked-by:signed-off-by:date:message-id:mime-version;
        bh=RyobVlYLDlwPdEUHFbysd50nKsdxrBAn3YN9DXUsA+c=;
        b=o8GXDqzKhb/YS+LQ8MbzZbE5CYg6gWOG+4tv2Gd1OzSNyJ++P2VsVA7gbRZcOljhcz
         Lo9k3tZTT29fjw/5MJRjvSZ6MujfNT6B7vYszxJqfnI9CNyQOwqrFS9VN9hxLuYLbK1N
         HgbQ0zYQkSWBONUrwlfS0LTT1EDGMNF21zXTZDIb38wydooxTfj9oQFzQPvJhuYwfNtZ
         K85MtI2RE867RfBfuaE5GoJ3+cZGcPTyXAZpMZCnEh0JFjTshqCTU/XOd8nxrxZmGnHT
         LPjSgL1tWUycgAzSAzZulPBWtWC4NKjI6kgKNTgh2mIrtUZdLXL02J4aleNIHbwzfdFP
         awOg==
X-Gm-Message-State: AGi0PuZkhS15Re4MNWFIK0jwgOJr/DVEZbAoQpzf3Av4WKAdrL6dos5o
        Vlv8dNyH1Xsz/k50ySWI8f0R5Bb7
X-Google-Smtp-Source: APiQypIjRjgsVPUBcXDJnEvR6tt9J8AMqa4ttQtiCcbriCsZnqyDtDIspQZuvw1zQ4lSotKOpPbzYA==
X-Received: by 2002:a05:651c:385:: with SMTP id e5mr15448868ljp.208.1587535378749;
        Tue, 21 Apr 2020 23:02:58 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id k11sm3811034lfe.44.2020.04.21.23.02.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Apr 2020 23:02:58 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 08/29] docs: filesystems: convert configfs.txt to ReST
In-Reply-To: <278a9befc98b49ea866c9b687d070c70cde20628.1587487612.git.mchehab+huawei@kernel.org>
References: <cover.1587487612.git.mchehab+huawei@kernel.org> <278a9befc98b49ea866c9b687d070c70cde20628.1587487612.git.mchehab+huawei@kernel.org>
Acked-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Date:   Wed, 22 Apr 2020 09:02:53 +0300
Message-ID: <878siocb1u.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> - Add a SPDX header;
> - Adjust document and section titles;
> - Use copyright symbol;
> - Some whitespace fixes and new line breaks;
> - Mark literal blocks as such;
> - Add it to filesystems/index.rst.
>
> Also, as this file is alone on its own dir, and it doesn't
> seem too likely that other documents will follow it, let's
> move it to the filesystems/ root documentation dir.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-By: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6f3g0ACgkQzL64meEa
mQba5A//XsmnQn1aCllE6lC0hRPpOiiZ3kYrkvIcFHatDymDaMfr9EcQ70+t3Ams
a7EWUKsvLYdVuTku2d5lzBP604QHRfiWDJaHnVI4op6TGXFRVMP1WdLosAOT/W+Y
xoiEGvbdCPP6gBmni2ov1KANJ190i8xjN8uFJshYp+PVsZAQczUg4M6hX7dq06Rq
raYGesTSqco821bNK2lxn2Jl2jJ11ExVbuXg4KXGSgwIRFjC6zIleLh531KExYeI
fOYGnB0vogidsLJPrl4Z67EXY/n60aIX3R8QI/uV/tnqs7feiddEQ761VYzk2r3w
M4MxxJ2JTnITSdWKW10DevQv/uu8ET/6MLjf8S8NKiwRl9i+cg4zW3TSfLUd8TZ7
AW9wG1ZZPjVdPSoqFr41unFVZs/35VAAduGuGU1vHoN+FL7nO7Ds+04hT7By/r7I
joiHLfQTnchumHMaWeCWvM4XUHJgWdbukoguaIKMuvimo7+QD8psnAKgJujIv/zj
WGt+xkJyQmiv2OHIvpXj3B5G+dF3jvE3qTRJk/Kn/1NBGMnPAYYyBGWawIpusoNB
CYkKdCUnS4TrEnRODyXP9eJOayq2DFnpqr4TId/B7oaEUVFNIMLSKxnZqAUnJPRM
/oL6oHjGj9x1Gkqy/9onKjO+sBbY0yiRy4AL4YkR2IlkYb3qC8k=
=sHvv
-----END PGP SIGNATURE-----
--=-=-=--
