Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B42CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5984F20757
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2C7Mgmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgFCAck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 20:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFCAcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 20:32:39 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C740DC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 17:32:39 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o8so474963pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 17:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qnzjt+g4cB//ahJdxLx9hz0hNZU/fqEnBmDtd0LYOjI=;
        b=a2C7MgmflNZhuX60tQc+uDBp8E6Awdh6dSwcT+NDEXWcaHr/WWC05JVeSUc7C7RsLJ
         hXQGv1iFTHu42sDAEMWcfgy1fqDYWGp+Feyl8E6t4/q7PBCVzhoeDOKBZaQDvmIkIbY5
         RwlHH0xf8NGNR1/oPvBwUt5llOgKsYTUrBFfWF4ZY2mFdyFM/i3fHCbJ2+GrJLVnMzKh
         wj+93IGgiwqCbuhdFulNMhR8rPmYpXJdPSH9YEOVrLqivLPmyO9PU18fdei+UcJQAT7h
         QBZyjY06AmQ1zHUTVToguV8ZZP+7/LF3YiCKKBP/+vkQ8HElOFTLtkHJBTTvTNH5H/zO
         e3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qnzjt+g4cB//ahJdxLx9hz0hNZU/fqEnBmDtd0LYOjI=;
        b=mBJGiOtlj5EWngRszTzqlYdMdpxmODQANsv2OcZ3wHu0jAROCWYi46uXpCmzZwbEgH
         tIS/l5Zp0niRRWyDlUtfHzq0L6o0ofj40z7MbP4VrWVkM2U7CCY0tDQ4OZb84v8dte2Y
         YSeZ9aQRqmJr1SrqUMCDSTFH1oStVdzxjOYwgMH4UBD4RArS+ZKi5V/itBBjLdfiU8yY
         CiOkMKKZ7d4GJtN7lPLOsIRuY1OvoP810+cm+Lai6OtP+5f/5FsFD5Ldi/wkT8MfvfLA
         IKRflfgOqVPFE+xi7oIVxkWCf3lxAwsrGvg1/5rRI/SuXGfmwcuBlte6eqmayC9zdzce
         7ztw==
X-Gm-Message-State: AOAM533w8Vk03XFRGZyzhQ8wCHs4h3n4Dsyl+qnx5wlZ613K/z+NVuDO
        8Gd7TAvESipbcdCc7T6qsNoiKQ==
X-Google-Smtp-Source: ABdhPJzxg/0H0QxEm2ZZRar4GgxFDicXkNmogMqShiKQwEu039y2YbeEh9yGYV9WF3rK2mwrh7WFwQ==
X-Received: by 2002:a63:1a01:: with SMTP id a1mr24703646pga.87.1591144358699;
        Tue, 02 Jun 2020 17:32:38 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id y10sm138263pgi.54.2020.06.02.17.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 17:32:37 -0700 (PDT)
Date:   Tue, 2 Jun 2020 17:32:32 -0700
From:   Prashant Malani <pmalani@google.com>
To:     Rajat Jain <rajatxjain@gmail.com>
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
Subject: Re: [PATCH v3] iommu/vt-d: Don't apply gfx quirks to untrusted
 devices
Message-ID: <20200603003232.GC109930@google.com>
References: <20200602232602.156049-1-rajatja@google.com>
 <20200602234912.GB109930@google.com>
 <CAA93t1r9Kg0OFwoOhNUKYeSbZrFgu5k_eexer34msjsLBNohcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA93t1r9Kg0OFwoOhNUKYeSbZrFgu5k_eexer34msjsLBNohcg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Trimming text)

