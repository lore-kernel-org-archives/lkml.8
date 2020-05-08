Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E44C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04BAF208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588919086;
	bh=pPSmWEmJ160Bc+WllwR+8KD7YugnYDy2tA6HHf0l9fE=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=tEDrWxVovUmTxIgoczmtgE1bdomELsBgTg/s77sdHnfrH5W3LZlvhth6IJW2StPyw
	 cnL6uL6O7kjtVKfH7HhQwM/kwLK/5FfHPq8CXs1yLDNdN4ucqcf0kGX5mBT2NSkdkP
	 IVxRnsUH5p9cNCQhDsw2hClkPdmS8ZoERM7nBuHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEHGYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:24:45 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54678 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgEHGYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:24:44 -0400
Received: by mail-pj1-f65.google.com with SMTP id y6so3799949pjc.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 23:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i1+Fi2Gz9aO+LiI1IuEp79dxri3zzcr9BCWHTv4nO+I=;
        b=IwXRuU9OcKUxo0wmJ72HlDxRIscL7zUvMLXEhptENiqE4ItWgU4voIIMgQDq9TF1vZ
         JpL+xSD3sUx4Od2GD9eQUnCcXPnnhBEHXTfNFDAnjEbS88C1sugaoJujZxPo6dtxa3NL
         TvFL8he9DSwy36aJ6sA+AzZxMViZoQ0gWLqII6z+58paL+2HZelTrpEH3yGMN6QSQ0F7
         3YAtNRAIN5is4AM9BDnFIaC6T2Igh2FYG8r2EMsdb1gI1vIF3eh0ZnZOngWjVE3pIWS4
         2H82LhYL94pNm4yY9D+d6gk86t0iqKErpO6KmT6qjbhA1joCmxAH5mAKdgb+OYvXs0/q
         fyPA==
X-Gm-Message-State: AGi0PubV6/9eSmj7H7EWXqDCWVAGammQ2ctCxmppX6P4+9GuGZ6Yh9wx
        6TWDUed+pWV6J2LRx9jhG4Q=
X-Google-Smtp-Source: APiQypKJsrqaL4JlAyOtu2/FGMvMdnRLTeRLGdWuZh3doKFP2zosIkuGbYxfLzHWIh1r44SjtEN5vQ==
X-Received: by 2002:a17:902:bd07:: with SMTP id p7mr872744pls.293.1588919082050;
        Thu, 07 May 2020 23:24:42 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id w126sm709574pfb.117.2020.05.07.23.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 23:24:41 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 5A4CB403EA; Fri,  8 May 2020 06:24:40 +0000 (UTC)
Date:   Fri, 8 May 2020 06:24:40 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     jeyu@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
        rostedt@goodmis.org, mingo@redhat.com, aquini@redhat.com,
        cai@lca.pw, dyoung@redhat.com, bhe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, gpiccoli@canonical.com,
        pmladek@suse.com, tiwai@suse.de, schlad@suse.de,
        andriy.shevchenko@linux.intel.com, keescook@chromium.org,
        will@kernel.org, mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] taint: add module firmware crash taint support
Message-ID: <20200508062440.GF11244@42.do-not-panic.com>
References: <20200508021438.4373-1-mcgrof@kernel.org>
 <20200508061124.GZ10381@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508061124.GZ10381@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 08:11:24AM +0200, Daniel Vetter wrote:
> On Fri, May 08, 2020 at 02:14:38AM +0000, Luis Chamberlain wrote:
> > Device driver firmware can crash, and sometimes, this can leave your
> > system in a state which makes the device or subsystem completely
> > useless. Detecting this by inspecting /proc/sys/kernel/tainted instead
> > of scraping some magical words from the kernel log, which is driver
> > specific, is much easier. So instead provide a helper which lets drivers
> > annotate this.
> > 
> > Once this happens, scrapers can easily scrape modules taint flags.
> > This will taint both the kernel and respective calling module.
> > 
> > The new helper module_firmware_crashed() uses LOCKDEP_STILL_OK as
> > this fact should in no way shape or form affect lockdep. This taint
> > is device driver specific.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> > 
> > Below is the full diff stat of manual inspection throughout the kernel
> > when this happens. My methodology is to just scrape for "crash" and
> > then study the driver a bit to see if indeed it seems like that the
> > firmware crashes there. In *many* cases there is even infrastructure
> > for this, so this is sometimes clearly obvious. Some other times it
> > required a bit of deciphering.
> > 
> > The diff stat below is what I have so far, however the patch below
> > only includes the drivers that start with Q, as they were a source of
> > inspiration for this, and to make this RFC easier to read.
> > 
> > If this seems sensible, I can follow up with the kernel helper first,
> > and then tackle each subsystem independently.
> > 
> > I purposely skipped review of remoteproc and virtualization. That should
> > require its own separate careful review and considerations.
> > 
> >  drivers/atm/nicstar.c                               |  1 +
> >  drivers/bluetooth/hci_qca.c                         |  1 +
> >  drivers/gpu/drm/i915/i915_gpu_error.c               |  1 +
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c         |  2 ++
> >  drivers/gpu/drm/msm/msm_gpu.c                       |  1 +
> 
> I'm not finding the drm changes in your diff below ... 

That was on purpose, as this was an RFC and I didnt' want to
clutter this with noise.

> Also what Kees
> said, I think best to split this up and properly cc per
> get_maintainers.pl.

Sounds good.

  Luis
