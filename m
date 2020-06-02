Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553F3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30263205CB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNfJ7i15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgFBOkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgFBOj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:39:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C03C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 07:39:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so3691902wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 07:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FUYPo8fB6BaXWbeo8MJfYdpZveOhkfTpvMXfShXVl2U=;
        b=UNfJ7i15I+Y/LzEU4j8lQ7MgEBaWKP0vWG7JdIILtTvy5ReIgcx3InYMMZKjAOiqRV
         FcbghXOQN1BXoMHzAAB9FppHnhkd3NUND2KjB4TmF0je+uTY/SnWRtw7C1eB/MwD4Czk
         j26LgN3HFBAmyNGdGLspNBYQJhzlbf1WT9KsDPiIsQ//AAjPp+qiUHRxyTmAZGzWTv4R
         z9phdzRtSzavTj32z+H8tzuSSllOEaueh8p7bjM4PHVJHQCRLcAGHnBE1Dn0JG/4yxus
         yBvViXAEfvsuuvU0Fcze8Q6tH3wXa4m+7bWejd+BOfiXtVtCAbE4ar5oMGiyRJxaLcDJ
         U/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FUYPo8fB6BaXWbeo8MJfYdpZveOhkfTpvMXfShXVl2U=;
        b=rsOwk+Fa4ZMzXa9dk0V/MSMe4riZAMc6TzPGZfgF+WflZp9KCiA5fHWP7r5aEaaltx
         o0PlZ3ByCph6CLYaddaMmDrATigGqP5nGKNx5LIWCUdKRsZalN3oN9vupMI+3vosBOqW
         +K03IgWTFCWDRKuBF045lY1doNNSZFTt2k7wXBXh3K9KF6Q4+o0iZRaq6M7zr515cr/a
         va5s0ViXwRWq1hKWiYBu4Q3Fizo13taQIn4Q93YJDacqf320jgO/r395CFcVHOC9webZ
         +BPjm+OAqCjuskrS9lLuksVbVDB7QAsvjPojG6bhJN/Liwi9yRax0m5hMw09nrc0IQo8
         qQYg==
X-Gm-Message-State: AOAM533Tg/8kAzeIkXK89JmBQaLurgVlHhHUAUiswBTHdVd1iqY0+4k1
        8ZvUdrD6WlTligcF5NZNwp6D8rhhJYWGH2RDFLw=
X-Google-Smtp-Source: ABdhPJwrjdBmlreZah9W7r9r21z3nSN/KOpVsiV4cBN3K6kvpACwdA9Zl067g+t1tRAigKtydZQnx9ZgBZwfjYr/bzI=
X-Received: by 2002:adf:fd41:: with SMTP id h1mr27830873wrs.374.1591108798154;
 Tue, 02 Jun 2020 07:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200602092030.31966-1-piotr.stankiewicz@intel.com>
 <14063C7AD467DE4B82DEDB5C278E8663010E23E538@FMSMSX108.amr.corp.intel.com>
 <CAHp75Vfe5dQkOiFoAZx5b-NS1afiD-YC_w+5LcX8P1Hm0ASenA@mail.gmail.com>
 <CADnq5_OO=gyo22ZrXp6pDtz2QZ2=LC429u_kkd0ZvX4=M3mBPw@mail.gmail.com> <CAHp75Vd1zVt7F2+44EFPHOrCOzexe=mLaiZixqJR9NNK9-wNQg@mail.gmail.com>
In-Reply-To: <CAHp75Vd1zVt7F2+44EFPHOrCOzexe=mLaiZixqJR9NNK9-wNQg@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 2 Jun 2020 10:39:47 -0400
Message-ID: <CADnq5_Mcys8tF-UAZ1JrLy1HnL-Ms7TTrLBPrWkA08tuhjkB2A@mail.gmail.com>
Subject: Re: [PATCH 07/15] drm/amdgpu: use PCI_IRQ_MSI_TYPES where appropriate
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tom St Denis <tom.stdenis@amd.com>
Cc:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Stankiewicz, Piotr" <piotr.stankiewicz@intel.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 10:35 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jun 2, 2020 at 5:21 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> > On Tue, Jun 2, 2020 at 10:00 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Jun 2, 2020 at 4:38 PM Ruhl, Michael J <michael.j.ruhl@intel.com> wrote:
> > > > >From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
> > > > >Piotr Stankiewicz
>
> > > > >               int nvec = pci_msix_vec_count(adev->pdev);
> > > > >               unsigned int flags;
> > > > >
> > > > >-              if (nvec <= 0) {
> > > > >+              if (nvec > 0)
> > > > >+                      flags = PCI_IRQ_MSI_TYPES;
> > > > >+              else
> > > > >                       flags = PCI_IRQ_MSI;
> > > > >-              } else {
> > > > >-                      flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
> > > > >-              }
> > > >
> > > > Minor nit:
> > > >
> > > > Is it really necessary to set do this check?  Can flags just
> > > > be set?
> > > >
> > > > I.e.:
> > > >         flags = PCI_IRQ_MSI_TYPES;
> > > >
> > > > pci_alloc_irq_vector() tries stuff in order.  If MSIX is not available,
> > > > it will try MSI.
> > >
> > > That's also what I proposed earlier. But I suggested as well to wait
> > > for AMD people to confirm that neither pci_msix_vec_count() nor flags
> > > is needed and we can directly supply MSI_TYPES to the below call.
> > >
> >
> > I think it was leftover from debugging and just to be careful.  We had
> > some issues when we originally enabled MSI-X on certain boards.  The
> > fix was to just allocate a single vector (since that is all we use
> > anyway) and we were using the wrong irq (pdev->irq vs
> > pci_irq_vector(pdev, 0)).
>
> Do you agree that simple
>
>   nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, PCI_IRQ_MSI_TYPES);
>
> will work and we can remove that leftover?

Yes, I believe so.  Tom, can you give this a quick spin on raven just
in case if you get a chance?  Something like this:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 0cc4c67f95f7..c59111b57cc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -248,16 +248,10 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
        adev->irq.msi_enabled = false;

        if (amdgpu_msi_ok(adev)) {
-               int nvec = pci_msix_vec_count(adev->pdev);
-               unsigned int flags;
+               int nvec;

-               if (nvec <= 0) {
-                       flags = PCI_IRQ_MSI;
-               } else {
-                       flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
-               }
                /* we only need one vector */
-               nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
+               nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1,
PCI_IRQ_MSI | PCI_IRQ_MSIX);
                if (nvec > 0) {
                        adev->irq.msi_enabled = true;
                        dev_dbg(adev->dev, "using MSI/MSI-X.\n");


Thanks,

Alex
