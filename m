Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16707C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E267A20772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2i4foXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgFDNyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgFDNyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:54:12 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93563C08C5C0;
        Thu,  4 Jun 2020 06:54:12 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id x93so4759346ede.9;
        Thu, 04 Jun 2020 06:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CfoH+dzxq6WF2tRiVmflAMFqoQOaRQWQsTk3x8AbDNM=;
        b=K2i4foXxpYkjDeRunVQUsQHbferp6YJjO3/34mwZQ5PQAJTVLHMqsd548LxynjTCXi
         GZa8qpOm/9oUQ6fJgJMHDbBXZqPpi8yRQL5UDM3w0m0Rh1V47q+6KgcWDzDolVybGEmM
         qwZ+7ggcNpGoa+JK2kmCC10SY0hqA468A35o8l47RUxDiO8BxxxoZxDVmYrzR1dyHVQ8
         LVajGPn78YZR8NlUcly/Ap+jh5xICRebZdrXSyI8ryIPHI1I1bS35uouuCRcYrsh2IgC
         opoCuNCdujxrLCdpjaFmvImH2iokR2GME1NM24xYVM0zzfzPf8TVx6IekYHmgDxcrDRh
         5+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CfoH+dzxq6WF2tRiVmflAMFqoQOaRQWQsTk3x8AbDNM=;
        b=b7UxqFl40DAeCqrXHJFDpqzNK+7F4fdP77bYBT5zgYDP63nfZUBU/inUrOQEw9GCYV
         bH7qW/K1SWtGt9l/l/PcXVYPNPQ35jy6H711juoQR/xdwvTXfnTPDYhXVF3+nbKn4pQP
         zTJNNiZkTQI2p/rxxYy+N4bltBwEfFlunLp063GurOhVrMRCPrY+Ka+bxfhEh1lqghDa
         1qjpb0VTdQe88XZV0cps6YmfGlEgFWKkVB0Js8UbQ+8jMtjzXyFbHyrsU8WbFyC8d/0A
         PRV4WeO658y0fL5w9fQwWUS+AMxRvw5s1W7Y/Xz78YkJPwOaSHlfZEEWbGWFboIlWP3z
         tVdQ==
X-Gm-Message-State: AOAM532f1qzAxlage+GHijTfT5QlTvCXgVFD9QmMkHkTeIJQJiiq3VQF
        3EF3zMeoRpoi5uPAsqlhaVIsGPZS
X-Google-Smtp-Source: ABdhPJwGAM5wYCsr8ydd5hwq5zkFZ0IBTFbhHPuqkMguJsBhL3lZeFTSwuJnex5HZJd/xl2WFoOfBA==
X-Received: by 2002:a05:6402:3078:: with SMTP id bs24mr4387995edb.284.1591278851298;
        Thu, 04 Jun 2020 06:54:11 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id q12sm2167511ejt.106.2020.06.04.06.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 06:54:10 -0700 (PDT)
Date:   Thu, 4 Jun 2020 15:54:09 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/8] usb: gadget: tegra-xudc: Add vbus_draw support
Message-ID: <20200604135409.GA1138399@ulmo>
References: <1589437363-16727-1-git-send-email-nkristam@nvidia.com>
 <1589437363-16727-3-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <1589437363-16727-3-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2020 at 11:52:37AM +0530, Nagarjuna Kristam wrote:
> Register vbus_draw to gadget ops and update corresponding vbus
> draw current to usb_phy.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V3:
>  - Propogated usb_phy->set_power error to vbus_draw caller.
> ---
> V2:
>  - Patch re-based.
> ---
>  drivers/usb/gadget/udc/tegra-xudc.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7Y/P0ACgkQ3SOs138+
s6FGuBAAh726xRnA8AgpFzFY6CK2cnfLe1wgMCL1lGWrqaJVAlJXxLvRFu27AwyJ
E24tlump5oS44vr63gxbJeCb6cxL46GS5w76IviVfMsQaCNFvzVKLa8xzZe8G01y
XCRzmMitVXO6oQEkTtI2cd6mzXYC9UHTcGQBSf1ZrA2HiiEWjphbV4i4A3xCLijJ
hxa4Ft3nnXUcDkJRpwPZgDBXWCkNA0jxtnImIIFJ72qQa3/Xphunoe8R+pH9C96+
GqeIZxULrEEwsa+EdjTpa2zgcICxEHf+9bPqGKdN4Swg2fm+oCXerJVjbJz+KyD3
qutHM6kSZEjCWH4TAgB29eUsjoQYBJZTkYDFHr89ZlD4zqYLYXvNpy2S+A56m4wC
Q/fRVE09PNweckEasggSi5t6Lt53ffsIH8PtTGITf3C4iKG/0BYbCUYDaU569rkO
gWs5RvNFHSXK9p38k593Eq9Xb4eyGnLc10D/Sa/IXb37BLB76TnzBqMqABMctXul
j5sFYkYzJZuD22eUmReer+wvt78u2gDaew6kx7Vz5Bceoe9Mz3lqjj9djNORzdY2
8nSGxGDuNxZOwRLd0iv3lg/8VqlVfz5iRZXVKNBqFOPk7QLgkp6M4+JebNMaolHy
TB41eCaCzhkjN+UBHrhHTxKJ8RHPcvuiJ2xEfzSYbmumZo/q2MU=
=Zn9i
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
