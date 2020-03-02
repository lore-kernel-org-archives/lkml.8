Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299D5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0BC22B48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vEXELDoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgCBVnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:43:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42982 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgCBVnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:43:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id f5so344558pfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 13:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4dlwidJa8gDEE3TMB16QWBVQS+uPEhVk5tCpDd5ZLJM=;
        b=vEXELDoob+J8VQsf8H5NR7WHeynlggYFMF78SSlMvgD2RMO3pCCAnjZ3ehbZ0aldd5
         dvf/XYY1VurmRTOGDqrCs5Ogc4X3lhwKDoyakd25opm8rk2WQu/n3OVQmXgFFXpRzAqm
         +dfu3sriNNRUBMscl3Wkk6oEhhSCH4rNiD0wvwA7kcGQyNILwyp+ZryAv146IdGKnkag
         3EGku1T/MjyHVFIoP/tJUePzmBZb1HpgqR8OE5hqsOBz0N3SMhpLwySFMHBZLjrBZjCW
         DqdDnDcev7344FrO0mGzQ3J0ow2S6Et9x5hDZFr+bHFGvsTWU22EoCVmuaq2YYQTzRrQ
         esMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4dlwidJa8gDEE3TMB16QWBVQS+uPEhVk5tCpDd5ZLJM=;
        b=TDfZQVvCE6oPVHHuUOpkC0hSSSNpWllAYFCz5623H2+8E4RzsemuimEJj7Vwo62/7b
         sKsG7UX9o60ImekzoN8mM9F05kTCR69bh99Acb7uakk2uYo0kFXfnQTpAW1ax6Dpbi6k
         ZWj2ltQmAdkJ/VeJymdpK3Q/UarCMFnIkdIQ6fjPoGMQDHgDa60WQA0uL1laXdyBvn8m
         X7odKiuGe82TaiROQerDVTkK2JL0rDXFOUt5MDoDJAeQyXMXROvqw2UqmaQLv306raE/
         rlQQWbXoZTx82FAob7cXhdaEkNBT0Ho6QE+DF9b3gF4Ihn1/OThhWy0seqtnuAN0SIJM
         3nGA==
X-Gm-Message-State: ANhLgQ2TiJ2w7YMAspeE5V91dWMOYMQ2FX18aaH9ML8wKEqjtuHqSxz5
        le7LhnEl8iciUiQvqNOz+9a+PA==
X-Google-Smtp-Source: ADFU+vtQXMul1hNQtsoN7QrNSj8GdpelOfLhaSfk0E4yO0oVxkQ4ZreXZEDUg5eQKHQcTUxVkdhiBg==
X-Received: by 2002:a63:9549:: with SMTP id t9mr876417pgn.346.1583185401237;
        Mon, 02 Mar 2020 13:43:21 -0800 (PST)
Received: from yoga (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id y197sm23281150pfc.79.2020.03.02.13.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 13:43:20 -0800 (PST)
Date:   Mon, 2 Mar 2020 13:43:17 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     nikita.shubin@maquefel.me, Nikita Shubin <NShubin@topcon.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remoteproc: error on kick missing
Message-ID: <20200302214317.GI210720@yoga>
References: <20200228110804.25822-1-nikita.shubin@maquefel.me>
 <CANLsYkyDsJaxO_37qTjEP+aeQju8W2+jhHFRF7+oifBMqJqyng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkyDsJaxO_37qTjEP+aeQju8W2+jhHFRF7+oifBMqJqyng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02 Mar 09:44 PST 2020, Mathieu Poirier wrote:

> Hi Nikita,
> 
> On Fri, 28 Feb 2020 at 04:07, <nikita.shubin@maquefel.me> wrote:
> >
> > From: Nikita Shubin <NShubin@topcon.com>
> >
> > .kick method not set in rproc_ops will result in:
> >
> > 8<--- cut here ---
> > Unable to handle kernel NULL pointer dereference
> >
> > in rproc_virtio_notify, after firmware loading.
> 
> There wasn't any kernel stack trace?  What platform was this observed
> on? I'm afraid we won't be able to move forward with this patch
> without one, or more information on what is happening.
> 
> >
> > refuse to register an rproc-induced virtio device if no kick method was
> > defined for rproc.
> >
> > Signed-off-by: Nikita Shubin <NShubin@topcon.com>
> > ---

Nikita, please include "v2" in the subject and add here (below the ---)
short summary of what changes since v1.

> >  drivers/remoteproc/remoteproc_virtio.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> > index 8c07cb2ca8ba..31a62a0b470e 100644
> > --- a/drivers/remoteproc/remoteproc_virtio.c
> > +++ b/drivers/remoteproc/remoteproc_virtio.c
> > @@ -334,6 +334,13 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
> >         struct rproc_mem_entry *mem;
> >         int ret;
> >
> > +       if (rproc->ops->kick == NULL) {
> > +               ret = -EINVAL;
> > +               dev_err(dev, ".kick method not defined for %s",
> > +                               rproc->name);
> > +               goto out;
> > +       }
> 
> I think it would be better to use WARN_ONCE() in rproc_virtio_notify()
> than prevent a virtio device from being added.  But again I will need
> more information on this case to know for sure.
> 

I reviewed v1 and afaict there's no way rproc->ops->kick would change
and that things wouldn't work without a kick.

So I requested that it should be checked during initialization instead.
Please let me know if I missed some case.

Regards,
Bjorn

> Thanks,
> Mathieu
> 
> > +
> >         /* Try to find dedicated vdev buffer carveout */
> >         mem = rproc_find_carveout_by_name(rproc, "vdev%dbuffer", rvdev->index);
> >         if (mem) {
> > --
> > 2.24.1
> >
