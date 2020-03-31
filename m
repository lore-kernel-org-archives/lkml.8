Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BB4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B93208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585651326;
	bh=imsnPA4JCAInhZuF+6cN29LP+UEQkzirwfry5AqSjoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y7LkFeEm6RxHT8gnXF/Kr4mOWSH+pB9PJZ/+eKOnlnNywNDisEUh3+CVo5YCup4LT
	 2xCzvqmealO33Yh/UBiGxDExfhNwsIpalZ3XvKH22FIDFPWQlAWbWIg7JvrMCYenoR
	 Gnz3+cKj5QbzSSO8lr4Mu1C4No8yMBsZfLKYHZuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgCaKmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:42:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729925AbgCaKmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 06:42:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5338F20772;
        Tue, 31 Mar 2020 10:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585651319;
        bh=imsnPA4JCAInhZuF+6cN29LP+UEQkzirwfry5AqSjoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7Zg/zvTMTOmfZtJP1ZYyyktkLVY0CSxepy30ZLypgvHM4DsTyFltOlU/RhRm4f/x
         1Oicim8UmkM2ZBnl2BUabChT+WRYIjnoExzKnyfuS2gG1dma3NnIFmQVyPhtDgp/em
         KJ2zxOOkRZ73azXNHt9/6bZtZOnssh+mAHDsZAjo=
Date:   Tue, 31 Mar 2020 11:30:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Nicolas Pitre <nico@fluxnic.net>,
        Chen Wandun <chenwandun@huawei.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Jiri Slaby <jslaby@suse.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukas Wunner <lukas@wunner.de>, ghalat@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] vt: don't use kmalloc() for the unicode screen buffer
Message-ID: <20200331093041.GA1199411@kroah.com>
References: <nycvar.YSQ.7.76.2003281745280.2671@knanqh.ubzr>
 <nycvar.YSQ.7.76.2003282214210.2671@knanqh.ubzr>
 <20200330190759.GE7594@ravnborg.org>
 <CAKMK7uF_mZ3yJouqAOO9v7jaso2aL6GSwRK13uOEuUsOevdUBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uF_mZ3yJouqAOO9v7jaso2aL6GSwRK13uOEuUsOevdUBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:43:11AM +0200, Daniel Vetter wrote:
> On Mon, Mar 30, 2020 at 9:08 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Nicolas
> >
> > On Sat, Mar 28, 2020 at 10:25:11PM -0400, Nicolas Pitre wrote:
> > > Even if the actual screen size is bounded in vc_do_resize(), the unicode
> > > buffer is still a little more than twice the size of the glyph buffer
> > > and may exceed MAX_ORDER down the kmalloc() path. This can be triggered
> > > from user space.
> > >
> > > Since there is no point having a physically contiguous buffer here,
> > > let's avoid the above issue as well as reducing pressure on high order
> > > allocations by using vmalloc() instead.
> > >
> > > Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> > > Cc: <stable@vger.kernel.org>
> > >
> > > ---
> > >
> > > Changes since v1:
> > >
> > > - Added missing include, found by kbuild test robot.
> > >   Strange that my own build doesn't complain.
> >
> > When I did the drmP.h removal vmalloc was one of the header files
> > that turned up missing in many cases - but only for some architectures.
> > I learned to include alpha in the build.
> > If it survived building for alpha then I had fixed the majority
> > of the issues related to random inherited includes.
> >
> > The patch itself looks good.
> >
> > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Greg, I'm assuming you'll pick this up through the tty tree? I kinda
> want to stop the habit of merging vt patches, maybe then
> get_maintainers will stop thinking I'm responsible somehow :-)

Yes, I'll take it, and have been taking vt patches for a few releases
now so don't worry, you aren't responsible anymore :)

thanks,

greg k-h
