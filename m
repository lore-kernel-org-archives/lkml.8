Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DE3C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D4B220720
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588917861;
	bh=9bFkVGNTv2FLfvQPxTLIZwCeKL0Hz20Fpl2o6uhgv6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X6LDGLlKAgSNDd397Pq2BEFANWP49CpXNwOUkL5C8Oj0Ca3OP6M/Wca0SogJm/C6e
	 sqM3RaLzlYt0YttxxSLl4w6OFE6AUQ4ngY8eztl0Wc3TbBsVrkzr5Elv1pGVYyj8gr
	 gJeqsIjrOSPadDeclyc2sWI6UmiqS3eXI70nrae4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgEHGEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:04:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41070 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgEHGET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:04:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id u10so263759pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 23:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bhh8Hh8RF4UmT7ZujEDKC5a04db0JAVysUUltBxyiuc=;
        b=QfLfERn6y81T1/rns3p0EvYPTZq82PTb7/f156pX+D85MNf/ml6E0FQEyPKPuGokfF
         XePKhuQYo3pH9p7EvMxb2i0pjOHMBUL7jLIwstlNk1MFx8Anj7OSivgTrV8EaVPYBzya
         Fe13toNIakgPONgrrCaXeUmNqMWQDYB+2/KYXjNqRPZy+jy/2otVZTyZ6k9yTDgkWcZV
         meu9HMyOQRibZTg0jzkJISnHC82XCea8lj/blvaCdyBGiyTzaq09I9OxLQ1aAFdI3nla
         Vro0rvknD6zlGIrdz40hWWr4NvVVHvhhGGjlnbyTgmfDiltvc1hRU4WZzCNoyZEfQAyb
         IKCg==
X-Gm-Message-State: AGi0PuZvrWj2SrQFm/3R1F3v1AbSeAXe9mB2t/BCuO5HDd5Opa+UyMHk
        aUlVDKLY2dbPt+L/28GKSHs=
X-Google-Smtp-Source: APiQypLL/0NgJzJ9C6A/AWa+BcOb2rxReqycHPYHl3403j+fYrWnyGK3SAQ7xTo/uSgdux6NmFla0Q==
X-Received: by 2002:a17:90b:3843:: with SMTP id nl3mr4377936pjb.72.1588917858973;
        Thu, 07 May 2020 23:04:18 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id m63sm629925pfb.101.2020.05.07.23.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 23:04:17 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1B19A403EA; Fri,  8 May 2020 06:04:17 +0000 (UTC)
Date:   Fri, 8 May 2020 06:04:17 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     jeyu@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
        rostedt@goodmis.org, mingo@redhat.com, aquini@redhat.com,
        cai@lca.pw, dyoung@redhat.com, bhe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, gpiccoli@canonical.com,
        pmladek@suse.com, tiwai@suse.de, schlad@suse.de,
        andriy.shevchenko@linux.intel.com, daniel.vetter@ffwll.ch,
        will@kernel.org, mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] taint: add module firmware crash taint support
Message-ID: <20200508060417.GE11244@42.do-not-panic.com>
References: <20200508021438.4373-1-mcgrof@kernel.org>
 <202005072244.F2E0286@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005072244.F2E0286@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 10:47:08PM -0700, Kees Cook wrote:
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
> 
> This all seems reasonable to me. You might need to break these up into
> per-maintainer patches to get appropriate review. Perhaps land the
> infrastructure and some initial patches via netdev and in the next
> release send patches for DRM, media, etc?

Works for me.

I'll give it a few more days for review on the RFC before I shoot out a
series for netdev.

  Luis
