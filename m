Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04F5C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF85B20A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5YjvUPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgEHK0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgEHK0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:26:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A831BC05BD43;
        Fri,  8 May 2020 03:26:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s8so1243553wrt.9;
        Fri, 08 May 2020 03:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U/nGiKbFLFriNl4EVgpGj88MYeZZdcTLN4ma7CGTOns=;
        b=f5YjvUPChhk0lY3dMb5i7+8WWfjET6KiM41cHBRUu6xufVdFD+lXMAQ8LwyL+QfbD4
         W8rrmbc5708tczFvjA3+i0m70+26t13Dih7H2T0D/fedRyIbGkXRzjWEUsBoIbqs5uhU
         Ustc+v1CDaRSr16TyxMWmiXR83u5yH0ipJxHRGfE9lGYtWNkGIy/U//whczKkAFjp1b9
         GYUyiogtmunUJAeUY46LFh8/NRyJMxxO/CkFVlbB2V1yYRtxS7MAE2eEkQYMtwPM1NU7
         EqRtaEhfIHvEzGkipg7KxZKDfELKELHg6PcsTrHA3O7Fc7aHahTQkvOG2/G+WK56HcKI
         oVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U/nGiKbFLFriNl4EVgpGj88MYeZZdcTLN4ma7CGTOns=;
        b=Oy4yuKFjTE35o/g8FziF+iQC/pjcDbqZbXRdEMSEE72zbxZRiffoN3Q/n7nnjDIhYA
         CNq1jB7qyLpTq6nM5nWXyblDwI3rqDl7AOOhVfCChi8PNhfnys6Xr/8L4w1wy8swR6fc
         1Pgz094e2SlRkExwHFV8JigJ8rmHC5HGLBG8maTJ++vmG/1yUNAoQevyag4apP+pd39t
         gxLlWoaNaFJV/EThJJpSE7dbIo9xR7p48f8Cea2xcv4422xZH6Sew5u7FU2a52MPkaqA
         Y/TbV+Q/KaF0rMDN+O13kITHH2z4+VidOkqjbQVa2z+9Ze63OKc+UgwV3GsXqa9AqNzg
         EzaQ==
X-Gm-Message-State: AGi0PuaaPEnrmIa3dz+5URAfkb3mjzv5MhFhshn+5MrnRbM2Vos4rzh+
        DsoQuGCPQHJ2iwZyZZ5Y5xE=
X-Google-Smtp-Source: APiQypKRGJRAQ0UZdIySQIaoUKnB7SQfKdP6aHBF/MqvfySOmbKcCMXcGTUk1STZ47zTNYv8/b2/xw==
X-Received: by 2002:adf:e788:: with SMTP id n8mr418066wrm.317.1588933593344;
        Fri, 08 May 2020 03:26:33 -0700 (PDT)
Received: from localhost (p2E5BE57B.dip0.t-ipconnect.de. [46.91.229.123])
        by smtp.gmail.com with ESMTPSA id c19sm2364623wrb.89.2020.05.08.03.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 03:26:31 -0700 (PDT)
Date:   Fri, 8 May 2020 12:26:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] gpu: host1x: Clean up debugfs in error handling path in
 'host1x_probe()'
Message-ID: <20200508102631.GA3030605@ulmo>
References: <20200426191630.41290-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20200426191630.41290-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2020 at 09:16:30PM +0200, Christophe JAILLET wrote:
> 'host1x_debug_init()' must be reverted in an error handling path.
>=20
> This is already fixed in the remove function since commit 44156eee91ba
> ("gpu: host1x: Clean up debugfs on removal")
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/host1x/dev.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl61M9QACgkQ3SOs138+
s6E5qA/+MmoiWrLTVaFdEnFgY568ldpbMKJel9y+2djQ7IncLvkQt+g/Z6o0ghVD
OkhEvQfWM6rdYUehLaFfN9k1VJ+8VaNqrvDPa+SEfivIS0lDAF5dU4x6rOxN8gFf
t6VHONMlhZsHhPI8jlMvIW+v3OczrbDzXmo5P9o6iKPFDfkqEpbS8FAqlzhpXGPY
qVSmowOZtNJcvF1754ssJFb95uz0kl0XZ6LNa5Pgl1YFHgBAZrUKHtu5ekmvs2hU
tXJB6Z/nyJs8/38HWqQD6+6MjOsPVD3hBEf/Mz6PE3TLSQlTxUoGGvECjU4NNnnl
HrdBPXIOCNYC5a8KAEyaFg9I4jUcpnhwfB7RwXZeFUmUMdl0DZx4m6jckCbD13pV
Qax13ypm7mUuTAh1ZpzI01Vb193QG5Zx3YpSb/cFlFeoe12YXZH+j9lawuoCI83s
TfcwxTaPtYhUd3UnxpW21SKmun49sL12lilKyLhydEWCVcMozaYJUyz7wkJPEoU5
Jkpnu8M1YhW6W3nFa/hOBXdcEHg+LG14DRaGZ/Dfv+9oMRNcOEoW+p7WZSSDODs1
84p1Ec/NedIcB9XJjtaB6RLkwu5PbPk5g7uBEZLl6hVSZfUnXW7/wg/zcuedwkO4
p7GYMpqt2vRfQ7iM4VXH60fqlN3lF1GDj0T5JZsMrclFInwK2dw=
=zg/O
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
