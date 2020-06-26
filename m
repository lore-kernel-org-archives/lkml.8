Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B329C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC5E3207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593175633;
	bh=ghOcSnKLh1qBcrM/sdPdydWDEu/uuz/OGlZDCEKbh88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F3wk+cbzkH5ztUoKkjHE0gB+fgQQIQ8zJ+jNw3Gk0IlywtZkhnpquYHy5PYZWylzO
	 lnj3p19IGCVizd/FXRG5pwjx6MDWqDRNLiyC/mdPjTRU9+6UR9iMm9CkYQkbDyuBKv
	 RLmwO5u5xBd75zswKQdzxwdcXYnp4P4ZvPDeKQdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgFZMrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:47:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39630 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFZMrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:47:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id d18so1161370edv.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 05:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q677LOBSZK3GRaj2PYVKEMW6WT8sZ6D1XkKn5i6DRN8=;
        b=IQM4HdJXmLAIhcFusoLdXrkJERGMKeO/Od/ysK/lO6IPf+5WuGtdYLrPp3KNXQpOJK
         LxtGdF+FeJl2sbjIUDsDymZODVNuYtgRNpTV5D3qIz4BF5L5QckDB1wjB0ELmu2Mklgc
         4e/g0D/DhTzV03w5iWOA5nEfYn6dqAbbPGrmaOME8DRZ0pLLf5DYCnBEH1CsjvSch1CT
         +f9k1slcEAS5TcHlwuvyLlHbNwCisWAkyHjw6oybAojTywZ8PIkzcuvJ56UYFKBNL7t1
         lnjlCrC5NQ8tmepjV2kUY/EgKRasC3FU0N3mkajeqdhc1EwmcdZrqg3Jw6NtfT/wuAr6
         Onbg==
X-Gm-Message-State: AOAM531MUgpQH50Hi3QbkobaPOd7HAFehjnc//GfLsJNn2MINR3q3sXs
        rcxXfu8E+hzWM/b6FbN7R/wwlm6E
X-Google-Smtp-Source: ABdhPJzvRrQp4sNnBeNy5DvIM5p2B4BWpsaztrroQ2rsv/gwu1/HcbrtyIX4R2sLP1GO438dmbsPOA==
X-Received: by 2002:a50:f047:: with SMTP id u7mr3373855edl.274.1593175628873;
        Fri, 26 Jun 2020 05:47:08 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id a62sm21499657ede.45.2020.06.26.05.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:47:08 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:47:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v2] x86/mm: use max memory block size on bare metal
Message-ID: <20200626124706.GZ1320@dhcp22.suse.cz>
References: <20200609225451.3542648-1-daniel.m.jordan@oracle.com>
 <20200619120704.GD12177@dhcp22.suse.cz>
 <20200622191739.4lekqrmjnzv2vwl2@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622191739.4lekqrmjnzv2vwl2@ca-dmjordan1.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-06-20 15:17:39, Daniel Jordan wrote:
> Hello Michal,
> 
> (I've been away and may be slow to respond for a little while)
> 
> On Fri, Jun 19, 2020 at 02:07:04PM +0200, Michal Hocko wrote:
> > On Tue 09-06-20 18:54:51, Daniel Jordan wrote:
> > [...]
> > > @@ -1390,6 +1391,15 @@ static unsigned long probe_memory_block_size(void)
> > >  		goto done;
> > >  	}
> > >  
> > > +	/*
> > > +	 * Use max block size to minimize overhead on bare metal, where
> > > +	 * alignment for memory hotplug isn't a concern.
> > 
> > This really begs a clarification why this is not a concern. Bare metal
> > can see physical memory hotadd as well. I just suspect that you do not
> > consider that to be very common so it is not a big deal?
> 
> It's not only uncommon, it's also that boot_mem_end on bare metal may not align
> with any available memory block size.  For instance, this server's boot_mem_end
> is only 4M aligned and FWIW my desktop's is 2M aligned.  As far as I can tell,
> the logic that picks the size wasn't intended for bare metal.

> 
> > And I would
> > tend to agree but still we are just going to wait until first user
> > stumbles over this.
> 
> This isn't something new with this patch, 2G has been the default on big
> machines for years.  This is addressing an unintended side effect of
> 078eb6aa50dc50, which was for qemu, by restoring the original behavior on bare
> metal to avoid oodles of sysfs files.

I am not really sure the qemu was a target. I suspect it was just easier
to test in qemu.

[...]

> > I believe that we should think about a future interface rather than
> > trying to ducktape the blocksize anytime it causes problems. I would be
> > even tempted to simply add a kernel command line option 
> > memory_hotplug=disable,legacy,new_shiny
> > 
> > for disable it would simply drop all the sysfs crud and speed up boot
> > for most users who simply do not care about memory hotplug. new_shiny
> > would ideally provide an interface that would either export logically
> > hotplugable memory ranges (e.g. DIMMs) or a query/action interface which
> > accepts physical ranges as input. Having gazillions of sysfs files is
> > simply unsustainable.
> 
> So in this idea, presumably the default would start off being legacy and then
> later be changed to new_shiny?

Well it really depends. Going with disable as a default would suit most
users much better because the vast majority simply doesn't use the
functionality. On the other hand real users would regress unless they
enable the option. Which is definitely not nice. Another and much less
intrusive change would be creating sysfs interface on-demand. So until
somebody actually tries to use the interface it won't exist. I haven't
tried to explore how complex that would be. I am not really familiar
with sysfs to be honest. But fundamentally nothing should prevent such a
solution.

Another option would be to create sysfs interface only if there is a
hotplugable memory reported by the platform. But I am not sure we have a
proper interface for that for all arches.
-- 
Michal Hocko
SUSE Labs
