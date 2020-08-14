Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA691C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9594720838
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597443441;
	bh=50MT4w5TiZE5W7kv+5tPls0JCQfaUVXnZIje/GL0rWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HC12nd4dCXq/5d7W5qMIcfz9+bjic5JWLSvQ6f2CWSqbsxdsTZxJDrUa5RyMIeFSl
	 IqaPnQqizk+QYh8ZF91kuC+45ZZMT5kbDpojuMDOyzcY/R6ZOGZ7Pxrq1L3Os/v8Ym
	 eS8zY+UEMZ0y2HVLr42RR5zjWocpxvS6ol8an+Dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHNWRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgHNWRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 18:17:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9EAC061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:17:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p37so5185531pgl.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a4ibtvRrxAoVM/NN3yAdW+CNBTEGC3GLvqFI/rLefWY=;
        b=S6ugoHFB19hswaDF7+sl0LqxfBR5gH3Qs1lHFTlv2ur9/qH60hWFtDCK0mGjTV/M7/
         Ds5jeJSUtAUa0JwVvT2bJXc+mq1go2SGDmEO88HwtCVoWw2uoo1t5ks5d83pdW7wCDRe
         sD08nt0GktPOZTcdaKozmgQu01XfpHLFK1uuD35njHAo3aNVDd5aYe4qPvhADaNvnnzW
         EKnNz6Nni79odgWL8aosALhOYgqjbvDYAQHLnPRyxn9LCRpTsuszlUs46su1XVOf8gkQ
         BMX2BGnKOY48pVHIIqCW+XAPqtJTBTaN5W7UhPNVQiIJ4oyRhjMGtaSkIPBXfQTT7YDU
         jwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=a4ibtvRrxAoVM/NN3yAdW+CNBTEGC3GLvqFI/rLefWY=;
        b=mKCpEqmMtR0dWsDi2URlENDi/I63E0G60+hps9SfRAY55jrdAm0YuGOBTuc6e3FCMy
         MzUp8gSfcbACUnUh91Qg5NZXVckdT1CpKbeInSWVICPPlHp7GJZiG5u32c0Li4cY/xIO
         SSJdeLqOS1maw3eNE6fXqYu5LCUmVI6zdGX2XJDNIaL9NJzzf7H/NfayeMofZ9PG5iJq
         DN1mg9vvsNuJKD9wJiY/XaKHNrNsOLnlVb4jfBxd5YSKWJ+NIbG+NaUGPh9caxxgUtrU
         KSy7qXgKHWTeI4ArYxXE0VQZtI/8RDe+k3BKrfW3Ypr2FZzfxRzsletBTK4SgLPtrIsm
         NQXQ==
X-Gm-Message-State: AOAM530patr/n7o2y9R69WAsAXhzi5IzB6nvVgkco9G5AUuJ2cl5jePL
        loJl3K3VrNtAte8J2fxYAog=
X-Google-Smtp-Source: ABdhPJySVfX1y36ooWMxyTSGFMnmfvSsPaON68rV+0v2YSK1IRpYY32sA3uk9a+GhNtd/UPiXxTHRw==
X-Received: by 2002:aa7:9468:: with SMTP id t8mr3163170pfq.182.1597443438653;
        Fri, 14 Aug 2020 15:17:18 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id t25sm10048324pfe.51.2020.08.14.15.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 15:17:17 -0700 (PDT)
Date:   Fri, 14 Aug 2020 15:17:15 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <klamm@yandex-team.ru>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, liumartin@google.com,
        fengguang.wu@intel.com
Subject: Re: [PATCH] mm : update ra->ra_pages if it's NOT equal to
 bdi->ra_pages
Message-ID: <20200814221715.GA2856780@google.com>
References: <1597368611-7631-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20200814014355.GS17456@casper.infradead.org>
 <20200814020700.GT17456@casper.infradead.org>
 <CAGWkznEkTeTq4-wPKBcNsF2vF5SVaFc3xoZmceKSwg34vpkqbg@mail.gmail.com>
 <20200813193307.d5597367b7964d95f63e4580@linux-foundation.org>
 <CAGWkznFwDnrSqt68oMp+rcNFT_EgN3ke7-e0Tb1xfXreVXgHYw@mail.gmail.com>
 <20200814031929.GV17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814031929.GV17456@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 04:19:29AM +0100, Matthew Wilcox wrote:
> On Fri, Aug 14, 2020 at 10:45:37AM +0800, Zhaoyang Huang wrote:
> > On Fri, Aug 14, 2020 at 10:33 AM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > >
> > > On Fri, 14 Aug 2020 10:20:11 +0800 Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> > >
> > > > On Fri, Aug 14, 2020 at 10:07 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Fri, Aug 14, 2020 at 02:43:55AM +0100, Matthew Wilcox wrote:
> > > > > > On Fri, Aug 14, 2020 at 09:30:11AM +0800, Zhaoyang Huang wrote:
> > > > > > > file->f_ra->ra_pages will remain the initialized value since it opend, which may
> > > > > > > be NOT equal to bdi->ra_pages as the latter one is updated somehow(etc,
> > > > > > > echo xxx > /sys/block/dm/queue/read_ahead_kb).So sync ra->ra_pages to the
> > > > > > > updated value when sync read.
> > > > > >
> > > > > > It still ignores the work done by shrink_readahead_size_eio()
> > > > > > and fadvise(POSIX_FADV_SEQUENTIAL).
> > > > >
> > > > > ... by the way, if you're trying to update one particular file's readahead
> > > > > state, you can just call fadvise(POSIX_FADV_NORMAL) on it.
> > > > >
> > > > > If you want to update every open file's ra_pages by writing to sysfs,
> > > > > then just no.  We don't do that.
> > > > No, What I want to fix is the file within one process's context  keeps
> > > > using the initialized value when it is opened and not sync with new
> > > > value when bdi->ra_pages changes.
> > >
> > > So you're saying that
> > >
> > >         echo xxx > /sys/block/dm/queue/read_ahead_kb
> > >
> > > does not affect presently-open files, and you believe that it should do
> > > so?
> > >
> > > I guess that could be a reasonable thing to want - it's reasonable for
> > > a user to expect that writing to a global tunable will take immediate
> > > global effect.  I guess.
> > >
> > > But as Matthew says, it would help if you were to explain why this is
> > > needed.  In full detail.  What operational problems is the present
> > > implementation causing?
> > The real scenario is some system(like android) will turbo read during
> > startup via expanding the readahead window and then set it back to
> > normal(128kb as usual). However, some files in the system process
> > context will keep to be opened since it is opened up and has no chance
> > to sync with the updated value as it is almost impossible to change
> > the files attached to the inode(processes are unaware of these
> > things). we have to fix it from a kernel perspective.
> 
> OK, this is a much more useful description of the problem, thank you!

It's not the first time we brought up the issue.
https://patchwork.kernel.org/patch/10866161/
Hopefully, we have some solution at this time.

> 
> I can think of two possibilities here.  One is that maybe our readahead
> heuristics just don't work on modern phone hardware.  Perhaps we need
> to ramp up more aggressively by default.
> 
> The other is that maybe it really is just a "boost at startup" kind
> of situation and so we should support _that_.  Some interface where
> we can set a ra_boost, and then do:
> 
> 	if (ra_boost)
> 		newsize *= 2;
> 
> in get_init_ra_size().

With kernel boot paramter, it sounds good idea to me.
