Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0EDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47CAB2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7K8efCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgHYUUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYUU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:20:28 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5204AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:20:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w25so15285795ljo.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TDBfHzBFyP6h01HYJ4KqTPKabcjc/ti98JY0bYSyFc4=;
        b=R7K8efCt5R7qk4Zhoo97u+soBC3l8BQg4q6dDYRsC41gvGExf5cc/Icb9s/oijdugJ
         9nYrREha8UKyjETDC3hEbUX4spQm6UO+RoQIXoTn9HEV84H8V+0yjHDAmlvT5ADLtAwh
         aoBwSuMoWcKjxV/bsQcxWK3Ykc5K6d8kmq80nMHdGzsl4Qn8pyOB1kqSFtpA9HIJu5xP
         cm4+0UDPqlRjD6EFgQ7OjD9ns2q+U9dEWOQTSNclVHAYLmmWyrlHi6bstJLxdBrsNqc1
         9oCF+6+bwJuQNxBooBW8UCVkTIQtac18rljgKCQ1R2YIgefFQEQXbXV4wAcrCf/jG268
         dUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TDBfHzBFyP6h01HYJ4KqTPKabcjc/ti98JY0bYSyFc4=;
        b=NWWnzqylJgygAzA4zyE3jpmV0gyz8vZZqBbezmITE+IYJh/JWxxrhskYxuMfvtF5EW
         Z4S4va6kZNbiwOwWSJo/iXg7kBU9W+n99H8Fd3o69TzR47/Lnu/2zAtAN/MZLMUFKCu9
         j4ortP9s9II6W7bDVkYIdSaeORbv2p2fC///JWGjMDwL9dYtVoB1cUTjn+xJruWXD243
         nsOS9ikLxqzTVjWdK8CVvdjofMpOOMTFusMcUYkWwoXcikfC9AaTADdGzKsWNPlDvLAJ
         gmcNdGRr9sC/ojsoptkmmrD2+J8IeQmIo5zzZ9RNE4FcDeAOvPUuswV1/vYA0lSvfPxf
         xLSg==
X-Gm-Message-State: AOAM532y9ht9MbebJOnigWxkk9DK4KHNRjWkLrCUrylgqs0lL/+tQyP5
        P2akkPEe8/kSGsCFJfxX0QmShV9nfUxbO9PYDNk=
X-Google-Smtp-Source: ABdhPJzhKLCHrmOhIWsmNZpOtluajQCyO4SeQk4gAT9oVh1CvMzjGeWLbxMByg0YE3q4SEWCgMYJxkBFDUKOtN98iPE=
X-Received: by 2002:a05:651c:23a:: with SMTP id z26mr5410654ljn.257.1598386826599;
 Tue, 25 Aug 2020 13:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <1596049269-14950-1-git-send-email-jrdr.linux@gmail.com> <692e6a9b-6caa-7c60-d685-6cc951ee9483@nvidia.com>
In-Reply-To: <692e6a9b-6caa-7c60-d685-6cc951ee9483@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 26 Aug 2020 01:50:15 +0530
Message-ID: <CAFqt6zY4KBe7KukmvYbbbzZMrW5T5gS4dx0KrMUdZ9Y8K=yucA@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/virt/fsl_hypervisor: Correcting error handling path
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        mchehab+samsung@kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 6:30 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 7/29/20 12:01 PM, Souptick Joarder wrote:
> > First, when memory allocation for sg_list_unaligned failed, there
> > is no point of calling put_pages() as we haven't pinned any pages.
> >
> > Second, if get_user_pages_fast() failed we should unpinned num_pinned
> > pages, no point of checking till num_pages.
>
> Hi Souptick,
>
> For both of the above, the wording "no point" is so overly gentle as
> to be misleading. That's because calling put_page() on any pages beyond
> num_pinned is a *bug*.
>
> So let's reword that. And let's change the patch subject from "Correcting" to
> "fix".
>
> And probably good to add a Fixes: tag, too.

Is there any scripts/ settings to fetch Fixes: tag other than using git blame ?

>
> More:
>
> >
> > This will address both.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > ---
> > v2:
> >       Added review tag.
> >
> >   drivers/virt/fsl_hypervisor.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
> > index 1b0b11b..ea344d7 100644
> > --- a/drivers/virt/fsl_hypervisor.c
> > +++ b/drivers/virt/fsl_hypervisor.c
> > @@ -157,7 +157,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
> >
> >       unsigned int i;
> >       long ret = 0;
> > -     int num_pinned; /* return value from get_user_pages() */
> > +     int num_pinned = 0; /* return value from get_user_pages() */
> >       phys_addr_t remote_paddr; /* The next address in the remote buffer */
> >       uint32_t count; /* The number of bytes left to copy */
> >
> > @@ -293,7 +293,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
> >
> >   exit:
> >       if (pages) {
> > -             for (i = 0; i < num_pages; i++)
> > +             for (i = 0; i < num_pinned; i++)
> >                       if (pages[i])
>
> I suspect that this "if" is unnecessary now.
>
> Either way, the diff itself looks good to me, so with the wording changes to
> the commit description, you can add:
>
>      Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> >                               put_page(pages[i]);
> >       }
> >
>
