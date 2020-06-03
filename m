Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DB6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84F7206A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/fgY/fE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgFCAYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 20:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFCAYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 20:24:01 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72986C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 17:24:01 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s1so431200qkf.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 17:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=tZ3XoT2xZEfNC/AyFq+/Ka38eQvJGuuJWEZPW0Bc1GQ=;
        b=r/fgY/fEN630qOz7tef3jP0wsTmP7VW9PQlghEmZ5ZjwA6aIuNCq1jSQVfkWqdt2KL
         EVD5jYxo3g/VLqi6lZJ7zEV/FfQCHKANvkAfNuhl9b41bNHsn0sBk3ObnMcoAF/2+MVQ
         IHF0CZ2w8OU0OyblT1lTbEi8I8iwyzPf9UcJ5BZQoopoqV12O3z6jAqassTQcINkkoZ2
         mhpPYvysJ/pc1IdvztL9JKpaqh6+9KrkunVEneZajqHxg6L4JAIDdMlabuPk5V6G3u75
         jRJkr9ncf9yifmI6Ifezn30CS77Sa7FSGrewqNhrQPFp6nuQCARPMZT9cGiOn+0AXiwi
         5QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=tZ3XoT2xZEfNC/AyFq+/Ka38eQvJGuuJWEZPW0Bc1GQ=;
        b=aHZ66exbPCWLcjZP2u8BbABmyojmO4txQvVxELc1/RbO28KtZvw1fIzvTOCVoYD+K9
         gipnPIumsr/e7eXXiLfRG589BNz585nY4HhkqMPqwTdL/vHS06Ba83ODuLWMjn00E+/+
         ezTpQ2orQSfgPhA9TPHx/Js5XtRVfIFgC6KuCOnJNL92Pyqy1Lb3WPCP5j+YhFWelOab
         zuD+AlLcqKuCBbEcgDdsmA79CcYvkD5y9pJj3ok1h5kuzjRw//OJzCI3uf7mxACMBQut
         tlKmAmTsNXZlVuccetOJ47CCCriGnWEXs6dtGQqpH45CDSaFDue0XpsbOpDdpyXB0pw9
         uTNQ==
X-Gm-Message-State: AOAM5328SlRyxPMoUdbMejTio1aWefbYCLepZsxKu7suiI8J9HYCkrt/
        zJLMud6L1lqqdMt5dhux6AuCCJTmYFuw95XRflE=
X-Google-Smtp-Source: ABdhPJxhgWrAxoxmggeI37q37/oufdA5eHmyBGt01gEpS0l3vBe9PkELJWGN1xflvShE44Xu/jqwhzIBtJcccPNQpXE=
X-Received: by 2002:ae9:ebd2:: with SMTP id b201mr21530740qkg.409.1591143840271;
 Tue, 02 Jun 2020 17:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200602232602.156049-1-rajatja@google.com> <20200602234912.GB109930@google.com>
In-Reply-To: <20200602234912.GB109930@google.com>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Wed, 3 Jun 2020 00:23:48 +0000
Message-ID: <CAA93t1r9Kg0OFwoOhNUKYeSbZrFgu5k_eexer34msjsLBNohcg@mail.gmail.com>
Subject: Re: [PATCH v3] iommu/vt-d: Don't apply gfx quirks to untrusted devices
To:     Prashant Malani <pmalani@google.com>
Cc:     Rajat Jain <rajatja@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com, bleung@google.com,
        levinale@google.com, zsm@google.com, mnissler@google.com,
        tbroch@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 4:49 PM Prashant Malani <pmalani@google.com> wrote:
>
> Hi Rajat,

Hi Prashant, thanks for taking a look.

