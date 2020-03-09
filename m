Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA93DC18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966E92464B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583770355;
	bh=GIRsxtYGGZ/TKj/qEtugQGPGGyg7OevInygZMPq+Co0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PA7q2jr7CrW3I0gaSorgk/cIMkjbvxBRr3s4sXiFBQq9p/4966VPrAJq1tsZNIoDX
	 BLs/rinO6/wC3I6rBLxymtL0IqtyybpG64T4Co/O8QmWlsLK63/MsEnL78JywTT+CG
	 76v2fxhjNX2DsE2e4XPtQDgo1AItUvtXhL5WgItI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCIQMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:12:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45612 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCIQMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:12:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id m9so2955583wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 09:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ns9eVzO0p4o5Bx4eeLESDE82IoXncv33ZlQOlMd3q+E=;
        b=HjT00sgt0uwGXFLQikGbkyAzXKAHNlgFYGSXtP80snCZKRD7zT2UTj2iwtqm74ShQ7
         8Ihay+fadQYZ5RjCdXl2SHSzgOThrT29aMZKke61zx1je7KfthTlRaAwip1+2qqwJOZX
         SzJk6Jtpmhwxe0yQBCe7/PKI890CvVaNJbETPwpniDUjgSlKxPWMuly5Hp6KcTCRMhA3
         xN6CF5PNN1szhHKJLqFQwduMBDI3oHK7HlcdGDiOK+AJAtnlyp9BmEoM/PMLmvSYmW6L
         32KAeVZmbeU5SaF5rIqak7ajL44/fvXXkLwtjc6YxSejAcMs6jwc6xZ4iuwpFbJ82STR
         xQgQ==
X-Gm-Message-State: ANhLgQ0g+0RJKFC8hsjsu+VrlLzmVkoeHQtdux9ri9jFwUZ2jVbT8bx5
        ZZj/SSppM+0w0+AzUwKeu4c=
X-Google-Smtp-Source: ADFU+vtGtkMl72MPjSoG4s8UweB4LM3o4SVaJcSG020HGNIU3RPOAlOTn9cx796UeKN6w4dB0+QhJw==
X-Received: by 2002:a5d:514a:: with SMTP id u10mr1799384wrt.360.1583770352235;
        Mon, 09 Mar 2020 09:12:32 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id u8sm16068166wrn.69.2020.03.09.09.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 09:12:31 -0700 (PDT)
Date:   Mon, 9 Mar 2020 17:12:30 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shaju Abraham <shajunutanix@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Shaju Abraham <shaju.abraham@nutanix.com>
Subject: Re: [PATCH] mm/vmpressure.c: Include GFP_KERNEL flag to vmpressure
Message-ID: <20200309161230.GT8447@dhcp22.suse.cz>
References: <20200309113141.167289-1-shaju.abraham@nutanix.com>
 <20200309115818.GK8447@dhcp22.suse.cz>
 <CAGxeL8CxaeKsqEMtLMZL8mdxUXPcH6ZkpMNjUmzZJ6q603B-_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxeL8CxaeKsqEMtLMZL8mdxUXPcH6ZkpMNjUmzZJ6q603B-_g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-03-20 21:02:50, Shaju Abraham wrote:
> On Mon, Mar 9, 2020 at 5:28 PM Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Mon 09-03-20 11:31:41, Shaju Abraham wrote:
> > > The VM pressure notification flags have excluded GFP_KERNEL with the
> > > reasoning that user land will not be able to take any action in case of
> > > kernel memory being low. This is not true always. Consider the case of
> > > a user land program managing all the huge memory pages. By including
> > > GFP_KERNEL flag whenever the kernel memory is low, pressure notification
> > > can be send, and the manager process can split huge pages to satisfy
> > kernel
> > > memory requirement.
> >
> > Are you sure about this reasoning? GFP_KERNEL = __GFP_FS | __GFP_IO |
> > __GFP_RECLAIM
> > Two of the flags mentioned there are already listed so we are talking
> > about __GFP_RECLAIM here. Including it here would be a more appropriate
> > change than GFP_KERNEL btw.
> >
> > But still I do not really understand what is the actual problem and how
> > is this patch meant to fix it. vmpressure is triggered only from the
> > reclaim path which inherently requires to have __GFP_RECLAIM present
> > so I fail to see how this can make any change at all. How have you
> > tested it?
> >
> >    We have a user space application which waits on memory pressure events.

> Upon receiving the event, the user space program will free up huge
> pages to make more memory available in the system.  This mechanism
> works fine if the memory is being consumed by other user space
> applications. To test this, we wrote a test program which will
> allocate all the memory available in the system using malloc() and
> touch the allocated pages. When the free memory level becomes low,
> the pressure event is fired and the process gets notified about it .
> The same test is repeated with kmalloc() instead of malloc(). A test
> kernel module is developed, which will allocate all the available
> memory with kmalloc(GFP_KERNEL) flag.  The OOM killer gets invoked in
> this case. The memory pressure event is not fired.  After modifying
> the vmpressure.c with the attached patch, the pressure event gets
> triggered.  Swap is disabled in the system we were testing.

Are you sure this is really the case? I am either missing something here
or your test might simply be timing specific because

	GFP_KERNEL & (__GFP_FS | __GFP_IO) = true

so I really do not see how the current code could bail out on the test
you are patching so that the patch would make any change. The only real
difference this patch makes is to trigger events for __GFP_RECLAIM
allocations which could be GFP_NOIO. All non-sleepable allocations would
wake kswapd and that would in turn reclaim with _GFP_FS | __GFP_IO set
so the check doesn't change anything.

Am I missing something?
-- 
Michal Hocko
SUSE Labs
