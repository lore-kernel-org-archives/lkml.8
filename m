Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9673C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F68A20768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pprvlrpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbgF3HVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgF3HVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:21:42 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D6FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:21:41 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y13so10724742lfe.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V3VDYgt1zTFMdABjQ8B+qkXvuWVdNTswZvSgfcJ5ZfU=;
        b=PprvlrpbinByF4TFkGGycc90/2r42FHT5UVS3tEzsUBzG/xaCTpG788raEyTTMlN1O
         h4D0KagKUnuaMgjUGd3vvbNG42kDf5lGRhhjmXFRyjBwFD6yzJI1PE+Xh5jfyCgFNerh
         750MnbWvRWbk7isk9GiI92InbTEd0yLVQt3sGAYtvSWU7PZ/qdRFdm5kykHRKQPF5uRm
         s31W94kUBakZI1XuTPCzEyKJeEosYMA15WMTK1IKzl8A4V9LDPfDAmNks3tmpU9MRxL5
         zyYwdFuHL7fXvS7VbAJBfKOpfoHkNkM3OJxb7KB7i6Y0SVluEcZDLSdrnasKDSR84lI7
         9ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V3VDYgt1zTFMdABjQ8B+qkXvuWVdNTswZvSgfcJ5ZfU=;
        b=ZeXZfTvTlaSpRvmDmTaNhapjq5pe6QkusXFbhuAFhW7boPdr22z5CZt1GLoShrXbs+
         xz74L56U+8LWpg0OCRqPuWDxEDj6CMOynIsWIrqTOOk4lnJOVH5PUZUx0Y87NX1HTk4X
         OUntCxjzlFCSX9M2rjJOxrLf7QnOuCw1pTg249nMH6UbhFm9a8U9G5z9DL6yYHI7JF/z
         jvNr9dfrv+JJ25eEV7u7kK57kETne6z50oODH92yjRVrwTN8ckxECd3TlyBGLriE6f4v
         RQxzA7JyKC4mmod1/v+zKU01HW5zh7DGA66U55bUjCrG/HEqGmwi6H9XI6hIKraQE5Od
         sn+w==
X-Gm-Message-State: AOAM533y0yKT1Et/qe0hMiGnZ4t0COMxSTGpBD0Qj2cAB2RBz89TKuUE
        XT6xKKFm7fmUl0g0qOc9inxkn8bZmQA02MEKS/0=
X-Google-Smtp-Source: ABdhPJzfnYZJ+FpolUHdlpEl9/AZXSN2liVUehp9/X6K4o90BRCqYWVJ7LAGfE/KlEjoh8jtgnuvmK5vwYiZFuCtkHo=
X-Received: by 2002:a19:b07:: with SMTP id 7mr11415981lfl.38.1593501700365;
 Tue, 30 Jun 2020 00:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <1592362839-4050-1-git-send-email-jrdr.linux@gmail.com> <CAFqt6zbQ-AJK_3NHmaOVXYUaD7ajvEvogMAOrse-99+vPi7xNw@mail.gmail.com>
In-Reply-To: <CAFqt6zbQ-AJK_3NHmaOVXYUaD7ajvEvogMAOrse-99+vPi7xNw@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 30 Jun 2020 12:59:56 +0530
Message-ID: <CAFqt6zZeXeEb1KfPTuNb2R5GQdPpPPJ5JFY8KuErUUV4DdOTnw@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/virt/fsl_hypervisor: Correcting error handling path
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, mchehab+samsung@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:05 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Wed, Jun 17, 2020 at 8:22 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > First, when memory allocation for sg_list_unaligned failed, there
> > is no point of calling put_pages() as we haven't pinned any pages.
> >
> > Second, if get_user_pages_fast() failed we should unpinned num_pinned
> > pages, no point of checking till num_pages.
> >
> > This will address both.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
>
> Any suggestion, what is the right tree to take this patch forward ?

If no further comment, can we get this patch in queue for 5.9 ?

>
> > ---
> > v2:
> >         Added review tag.
> >
> >  drivers/virt/fsl_hypervisor.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
> > index 1b0b11b..ea344d7 100644
> > --- a/drivers/virt/fsl_hypervisor.c
> > +++ b/drivers/virt/fsl_hypervisor.c
> > @@ -157,7 +157,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
> >
> >         unsigned int i;
> >         long ret = 0;
> > -       int num_pinned; /* return value from get_user_pages() */
> > +       int num_pinned = 0; /* return value from get_user_pages() */
> >         phys_addr_t remote_paddr; /* The next address in the remote buffer */
> >         uint32_t count; /* The number of bytes left to copy */
> >
> > @@ -293,7 +293,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
> >
> >  exit:
> >         if (pages) {
> > -               for (i = 0; i < num_pages; i++)
> > +               for (i = 0; i < num_pinned; i++)
> >                         if (pages[i])
> >                                 put_page(pages[i]);
> >         }
> > --
> > 1.9.1
> >
