Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ACEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD0A20771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km8eT+/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbgFWMdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbgFWMdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:33:43 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878C2C061573;
        Tue, 23 Jun 2020 05:33:43 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a1so7402733ejg.12;
        Tue, 23 Jun 2020 05:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=30SAKFPQimrg7HfeM0k4d4h70bpCAoDQ381GiN74sfg=;
        b=Km8eT+/N1jc92cnH+YZIZ6aDEoV1S3U7kSMdPsd/xGkisGOsDInQgjCTyAvnN3Kdgs
         nJg9ogu5wXRKgqIMab77gh+9asX43rx3A/QlqRDBk85P46Z3EaxD+pB6adpD08r8KGjQ
         q7g4xj/IdLkqm7NgldBzvTjIz6nQQdFC4eDEUrr7S2UJ9Itag/aWtwXWhfelIAiKp2cs
         bHo901xTd/T/Q2uw/JtEJAJrLpOziIcyfHtJRLmLgoUZ5FBLCGEU2MBybyNjpqm3OR00
         n+1f8GDYFnnKWAiTE4Nm1Ahn5Uno3/hlmQaJISnRv6sD6JsBXXsnCwywP8d1JWCZQlxP
         2MBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=30SAKFPQimrg7HfeM0k4d4h70bpCAoDQ381GiN74sfg=;
        b=qt+zVZMAOlgmcdkuGl/mfuznivkHVlYBjS/YfUSdZVrRN9a8+6ZOOLb/Rb/mq7ufjh
         BTUz8JKRv7HFLwcLuQ4iWt96FzuapLJ+Lu6/5YN4MDIkH3VQ9LXY0mrxfN9LTsPq8JVo
         r3riHk5omm4QxpRJbCs3wr1dduos2vCPdRwsJDsw09f+6UWS1hI+OP3mEgKaZTwAPAao
         X4b/AWYyjS2AQyABFV7dR6jQ8myghl1jb/gLDORh9spVvt/yKvqt+a/CKnY3W7Ldi0Os
         MG9Rt4c5V1j3DIeDxd8SIlKchF6mWuDaD70gMA/2M0ijVs2wQdN2R5zMtdL06Xk/NwP4
         AeuQ==
X-Gm-Message-State: AOAM530aBh6dOhqsYgfL36kFg4AI4HSghYya4p72Qv4tkN+b00opQ6pu
        F+/iPkvi16CE1KnYm8iwO+s=
X-Google-Smtp-Source: ABdhPJzwuKRc487tG9XzHN2VHGlbJ03At5WFM+NxaEuJoR2uuR0SVg6pjfA1LNVllF3OnwURr2VfvA==
X-Received: by 2002:a17:907:abb:: with SMTP id bz27mr20983635ejc.170.1592915622280;
        Tue, 23 Jun 2020 05:33:42 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id lw11sm13134042ejb.58.2020.06.23.05.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 05:33:40 -0700 (PDT)
Date:   Tue, 23 Jun 2020 14:33:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Krishna Reddy <vdumpa@nvidia.com>, snikam@nvidia.com,
        mperttunen@nvidia.com, bhuntsman@nvidia.com, will@kernel.org,
        joro@8bytes.org, linux-kernel@vger.kernel.org,
        praithatha@nvidia.com, talho@nvidia.com,
        iommu@lists.linux-foundation.org, nicolinc@nvidia.com,
        linux-tegra@vger.kernel.org, yhsu@nvidia.com, treding@nvidia.com,
        linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
Subject: Re: [PATCH v6 3/4] iommu/arm-smmu: Add global/context fault
 implementation hooks
Message-ID: <20200623123339.GA696655@ulmo>
References: <20200604234414.21912-1-vdumpa@nvidia.com>
 <20200604234414.21912-4-vdumpa@nvidia.com>
 <20200623083643.GB4098287@ulmo>
 <2dda4530-39cc-d549-1124-26337dd9afbe@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <2dda4530-39cc-d549-1124-26337dd9afbe@arm.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2020 at 12:30:16PM +0100, Robin Murphy wrote:
