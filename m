Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D595C35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 00:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C09120848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 00:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgBLAju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 19:39:50 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35084 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgBLAju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 19:39:50 -0500
Received: by mail-oi1-f196.google.com with SMTP id b18so376400oie.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 16:39:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noQt5nFC8uX1+KZFclIWhAR/XrOfOL5Ao8eiHvlk32o=;
        b=otrH4XCIh3Edq9Jc//pxNzlFj0DQiKb94jW7Hh3lSXk8YTEq7Y7Mz/4WeKg7r02xCp
         PDjGsNbBIchbjamZfN1rU/8qdn3QEDMOYWeTI/bcJsBa98wP2x+2c4gS6Q8riAnW5PIQ
         IoaLcnFp3dNMFoE5KU4sn8K2fgGDhnEwKfO4QnUdF6ljXYC30pvRItCtJMRwvq45zMZw
         NQBBHVJeolb4s8UKpf7UYApewAtRkDIWrMKs6CdAFZff8DSx44SFvfAuYvCNdKYluEO7
         phVjQOtHLne5+RwycMdrWSAtHcGPH6kQUFnSFyxPdq06x+IWLjwStzXizuzQEM5XgAOJ
         HEhQ==
X-Gm-Message-State: APjAAAXrhvijXUZnbJlIKySSXcMOASsSOojytCr2ziFmNkJwVwNTg/cK
        pylpAwMd1JvyJK/FknJsdKrPmQL6
X-Google-Smtp-Source: APXvYqwPVSjzVUuGem5RHulIv0mTWGHEZAF6YCehXzhtfsEhGT1gTAPI9zJ3+haryA135DW0iFsDdA==
X-Received: by 2002:aca:4306:: with SMTP id q6mr4641138oia.54.1581467989321;
        Tue, 11 Feb 2020 16:39:49 -0800 (PST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id w201sm1644760oif.29.2020.02.11.16.39.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 16:39:48 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id j16so230336otl.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 16:39:48 -0800 (PST)
X-Received: by 2002:a9d:7f83:: with SMTP id t3mr3624739otp.63.1581467988518;
 Tue, 11 Feb 2020 16:39:48 -0800 (PST)
MIME-Version: 1.0
References: <1581464215-24777-1-git-send-email-leoyang.li@nxp.com> <20200211234536.GK25745@shell.armlinux.org.uk>
In-Reply-To: <20200211234536.GK25745@shell.armlinux.org.uk>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 11 Feb 2020 18:39:37 -0600
X-Gmail-Original-Message-ID: <CADRPPNSOYOe3vuUFEp3z-1RX6QHmRFJpxHTCLhniX-0hh2T01Q@mail.gmail.com>
Message-ID: <CADRPPNSOYOe3vuUFEp3z-1RX6QHmRFJpxHTCLhniX-0hh2T01Q@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: fix the module name for disable_bypass parameter
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 5:47 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Feb 11, 2020 at 05:36:55PM -0600, Li Yang wrote:
> > Since commit cd221bd24ff5 ("iommu/arm-smmu: Allow building as a module"),
> > there is a side effect that the module name is changed from arm-smmu to
> > arm-smmu-mod.  So the kernel parameter for disable_bypass need to be
> > changed too.  Fix the Kconfig help and error message to the correct
> > parameter name.
>
> Hmm, this seems to be a user-visible change - so those of us who have
> been booting with "arm-smmu.disable_bypass=0" now need to change that
> depending on which kernel is being booted - which is not nice, and
> makes the support side on platforms that need this kernel parameter
> harder.

I have sent a new patch replacing this patch.  That patch will keep
the command line unchanged.

>
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > ---
> >  drivers/iommu/Kconfig    | 2 +-
> >  drivers/iommu/arm-smmu.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index d2fade984999..fb54be903c60 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -415,7 +415,7 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
> >         hardcode the bypass disable in the code.
> >
> >         NOTE: the kernel command line parameter
> > -       'arm-smmu.disable_bypass' will continue to override this
> > +       'arm-smmu-mod.disable_bypass' will continue to override this
> >         config.
> >
> >  config ARM_SMMU_V3
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 16c4b87af42b..2ffe8ff04393 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -512,7 +512,7 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
> >               if (IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT) &&
> >                   (gfsr & ARM_SMMU_sGFSR_USF))
> >                       dev_err(smmu->dev,
> > -                             "Blocked unknown Stream ID 0x%hx; boot with \"arm-smmu.disable_bypass=0\" to allow, but this may have security implications\n",
> > +                             "Blocked unknown Stream ID 0x%hx; boot with \"arm-smmu-mod.disable_bypass=0\" to allow, but this may have security implications\n",
> >                               (u16)gfsynr1);
> >               else
> >                       dev_err(smmu->dev,
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
