Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98182C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8AD20734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Z0/isLNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgGQHHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgGQHHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:07:09 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2214C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 00:07:08 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id e4so7257971oib.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 00:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CPnX6ZZ4pxkd9TAEZP+nlom1WGP6ShX2uzkhMxmoCgs=;
        b=Z0/isLNmTG17gmG6L59e06uZwFWTkG8667jfHIAozBpa6HGgY8MTxvN87ov9noGknf
         ROx8mOGckDSd85/k3criF7VUrhME58WXh95iPmWNWTP5goFt+mjfIpABBJN15TPoCp+Z
         cs3/jV1pYvFMgfXabtoWtWc1XCsFSstQFrnsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPnX6ZZ4pxkd9TAEZP+nlom1WGP6ShX2uzkhMxmoCgs=;
        b=LQne0namIaxKTyQIw4RwrUvAcaqIKeqg66L4Vy/HNcqk7RyhrxIia7EbZXIyPhGBpF
         sfQf49adJe8qZglEAjAwGHSRqbnLcW1RlV5lvsyM8AgLFQfDeUY5IhWfltIjcbBJUBJZ
         HPLYIiuEjAAAwIls0ElP1eNoPBw2UTi4VpuhrtrKh43PQmFjJvdH0sxLLz3T/W1wMDxm
         lwWQRxDTFf8lMBTd2elLCDY+yR9CHXds8pXZs2neeRYPUmWtZPyETe8ZfrnGakB8duso
         9Uchlf3930ekTGI6/Qt+yVdVYpoKQEYUzs5vbOMrIJ6j6a6i/KBJ21UMRz8be0jR9VsU
         vlLA==
X-Gm-Message-State: AOAM530zM3gI2nTUp+6qvNfw8jA2E/sMHAHn08wA4TCtZBD+goQrxM9t
        UV9Yoom/t81TYV7VqQWR0TYZR/KUsIwsgvgJlt9xsQ==
X-Google-Smtp-Source: ABdhPJxQMEGaDN2TI7WZI9cZeuv/fedq3mzV9H5A703+/MWxi0v21K2uuqaxm5IjyKaaYDVrylh/NF7mAhXcgLjbVPU=
X-Received: by 2002:aca:da03:: with SMTP id r3mr6602701oig.14.1594969628090;
 Fri, 17 Jul 2020 00:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200716090333.13334-1-miaoqinglang@huawei.com> <20200717064017.GA76612@jamwan02-TSP300>
In-Reply-To: <20200717064017.GA76612@jamwan02-TSP300>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 17 Jul 2020 09:06:57 +0200
Message-ID: <CAKMK7uEpmhKok9Q3Rrg0v=1p7pv-wpV0Y3-k9GVav+Ad5Z4AkQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/komeda: Convert to DEFINE_SHOW_ATTRIBUTE
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     Qinglang Miao <miaoqinglang@huawei.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 8:40 AM james qian wang (Arm Technology China)
<james.qian.wang@arm.com> wrote:
>
> On Thu, Jul 16, 2020 at 05:03:33PM +0800, Qinglang Miao wrote:
> > From: Liu Shixin <liushixin2@huawei.com>
> >
> > Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> >
> > Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> > ---
> >  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > index 0246b2e94..4a10e6b9e 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > @@ -41,18 +41,7 @@ static int komeda_register_show(struct seq_file *sf, void *x)
> >       return 0;
> >  }
> >
> > -static int komeda_register_open(struct inode *inode, struct file *filp)
> > -{
> > -     return single_open(filp, komeda_register_show, inode->i_private);
> > -}
> > -
> > -static const struct file_operations komeda_register_fops = {
> > -     .owner          = THIS_MODULE,
> > -     .open           = komeda_register_open,
> > -     .read_iter              = seq_read_iter,
> > -     .llseek         = seq_lseek,
> > -     .release        = single_release,
> > -};
> > +DEFINE_SHOW_ATTRIBUTE(komeda_register);
> >
>
> Hi Shixin & Qinglang
>
> Thanks for your patch.
>
> Reviewed-by: James Qian Wang <james.qian.wang@arm.com>
>
> Since your patch is not for drm-misc-next, so seems better
> to leave it to you to merge it. :)

I do think it's for drm-misc-next, what other tree would it be for?
Some people put -next in their patch tag to differentiate from -fixes,
so maintainers know what to do with the patch. It's also not part of a
series, hence I think this is on you to apply it.

Cheers, Daniel

>
> Thanks
> James
>
> >  #ifdef CONFIG_DEBUG_FS
> >  static void komeda_debugfs_init(struct komeda_dev *mdev)
> > --
> > 2.17.1
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
