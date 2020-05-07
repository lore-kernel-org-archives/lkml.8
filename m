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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E81C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8214E20CC7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okdsFizy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgEGUEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGUEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:04:32 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C1AC05BD43;
        Thu,  7 May 2020 13:04:31 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g13so7881525wrb.8;
        Thu, 07 May 2020 13:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FvhaiJ3h6ZyJvUgpCdCyaYIlUWzK0anfc0J+81pJ5QI=;
        b=okdsFizyrPSw4e3/LCJm943UGkVocO9S28coEA/qEURQ+8+nGVGzWz29QX8yj4SYYJ
         j1MshJ3QDySu/WRs7sts94FW8wIZoeMaHTM5AUUzxhG8S1XeUAwwEOv0dOWMwDwqcUuv
         QNHW7ml+iPraZ6HLHXG2BbOW/hxDHrZWHuTxLexi65/OsHU9itSrUKs5mvS/UbktF1as
         KSm009FvpeFYvRowMytc/UJoQRSHTKa9XAfDOzm4D9EcU4klpv1diHZ9tWbv1HQ5225V
         KbInZJLnRn8x9z83wdBiXTvpM9JsmlIArOwQL9BypCTEJJD6w/4FY5xw8MkI5HwWHyJz
         R0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FvhaiJ3h6ZyJvUgpCdCyaYIlUWzK0anfc0J+81pJ5QI=;
        b=imHYp+DoIAKEU9+yMcpU1Oj8e4TKrd9TuekoGYCiI7bp4uStzBmeHg2ZmuSZwKfHUb
         1+IS3pZDZbHtNZzWewX3SJpIwbVX4jpyZC5cQKgAQRJ3+0zHHYVtSWN5V09zONnTnIU1
         Q9sttfNmKJ+DOe8eLH5/nGqpkqQ1xzpYvwYcJUL7F02a4fltjiWygNFpmXND4CSIsM8I
         0x13qX5Xm7FcaaeboIRtx38Q7r5qKqEgUs66I6MU00WzteSb3ReX5jCqf9EpzV8EdEWC
         zVqjpJj+a0qp/KnF8pAWc+e9Kj2XjdeYo/z1lEF2j7qWKWMGTUQLc8Krs09LySET+qRD
         9MXw==
X-Gm-Message-State: AGi0Pub7/YB/FBtpRo3x25G0v5fFpOK0VtPskXP/dKdNn1wyCHIsfPzF
        uCSNrzqX7coiOz799AJWn/0=
X-Google-Smtp-Source: APiQypJQ++drKO6HmujH0HcRFuNEZIifUWFB/uhKT4BW7F5AI0iyKirmo5KNvjNdTtLs7ciiXEUVdw==
X-Received: by 2002:a5d:42c8:: with SMTP id t8mr17035281wrr.70.1588881870573;
        Thu, 07 May 2020 13:04:30 -0700 (PDT)
Received: from localhost (p2E5BE57B.dip0.t-ipconnect.de. [46.91.229.123])
        by smtp.gmail.com with ESMTPSA id 33sm10227786wrk.61.2020.05.07.13.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:04:29 -0700 (PDT)
Date:   Thu, 7 May 2020 22:04:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Joseph Lo <josephl@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] of: Make <linux/of_reserved_mem.h> self-contained
Message-ID: <20200507200428.GC2981633@ulmo>
References: <20200506123236.7463-1-geert+renesas@glider.be>
 <20200506123236.7463-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
In-Reply-To: <20200506123236.7463-2-geert+renesas@glider.be>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2020 at 02:32:35PM +0200, Geert Uytterhoeven wrote:
> <linux/of_reserved_mem.h> is not self-contained, as it uses
> _OF_DECLARE() to define RESERVEDMEM_OF_DECLARE(), but does not include
> <linux/of.h>.
>=20
> Fix this by adding the missing include.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/linux/of_reserved_mem.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl60acwACgkQ3SOs138+
s6FsFA/7B7X7gehd5I0pTYnsO1phcr4+EnGh1T1c9A8M/5MqPcKsQcylY7g3R1kz
3/rUSlzCOsUouLNzZsJE/sra1gVqC4eMeAEvmflM1EcijoVTsutz64qG273qsKkK
AxbYqFrA/ghLL8/x8pKCGu9WOLmWoOGhq9LKx+SoAZ5i9Oe/kvg1eiTfO+ph7jZ8
rOm01tFMdLuHKbAlWTilGTmMJ5SL6xZg0GRmmwDOWJTtnRDNKW4ooACxZQ9nkn/0
oLkAobbxi0Jv/N5FlWhmN0e4R1ZIOMZk4o48Kjh2eoJRITqfUho167uoXR2db90o
3kJ4Ug6a0niURulQhCWtCZAIkujCiXQ51KX9WLfd9iscor6pH1FuiDIiSLKIGc6M
cD6Z4Bacg7oxMGOex5czPzPhEnTgvMfkzWVKsMhYqF7s8QbnTDdOvqvEIE2cBvp7
uNw20L9vMUj4vQDNOPPy43nnbZoZsg44+nzfTR2NgKC1fpLyNbBfWSvR4rCb0uTd
ptNxChFyvtXMMvd/b9GrmZkO24XlLh34fbNBApaGECXWBaehFunuct56k9tbBErW
32wFoCsGYksfG1fGiZnhJ9foUhqtNXTbm4PhInvVy92nj1pQ70oHnTn0zwsQhnKt
EOoV9Iv6IltW49/Kdz0KBunWyEUziOzhPBFrHXP1WF+6DqKUhtI=
=V1u3
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
