Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8DAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D60220772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5OLUKPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgFDN4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgFDN4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:56:09 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC85BC08C5C0;
        Thu,  4 Jun 2020 06:56:09 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id k8so4795520edq.4;
        Thu, 04 Jun 2020 06:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xt+qXlJ/w/CHGInS8iFF4yNL9YX64MPwrfuBL7dI4q4=;
        b=N5OLUKPFgcli+zUSxnqsncN7jxB9gjk3ZCEvyN1giZvfYm1xVPt+tNEhB5WcBaFFGe
         yT+tzW8k5Mw4yUZKUMuiKI7dBoXD0zq25WalgyKkg1yFmvFX0I/aixQZClKmUxBvM4V3
         UxW/K0z+V0aKWOcAKpKaMGwDuvG9yfsFPlB+bbnv4sL0c9x1MGFSZxKcahEZRR6OEKEU
         R7rSE8O6T9UQd0lbN5M5uE6ebqzM73Nfh4J1bX9cdPfCX1v0BxrV6vEThzMGFuwmn/Bt
         QiNfukXkp1APXxATxv7HQvCoYLdql3DzQ7QQN/lLQ5JGSzL64c5VEeWARepWQHlgjg5k
         10UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xt+qXlJ/w/CHGInS8iFF4yNL9YX64MPwrfuBL7dI4q4=;
        b=I9cxQOpCewh2IZbo1by6McABJ0DCLrQhfGImtguxX9Ae3I/h8yEqv4O/r/BUxYlMsp
         ohDdnSw+tIBEVs07i43dXqSr07LDiFWhTAGXpR4iGEXZNX5mi5YeFvBADcD/EBbfv/3b
         RFOtTbKtK04js9+l20RtVPLQufsbdAgLyJC4yLlCDyl4iCMefMACZR8QnHh4kNAbWl2X
         qK7bTAQ7q1YDqwK1SuU/LDug2bgNbtirJuFEALzYs/i0xtpJqOc3UUoqTFMCvmF8jJIb
         Sejw48Fku2bQSJl1K5oe5Uifj6D0gfgffw1V7QqCBYAK1TVRQf3yKkENQYcALD9IlCL2
         PALQ==
X-Gm-Message-State: AOAM530lBJ7wDYJErD9nbpSjAbUtb++IeovFlRg7g9XwG5mhqz6gq+eR
        vHZGzdHakPoaLZv4u8VdVqs=
X-Google-Smtp-Source: ABdhPJzw1NIuAeA/NKqB3LPilD16ORfGsYt3arn8mpO186HyKfuiNhGudCWjjzj61bIU1fjludSbeA==
X-Received: by 2002:aa7:d6d0:: with SMTP id x16mr4542349edr.175.1591278968447;
        Thu, 04 Jun 2020 06:56:08 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id kt10sm2217467ejb.54.2020.06.04.06.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 06:56:07 -0700 (PDT)
Date:   Thu, 4 Jun 2020 15:56:06 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 6/8] phy: tegra: xusb: Add support for charger detect
Message-ID: <20200604135606.GC1138399@ulmo>
References: <1589437363-16727-1-git-send-email-nkristam@nvidia.com>
 <1589437363-16727-7-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <1589437363-16727-7-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2020 at 11:52:41AM +0530, Nagarjuna Kristam wrote:
> Perform charger-detect operation if corresponding dt property is enabled.
> Update usb-phy with the detected charger state and max current values.
> Register charger-detect API's of usb-phy to provide needed functionalitie=
s.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V3:
>  - Allighed functions and its arguments.
>  - replaced spaced by tabs for MACRO definition allignments.
>  - Unified primary and secondary charger detect API's.
>  - Used readl_poll_timeout instead of while loop condition check for regi=
ster.
>  - Fixed other comments as per inputs from Thierry.
> ---
> V2:
>  - Patch re-based.
> ---
>  drivers/phy/tegra/Makefile |   2 +-
>  drivers/phy/tegra/cd.c     | 283 +++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/phy/tegra/xusb.c   |  80 +++++++++++++
>  drivers/phy/tegra/xusb.h   |   7 ++
>  4 files changed, 371 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/phy/tegra/cd.c

Acked-by: Thierry Reding <treding@nvidia.com>

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7Y/XYACgkQ3SOs138+
s6F9wA//c1AJ3FHM0Hd0rv+zsl52J25fXL900vW2xXJen+Y78K4WsUeU0DrOVWLL
Jb1uuFoKiiGvOfRKIPK986xWqECWMz9E/dz7GTgsngBiu5db3Ndc3gPBYDu2FfNu
B4ZV5yY11shrWHNxahITTivyGfJLOtCFQh18BjhJOjJ5vLwlj/FWdvWVMY7s+rbU
0mURwNp7bHTajE+mKN58eY3AxY6RZ8+083I3hWXW3TreGxCMvVVNFRB1D8+Mk+X1
nvwWziAugYRnlLMt5L2vvEeiPDiQjbzGqfP6vxgRXZrEL/TLoQK2MC3c6v3ZQYsY
9ms7ZmQUTAHh4omhYJPaldWPYTQ95Dqw5lAHEaers7MkqPSGOedfLBsINCtBt6f1
iwJY6YOkAG9q8adHZN8RWTtdirqOhLH2o29RUCqD5vv9Oqg9zhrF+bJHQmwOJix8
+Rs8KwndDSwuEuR8KF646FgLJH5LOODFMSLl7cB0/N+MRLehAfn/ItuwtujDXGln
EIwpS3rd45U5rslitfsr3J491GFJyF8dEeUTnNFJjRUoOR8vSKYo0ckDLwLY5xHc
yl/ufE2sFqLcAuU/9T8yxTGElnyQ1B18Og5QwZYUtE5BnzF22r3jbWc3TkmOXtTI
yCKcLMH0fWkTb0tA3JLq6ps09ATBjQbv3koCi6hmcLfnh04NvFY=
=+q6H
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
