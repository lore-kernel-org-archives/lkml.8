Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE67CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACAD6207D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eY3K2oVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgIAUOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgIAUOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:14:42 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3377C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 13:14:41 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y4so3105293ljk.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 13:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y2+LiS1AoKBUrRYa8fWVK5wdjbXOPkokQz7JgjJ+rI8=;
        b=eY3K2oVuNusKW//NR5L5uqQ4Eb8r9zpoOxDYBm8RtZaB3IO/6zBvYJmZCqn4YK99PV
         uxqMcJrnqhMhrAAQGkhkF8o1U6qDIfCCDqW4KDPOSWBy+UuMUaO2gPh+vMGiDsqfDiY9
         4XMIePCJ0hfvQCWI7PnjspPuPhD4Dbv8ea4h5ZmVlgccTo1hWITGXntpHRhq9cXPbmvF
         L+WRH4KCuUe0YpNN+7+hV08w7voyHlexpAiyzv8cc+7PCwNopFbz1hsQ5RD9RBBSy6RZ
         lEWbR9Bzx2/ZkYlmShkKtdKaH5m84pPWeJ4OrQM7roRHKyDLC/ghKx62dLB3Elgy/DpK
         hy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2+LiS1AoKBUrRYa8fWVK5wdjbXOPkokQz7JgjJ+rI8=;
        b=KWcI1XEsHpmPI7SsR8lewALC8Qad5nezF3Tn96be+HGp4fFd3QQcCdN/kMVVl8Ljk4
         sI4FaX61tPuYdeJcji7lrHD/iecaEwLPROlzVneRAGPIg9P6GsYMqoiEz/yLHPMd7O1C
         IER0y3sd4XpAWFZ3RXNzDbCIiBgpmJExq743qpd8W99js7mkcjJ/jFfB8h/I5S5lWKv3
         9Fo0u4SuHdrji4cMAaXYGYSCO3k3GRGIC7YfRQDdXPbyGC/MADbcSyKPyPJiSR7udNy9
         NR53gWtaAjCch+AdRTQw1PKHGbm18CdqRKdbvZ6yhVOBRzeyCOB7n51M0dkpOcSssEOT
         iCww==
X-Gm-Message-State: AOAM5332T1I5Eesb8gYDRIUXxDWKxSgBAdsuCWhvMiqAWupGVEHEbShR
        NzTCQgMGnsjq0e9PXOlKWrGrqsdXjvCPdi41C2dX6e9CPD8=
X-Google-Smtp-Source: ABdhPJzvtk8Yic4Ue7VB6QN4h9xhxMb2g6D+jnn3XCZLyMHx9jnh1uD2aJHfChlwrS9FRmvbcRaKf9HZSmb9+zBDLys=
X-Received: by 2002:a05:651c:210:: with SMTP id y16mr1412934ljn.266.1598991280222;
 Tue, 01 Sep 2020 13:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <1598911668-6178-1-git-send-email-jrdr.linux@gmail.com> <82329783-739b-a315-8957-2c49a3ab1350@nvidia.com>
In-Reply-To: <82329783-739b-a315-8957-2c49a3ab1350@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 2 Sep 2020 01:44:28 +0530
Message-ID: <CAFqt6zYcTHDvhFgFNxy+MjD_h7nFUojOnB29v_-TbEsQtmXWCQ@mail.gmail.com>
Subject: Re: [linux-next PATCH v3] drivers/virt/fsl_hypervisor: Fix error
 handling path
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, timur@freescale.com,
        galak@kernel.crashing.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Tue, Sep 1, 2020 at 4:28 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 8/31/20 3:07 PM, Souptick Joarder wrote:
> > First, when memory allocation for sg_list_unaligned failed, there
> > is a bug of calling put_pages() as we haven't pinned any pages.
>
> "we should unpin"

will it be "we shouldn't unpin" ? can you please clarify this ?
>
> ...
> >
> > @@ -250,7 +250,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
> >               num_pages, param.source != -1 ? FOLL_WRITE : 0, pages);
> >
> >       if (num_pinned != num_pages) {
> > -             /* get_user_pages() failed */
> > +             /* get_user_pages_fast() failed */
>
> Let's please just delete that particular comment entirely. It's of
> questionable accuracy (partial success is allowed with this API), and it
> is echoing the code too closely to be worth the line that it consumes.
>
> More importantly, though, we need to split up the cases of gup_fast
> returning a negative value, and a zero or positive value. Either here,
> or at "exit:", the negative return case should just skip any attempt to
> do any put_page() calls at all. Because it's a maintenance hazard to
> leave in a loop that depends on looping from zero, to -ERRNO, and *not*
> doing any loops--especially in the signed/unsigned soupy mess around gup
> calls.
>
>
> >               pr_debug("fsl-hv: could not lock source buffer\n");
> >               ret = (num_pinned < 0) ? num_pinned : -EFAULT;
> >               goto exit;
> > @@ -293,12 +293,12 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
> >
> >   exit:
> >       if (pages) {
> > -             for (i = 0; i < num_pages; i++)
> > -                     if (pages[i])
> > -                             put_page(pages[i]);
> > +             for (i = 0; i < num_pinned; i++)
> > +                     put_page(pages[i]);
>
> Looks correct. I sometimes wonder why more callers don't use
> release_pages() in situations like this, but that's beyond the scope of
> your work here.
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
