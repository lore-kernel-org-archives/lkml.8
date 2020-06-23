Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71BDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16972072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dC2x/AZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbgFWIdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbgFWIdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:33:53 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9ECC061573;
        Tue, 23 Jun 2020 01:33:52 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g1so15726728edv.6;
        Tue, 23 Jun 2020 01:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mByc+HdrrJVo82qOlaNYMdsIyPS2/ALz2+ifGVUr9zU=;
        b=dC2x/AZRE3KWtfaIXsv78v09gfMqxzRs7yz4QEOPZEQOZGrnT/yy44af4IRXkLcV1X
         xihpklYb9RrIn9oYx+XKoxjApf6RFWl+mEzOC/bdXoSNWahYJ83gU7bZNpsl9vbieaFo
         obV6YkC4SUEmM2NV/ApFUK7TKzHZ0s3H9wXBBEkAOWmjyAzas5gr0pkIYryq8S4yvQp8
         FBgKBArq28TI3ur/DQ8N2ZaleywxlzyRDqM6lfG61JR6fskg1bHfmGMDHnesntG7xDqf
         r6doil1skOkDFqvxPxhp2hY12FIESKM/Wxrk3QYmc+Sq6VBRqe5mV8ABafBr0ILwhTLz
         NS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mByc+HdrrJVo82qOlaNYMdsIyPS2/ALz2+ifGVUr9zU=;
        b=DWVCP5zQSTg64ZddhIaYDWHpu3gJhElVrHezG9YJ5HzdjmPAIN4Jqut3kAoD0+cp/J
         iY+UI7qLiozIHc4RB7bsGW8eVmCP8GScI5pPJlH5n8INe0gk1LdeKiMsRjl1sw/ymVkp
         vOslqf7CZucmlrab6mlkmcQFA99qUcijes9rC7egWKu/Xs+DGG0o7ig2JqBKmfkQ48hd
         KaDQSCmeOfo2gLcZeFYTL7PQwAFmjEQTozkBcD/mW9CYlbrfxqhBWLVkYDWYXPauSgk7
         6+ydR1HBf3MAHXOTDiumUu2HlRRj+NorHpHwKI8U029sntTUqlWbO8s65wMJzFcCfUK+
         Oriw==
X-Gm-Message-State: AOAM531GQWQidbGsTUzMLiWePNdqX/NJh5e7xwFSsXRpQP56faNX4H5j
        MHfiCziNLlZqa4XDIrUJVGs=
X-Google-Smtp-Source: ABdhPJxLjGU5g0rdOk2g6boet8HWFpPywMBg/d1/q9eFZqBZEmhRL00230dLs+48qy++4ChmW1D27w==
X-Received: by 2002:a50:fb14:: with SMTP id d20mr20880575edq.209.1592901231168;
        Tue, 23 Jun 2020 01:33:51 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id w12sm3339851edx.19.2020.06.23.01.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 01:33:49 -0700 (PDT)
Date:   Tue, 23 Jun 2020 10:33:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     snikam@nvidia.com, mperttunen@nvidia.com,
        kbuild test robot <lkp@intel.com>, bhuntsman@nvidia.com,
        will@kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org,
        praithatha@nvidia.com, talho@nvidia.com,
        iommu@lists.linux-foundation.org, nicolinc@nvidia.com,
        linux-tegra@vger.kernel.org, yhsu@nvidia.com, treding@nvidia.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        bbiswas@nvidia.com
Subject: Re: [PATCH v6 4/4] iommu/arm-smmu-nvidia: fix the warning reported
 by kbuild test robot
Message-ID: <20200623083348.GA4098287@ulmo>
References: <20200604234414.21912-1-vdumpa@nvidia.com>
 <20200604234414.21912-5-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20200604234414.21912-5-vdumpa@nvidia.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2020 at 04:44:14PM -0700, Krishna Reddy wrote:
> >> drivers/iommu/arm-smmu-nvidia.c:151:33: sparse: sparse: cast removes
> >> address space '<asn:2>' of expression
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  drivers/iommu/arm-smmu-nvidia.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This should be folded into the patch that introduced this error.

Thierry

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7xvmoACgkQ3SOs138+
s6H5OhAAnUJxO+okbp2kcAzUIo+/gCFpLxt2IUml3mizRRO5emehRyjmdq/5zbng
wee1t+qSJyX65D2aRq1WUi0ENusf6T+5mO+s3Qao6d8cu35H4l3j56kX3gO9mew3
eCvMH5ZmczMiqS5Tlyk+BxmsBBcP8c6FpygcLrsiMtXX6NkaUScSSOB74tkamv1g
KOslg0uZNaANq6jCKOaJ4uhkHjAUDLFigq4CNcPG1dqyAIYipHZy1tHgK7IORCic
SPsMCaOYh7OXKaLdrZn6+TqX1JdlJpRjwecViTdR30CxbPvAJjata1suxbVOK6c/
sh0bKzeOyeb7iza2nQltD7YkeCF7Y9o69NFyzdl0KKkObCOxuWNn3BwS2iu6rm9r
ZMBwxo35jzHh/KWtaRaPlQaGwYqYpCTCezyFAo4kvsbD+mjIMvcFtJ786zgsdNcV
ZplpSnKvt6NwxjxzSZwUI1a25xUYA7WKrxVLi9yEAcfGEZYyQxFkiJDKK0JsmHiU
NILvdgXpTNZODuLwQ2vItfbrLVK+Uil/frAPNHfNjYlPG24CC7D2FCIgDLhBlhfD
aU90sf7sbWBIFzFGci5RjTQGkAd0h6akiHuVJkOQBRHM58G5V4Y85H9dpm6C0GmP
hUcrPhSv+SGL4BLUTu8zBcq0Jyp0kDhbBypUSVotnQdJW5LJrFI=
=M0sQ
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
