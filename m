Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69995C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 426DD208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8RNdA0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgGTBQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgGTBQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:16:11 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A351C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:16:11 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id v6so15906563iob.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=au9WXwX08BBTh5LKHhan7lypdLsLLcyPE8UGYw51Kno=;
        b=G8RNdA0B7utkyEKmfbJVIg9ZjTO8HRme5UU5biS9ZC8rzpkXftoN0iM6hWZ/0cOZiH
         tFNgkq4QzWcuyYsBqzEjcBlYzAGqHy5IRyESh+gxjEKShJ7bZufbQGvCQUmYFnrtDtGI
         6f7Lxjvu17Dx7ITZW4zy5p1rfzxHOSMhfSbjx23EQCvnnxOP+9GZvnFcKMvclRWmwq0O
         FUBclyCjEynD1bnzMUwvWT49V1DFAMhoSgSZ1EVdmQ6PVeiMQu8W+oFm5iOL9CamiBWT
         HRqZ0WMUXvx49UP/kfobhqdDwwz35whKNs2/VivOJN8SFQ6vYIe8bz/oMq/96V9V/fIX
         Gs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=au9WXwX08BBTh5LKHhan7lypdLsLLcyPE8UGYw51Kno=;
        b=hs4YCABe4Kg+QKNyvUAfZKwp0FSBrTTNFbQ//OQ45iC4vA+jnMpjHvHP2ciFNTCla3
         yxBjtbHJlIMX4nvjMwXuLu4cwDmvj1KHqCRgv9dmryTwsOWx9lOR2VKY0/npelOlg/Zv
         qubyo0nxnnsq33rJMnI0zZXcXqQurJoiLQOzWWsSOkjQ/4nP2jN+iz740QJTVc7MQDOf
         YN+Zq/7Kq42dHDvcAuBDKyVRCv7vd9e7hun+hCqlTNnLMUBmFxJRCPsNSjcF1QCdycEy
         OhPEtQnrbNGUF+TKsN0hIPgfreXKrSnzTrQxg5qlAEXSExLbggrWXEucsi4xc3wqNIKk
         4E2A==
X-Gm-Message-State: AOAM531EDaZacR0h3NkZ+hHXAWrM79NdaF6bH5Ic1hkG3dQkZ0pLvspq
        aXsPXXEZFJCMGlOa4OEmr0paKCxpHja6+R3KVjc=
X-Google-Smtp-Source: ABdhPJxMrBDfVkpZ+sLYxVqdhO7iy7EoL59rnSUQvECKhq6UqDXY47c2MRunHK7TVLiStoayYJw1ktPDQUX/+0ksUb8=
X-Received: by 2002:a02:cc24:: with SMTP id o4mr23362603jap.105.1595207770984;
 Sun, 19 Jul 2020 18:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <37af499e-2b8b-7e78-ed4b-0aaf711fcb38@csgroup.eu>
 <20200614233235.121432-1-gthelen@google.com> <CAOSf1CHjrFb3J6t0HQXQVVM-PEgAcaCADA8mcwYVi4mpq+f3Yw@mail.gmail.com>
 <xr93sgdo7i2t.fsf@gthelen.svl.corp.google.com>
In-Reply-To: <xr93sgdo7i2t.fsf@gthelen.svl.corp.google.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Mon, 20 Jul 2020 11:15:59 +1000
Message-ID: <CAOSf1CGJztzwHX__D0fXkPMXZfDHdwtvU4omwGrWhQfJpBj-Og@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/powernv/pci: use ifdef to avoid dead code
To:     Greg Thelen <gthelen@google.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 5:13 AM Greg Thelen <gthelen@google.com> wrote:
>
> Oliver O'Halloran <oohall@gmail.com> wrote:
>
> > On Mon, Jun 15, 2020 at 9:33 AM Greg Thelen <gthelen@google.com> wrote:
> >>
> >> Commit dc3d8f85bb57 ("powerpc/powernv/pci: Re-work bus PE
> >> configuration") removed a couple pnv_ioda_setup_bus_dma() calls.  The
> >> only remaining calls are behind CONFIG_IOMMU_API.  Thus builds without
> >> CONFIG_IOMMU_API see:
> >>   arch/powerpc/platforms/powernv/pci-ioda.c:1888:13: error: 'pnv_ioda_setup_bus_dma' defined but not used
> >>
> >> Move pnv_ioda_setup_bus_dma() under CONFIG_IOMMU_API to avoid dead code.
> >
> > Doh! Thanks for the fix.
> >
> > Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
>
> Is there anything else needed from me on this patch?
> Given that it fixes a 5.8 commit I figured it'd be 5.8 material.

Oh sorry, I completely forgot about this patch. I sent another series
that included a more-or-less identical fix after the kbuild robot sent
a reminder:

http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=187630&state=*

That's current in powerpc/next, but if it's causing a build break then
I agree it should probably go into 5.8 too.

Oliver
