Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCDEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ECF52086A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSXSlqHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgFBOfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBOfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:35:21 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C247C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 07:35:21 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o6so5162946pgh.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mYlS2iciwsHXiaofbZsld8ptg5tb8qfGANhtOourZvI=;
        b=mSXSlqHydsbU5VJwZsklBYuOKu4DgisHccVnCvpwG7iUPxHWtWHxBjW86nVTGr7ZUH
         T54oYG/OKUn/YXneO0NPQFRHQwMUAv7mie5yg2mtH6tJvM9m0nhsAM/N0mAPoAUYHDPl
         bhig6+z0feWmjC+0y1eO/hG48+JaRBp3QZS2G8IcS4CVypUA2mM0HsOPG64Sf0/yX/MZ
         y8HGSOlPfafdSiyijkDbRiiBBAMRpuUe6/xPYCACNg9LL/6uJwjM3t5eHV2D0FvlqP7A
         2OSM36Icybzzkw9UXW49MiJw28t+ha37NRdx39sIVnk8u98X6zjr55Q+rdJ/qpm37DH6
         vjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYlS2iciwsHXiaofbZsld8ptg5tb8qfGANhtOourZvI=;
        b=rFBBu1Mmh10YGyRnEFEGeS2rUjSRzIM23lRVSj1ktacl4iUbn/Zdk+IR2dI9idKXA4
         Nru+dQ57Tdjp2Y6wDOE+b18ZZ6o4XH76WfdUJxQZ200ti4J35px1krvRkdUDaVhbcoue
         iL8Ap5JG+TMlAzZ8Wy1B6AlukJU719qyiw9/TlABEoyDh185Bdn9tcAw982pmGTFVUcu
         gm/lgnlXG9k4Xtei6So4mQCbphXSEC1byMSqpq17IB8ENJghsE2dYPqBBXEPiyNObUU7
         scRA8ZWOw9HPCTEI3V2m1Jew+G9W/dE+tOgvRbTQjp2Il31sYZmiyWKwxRTCZxBcisaE
         rLWw==
X-Gm-Message-State: AOAM533ZsI542MKKz/WYnuUF0uTig73buS5QWonlKV/oSpN+aBgDjKp6
        vMn07bieFYcIfL70z2ZwJ0E0tZmUKgr0u79WYgd06noVnNXNng==
X-Google-Smtp-Source: ABdhPJyCpwadTio0lN2T0Sanps9T+uhOtWpM2pkaVVZ+ZtL107eRbrGhBVpEicozrQekDLdG1bZ231XwC1g/LIyNQqE=
X-Received: by 2002:a63:305:: with SMTP id 5mr23614425pgd.74.1591108520518;
 Tue, 02 Jun 2020 07:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200602092030.31966-1-piotr.stankiewicz@intel.com>
 <14063C7AD467DE4B82DEDB5C278E8663010E23E538@FMSMSX108.amr.corp.intel.com>
 <CAHp75Vfe5dQkOiFoAZx5b-NS1afiD-YC_w+5LcX8P1Hm0ASenA@mail.gmail.com> <CADnq5_OO=gyo22ZrXp6pDtz2QZ2=LC429u_kkd0ZvX4=M3mBPw@mail.gmail.com>
In-Reply-To: <CADnq5_OO=gyo22ZrXp6pDtz2QZ2=LC429u_kkd0ZvX4=M3mBPw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Jun 2020 17:35:08 +0300
Message-ID: <CAHp75Vd1zVt7F2+44EFPHOrCOzexe=mLaiZixqJR9NNK9-wNQg@mail.gmail.com>
Subject: Re: [PATCH 07/15] drm/amdgpu: use PCI_IRQ_MSI_TYPES where appropriate
To:     Alex Deucher <alexdeucher@gmail.com>
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

On Tue, Jun 2, 2020 at 5:21 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> On Tue, Jun 2, 2020 at 10:00 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jun 2, 2020 at 4:38 PM Ruhl, Michael J <michael.j.ruhl@intel.com> wrote:
> > > >From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
> > > >Piotr Stankiewicz

> > > >               int nvec = pci_msix_vec_count(adev->pdev);
> > > >               unsigned int flags;
> > > >
> > > >-              if (nvec <= 0) {
> > > >+              if (nvec > 0)
> > > >+                      flags = PCI_IRQ_MSI_TYPES;
> > > >+              else
> > > >                       flags = PCI_IRQ_MSI;
> > > >-              } else {
> > > >-                      flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
> > > >-              }
> > >
> > > Minor nit:
> > >
> > > Is it really necessary to set do this check?  Can flags just
> > > be set?
> > >
> > > I.e.:
> > >         flags = PCI_IRQ_MSI_TYPES;
> > >
> > > pci_alloc_irq_vector() tries stuff in order.  If MSIX is not available,
> > > it will try MSI.
> >
> > That's also what I proposed earlier. But I suggested as well to wait
> > for AMD people to confirm that neither pci_msix_vec_count() nor flags
> > is needed and we can directly supply MSI_TYPES to the below call.
> >
>
> I think it was leftover from debugging and just to be careful.  We had
> some issues when we originally enabled MSI-X on certain boards.  The
> fix was to just allocate a single vector (since that is all we use
> anyway) and we were using the wrong irq (pdev->irq vs
> pci_irq_vector(pdev, 0)).

Do you agree that simple

  nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, PCI_IRQ_MSI_TYPES);

will work and we can remove that leftover?

-- 
With Best Regards,
Andy Shevchenko
