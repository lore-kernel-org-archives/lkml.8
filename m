Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E682BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4BD2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDLwChJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbgFVXCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731406AbgFVXCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:02:14 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57700C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 16:02:13 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m26so10590975lfo.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 16:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ecq4FS9wELzuVh2aNsJmKpLPD9PbAHLuJOkUzY8Xxes=;
        b=CDLwChJW595HajdiJojE/+eW1r1r4swlZKiMJEBB/xgJUPsRe7eatKhRtaAggFj9bD
         7SzxCuD4enZovjYeo6u5UKDTYtZFs1omXlP2i+IVjYWh2nOQGvAi5LMciy5upiypKr7f
         6bDx5tB2jaerpTT/GcWq7hUccgf2L0SGDaRwyd7yQUj89bOAQNLhWjsjc5Qjs342fZc/
         bIgLxa6HcvwPEPhx8OlcMZ5e1H7GcWzrjte7ozSnnSwPsbx68QHWcfWv8QUnQ60N7/iJ
         8KFigh54NcYqABzqIEhNuYZAOZowoa/IpyLCdxifXX1tDDo3gS8+ZXm5JFFXy74iFeV/
         v/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ecq4FS9wELzuVh2aNsJmKpLPD9PbAHLuJOkUzY8Xxes=;
        b=tgpWi2bFjBvSTauTdV75orERM8/SroxChqGreGd/DJ3tUWlFlGh63uYJv7YxFr+lRP
         jRlF11pzqmj2ejS17kotxJ0b31vTn7C/Zbu9uQ56fnPhrOL9vg+o9AVx87YRe4g49ynN
         fh84qFRQ00UeAt30s+j3MVZoXtMKJyOvaFZlVitizIMnvEY4pAVE08JYBi4/napwNHE7
         SWqBrtoVmb3wijd2SkjjW0fNiAYGtp8+J+qvv4RCK9+yBsB7vPrAtQHHiwfeDWnRNEGW
         jK3AyDbZiKO+a1Yjxlht+xa+pouXt9z9SkmOo0xRZSH5xATHzKqJaozsczrdTnYQFZ/m
         TzhQ==
X-Gm-Message-State: AOAM5323tHzgkihrTl8ebrxe+7hHgPcnOy+2k9yTm+PPISx1f3H2be3h
        xEreNYDPB/Y5fnbRc33HTJ48T5x1thT47mOENOLBfqL1
X-Google-Smtp-Source: ABdhPJzpXmJeWyudmGnFcSJwgw8D3FpyMLH8rnnQyE9NCv3nyMOzGL3CkYp5ze+ga7o74BuYJeUW/t+chDaZtbSGJBY=
X-Received: by 2002:ac2:5467:: with SMTP id e7mr10346942lfn.122.1592866931554;
 Mon, 22 Jun 2020 16:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200616011742.138975-1-rajatja@google.com> <20200616011742.138975-3-rajatja@google.com>
 <20200619161009.GH42799@otc-nc-03>
In-Reply-To: <20200619161009.GH42799@otc-nc-03>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 22 Jun 2020 16:01:34 -0700
Message-ID: <CACK8Z6FZ560vfMYH8idaea31_9dq4Vvo7LiMASnxZKZJtX89wg@mail.gmail.com>
Subject: Re: [PATCH 3/4] pci: acs: Enable PCI_ACS_TB for untrusted/external-facing
 devices
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Oliver O'Halloran" <oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ashok,

On Fri, Jun 19, 2020 at 9:10 AM Raj, Ashok <ashok.raj@intel.com> wrote:
>
> Hi Rajat
>
>
> On Mon, Jun 15, 2020 at 06:17:41PM -0700, Rajat Jain wrote:
> > When enabling ACS, currently the bit "translation blocking" was
> > not getting changed at all. Set it to disable translation blocking
>
> Maybe you meant "enable translation blocking" ?

Oops, yes.

>
> Keep the commit log simple:
>
> When enabling ACS, enable translation blocking for external facing ports
> and untrusted devices.

Ack. Will change in the next iteration (currently waiting to see if
there are any more comments).

Thanks & Regards,

Rajat

>
> > too for all external facing or untrusted devices. This is OK
> > because ATS is only allowed on internal devces.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> >  drivers/pci/pci.c    |  4 ++++
> >  drivers/pci/quirks.c | 11 +++++++++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index d2ff987585855..79853b52658a2 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3330,6 +3330,10 @@ static void pci_std_enable_acs(struct pci_dev *dev)
> >       /* Upstream Forwarding */
> >       ctrl |= (cap & PCI_ACS_UF);
> >
> > +     if (dev->external_facing || dev->untrusted)
> > +             /* Translation Blocking */
> > +             ctrl |= (cap & PCI_ACS_TB);
> > +
> >       pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> >  }
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index b341628e47527..6294adeac4049 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4934,6 +4934,13 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
> >       }
> >  }
> >
> > +/*
> > + * Currently this quirk does the equivalent of
> > + * PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV
> > + *
> > + * Currently missing, it also needs to do equivalent of PCI_ACS_TB,
> > + * if dev->external_facing || dev->untrusted
> > + */
> >  static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
> >  {
> >       if (!pci_quirk_intel_pch_acs_match(dev))
> > @@ -4973,6 +4980,10 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
> >       ctrl |= (cap & PCI_ACS_CR);
> >       ctrl |= (cap & PCI_ACS_UF);
> >
> > +     if (dev->external_facing || dev->untrusted)
> > +             /* Translation Blocking */
> > +             ctrl |= (cap & PCI_ACS_TB);
> > +
> >       pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
> >
> >       pci_info(dev, "Intel SPT PCH root port ACS workaround enabled\n");
> > --
> > 2.27.0.290.gba653c62da-goog
> >
