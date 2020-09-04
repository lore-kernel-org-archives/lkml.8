Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CBEC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 883892137B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS/byoFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgIDMUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbgIDMTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:19:53 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B970C061244;
        Fri,  4 Sep 2020 05:19:53 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g4so5924639edk.0;
        Fri, 04 Sep 2020 05:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xpMuN6oufyDsPAKl7hqAVZXkONbQHQ1IA1e69CcugwI=;
        b=VS/byoFLeR9gTw/tfqWAMD+WnTiGH4K21Z/4suj5vpyhN4kjKp7gDA90GmeDX8Qg5V
         6FmxgLfqRbYdVIf+/zpUr3/EGORx/5pNL2nUvdcoVUQQfCX/3kw/BZLt4d1asqkax/8T
         XfySzac9YJ+V3wtMhCkKP9mgTGM66voPz9+00PCeUmqOGpHetIcPgi0Rx3NCmToTNnTD
         VRdcyU4+JklxYByZ9XcyapKWe3MH+ocHmezSg2mzIOTA8V9/m0ipPI+L7Av1/+/j5AiV
         1nJEn4ZMDtxFL4AHMLSuniTAnoo/MPZaJ9MYfmy7VsRD0cIW5dFINa2GydcsPI7Gr3Hl
         dzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xpMuN6oufyDsPAKl7hqAVZXkONbQHQ1IA1e69CcugwI=;
        b=GwYGyRmW6laoYmD9OBcjNUCMn0mbIvNujux5utSpjI4Chm3nLNjCU0jdaOnF0ZDZl6
         N7zr3vkLIqY2YcKQMaW2OFQnRcOnCsUdmMXYgNrnCZIfIQ/lWDOQ1XmUd3cQtFgzxbew
         9xgdadZGIJebyxhGhgO4qKMDWa0miU60PA5YONfp74wCMlGzSYaYqynkWPKbKDLMns2r
         Fe3yOZpOMMbha6wfFuWWyPCoEZYnC73LoeM9i3xFq3PtQwbaaU3KSh/PSaSN49/AXAUM
         mXUDsWU5779qaHc7Bmo8Ol3e6LuTUAYWaP7eKTlSg0MMZTWk/hc/TPnFjBE98t6X6My+
         jt+g==
X-Gm-Message-State: AOAM530qzxgpErjyWpS9zqDId+6JFIGoOaJzEztCiHVOifUxGmo9TMZ2
        MdBLcG5hVfFihHZIJfWGhGE=
X-Google-Smtp-Source: ABdhPJzuwMBGdBk9IYYGRNIj0xeJachDfQfz2WniTevu+3xzRvwqoytHGkTtUp2e0fxhiAgvCksl0A==
X-Received: by 2002:a05:6402:503:: with SMTP id m3mr8390126edv.45.1599221991805;
        Fri, 04 Sep 2020 05:19:51 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id x10sm5740082eds.21.2020.09.04.05.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 05:19:50 -0700 (PDT)
Date:   Fri, 4 Sep 2020 14:19:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] iommu/tegra-smmu: Add locking around mapping
 operations
Message-ID: <20200904121949.GA570531@ulmo>
References: <20200901203730.27865-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20200901203730.27865-1-digetx@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2020 at 11:37:30PM +0300, Dmitry Osipenko wrote:
> The mapping operations of the Tegra SMMU driver are subjected to a race
> condition issues because SMMU Address Space isn't allocated and freed
> atomically, while it should be. This patch makes the mapping operations
> atomic, it fixes an accidentally released Host1x Address Space problem
> which happens while running multiple graphics tests in parallel on
> Tegra30, i.e. by having multiple threads racing with each other in the
> Host1x's submission and completion code paths, performing IOVA mappings
> and unmappings in parallel.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>=20
> Changelog:
>=20
> v5: - Replaced GFP_NOWAIT check with __GFP_ATOMIC to fix "sleep in
>       atomic context" warnings, NOWAIT !=3D ATOMIC.
>=20
> v4: - Returned to use spinlock, but now using a smarter allocation
>       logic that performs allocation in a sleeping context whenever
>       possible.
>=20
>     - Removed the stable tag because patch isn't portable as-is
>       since the arguments of map/unmap() callbacks changed recently.
>       Perhaps we could just ignore older kernels for now. It will be
>       possible to fix older kernels with a custom patch if will be needed.
>=20
> v3: - No changes. Resending for visibility.
>=20
>  drivers/iommu/tegra-smmu.c | 95 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 84 insertions(+), 11 deletions(-)

Seems to work fine. Tested on Jetson TX1 with display and GPU, which are
the primary users of the SMMU.

Tested-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9SMOIACgkQ3SOs138+
s6H9aA/+POA3gKeeFXU13V+vbYgFzYonGue9SVkjCLeoT91VnE/GC8951N6yBoU+
LuxfBZj1l3O52ICRMHIAX4A1SRrHdhoPvj3GsDWdCpxuVinvlm3ZpsIq+klF2yfp
jmuzRCKisOr0cWz+WUbMEjSu5E4IIFQOjaG4pejbKuma7bcVLisSTtlXorgGp29+
4MCueGk+BVMdGqr7dw+9J6fdFk2v5JWN/UT9rFsLrMTkvZ3JwAKUHRDq0W9iItZN
EIGy+FBETildbjBMBplBUxF00U7JedZuvqfEyZUYPxX3VkiAx0+b5bf3CKySRYYT
ew16Kcv99xqpI9pCoVfQW57b28lX3HJ/okOuFx+zDE24jfX9cMJJ5y9Jr+za3CN6
rCtILMNBCQQIlgkXgePW4EQuGhHYtbc7CEfHQ6Mam7ePlteZq72yOURxszSz5t2f
fun4hdomQNYQY/6yEYd90HGtf7mdKOiIlezNwx/xWyE+PWk8u8LUHcY3VY/ymE07
ZfajZTDFr/fz3Bz/pAPRPJt0YgIPeg+PjNESa1HB3RKyxBCCeo8F4gA9KSc6K2ve
fX5EqIbZx0ZbGFciLgR3liIOLd3KvDUKfTarRfXjKyb4EIOosb4R8ZE2WDBe8qDF
UxolffLfQYAXanJ8rpduYEuWG0gIBMsGPzuE21RTg9Os5erG1ng=
=i6XW
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