>
> On Tue, Jun 02, 2020 at 04:26:02PM -0700, Rajat Jain wrote:
> > Currently, an external malicious PCI device can masquerade the VID:PID
> > of faulty gfx devices, and thus apply iommu quirks to effectively
> > disable the IOMMU restrictions for itself.
> >
> > Thus we need to ensure that the device we are applying quirks to, is
> > indeed an internal trusted device.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> > v3: - Separate out the warning mesage in a function to be called from
> >       other places. Change the warning string as suggested.
> > v2: - Change the warning print strings.
> >     - Add Lu Baolu's acknowledgement.
> >
> >  drivers/iommu/intel-iommu.c | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index ef0a5246700e5..dc859f02985a0 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -6185,6 +6185,23 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
> >       return ret;
> >  }
> >
> > +/*
> > + * Check that the device does not live on an external facing PCI port that is
> > + * marked as untrusted. Such devices should not be able to apply quirks and
> > + * thus not be able to bypass the IOMMU restrictions.
> > + */
> > +static bool risky_device(struct pci_dev *pdev)
> > +{
> > +     if (pdev->untrusted) {
> > +             pci_warn(pdev,
> > +                      "Skipping IOMMU quirk for dev (%04X:%04X) on untrusted"
> > +                      " PCI link. Please check with your BIOS/Platform"
> > +                      " vendor about this\n", pdev->vendor, pdev->device);
> > +             return true;
> > +     }
> > +     return false;
> minor suggestion: Perhaps you could use a guard clause here? It would save you
> a level of indentation, and possibly allow better string splitting
> (e.g keeping "untrusted PCI" together). So something like:
>
> if (!pdev->untrusted)
>         return false;

I personally have found double negation expressions always confusing,
even if negation is part of the variable. (For e.g. I have found I
need to be always stop and convince myself that:

"if (!pdev->untrusted)"
    <do something>

conceptually implies

"if (pdev->trusted)".
    <do something>

So I tend to keep negations to minimum. In this case, it doesn't buy
us much either, so I'd prefer to keep it the same unless there are
more opinions on this. OTOH I don't mind changing it too if you feel
strongly about this.

Thanks,

Rajat


>
> pci_warn(...);
>
> I also hear the column limit warning is now for 100 chars [1], though
> I'm not sure how it's being handled in this file.
>
> Best regards,
>
> -Prashant
>
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/Documentation/process/coding-style.rst?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144
>
> > +}
> > +
> >  const struct iommu_ops intel_iommu_ops = {
> >       .capable                = intel_iommu_capable,
> >       .domain_alloc           = intel_iommu_domain_alloc,
> > @@ -6214,6 +6231,9 @@ const struct iommu_ops intel_iommu_ops = {
> >
> >  static void quirk_iommu_igfx(struct pci_dev *dev)
> >  {
> > +     if (risky_device(dev))
> > +             return;
> > +
> >       pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
> >       dmar_map_gfx = 0;
> >  }
> > @@ -6255,6 +6275,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
> >
> >  static void quirk_iommu_rwbf(struct pci_dev *dev)
> >  {
> > +     if (risky_device(dev))
> > +             return;
> > +
> >       /*
> >        * Mobile 4 Series Chipset neglects to set RWBF capability,
> >        * but needs it. Same seems to hold for the desktop versions.
> > @@ -6285,6 +6308,9 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
> >  {
> >       unsigned short ggc;
> >
> > +     if (risky_device(dev))
> > +             return;
> > +
> >       if (pci_read_config_word(dev, GGC, &ggc))
> >               return;
> >
> > @@ -6318,6 +6344,12 @@ static void __init check_tylersburg_isoch(void)
> >       pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3a3e, NULL);
> >       if (!pdev)
> >               return;
> > +
> > +     if (risky_device(pdev)) {
> > +             pci_dev_put(pdev);
> > +             return;
> > +     }
> > +
> >       pci_dev_put(pdev);
> >
> >       /* System Management Registers. Might be hidden, in which case
> > @@ -6327,6 +6359,11 @@ static void __init check_tylersburg_isoch(void)
> >       if (!pdev)
> >               return;
> >
> > +     if (risky_device(pdev)) {
> > +             pci_dev_put(pdev);
> > +             return;
> > +     }
> > +
> >       if (pci_read_config_dword(pdev, 0x188, &vtisochctrl)) {
> >               pci_dev_put(pdev);
> >               return;
> > --
> > 2.27.0.rc2.251.g90737beb825-goog
> >
