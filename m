Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA193C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE99B2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Oat+rg8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgGQJKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQJK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:10:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E10EC061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 02:10:29 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so16097707wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 02:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RIrVrjLtwQkL3McUGwUvIB+DN94jC/DLEexvQhe84YU=;
        b=Oat+rg8i3eREhjXd/whtaoFRwxL99mKRwt9AkCnB0C/RJsr759mEe8qgpffcyNXwhG
         39wM8ciPlUx4tVBowm+NAr4Xjo82ghubNT8bHKRqGfdu97LzUEy+6IWkHi4Y5eEwKsqW
         J3BcCuV/p1+VoQPRJOD8bhVAtIUnxxv2Nmy4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=RIrVrjLtwQkL3McUGwUvIB+DN94jC/DLEexvQhe84YU=;
        b=MqsmRDSLRLC84bSk3pFqu1hGmJJoIm7dKA5RUlLTZScced1opYg81t0RSMFXB/mRYc
         x4xDMpNM6LnLgbEDhCm4qMOxve/7JVQtiviyoxzRA6mUX8FxAgfgMUUCYBp9kxOzeEOW
         bTIOBAWTtqKSQ26a5C/CW5HbiFN3B0GsaEGGc+r1ijao9l2F44HJfGY93+rlYj3Lefrp
         SoYHD2+A9Hgg7K9UmJD8ctOUqUYjLiO9sJ7A0Hn6nCxm3pskvzO40EwgXlyrZnxLeLCq
         7uOKndNfVSvzWCeHG963JjwqyFtrd1EUfSMjHfGBHyYQS6OC+FTSEauRNNyekKt1dp6u
         Ee+g==
X-Gm-Message-State: AOAM5334+KqViCupo01VqbtHe7b0/a2KqkIMWD53G29d8MzBJuf0oZAW
        P9AGrjIWxrWFfjZ0JQ/zve+q7g==
X-Google-Smtp-Source: ABdhPJzMR/Nane2DdiBw7mSJD3ueSyM8gA9dJI4WCAq43nH9MbNG5XlLOsgXnYJoYG7mnlR1nH30cA==
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr8072794wma.18.1594977028210;
        Fri, 17 Jul 2020 02:10:28 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u186sm13015061wmu.10.2020.07.17.02.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 02:10:27 -0700 (PDT)
Date:   Fri, 17 Jul 2020 11:10:25 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     miaoqinglang <miaoqinglang@huawei.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>
Subject: Re: [PATCH -next] drm/komeda: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20200717091025.GQ3278063@phenom.ffwll.local>
Mail-Followup-To: miaoqinglang <miaoqinglang@huawei.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>
References: <20200716090333.13334-1-miaoqinglang@huawei.com>
 <20200717064017.GA76612@jamwan02-TSP300>
 <CAKMK7uEpmhKok9Q3Rrg0v=1p7pv-wpV0Y3-k9GVav+Ad5Z4AkQ@mail.gmail.com>
 <7264de7e-6da4-288d-855d-410b2e05458b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7264de7e-6da4-288d-855d-410b2e05458b@huawei.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 04:00:36PM +0800, miaoqinglang wrote:
> 
> 
> 在 2020/7/17 15:06, Daniel Vetter 写道:
> > On Fri, Jul 17, 2020 at 8:40 AM james qian wang (Arm Technology China)
> > <james.qian.wang@arm.com> wrote:
> > > 
> > > On Thu, Jul 16, 2020 at 05:03:33PM +0800, Qinglang Miao wrote:
> > > > From: Liu Shixin <liushixin2@huawei.com>
> > > > 
> > > > Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> > > > 
> > > > Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> > > > ---
> > > >   drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 13 +------------
> > > >   1 file changed, 1 insertion(+), 12 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > > > index 0246b2e94..4a10e6b9e 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > > > @@ -41,18 +41,7 @@ static int komeda_register_show(struct seq_file *sf, void *x)
> > > >        return 0;
> > > >   }
> > > > 
> > > > -static int komeda_register_open(struct inode *inode, struct file *filp)
> > > > -{
> > > > -     return single_open(filp, komeda_register_show, inode->i_private);
> > > > -}
> > > > -
> > > > -static const struct file_operations komeda_register_fops = {
> > > > -     .owner          = THIS_MODULE,
> > > > -     .open           = komeda_register_open,
> > > > -     .read_iter              = seq_read_iter,
> > > > -     .llseek         = seq_lseek,
> > > > -     .release        = single_release,
> > > > -};
> > > > +DEFINE_SHOW_ATTRIBUTE(komeda_register);
> > > > 
> > > 
> > > Hi Shixin & Qinglang
> > > 
> > > Thanks for your patch.
> > > 
> > > Reviewed-by: James Qian Wang <james.qian.wang@arm.com>
> > > 
> > > Since your patch is not for drm-misc-next, so seems better
> > > to leave it to you to merge it. :)
> > 
> > I do think it's for drm-misc-next, what other tree would it be for?
> > Some people put -next in their patch tag to differentiate from -fixes,
> > so maintainers know what to do with the patch. It's also not part of a
> > series, hence I think this is on you to apply it.
> >
> Hi James & Daniel,
> 
> ​Sorry I didn't make it clear in commit log, but it do based on linux-next.
> 
> ​I think the reason why James think it's not for drm-misc-next
> is conflicts exists when this patch being applied. There's conflicts because
> commit <4d4901c6d7> which switched over direct seq_read method calls to
> seq_read_iter should applied before this clean-up patch(linkage listed as
> below).
> 
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/+/4d4901c6d748efab8aab6e7d2405dadaed0bea50
> 
> I can send a new patch based on mainline if needed.

Uh yes this is annoying. We're at feature cutoff so this will likely cause
bad conflicts no matter what if we merge it now, but the clean solution is
to rebase onto drm-misc-next, and then let maintainers sort out the mess
with conflicts. It's a pretty simple change in the above patch, so
shouldn't cause too many troubles.
-Daniel

> 
> ​Thanks.
> 
> Qinglang
> 
> .
> 	
> >
> > Cheers, Daniel
> > 
> > > 
> > > Thanks
> > > James
> > > 
> > > >   #ifdef CONFIG_DEBUG_FS
> > > >   static void komeda_debugfs_init(struct komeda_dev *mdev)
> > > > --
> > > > 2.17.1
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 
> > 
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
