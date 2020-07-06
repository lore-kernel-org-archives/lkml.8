Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BCEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E746920720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQJyuwzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgGFXUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGFXUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:20:09 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD080C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 16:20:08 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id s16so18199102lfp.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 16:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S3X9p3/Tcr/ntGdk7/sKAQe/cqkFM9AS9Ft6l97WEKQ=;
        b=uQJyuwzhr1LE9Kuu0uj364VAAz32Bh7MBlXiEDIQ/nUXcVpCy46dFU+hOB7IQ1k/ZN
         bJgvUcwxMNHu4LDAb+vAaKgiG7GYiIy67zI1i2MUI3EvXO84kY8FEEPUVp/hvHeiNL6c
         ZygjdlEC+YziNf4Q/RlhItGSwpgUrrWRKO5Co76LjKMxg7su1J6iFs06TCzAmeHEY/Jk
         ceUn6JagX5snL/WJLnKUWPPc4WHeRKiN6R6mT6oQ1sbMsRTT6O2cGqrkOashlprvdlRo
         eyPIPw8Vy/Ewj162V27wNRLki/xnrojkju/PLxmHEJ6Ji+8AscOEXddWLC6XeyOL1qct
         3PQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S3X9p3/Tcr/ntGdk7/sKAQe/cqkFM9AS9Ft6l97WEKQ=;
        b=HrSbfnb39i3sRhciJ3k3t7zyn+sbeTFbvaQ8vKaUIFq8+h1H+H51n20cqTpgiDGcTA
         JsBJ7+qvUO8OG7f7BwBZ/c9rssEPLiyV0SIEpV4Y48NhqL3FzmgITrFQFj4B/iZNpYTB
         1HhC26jUZ2Zsb6+0Ix82WRmJEhLuLpmDl8CIDa7NFAYooRivoFVinLDvN6FMzHt4RMVV
         xMdLov/hE2Ii633ks9POecSuPm4IqQLbhxGmYHUN8XWrhE+/FC6/Z9C/CHdXvkIopsK6
         LKqvRdKevfU79ZRhKSkvi0kfVn9YzdrJ03WcLQBHaTsjb487QYOym5OwIKgO60fK32rl
         n/Jg==
X-Gm-Message-State: AOAM532rLezxe3EN/Ceexq8KF1GnzWOYFcR/vjK1YrrJ0qaJm1LWvm4j
        2JtA0QY0QOHlfU3HbY6fadWz5yINfdIiTxNcCdAzPA==
X-Google-Smtp-Source: ABdhPJxhlrks5dTrFpXpr6UWodktRTBMegtu4j0YZwtWWhGamKlzpsn99s1KAheWtq3vN90rWaEkmGqPB/S4gzc6C0Y=
X-Received: by 2002:a19:ca11:: with SMTP id a17mr31096448lfg.120.1594077606885;
 Mon, 06 Jul 2020 16:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-4-rajatja@google.com> <20200706170736.GA125844@bjorn-Precision-5520>
In-Reply-To: <20200706170736.GA125844@bjorn-Precision-5520>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 6 Jul 2020 16:19:30 -0700
Message-ID: <CACK8Z6H-8SAmGPFAwQjiJFQyH0S6h5EGyzSNpnrdhsu2UhpFjg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] PCI/ACS: Enable PCI_ACS_TB for untrusted/external-facing
 devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
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
        "Oliver O'Halloran" <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 10:07 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Jun 29, 2020 at 09:49:39PM -0700, Rajat Jain wrote:
> > When enabling ACS, enable translation blocking for external facing ports
> > and untrusted devices.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v2: Commit log change
> >
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
>
> Nit: Reorder these as in c8de8ed2dcaa ("PCI: Make ACS quirk
> implementations more uniform") so they match other similar lists in
> the code.

Will do.

>
> But more to the point: we have a bunch of other quirks for devices
> that do not have an ACS capability but *do* provide some ACS-like
> features.  Most of them support
>
>   PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF
>
> because that's what we usually want.  But I bet some of them also
> actually provide the equivalent of PCI_ACS_TB.
>
> REQ_ACS_FLAGS doesn't include PCI_ACS_TB.  Is there anything we need
> to do on the pci_acs_enabled() side to check for PCI_ACS_TB, and
> consequently, to update any of the quirks for devices that provide it?

I'm actually not sure.
+Alex Williamson , do you have any comments here?

Thanks,

Rajat

>
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
> > 2.27.0.212.ge8ba1cc988-goog
> >
