Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59219C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9152072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W+ulR6nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgFBSnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgFBSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:43:39 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3BDC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:43:38 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so13877331ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AyaUVVMDE+TUTFKilCRtJ50WF2xa5EmGs9v2imFUYZE=;
        b=W+ulR6nkqAsZTIpa1G4Pxucwbit4Oys2/blbskVzp8WkjQqfpqKDlaCFcVnCknocql
         va5Ciki+HmjDFygrDozP9yzV/CFlQcHVqBdRWzViY5I+doh2oJ1x+uwhYMD8GA1oUWFa
         Lj813cY7RL48tm96YBDZR8DOwlAvoVXxU0URTUPSErtHXw+7CPWh7MW3e9znMLt/zmR1
         YtwuDN0fC7M6JfUodoVjFWYbEDJjPhf+VHVJN1rBb6KgMaIMSq1/dqY8P5E7DOTSeYJI
         5fZyvPWgyCosKxTCmgmBbzWDMp49vrZJsil42rKpOSTzkxFX97TwShsTvr221Ez1oxce
         OeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyaUVVMDE+TUTFKilCRtJ50WF2xa5EmGs9v2imFUYZE=;
        b=j9iLUksFcM0ShKcIk3tbzcchol1mz8sjRQ5NeuwIxVxzlNRaWBzjw6voAXjL7CyuEZ
         S3pXk+lsZ356/gyCP4sq2vzWQwprQ8ZnYn0t9DizJoWEitU+p3ioDQEdzvJ8ACVLsxjq
         wfoGAUINB3UvRqL7aplclOm0ixBYhhjlY7RrCqSjs6jmbCtXMJlw/Mi8sbzrT1wrV8ww
         +d8lVm689OrtXz+JWxw/PwHL+RdDS43c07bUsZ8MMGMv0gRQXFQ/JvxtX/LazwdJEs/M
         0qz8MU0KHlnbCo/tb9C5S828FB7pNMUs56SLv3lsiIy88qdweATP6Xfm3N2Vn0aRNviy
         fAXQ==
X-Gm-Message-State: AOAM531GWS7ItrEPAv/lPW/7DO1+f5n5NXcLJPOvnn1fYWHk417hShQC
        0vhkK8Fu/RqVeGGkAQEuf6ZKjTT9TsnN7f3Fr9G3Xg==
X-Google-Smtp-Source: ABdhPJygZvF23AT13Ruz2zDD4PIpNqJqzwV0GCF3as2X5NxZvARlgoO9hEnCPZnjhpFU4xkEZMU98Ovh7KShzu88G+Q=
X-Received: by 2002:a2e:8944:: with SMTP id b4mr202192ljk.247.1591123416673;
 Tue, 02 Jun 2020 11:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200602054517.191244-1-rajatja@google.com> <20200602095003.GI247495@lahna.fi.intel.com>
In-Reply-To: <20200602095003.GI247495@lahna.fi.intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 2 Jun 2020 18:43:00 +0000
Message-ID: <CACK8Z6F2n6yx7Fs43rmUQko3PAHZYcnc_eyE_xPdUHXwf2hhLw@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: Don't apply gfx quirks to untrusted devices
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Alex Levin <levinale@google.com>,
        Zubin Mithra <zsm@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Todd Broch <tbroch@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi MIka,

Thanks for taking a look.

On Tue, Jun 2, 2020 at 2:50 AM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Mon, Jun 01, 2020 at 10:45:17PM -0700, Rajat Jain wrote:
> > Currently, an external malicious PCI device can masquerade the VID:PID
> > of faulty gfx devices, and thus apply iommu quirks to effectively
> > disable the IOMMU restrictions for itself.
> >
> > Thus we need to ensure that the device we are applying quirks to, is
> > indeed an internal trusted device.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> >  drivers/iommu/intel-iommu.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index ef0a5246700e5..f2a480168a02f 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -6214,6 +6214,11 @@ const struct iommu_ops intel_iommu_ops = {
> >
> >  static void quirk_iommu_igfx(struct pci_dev *dev)
> >  {
> > +     if (dev->untrusted) {
> > +             pci_warn(dev, "skipping iommu quirk for untrusted gfx dev\n");
>
> I think you should be consistent with other messages. For example iommu
> should be spelled IOMMU as done below.
>
> Also this is visible to users so maybe put bit more information there:
>
>   pci_warn(dev, "Will not apply IOMMU quirk for untrusted graphics device\n");
>
> Ditto for all the other places. Also is "untrusted" good word here? If
> an ordinary user sees this will it trigger some sort of panic reaction.
> Perhaps we should call it "potentially untrusted" or something like
> that?

Fixed it, posted new patch at
https://lkml.org/lkml/2020/6/2/822

Thanks,

Rajat

>
> > +             return;
> > +     }
> > +
> >       pci_info(dev, "Disabling IOMMU for graphics on this chipset\n");
> >       dmar_map_gfx = 0;
