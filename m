Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68125C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C30F206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDu5SHMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgFBOV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgFBOV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:21:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCE0C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 07:21:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v19so3129407wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4GBFKi4AE0Zui6AvlkZAGUYSPOB17V3NVuaNVtHxfg8=;
        b=iDu5SHMRXV9p8WONfSFl2dlTGUryo+ZFiH/JA8c+BGpC0QU91UUvpFSqaIUDjwglhJ
         +yHCvrxwjM2SKBwJwKYa1GbRuovooFIfzoTCF1yl2ITib0CXGS1Wo55BhIedjUGxf4vx
         RG3eMkMSlDO2j3hjTVY5//OWrK6qpsshclWS/Qv5yLsvOaeSolKJbGUB+khoj/r74KkQ
         I2vw01NGl+huCDwhWUg0CQZssrqjSa/WN+ITveeRJgNZRro0WURSoglT5zeA200cars1
         PrtMq6YXBy9H/+RDUKJTr9cn+1Nbv3AFR3KzoMoRCs+U2F21+pZUjx6mwCqDr0z0eaar
         KyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4GBFKi4AE0Zui6AvlkZAGUYSPOB17V3NVuaNVtHxfg8=;
        b=lYRgLVLbPPz2UK9LkMHOgCnvebB/5hLOgiWExrgzvCbGf87ortuSNmRoMKBMzAS7Du
         /84xwEKMXtPBmEmkoo245julgSuvEiWb3CAW/USAViJEDw4x2I8HN4YVGiO/kn2PFVbf
         3ctfNiJSVmsi0UqvM7GdPzF6NAuQLqGpDlUkpAP6JTdL3jmqduo9z5FdHz2scbdwHKAQ
         KEN5I+DB1A/NRCtGLF+OqXvWlLPE7VF1fsFUCrshQ6/aN4XkaTSQCz6wMNon2XSLg6A5
         aFmCxcFRzRpwYdIDDd3F9iROBpcaOr1qlwLw/Vv8GvRaeb2xJVZiY+XIysbZQuNFeE36
         bWnQ==
X-Gm-Message-State: AOAM532w4LiXQaDGMAgDmRtGQoep4YoRHk6nnI76LTyroon/xzSk7VAZ
        uJ5f6N7jqVR49kpCTEUQK0gxMbiiapeo1W1/crU=
X-Google-Smtp-Source: ABdhPJwiSS2Ry+bKR7lnwZokdKyewXO4Wr3aDQ7TiyQVNw6HUV1RVyRn3Wt0zFxfu5fSXC17pT+RIs2BO9uqIhfNByE=
X-Received: by 2002:a05:600c:2201:: with SMTP id z1mr4316621wml.70.1591107684025;
 Tue, 02 Jun 2020 07:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200602092030.31966-1-piotr.stankiewicz@intel.com>
 <14063C7AD467DE4B82DEDB5C278E8663010E23E538@FMSMSX108.amr.corp.intel.com> <CAHp75Vfe5dQkOiFoAZx5b-NS1afiD-YC_w+5LcX8P1Hm0ASenA@mail.gmail.com>
In-Reply-To: <CAHp75Vfe5dQkOiFoAZx5b-NS1afiD-YC_w+5LcX8P1Hm0ASenA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 2 Jun 2020 10:21:12 -0400
Message-ID: <CADnq5_OO=gyo22ZrXp6pDtz2QZ2=LC429u_kkd0ZvX4=M3mBPw@mail.gmail.com>
Subject: Re: [PATCH 07/15] drm/amdgpu: use PCI_IRQ_MSI_TYPES where appropriate
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Stankiewicz, Piotr" <piotr.stankiewicz@intel.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 10:00 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jun 2, 2020 at 4:38 PM Ruhl, Michael J <michael.j.ruhl@intel.com>=
 wrote:
> > >-----Original Message-----
> > >From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
> > >Piotr Stankiewicz
> > >Sent: Tuesday, June 2, 2020 5:21 AM
> > >To: Alex Deucher <alexander.deucher@amd.com>; Christian K=C3=B6nig
> > ><christian.koenig@amd.com>; David Zhou <David1.Zhou@amd.com>; David
> > >Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>
> > >Cc: Stankiewicz, Piotr <piotr.stankiewicz@intel.com>; dri-
> > >devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org; linux-
> > >kernel@vger.kernel.org
> > >Subject: [PATCH 07/15] drm/amdgpu: use PCI_IRQ_MSI_TYPES where
> > >appropriate
>
> ...
>
> > >               int nvec =3D pci_msix_vec_count(adev->pdev);
> > >               unsigned int flags;
> > >
> > >-              if (nvec <=3D 0) {
> > >+              if (nvec > 0)
> > >+                      flags =3D PCI_IRQ_MSI_TYPES;
> > >+              else
> > >                       flags =3D PCI_IRQ_MSI;
> > >-              } else {
> > >-                      flags =3D PCI_IRQ_MSI | PCI_IRQ_MSIX;
> > >-              }
> >
> > Minor nit:
> >
> > Is it really necessary to set do this check?  Can flags just
> > be set?
> >
> > I.e.:
> >         flags =3D PCI_IRQ_MSI_TYPES;
> >
> > pci_alloc_irq_vector() tries stuff in order.  If MSIX is not available,
> > it will try MSI.
>
> That's also what I proposed earlier. But I suggested as well to wait
> for AMD people to confirm that neither pci_msix_vec_count() nor flags
> is needed and we can directly supply MSI_TYPES to the below call.
>

I think it was leftover from debugging and just to be careful.  We had
some issues when we originally enabled MSI-X on certain boards.  The
fix was to just allocate a single vector (since that is all we use
anyway) and we were using the wrong irq (pdev->irq vs
pci_irq_vector(pdev, 0)).  For reference, the original patch to add
MSI-X:

commit bd660f4f111161f60392dd02424c3a3d2240dc2f
Author: shaoyunl <shaoyun.liu@amd.com>
Date:   Tue Oct 1 15:52:31 2019 -0400

    drm/amdgpu : enable msix for amdgpu driver

    We might used out of the msi resources in some cloud project
    which have a lot gpu devices(including PF and VF), msix can
    provide enough resources from system level view

    Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
    Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

And the fix:

commit 8a745c7ff2ddb8511ef760b4d9cb4cf56a15fc8d
Author: Alex Deucher <alexander.deucher@amd.com>
Date:   Thu Oct 3 10:34:30 2019 -0500

    drm/amdgpu: improve MSI-X handling (v3)

    Check the number of supported vectors and fall back to MSI if
    we return or error or 0 MSI-X vectors.

    v2: only allocate one vector.  We can't currently use more than
    one anyway.

    v3: install the irq on vector 0.

    Tested-by: Tom St Denis <tom.stdenis@amd.com>
    Reviewed-by: Shaoyun liu  <shaoyun.liu@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Alex
