Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60757C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 01:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1707A20797
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 01:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNPORyb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgIEBQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 21:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgIEBQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 21:16:39 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD08C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 18:16:38 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t23so10029682ljc.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 18:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2TwEP2bwMgCZ9+c0ywDi8aPPqSNthraxohoKZ3dokMo=;
        b=aNPORyb3s9zdHHQPHQGEQDspHeU5Y9EhJb7wcXo98GqGH++TEklqyYX7pSP07YCh0Q
         AcpP3vImA+41+ln1T3pjaJs5mtX+o0c2KLaPD1g18iZoWgfUBk2brxUpvRkY0dACxgMP
         ZBvZGRLv6EByHNO+y2x/f85wGzZIQ/VcO7S0jtP+XTRLqh9ZXRuajTAQ29YYqU0e01qR
         FQRc5wzlXVHXpswbvzQqxeg2sIwzhxTnAUdokZXKt2e8evCZnT7taIebRM9/BwIrIY1V
         FzYvOUDqfpxZjxQdCBSKE5sPMznhhWzfIHrnbwkWVhtjhjhEAlXm15oRrtpx+sUiqMs+
         sX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2TwEP2bwMgCZ9+c0ywDi8aPPqSNthraxohoKZ3dokMo=;
        b=WOnIAcyu5sK65XMJjThenp3ZKflO53UFq6RzEXvG/M6NGVythA6ZIALv76XDIxqZOC
         +lbVnPdU/uGaZJBk2/vlmNCCD0cRJaC2IpmLhww3obQO44DsUmm1k4CNu4OjZ3aotJ6D
         o17Siafqni/gajJNqieIJCjH9CKc5FvSAxZy+IVX/GG8fG/XEIp3HHdSrNjY0tI/NojY
         ivFgphscgdAl2muw2X1Di5NntPhG2Uxrhls7OfeHyQRKpoXsUXspIDK4iWbkhsR6eNjW
         xFlnNlK72jjY3i1ztrGILyeCoYQGwnCZ8HBGz0Xpv63UoXjNgYQFMUQuZpZSUvISYCk8
         6QHQ==
X-Gm-Message-State: AOAM533FjceIM+DHZVI2yS03LSJG/k32Kkm3PnKgrX8bWGUwDbskoQyR
        tqqlGgHmpnGHhCL+/hUbUwoOp5xXAgp4tcr7itk=
X-Google-Smtp-Source: ABdhPJxV51UuGZGMtK7bp/so+sAuaRGjKJWEuCPdcICDi2PDX+c+W7zMIG8jPlWL5/8c5zDoO0eSojTsFiCiamcCOCY=
X-Received: by 2002:a05:651c:2c9:: with SMTP id f9mr4903765ljo.257.1599268596661;
 Fri, 04 Sep 2020 18:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <1598995271-6755-1-git-send-email-jrdr.linux@gmail.com> <a3b36dfa-b7bb-e69b-95d5-e7d6dd7bda3f@nvidia.com>
In-Reply-To: <a3b36dfa-b7bb-e69b-95d5-e7d6dd7bda3f@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 5 Sep 2020 06:46:24 +0530
Message-ID: <CAFqt6zaB_wcrUzmOJ6kQWMqdcPrENyJO4FNc_UU5z-AQQh_e3w@mail.gmail.com>
Subject: Re: [linux-next PATCH v4] drivers/virt/fsl_hypervisor: Fix error
 handling path
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>, timur@freescale.com,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Sep 2, 2020 at 3:00 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 9/1/20 2:21 PM, Souptick Joarder wrote:
> > First, when memory allocation for sg_list_unaligned failed, there
> > is a bug of calling put_pages() as we haven't pinned any pages.
> >
> > Second, if get_user_pages_fast() failed we should unpin num_pinned
> > pages.
> >
> > This will address both.
> >
> > As part of these changes, minor update in documentation.
> >
> > Fixes: 6db7199407ca ("drivers/virt: introduce Freescale hypervisor
> > management driver")
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > ---
>
> This looks good to me.

Can you please take this patch through the mm tree ?

>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> > v2:
> >     Added review tag.
> >
> > v3:
> >     Address review comment on v2 from John.
> >     Added review tag.
> >
> > v4:
> >    Address another set of review comments from John.
> >
> >   drivers/virt/fsl_hypervisor.c | 17 ++++++++---------
> >   1 file changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
> > index 1b0b11b..46ee0a0 100644
> > --- a/drivers/virt/fsl_hypervisor.c
> > +++ b/drivers/virt/fsl_hypervisor.c
> > @@ -157,7 +157,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
> >
> >       unsigned int i;
> >       long ret = 0;
> > -     int num_pinned; /* return value from get_user_pages() */
> > +     int num_pinned = 0; /* return value from get_user_pages_fast() */
> >       phys_addr_t remote_paddr; /* The next address in the remote buffer */
> >       uint32_t count; /* The number of bytes left to copy */
> >
> > @@ -174,7 +174,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
> >               return -EINVAL;
> >
> >       /*
> > -      * The array of pages returned by get_user_pages() covers only
> > +      * The array of pages returned by get_user_pages_fast() covers only
> >        * page-aligned memory.  Since the user buffer is probably not
> >        * page-aligned, we need to handle the discrepancy.
> >        *
> > @@ -224,7 +224,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
> >
> >       /*
> >        * 'pages' is an array of struct page pointers that's initialized by
> > -      * get_user_pages().
> > +      * get_user_pages_fast().
> >        */
> >       pages = kcalloc(num_pages, sizeof(struct page *), GFP_KERNEL);
> >       if (!pages) {
> > @@ -241,7 +241,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
> >       if (!sg_list_unaligned) {
> >               pr_debug("fsl-hv: could not allocate S/G list\n");
> >               ret = -ENOMEM;
> > -             goto exit;
> > +             goto free_pages;
> >       }
> >       sg_list = PTR_ALIGN(sg_list_unaligned, sizeof(struct fh_sg_list));
> >
> > @@ -250,7 +250,6 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
> >               num_pages, param.source != -1 ? FOLL_WRITE : 0, pages);
> >
> >       if (num_pinned != num_pages) {
> > -             /* get_user_pages() failed */
> >               pr_debug("fsl-hv: could not lock source buffer\n");
> >               ret = (num_pinned < 0) ? num_pinned : -EFAULT;
> >               goto exit;
> > @@ -292,13 +291,13 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
> >               virt_to_phys(sg_list), num_pages);
> >
> >   exit:
> > -     if (pages) {
> > -             for (i = 0; i < num_pages; i++)
> > -                     if (pages[i])
> > -                             put_page(pages[i]);
> > +     if (pages && (num_pinned > 0)) {
> > +             for (i = 0; i < num_pinned; i++)
> > +                     put_page(pages[i]);
> >       }
> >
> >       kfree(sg_list_unaligned);
> > +free_pages:
> >       kfree(pages);
> >
> >       if (!ret)
> >
>
