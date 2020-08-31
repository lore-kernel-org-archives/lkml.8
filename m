Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B07C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0363E20719
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCb7Gitz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgHaWKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 18:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgHaWKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 18:10:44 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FDAC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 15:10:44 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x77so4402412lfa.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 15:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OfgtonsfQzoxG89luQAsF6Hu7k5ugTDKW16FnDocNNk=;
        b=VCb7GitziBVHXnsWc2Ixjb/xUQTR+hZEpEWnPBDfMoCCji9Vkpc+Jqui3tcr3H2kQl
         FDvSqs9aSoSCMlKTha6yEwNhSsftkKtbpNGfi4PfE29N83GyrBdh09RumeAE16jsY3wu
         DbtASMSfeZ1mrqfzWeczvlGQ563ibC/BclIdjjp4l9RLZN11U64Gj/rrLgDDQmR0/dto
         70zc+8EO8nWUCs/UB1bmW2sXP2CGWLEiauD+zBFSvDeO1nSzPS4dl4uEHNXs+HuFxi6T
         UvWIzUL6O9lYMTw17hvb1lHvKUtZYclnDBVTDNP8pE1S7ZG2Rvg4HZeRUllWogsLviC3
         K7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OfgtonsfQzoxG89luQAsF6Hu7k5ugTDKW16FnDocNNk=;
        b=uVsX5aKTOS2+0pngsD/fonobQ3kGkdN08B6TwR8aRus2I0DcwYbf7wCAGR76tc0C+/
         cVuVFOQ3ozdzAsbdr0g/ibglECB1wqtdnRVsyJuftfsu32m22mfISgebVsafz3B4VZMZ
         Z/NYlm08FGplAWBpmMovNJdia+RSZMFx6jbUwu27Z/IBiKpB0+EJoc/Iw0Xl7XaVrMaY
         OfljPU9TMk3e/xLilI4V81PX1KWwDH0G6bp1Qcc3DjrRBpo6GzlP1SJB5/hJ1fl02oMy
         aIKc6IFqPR40CO1Ya5DuI3kIdlCNFMjyJi1Dv4lIZscraGD5wY+boyP2V12QWnCtErZE
         yNMQ==
X-Gm-Message-State: AOAM532plgIUfReMBIaLNsuBNrno3SbUxT1LQDwWg2vRQYT66k7NFwbB
        l4+cHv10gJENO/N9LPVQjmhhxPGisTxCAuryc7suBvcpLGWzcQ==
X-Google-Smtp-Source: ABdhPJz7NDYHCAuBVoTPH6ToIKxl2Ge6fjF6R9BbJc2ya/FAC1Pza8xQgTVyX/JErJwzmoErFzwvr55dqDih2SaOxpc=
X-Received: by 2002:a19:ee0d:: with SMTP id g13mr843485lfb.139.1598911841573;
 Mon, 31 Aug 2020 15:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <1598911668-6178-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1598911668-6178-1-git-send-email-jrdr.linux@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 1 Sep 2020 03:40:30 +0530
Message-ID: <CAFqt6zaAWL-f9YnosMhy7oOh8wT48cPSrhrwxn4qGPspvFz-=w@mail.gmail.com>
Subject: Re: [linux-next PATCH v3] drivers/virt/fsl_hypervisor: Fix error
 handling path
To:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
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

On Tue, Sep 1, 2020 at 3:38 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> First, when memory allocation for sg_list_unaligned failed, there
> is a bug of calling put_pages() as we haven't pinned any pages.
>
> Second, if get_user_pages_fast() failed we should unpinned num_pinned
> pages instead of checking till num_pages.
>
> This will address both.
>
> As part of these changes, minor update in documentation.
>
> Fixes: 6db7199407ca ("drivers/virt: introduce Freescale hypervisor
> management driver")
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Few questions ->

First, there are minor updates from v2 -> v3 other than addressing your
review comments in v2. Would you like to review it again?

Second, I think, as per Documentation/core-api/pin_user_pages.rst,
this is case 5.
Shall I make the conversion as part of this series ?

> ---
> v2:
>    Added review tag.
>
> v3:
>    Address review comment on v2 from John.
>    Added review tag.
>
>  drivers/virt/fsl_hypervisor.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
> index 1b0b11b..efb4e7f 100644
> --- a/drivers/virt/fsl_hypervisor.c
> +++ b/drivers/virt/fsl_hypervisor.c
> @@ -157,7 +157,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>
>         unsigned int i;
>         long ret = 0;
> -       int num_pinned; /* return value from get_user_pages() */
> +       int num_pinned = 0; /* return value from get_user_pages_fast() */
>         phys_addr_t remote_paddr; /* The next address in the remote buffer */
>         uint32_t count; /* The number of bytes left to copy */
>
> @@ -174,7 +174,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>                 return -EINVAL;
>
>         /*
> -        * The array of pages returned by get_user_pages() covers only
> +        * The array of pages returned by get_user_pages_fast() covers only
>          * page-aligned memory.  Since the user buffer is probably not
>          * page-aligned, we need to handle the discrepancy.
>          *
> @@ -224,7 +224,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>
>         /*
>          * 'pages' is an array of struct page pointers that's initialized by
> -        * get_user_pages().
> +        * get_user_pages_fast().
>          */
>         pages = kcalloc(num_pages, sizeof(struct page *), GFP_KERNEL);
>         if (!pages) {
> @@ -241,7 +241,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>         if (!sg_list_unaligned) {
>                 pr_debug("fsl-hv: could not allocate S/G list\n");
>                 ret = -ENOMEM;
> -               goto exit;
> +               goto free_pages;
>         }
>         sg_list = PTR_ALIGN(sg_list_unaligned, sizeof(struct fh_sg_list));
>
> @@ -250,7 +250,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>                 num_pages, param.source != -1 ? FOLL_WRITE : 0, pages);
>
>         if (num_pinned != num_pages) {
> -               /* get_user_pages() failed */
> +               /* get_user_pages_fast() failed */
>                 pr_debug("fsl-hv: could not lock source buffer\n");
>                 ret = (num_pinned < 0) ? num_pinned : -EFAULT;
>                 goto exit;
> @@ -293,12 +293,12 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>
>  exit:
>         if (pages) {
> -               for (i = 0; i < num_pages; i++)
> -                       if (pages[i])
> -                               put_page(pages[i]);
> +               for (i = 0; i < num_pinned; i++)
> +                       put_page(pages[i]);
>         }
>
>         kfree(sg_list_unaligned);
> +free_pages:
>         kfree(pages);
>
>         if (!ret)
> --
> 1.9.1
>
