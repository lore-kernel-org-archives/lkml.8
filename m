Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8053EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D86A20707
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oba7UMxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbgFWIic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731691AbgFWIib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:38:31 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A658C061573;
        Tue, 23 Jun 2020 01:38:31 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id s28so15695046edw.11;
        Tue, 23 Jun 2020 01:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KGfmCcP5g2L4qhGcwuqQFp+/Ilq6uH2EI6aUHJQmZb8=;
        b=oba7UMxue4VkTJ6mnnTKqhdJABWrSTnwFBTGl0KzioFLdPw3lwKD/Wuudpgq6qwgss
         u68UZq76S+MaP3bmQZ7yPjwL5HvsyQKWA0K8DQf3GHtC8OrjtPw4zB95umuoaf+LPQ7H
         NZe32Z9B1ACwnmiZYofgATmfVXLr+AZO6ok1dzTgBPx78gKul/+wqvn5fA3TOdDvHRX4
         RpzQqyP9mkREb90SppGg7pIsKWv8NppMkn7HS5zKfTFAt5cWa58plrLHAF7HDtYvfDel
         DSvI+XQDZyC+nzEhjetHe2yx5pJVEj667BCgEFrR9fSqmaZIONgza34Ni25NkmZThNW4
         zPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KGfmCcP5g2L4qhGcwuqQFp+/Ilq6uH2EI6aUHJQmZb8=;
        b=e1o7Pxdrf60NtJHKTjAhKtDZ2fCSmRccFV6K1jPcjFkDHJNKnh97Da3vVqys2YyPg6
         EpKRxE49pyQ3/AiT4bMkDWqGgNSvZEtv2bdAXZ98FNfnrTS78PCXbW7eKwFKJoLQyfjm
         wbHEGVOT1zr9TGD34ONToxDCU8pBEson7BK1iQv9XUTBfW9fjrCUQ0PXBrWkZpwF6E7L
         Q24HvNRU16Kgs/ZbNj+1Q9o8+wsRCtxg9ap8+CYsPpSh7sUIsjDBY3+GxuhKEBaOELbb
         i5WXtaiY/tZiip8YtsWi0RgDz9bqJa2prOXXQ30jWwVeNluefT9/XTg4C5ax13+HKznu
         zp3Q==
X-Gm-Message-State: AOAM5308uwBlQnfvQVERjWyZQPgoIpzORi0lpMTjKFcEtIDg632cJaOk
        eEWp3A4Sc9I69LoiLPt4o/M=
X-Google-Smtp-Source: ABdhPJwSBbh0R7MdzbdnGq7YVNkE+unXplKitsfBGfmOeW1hwWfXdt/wX9bCOi9oqEIcFQUXxRV33w==
X-Received: by 2002:aa7:d7cf:: with SMTP id e15mr5330879eds.236.1592901509923;
        Tue, 23 Jun 2020 01:38:29 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id f10sm8753967edx.5.2020.06.23.01.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 01:38:28 -0700 (PDT)
Date:   Tue, 23 Jun 2020 10:38:27 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     snikam@nvidia.com, mperttunen@nvidia.com, bhuntsman@nvidia.com,
        will@kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org,
        praithatha@nvidia.com, talho@nvidia.com,
        iommu@lists.linux-foundation.org, nicolinc@nvidia.com,
        linux-tegra@vger.kernel.org, yhsu@nvidia.com, treding@nvidia.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        bbiswas@nvidia.com
Subject: Re: [PATCH v6 2/4] dt-bindings: arm-smmu: Add binding for Tegra194
 SMMU
Message-ID: <20200623083827.GC4098287@ulmo>
References: <20200604234414.21912-1-vdumpa@nvidia.com>
 <20200604234414.21912-3-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <20200604234414.21912-3-vdumpa@nvidia.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2020 at 04:44:12PM -0700, Krishna Reddy wrote:
> Add binding for NVIDIA's Tegra194 Soc SMMU that is based
> on ARM MMU-500.
>=20
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Docu=
mentation/devicetree/bindings/iommu/arm,smmu.yaml
> index e3ef1c69d1326..8f7ffd248f303 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -37,6 +37,11 @@ properties:
>                - qcom,sc7180-smmu-500
>                - qcom,sdm845-smmu-500
>            - const: arm,mmu-500
> +      - description: NVIDIA SoCs that use more than one "arm,mmu-500"
> +        items:
> +          - enum:
> +              - nvdia,tegra194-smmu-500

The -500 suffix here seems a bit redundant since there's no other type
of SMMU in Tegra194, correct?

Thierry

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7xv4MACgkQ3SOs138+
s6FMxg//ZuFzYh2293V3nX16k17CojdDjbyvYLsHgQcpJrsaFK2aAj0N7VRrvSee
E3d1/nAy1MfyeGet+xDtsdVqJliFDdV+I0IsClmxHLWxoGwjzIs1J/y0IwK8I9vo
Hk5U3Mr2bnUHf71mtLC90Axy0OMJXuNkVCSZ+Xri+0pGneI4ESkPJ8yg8h4L9bRM
m7+igCtqvn/pzT2CnzHNfhop+DC2VVgOcFgsF2yn0jRvjwcN3rLg8u4Xy1Y2dXmg
MWByT7aNi/BnfBQ4IBe5IBRoyw3jpNRof6g/6G0jZDQbUFA1qv5w5nvjlQ/m6Y1M
/mHGfPXtQMrz9LP+GTQHgHlzWNKgx78wUBbQTEs/Sc/QhCte4i+cyvHuFHSLjhQT
QVGJga23p9VOLoGsStBCUSz0m6dRlyt9e5/O2NedofW+9LEOFyzo+LhGA9TkOokw
kGfqwwVkGoc08ytVzxYR21sCNwLWa3TWalgbpFU4dVX0WTWFKKd052aK+eHoYjJr
TSBmX8+xF0RVPikYTtYqe3HrThqTjnERePhDuf9SWAerjLEDFeP/7RgbdC+xK3O/
20ijfFT82UADr+5pjdZpbkXd6YCRniccMw3iFb0NlCDVTJHcsAJOSvCa2p8InLei
XkuHU0wQAEPJ101mL8m6S7BP241bnGS8lmlV0a3tyvZ01M3+OOs=
=pSyW
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
