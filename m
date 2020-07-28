Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EA1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C580A205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig4tkCGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgG1LPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbgG1LPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:15:30 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9DCC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:15:30 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l64so11394076qkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QIWDEkYc8mxAlKuadsKFH4VbD1YSAM7HFnbpBmNVSO8=;
        b=ig4tkCGz3vBobXOMO7BoapRzWs6lWMRevLLAhF4HMFvFHk51aV5q+u29L0ciq0z5Bw
         9heErKQGzKLJu5Sw+Tw8VfRTOpDfyoBOqwfy2SZT/dmbgSiqBwmyZDc5LBGtDvPp23+u
         ofAVBqom40t6XY+Ryc4eHoYhp7jof7gqfisCiwstRZMWzsipSyHPeAlmGRCltZqByuur
         l5qxWpuYjXF5o+VAXFK8pnsE41kEu8Ku+gq4KJ+NjXqKFmQyHyT29aBk3fOpJmkdk56z
         gTlNgo1uRetcwRU0yFDtYZBt1QJi9/sa5lS94DXH4cgYhPvvM969UBD0TUp9jO4NsJC8
         Z2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QIWDEkYc8mxAlKuadsKFH4VbD1YSAM7HFnbpBmNVSO8=;
        b=LLDY5dTHxrfjWflX/17QJOSx++VtWjycWxZZMAiVNPl6KS4YAnn+m9/nfpmCpPvcZo
         vBWAWrMRa6JmE5BHJDSF1Xr7AJl4+yt28khgzjr6gaPtRNfIUFwsufGM+TSds1B+mi2R
         SiSrq8/+SVLFjs5HFIvHl2tXn8qhAkQvfbWUc5wBzm7FMWj6LigDHtbFd7jcV1Xhfj1W
         RPTFFvMPM6eJsYGFvHjQt7O6vpyCkHphkfwBJ7oVOxuPIaXH/wsDzNRoTvBiq9hbxhjq
         y/gjyY+NBHc7yv3ehkBbSPOMdU72F/OGsd7ceCiGR9+48EfbSy9iWF8cuAzvd1IFnzYs
         J+rQ==
X-Gm-Message-State: AOAM533kfz4gqTNHtuBc5j+MtHdNxIKbjJMVC1kJM/3w03HzKoOK6IkG
        d9Qx7UsQiE+4sfWRDK4U2A==
X-Google-Smtp-Source: ABdhPJwnCLW6FdwCOh5nOUuPdn7nxL775A6fuG5o1mUkIc3N4vsgVbSbHf8jAqg4H/8NhGRdHWbh9g==
X-Received: by 2002:a05:620a:151:: with SMTP id e17mr27492002qkn.173.1595934929870;
        Tue, 28 Jul 2020 04:15:29 -0700 (PDT)
Received: from PWN (c-76-119-149-155.hsd1.ma.comcast.net. [76.119.149.155])
        by smtp.gmail.com with ESMTPSA id w27sm17261967qtv.68.2020.07.28.04.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 04:15:29 -0700 (PDT)
Date:   Tue, 28 Jul 2020 07:15:27 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-kernel-mentees] [PATCH] drm/bufs: Prevent kernel-infoleak
 in copy_one_buf()
Message-ID: <20200728111527.GA407693@PWN>
References: <20200728014343.341303-1-yepeilin.cs@gmail.com>
 <CAK8P3a29=CugbGtZRQc0abGXvexp=gBk+LwOCG3yNCPakup+NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a29=CugbGtZRQc0abGXvexp=gBk+LwOCG3yNCPakup+NQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 10:11:09AM +0200, Arnd Bergmann wrote:
> On Tue, Jul 28, 2020 at 3:45 AM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> >
> > copy_one_buf() is copying uninitialized stack memory to userspace due to
> > the compiler not initializing holes in statically allocated structures.
> > Fix it by initializing `v` with memset().
> 
> I would add 'potentially' somewhere in that description: it is architecture
> dependent whether there are holes in this structure as 'enum' types
> and 'long' are both dependent on the ABI, and even if there is a hole,
> it is undefined behavior whether the hold gets initialized.

I see. I will fix that up. Thank you for the advice!

Peilin Ye

> Other than that, the patch looks good.
> 
> > Cc: stable@vger.kernel.org
> > Fixes: 5c7640ab6258 ("switch compat_drm_infobufs() to drm_ioctl_kernel()")
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