On Wed, Jun 03, 2020 at 12:23:48AM +0000, Rajat Jain wrote:
> On Tue, Jun 2, 2020 at 4:49 PM Prashant Malani <pmalani@google.com> wrote:
> >
> > Hi Rajat,
> 
> Hi Prashant, thanks for taking a look.
> 
> >
> > On Tue, Jun 02, 2020 at 04:26:02PM -0700, Rajat Jain wrote:
> > > +static bool risky_device(struct pci_dev *pdev)
> > > +{
> > > +     if (pdev->untrusted) {
> > > +             pci_warn(pdev,
> > > +                      "Skipping IOMMU quirk for dev (%04X:%04X) on untrusted"
> > > +                      " PCI link. Please check with your BIOS/Platform"
> > > +                      " vendor about this\n", pdev->vendor, pdev->device);
> > > +             return true;
> > > +     }
> > > +     return false;
> > minor suggestion: Perhaps you could use a guard clause here? It would save you
> > a level of indentation, and possibly allow better string splitting
> > (e.g keeping "untrusted PCI" together). So something like:
> >
> > if (!pdev->untrusted)
> >         return false;
> 
> I personally have found double negation expressions always confusing,
> even if negation is part of the variable. (For e.g. I have found I
> need to be always stop and convince myself that:
> 
> "if (!pdev->untrusted)"
>     <do something>
> 
> conceptually implies
> 
> "if (pdev->trusted)".
>     <do something>
> 
> So I tend to keep negations to minimum. In this case, it doesn't buy
> us much either, so I'd prefer to keep it the same unless there are
> more opinions on this. OTOH I don't mind changing it too if you feel
> strongly about this.

Ordinarily, I'd agree with you regarding double-negatives.

However, in this case the condition phrasing is so brief ("not untrusted") that I'd
argue the indentation savings outweigh possible interpretation issues.

That said, I don't have a strong opinion here, so will defer to the maintainer's preference.

Best,

> 
> Thanks,
> 
> Rajat
> 
> 
> >
> > pci_warn(...);
> >
> > I also hear the column limit warning is now for 100 chars [1], though
> > I'm not sure how it's being handled in this file.
> >
> > Best regards,
> >
> > -Prashant
> >
> > [1]:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/Documentation/process/coding-style.rst?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144
> >
> > > +}
> > > +
> > >  const struct iommu_ops intel_iommu_ops = {
> > >       .capable                = intel_iommu_capable,
> > >       .domain_alloc           = intel_iommu_domain_alloc,
> > > @@ -6214,6 +6231,9 @@ const struct iommu_ops intel_iommu_ops = {
> > >
> > >  static void quirk_iommu_igfx(struct pci_dev *dev)
> > >  {
> > > +     if (risky_device(dev))
> > > +             return;
> > > +
> > >       pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
> > >       dmar_map_gfx = 0;
> > >  }
> > > @@ -6255,6 +6275,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
> > >
> > >  static void quirk_iommu_rwbf(struct pci_dev *dev)
> > >  {
> > > +     if (risky_device(dev))
> > > +             return;
> > > +
> > >       /*
> > >        * Mobile 4 Series Chipset neglects to set RWBF capability,
> > >        * but needs it. Same seems to hold for the desktop versions.
> > > @@ -6285,6 +6308,9 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
> > >  {
> > >       unsigned short ggc;
> > >
> > > +     if (risky_device(dev))
> > > +             return;
> > > +
> > >       if (pci_read_config_word(dev, GGC, &ggc))
> > >               return;
> > >
> > > @@ -6318,6 +6344,12 @@ static void __init check_tylersburg_isoch(void)
> > >       pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3a3e, NULL);
> > >       if (!pdev)
> > >               return;
> > > +
> > > +     if (risky_device(pdev)) {
> > > +             pci_dev_put(pdev);
> > > +             return;
> > > +     }
> > > +
> > >       pci_dev_put(pdev);
> > >
> > >       /* System Management Registers. Might be hidden, in which case
> > > @@ -6327,6 +6359,11 @@ static void __init check_tylersburg_isoch(void)
> > >       if (!pdev)
> > >               return;
> > >
> > > +     if (risky_device(pdev)) {
> > > +             pci_dev_put(pdev);
> > > +             return;
> > > +     }
> > > +
> > >       if (pci_read_config_dword(pdev, 0x188, &vtisochctrl)) {
> > >               pci_dev_put(pdev);
> > >               return;
> > > --
> > > 2.27.0.rc2.251.g90737beb825-goog
> > >