> On 2020-06-23 09:36, Thierry Reding wrote:
> [...]
> > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > > index 243bc4cb2705b..d720e1e191176 100644
> > > --- a/drivers/iommu/arm-smmu.c
> > > +++ b/drivers/iommu/arm-smmu.c
> > > @@ -673,6 +673,7 @@ static int arm_smmu_init_domain_context(struct io=
mmu_domain *domain,
> > >   	enum io_pgtable_fmt fmt;
> > >   	struct arm_smmu_domain *smmu_domain =3D to_smmu_domain(domain);
> > >   	struct arm_smmu_cfg *cfg =3D &smmu_domain->cfg;
> > > +	irqreturn_t (*context_fault)(int irq, void *dev);
> > >   	mutex_lock(&smmu_domain->init_mutex);
> > >   	if (smmu_domain->smmu)
> > > @@ -835,7 +836,9 @@ static int arm_smmu_init_domain_context(struct io=
mmu_domain *domain,
> > >   	 * handler seeing a half-initialised domain state.
> > >   	 */
> > >   	irq =3D smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
> > > -	ret =3D devm_request_irq(smmu->dev, irq, arm_smmu_context_fault,
> > > +	context_fault =3D (smmu->impl && smmu->impl->context_fault) ?
> > > +			 smmu->impl->context_fault : arm_smmu_context_fault;
> >=20
> > A simpler way might have been to assign arm_smmu_context_fault to all
> > implementations. That way we wouldn't have to perform this check here
> > and instead just always using smmu->impl->context_fault.
>=20
> But smmu->impl can still be NULL...
>=20
> Everything in impl, including the presence of impl itself, is optional, so
> the notion of overriding a default with the same default doesn't really m=
ake
> much sense, and would go against the pattern everywhere else.

True. I had assumed that every implementation would set smmu->impl
anyway, in which case there'd be little reason to use these default
fallbacks since each implementation could simply directly refer to the
exact implementation that it wants.

Perhaps the above could be made a bit more palatable by using a standard
if/else rather than the ternary operator? That would also more closely
match the pattern elsewhere.

Thierry

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7x9p8ACgkQ3SOs138+
s6FZPg/9HSAfgoaJNJaXTtNi/OEDZY+VElZLtUMvcQUqt0cbrIEJaGnYnsoTWi6K
K6p9wrmkmVs6D4yT8I84B+Fe34KFdITXA8NPGPD3g2YFSVCGwr1YzW9gtEwYliG2
c0q9TuA4tr1NF1F1Hy6B2vTgT22UIvXR38IXp9MP+Ti8EoM1VTcQL4S8ABruWT89
rUxYHWxWTOiBx401M2oyQY/ToahL1V/tjnS/muOpqxbAEl41NnHXQfdUcfjytZgg
uKMQZRvNCTufFFI3UWrW9vfimBnZWSTqtVtBC/0/c32e7sJvvf5HHXxaZ8+5roGw
trzSaZg4qbK3jq6TZSO/fIcWqrzdhO9ERBHUZt2MgvzBKAIX6VkRMlyPvoYLrVwv
Tto5T2vkq9XTMZB+vYqHMg54/3zntpoMA7BzHGXFItjebOXlkgCVGbJpDOCrxi2v
YIGPkFmV+RwOjf5oEsBAkQZ82trHmpjXJlu6Qx2IDiQpo9Lg3+YCyDRkFLODlRli
iS0jeeQzD0JoRjm7pnv8Yllop8VfPsYMA9WiURza8DQ6ccf8xFNpzlOB+CIa7zoA
PLUnvNCTsfxN5QzClaQ9mkyKq0YB9WXWgmJ2vaKIWMJp/vJkh9k+ZBfMJd1AgrFo
H12y1uz7qUlU94llCeiaLwgYnh02QiKDjLWT5+gDKhXuHMm5tcs=
=8o7I
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
