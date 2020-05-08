Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E00C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2771620720
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588904328;
	bh=EuEfExuv8GxUm/9AxpNngXeruKZTglHQOLfbSIXQvS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jZkicLgD4WJ+4QGj6RDeVtPGDpl7JCHvXkgc1GIv3bISc3v4KzX/jT3UUq2gS+q9+
	 JK++ZMLFz+erAFH+DA6LcV0DqzqnmOX6K8U7Y2afmhcl12SAX5baPKgVdujpcS5ZqN
	 OI0/1LG4nVmOGelAZYrWaDXkrgABLfBZbTLsVUYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgEHCSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 22:18:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43201 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgEHCSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 22:18:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id z6so35498plk.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 19:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rrANQAw88TdCPS5Lvil2wuvQ/jrJH7vBB9S7MegCNOM=;
        b=ua2zl0bgb9dDhNJkVWs4Y6fhqcybLc9gD5+ovjfIsITFkBRyYQOv5IYmRDC8fST10t
         qrrVbijpzypdLJ0HO74NvNv52qhNEY0eFCZ+0obX75TEaH4XFtADWpDvRiJN682sTkex
         NL6ILUaGJ5SCkrZRBozw8XlXkIXNbAYBa1H40z41NtEXh4TbyI2a8vMO3x6FF8bs0GUM
         jdKo2XQw+7hfH90gEF+ce4oX4QnvqbUtBxM7g97c/Pv8wfGztzkSFM8dViou87EO/iVs
         SoNXbFdn/Bj5G4Wl7cl2sxDE1xieTFO5cBfto3xfNcFFLK3v6VYvgtO99nMZr0yNGfPc
         j6aQ==
X-Gm-Message-State: AGi0Pua/9BF4oLJAS282YTHVNLBELQDQfB9IZR+fid7CK7mvsq5oFeWc
        IcrYCqr36jQ3JW7IuoF/qwM=
X-Google-Smtp-Source: APiQypI/jZXDBh9K0zLWBC20fYdxXjE/xq7oJZyHmdC0STsLykww2+QM7KRyd/kcZiVCWWosyVWw9Q==
X-Received: by 2002:a17:90b:3110:: with SMTP id gc16mr3367219pjb.155.1588904326314;
        Thu, 07 May 2020 19:18:46 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b29sm182297pgn.15.2020.05.07.19.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 19:18:45 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id EBEEF403EA; Fri,  8 May 2020 02:18:44 +0000 (UTC)
Date:   Fri, 8 May 2020 02:18:44 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     jeyu@kernel.org
Cc:     akpm@linux-foundation.org, arnd@arndb.de, rostedt@goodmis.org,
        mingo@redhat.com, aquini@redhat.com, cai@lca.pw, dyoung@redhat.com,
        bhe@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        gpiccoli@canonical.com, pmladek@suse.com, tiwai@suse.de,
        schlad@suse.de, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        nborisov@suse.com
Subject: Re: [RFC] taint: add module firmware crash taint support
Message-ID: <20200508021844.GB11244@42.do-not-panic.com>
References: <20200508021438.4373-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508021438.4373-1-mcgrof@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 02:14:38AM +0000, Luis Chamberlain wrote:
> Device driver firmware can crash, and sometimes, this can leave your
> system in a state which makes the device or subsystem completely
> useless. Detecting this by inspecting /proc/sys/kernel/tainted instead
> of scraping some magical words from the kernel log, which is driver
> specific, is much easier. So instead provide a helper which lets drivers
> annotate this.
> 
> Once this happens, scrapers can easily scrape modules taint flags.
> This will taint both the kernel and respective calling module.
> 
> The new helper module_firmware_crashed() uses LOCKDEP_STILL_OK as
> this fact should in no way shape or form affect lockdep. This taint
> is device driver specific.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> Below is the full diff stat of manual inspection throughout the kernel
> when this happens. My methodology is to just scrape for "crash" and
> then study the driver a bit to see if indeed it seems like that the
> firmware crashes there. In *many* cases there is even infrastructure
> for this, so this is sometimes clearly obvious. Some other times it
> required a bit of deciphering.
> 
> The diff stat below is what I have so far, however the patch below
> only includes the drivers that start with Q, as they were a source of
> inspiration for this, and to make this RFC easier to read.
> 
> If this seems sensible, I can follow up with the kernel helper first,
> and then tackle each subsystem independently.
> 
> I purposely skipped review of remoteproc and virtualization. That should
> require its own separate careful review and considerations.
> 

I should also note that another motivation for this is it is *very*
common for support issues to creep up, where the issues at hand are
firmware related. Easily ruling out a firmware crash, and later devising
tooling which captures this, can help with support.

  Luis
