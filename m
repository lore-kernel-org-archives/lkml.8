Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241B6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 027722067B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYLCVngy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgFBOAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBOAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:00:32 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84806C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 07:00:32 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s88so1480185pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 07:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7yBqRQ05m/Z4dmTqP2jf4amoRtlJTzK7ps3isjshOVc=;
        b=BYLCVngy4uvXcIBPOgBUgVA0OPaE+H9Fyfe9LVc4F4uRNZXwKG1fmWo90RbVuFdj2h
         3VSgFyffB6NjRiZG+jajuSTEagKpWwT8ZLfryOA7RcaVRV3s57dUZGAGd/QeFaXOKSwN
         wNicNnfkZQHReNgWl0ZUZ6e/OEe5N3ppU6i4QtSFoOfo7QOX3U8HCQ11vyiP680D6vJU
         m4HXHkMCbfQzopvgRyWnUi9Ep/1/CjKLH7xvxAu2KZuk/mVwA9NycekR1paT5abB5qRO
         tcDU1qOcqKNaosOCMDzgpMb9XiDWRPgNIW4a8pre/lp/T+/zExpaJ5ifhkEElourHw2i
         J+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7yBqRQ05m/Z4dmTqP2jf4amoRtlJTzK7ps3isjshOVc=;
        b=lyinFBNj6+zjbMnqdZ3z1g9NCe68EkU2/ub80vwACzY8TzbPBE7X+w613Bsvk9r9pJ
         uIsf8XxJA/+EoQST2wAdsdHlIX7WHiIm2ajtoibDLw72pLrqRhMJ7RVh4gO3Iy/3urpA
         pcNoFH3M7N0Vt1WYhwy0aKgaz9ALm1BJFokpfMBhAG3XR/30Gul+TMBTeYbZRGyrxc2g
         J5sbr9U9UGa/6F4tAcf6Wm6/ieDyznwDxM16qVm0VkhyGnl46LdBtuZmw2m9TN3hoW2C
         w7azMfwq+K3J+ckV/xgWsYwm6O3TsjyJDcbUQFvX7kXFpizwI0ubu/RhfWK5d/gy69eV
         UepA==
X-Gm-Message-State: AOAM530gUB51ZhtaxXfmdsbYEwtBuD9MJS/cxmSa/UCHpPAMLKXROK0J
        XU0C8Eh0y6Fm017e4fMAyCgVHcbJ5vGlUycRxiM+sYEVNlU4sA==
X-Google-Smtp-Source: ABdhPJxbQimuLaI1bwYXtc/xXdK9j/EbdTfKTdAZ6xD5IZjH/RkMWlo/QACxutOeZs5hbdkLutmcnDZurql5j/rBV8g=
X-Received: by 2002:a17:90a:1704:: with SMTP id z4mr5657315pjd.181.1591106431949;
 Tue, 02 Jun 2020 07:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200602092030.31966-1-piotr.stankiewicz@intel.com> <14063C7AD467DE4B82DEDB5C278E8663010E23E538@FMSMSX108.amr.corp.intel.com>
In-Reply-To: <14063C7AD467DE4B82DEDB5C278E8663010E23E538@FMSMSX108.amr.corp.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Jun 2020 17:00:20 +0300
Message-ID: <CAHp75Vfe5dQkOiFoAZx5b-NS1afiD-YC_w+5LcX8P1Hm0ASenA@mail.gmail.com>
Subject: Re: [PATCH 07/15] drm/amdgpu: use PCI_IRQ_MSI_TYPES where appropriate
To:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>
Cc:     "Stankiewicz, Piotr" <piotr.stankiewicz@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 4:38 PM Ruhl, Michael J <michael.j.ruhl@intel.com> w=
rote:
> >-----Original Message-----
> >From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
> >Piotr Stankiewicz
> >Sent: Tuesday, June 2, 2020 5:21 AM
> >To: Alex Deucher <alexander.deucher@amd.com>; Christian K=C3=B6nig
> ><christian.koenig@amd.com>; David Zhou <David1.Zhou@amd.com>; David
> >Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>
> >Cc: Stankiewicz, Piotr <piotr.stankiewicz@intel.com>; dri-
> >devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org; linux-
> >kernel@vger.kernel.org
> >Subject: [PATCH 07/15] drm/amdgpu: use PCI_IRQ_MSI_TYPES where
> >appropriate

...

> >               int nvec =3D pci_msix_vec_count(adev->pdev);
> >               unsigned int flags;
> >
> >-              if (nvec <=3D 0) {
> >+              if (nvec > 0)
> >+                      flags =3D PCI_IRQ_MSI_TYPES;
> >+              else
> >                       flags =3D PCI_IRQ_MSI;
> >-              } else {
> >-                      flags =3D PCI_IRQ_MSI | PCI_IRQ_MSIX;
> >-              }
>
> Minor nit:
>
> Is it really necessary to set do this check?  Can flags just
> be set?
>
> I.e.:
>         flags =3D PCI_IRQ_MSI_TYPES;
>
> pci_alloc_irq_vector() tries stuff in order.  If MSIX is not available,
> it will try MSI.

That's also what I proposed earlier. But I suggested as well to wait
for AMD people to confirm that neither pci_msix_vec_count() nor flags
is needed and we can directly supply MSI_TYPES to the below call.

> >               /* we only need one vector */
> >               nvec =3D pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);

--=20
With Best Regards,
Andy Shevchenko
