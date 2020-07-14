Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1326C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB6E2250F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594736578;
	bh=rd5OIlYx3b2juzE6QiM4oAmdyVKpLPJAqVO/kNES7eg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qsw12tUgImcz7XRSwCaSPmLFQX2g1OvHqokzzATKK+5LUk4TFlxjLprwUkWnZCuR/
	 Rby2Lh7//1OAKkuwKm2fM37AY8P+dWw4qVvNgsPbfEi4kJ5+Ko1JV24VZmMCFkXuPE
	 hrCaGTHN1ggA375nwP9aNMkZKXdh4Yl7suubypHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgGNOW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgGNOW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:22:57 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18E2E22365;
        Tue, 14 Jul 2020 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594736576;
        bh=rd5OIlYx3b2juzE6QiM4oAmdyVKpLPJAqVO/kNES7eg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PmB0EueNtgPHX2PIZw5HyzxDwaxVRzOwkSePCRZQxkefXAoStuJY3G5ocmAJHX+la
         yemTL8A5jKBcSxloLAbA443fa5XKv/kgtrnrPv0eGK30vnwYtNcS57d5TYFzXRwpMk
         4ojoqTORPROKHmG4o+HWInEO4xTKdJmcT20nSsSQ=
Received: by mail-oi1-f173.google.com with SMTP id l63so14008939oih.13;
        Tue, 14 Jul 2020 07:22:56 -0700 (PDT)
X-Gm-Message-State: AOAM5308eTQBeyuzycoIcssq26o1jkt3dr22JRo7TSk4bfUp0IPUyqz8
        P1SALUiL8rCHP7O1klmvTzdHAneWOv7NZSuGNQ==
X-Google-Smtp-Source: ABdhPJy6ZkarJ5J32IIpIQEGE/Wjp/cSwpg14EGOzfNSeRzwriu/1T8mkB7ZW+5hPoMCr1+/ya+Nb4Ie4kq7OvbrRc8=
X-Received: by 2002:aca:bb82:: with SMTP id l124mr3965827oif.106.1594736575478;
 Tue, 14 Jul 2020 07:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200708050017.31563-1-vdumpa@nvidia.com> <20200708050017.31563-5-vdumpa@nvidia.com>
 <20200709201348.GA808454@bogus> <BYAPR12MB2822514F93F831507A811EE9B3650@BYAPR12MB2822.namprd12.prod.outlook.com>
 <c2ab2a0d-419d-555f-c124-2cfa1ecb2a81@arm.com>
In-Reply-To: <c2ab2a0d-419d-555f-c124-2cfa1ecb2a81@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Jul 2020 08:22:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKg4CfGPxf-SzVevCaY0NU63oR+pqSqdV0aG+EaecGbvg@mail.gmail.com>
Message-ID: <CAL_JsqKg4CfGPxf-SzVevCaY0NU63oR+pqSqdV0aG+EaecGbvg@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] dt-bindings: arm-smmu: add binding for Tegra194 SMMU
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Krishna Reddy <vdumpa@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Yu-Huan Hsu <YHsu@nvidia.com>,
        Sachin Nikam <Snikam@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Bryan Huntsman <bhuntsman@nvidia.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 8:10 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-07-10 21:29, Krishna Reddy wrote:
> > Thanks Rob. One question on setting "minItems: ". Please see below.
> >
> >>> +allOf:
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            enum:
> >>> +              - nvidia,tegra194-smmu
> >>> +    then:
> >>> +      properties:
> >>> +        reg:
> >>> +          minItems: 2
> >>> +          maxItems: 2
> >
> >> This doesn't work. The main part of the schema already said there's only
> >> 1 reg region. This part is ANDed with that, not an override. You need to add an else clause with 'maxItems: 1' and change the base schema to
> >> {minItems: 1, maxItems: 2}.
> >
> > As the earlier version of base schema doesn't have "minItems: " set, should it be set to 0 for backward compatibility?  Or can it just be omitted setting in base schema as before?
>
> We've always needed at least 1 "reg" specifier in practice, so I don't
> think being backwards-compatible with broken DTs is a concern :)

'minItems: 0' would be a boolean (e.g. "reg;") and I'm not sure that's
even really valid json-schema. What you'd want here is 'reg' not
present (i.e. not in 'required').

Rob
