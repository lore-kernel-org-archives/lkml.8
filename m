Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D51C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FEFD20DD4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594676176;
	bh=XD73av0foN3wtcechTFS9LgVumy/F3/NlTWm0Dxtkqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VWplQVbghJeSEM3X8a2GwsSajxR8KODfH9jAzDO6kvLGmdIGmkBkr59F2076K85yA
	 l72NgLlCJV9edvRDfvzoQjPc2yMbsed7os0O8EGAr2RlThsIKlZhmXTQWvK9ftf5Zm
	 yEuUUDhYumwh1J0lY3cfEH7OUjkkIK/L5a5FssKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgGMVgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:36:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34745 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgGMVgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 17:36:08 -0400
Received: by mail-io1-f67.google.com with SMTP id q74so15174456iod.1;
        Mon, 13 Jul 2020 14:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ds31A3g/zm7RWz12Mdt2xEVw3TUuXdV7t8TgREVUS5k=;
        b=qVge8KVvAM6QAy5d5o3+KwDY3lnpJ6p/zSIJw+ag0cEZwur0Xg7mGDuIyBoQ6UYcDj
         FqEuMev3blcgS4S4s3c04sbC5DlzjshkGqkNiVxd1SJ4/0HI2vqXv9XcMEqDGCqHw+no
         jat3IiCL95DiFwxlOWyTYEUyAUQHtfPqt+ssrSGUleVyPTvDtX33IK4F1izdshVoV2Pe
         X/XpJGLZyZ894R4KEwBaYAaRSNqHmnKRc2hMlrKCkYT0LSkRam3Cj9B4cBQLL/UnKzWg
         1sFw/RGxPKsvXOU6RdZs0S4kqUQFA4Nsug/IK3KpHV2fVocLU+ypru8ZV79lmJNPa1rm
         v9Ow==
X-Gm-Message-State: AOAM531x0MxAxzmLgYXqHQV6iQt1M4i8BUyNtjVBZdZoktJuFRlzZqjt
        4WubjDoWu4ZCM7cY9ArGVA==
X-Google-Smtp-Source: ABdhPJzIjXhyFFB2gzub0W2jM/rvGAFEwl9LO8mdLyLFlXaE/U0x+bzAY8WF8WzxMPhaHpWDEwsegA==
X-Received: by 2002:a02:10c1:: with SMTP id 184mr2288036jay.135.1594676167287;
        Mon, 13 Jul 2020 14:36:07 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id x19sm1372922ioh.38.2020.07.13.14.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 14:36:06 -0700 (PDT)
Received: (nullmailer pid 769509 invoked by uid 1000);
        Mon, 13 Jul 2020 21:36:05 -0000
Date:   Mon, 13 Jul 2020 15:36:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomasz Nowicki <tn@semihalf.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        joro@8bytes.org, gregory.clement@bootlin.com, hannah@marvell.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        nadavh@marvell.com, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com
Subject: Re: [PATCH v3 3/4] dt-bindings: arm-smmu: add compatible string for
 Marvell Armada-AP806 SMMU-500
Message-ID: <20200713213605.GA766184@bogus>
References: <20200702201633.22693-1-tn@semihalf.com>
 <20200702201633.22693-4-tn@semihalf.com>
 <3172ec21-d773-7fcb-f1ee-f557f72f20c5@arm.com>
 <972f5cbd-705b-e18a-7477-5f6922804361@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <972f5cbd-705b-e18a-7477-5f6922804361@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 11:26:32AM +0200, Tomasz Nowicki wrote:
> On 03.07.2020 11:05, Robin Murphy wrote:
> > On 2020-07-02 21:16, Tomasz Nowicki wrote:
> > > Add specific compatible string for Marvell usage due to errata of
> > > accessing 64bits registers of ARM SMMU, in AP806.
> > > 
> > > AP806 SoC uses the generic ARM-MMU500, and there's no specific
> > > implementation of Marvell, this compatible is used for errata only.
> > > 
> > > Signed-off-by: Hanna Hawa <hannah@marvell.com>
> > > Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> > > Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> > > ---
> > >   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > index d7ceb4c34423..7beca9c00b12 100644
> > > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > @@ -38,6 +38,11 @@ properties:
> > >                 - qcom,sc7180-smmu-500
> > >                 - qcom,sdm845-smmu-500
> > >             - const: arm,mmu-500
> > > +      - description: Marvell SoCs implementing "arm,mmu-500"
> > > +        items:
> > > +          - enum:
> > > +              - marvell,ap806-smmu-500
> > 
> > Isn't a single-valued enum just a constant? :P
> 
> That's how copy-paste engineering ends up :)

It's fine like this if you expect more SoCs to be added.

Either way,

Reviewed-by: Rob Herring <robh@kernel.org>
