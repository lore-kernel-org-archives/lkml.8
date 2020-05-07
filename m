Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03911C54E4B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D19AB20CC7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsWLwMn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgEGUEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGUEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:04:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77710C05BD43;
        Thu,  7 May 2020 13:04:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g12so8226016wmh.3;
        Thu, 07 May 2020 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3h6Wxaol0a6qz/g9sOk8sowFQqPv0zlTHK7/yKTpjYc=;
        b=IsWLwMn8j1JgikjQjSbx9WlCvSqoimGfPPOhOuvPNFHc9GgZPUT/uK4bqxK4Lp4KL/
         DAR7QivKlnzkNW+Nr3pb5Bs7LEnOHNH+JG8AFKYzZoFpnW8nJhIDk4PDvh6NAhYHshbE
         okWVzmyJTN7tZLfSll5ZDZzy95NDq4/imj8p247gLuX3K3y9xvPOJCuNxiHqUKQtFnp0
         8i0ToaZfIxxIdLZotBDCRrD81n8t4ia7ULXy4RqHTGFJmjgkPiQyVUsvwU4Npw5T1Bhi
         vfzXgPYKFo9fK8O2n7dtNslVOo6kYTXaWHLORv3qOkoD6WQSihZ5WUMtJzmzBdVve6lV
         XS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3h6Wxaol0a6qz/g9sOk8sowFQqPv0zlTHK7/yKTpjYc=;
        b=jTz7k3diacny5EOGkF0Ehw4XH+RXU7dJXLxh2MiMQ0x5hgbwfMsYSK381TgiIMvLko
         blk9DGvILpv1LTsYdF61ord3CNV9Gq/Xzw/rIyJeOiZyFLQp8wXgaoy6XFDYxWjOTtkM
         P1WO0QkeCtnAKFS9NztGTM2/8+a0Zk5/p6F/doddFRP1XE2G6hT40w4PceqKbKNtOiQW
         AmHOZedPskWNRahwp9+Qhy3eXZyrv8TwUZLRx7KJ5l1HnQK/sYxRBm2shLC57g+yn4LA
         an8t9MWPxDdX1XCZMRTNqRrumVWZtYlW1VQoPzRIB25bDDlwMA42x0MWGYSIcoamAcba
         7pSw==
X-Gm-Message-State: AGi0PuaBl2N2bkLv7FzV6IHd3t1X1p1R5ytSkWs6IvbWgUAgTwVniJfK
        33/m/M/d4dGUdTyUwvEFfmLNCRiLR7E=
X-Google-Smtp-Source: APiQypKMDle9coDHG1Uju21cbB19u8GxlfizS+EPRRytfITIdCofTGnAygyGcQ70fRPEzLmmo47vwA==
X-Received: by 2002:a1c:2383:: with SMTP id j125mr11966019wmj.6.1588881852261;
        Thu, 07 May 2020 13:04:12 -0700 (PDT)
Received: from localhost (p2E5BE57B.dip0.t-ipconnect.de. [46.91.229.123])
        by smtp.gmail.com with ESMTPSA id y7sm10050182wmb.43.2020.05.07.13.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:04:10 -0700 (PDT)
Date:   Thu, 7 May 2020 22:04:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Joseph Lo <josephl@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] memory: tegra: Drop <linux/clk-provider.h>
Message-ID: <20200507200410.GB2981633@ulmo>
References: <20200506123236.7463-1-geert+renesas@glider.be>
 <20200506123236.7463-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <20200506123236.7463-3-geert+renesas@glider.be>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2020 at 02:32:36PM +0200, Geert Uytterhoeven wrote:
> The Tegra EMC scaling support code is not a clock provider, but merely a
> clock consumer, and thus does not need to include
> <linux/clk-provider.h>.
>=20
> Fixes: ec37a9a17afbfad5 ("memory: tegra: Add EMC scaling support code for=
 Tegra210")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/memory/tegra/tegra210-emc-core.c | 1 -
>  drivers/memory/tegra/tegra210-emc.h      | 1 -
>  2 files changed, 2 deletions(-)

Applied to for-5.8/memory, thanks.

Thierry

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl60aboACgkQ3SOs138+
s6EsCQ//fUz2NWTm2ukVFtdianU99A5+5SJwxhJ5j6U6gmB7SXmm7bFY0YT2odot
J0M3Ppj4BKbdO3EZL4bRxKngsHc4TSLTrt2QkyfGu/N2XEHymo2kPDM7P+QSCqxk
LT0w2P4b41h2UF/cuIwx41E6vZcZyCyJpSQyjFI6TwjT2u1BIo6HS6xqld/W/8Dg
MqYgaMxl1HfPCyRI2PmP9gEvMK5dEwFqTUW0hZSAslxi0jA0cJGkpUGbeNcRMTHo
ha/hK4ZzZjb6M7Y7k+Ln8LN7Wr/kFiei5PiY3jRuJhsV2BASXtF5WTbF9xlSlS9D
ROBzxvCpEceNMDyW4EX2wZlvCBekAS5kUKt34zAulEzJq9cGMGUNDK9VbUagUo5f
/5+3nOV1hg7gRedrQH3Gt0wCKqc8CEGsMlz+cAKo8tUc02/Pf9GEvoLHcdsSDZCV
ziT30qXgvVTK2ZYOyqJM04Mt1LJFIDOXBnyrc/vqAn5QItKPMqO1gomV+e5R+fz+
zevHSX8sFSU4z0z6bh43Y5cC+W6F2RijRZ90eVPRjLkxtxS6zAUpnMjl+NH988ZJ
vY3CpjLxMvHFKN6YxGBSHz7/Gvn76YPuyCc5HjBKX7Em5K6/sBqAIc6N/mbliNyw
Q3M3wBrn0bWntsWR+v2VBAxovOjvLJHnaz0+ULNP95w9FXr1SHM=
=jrqz
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
