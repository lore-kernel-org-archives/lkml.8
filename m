Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8F9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFFE72074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZtjbP6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgEONsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgEONsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:48:20 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0596FC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 06:48:19 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g12so2736839wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 06:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3qkYfWFETK6zBf4wXa1Hi398hQXeE5GebQwhI+ncIdg=;
        b=eZtjbP6NRTFnwBBzAQ/7vAIDOd0g+tBLTmdd6At7C7aKYpemjjiVaON1bhVUUka4xC
         fdspZ0DuMKB3IXzMrf+3fR3wLygypG8KaN12CdmaGZQ2FmwH8pUXNlPKBbDgCvg+59/j
         zdeM6ghctOvVndEqGsVetE7otExcx/34sd2COmwwEw61Dpsn5VAnv01ICh9OtH7azKr5
         zBESlD1TJsEj1W/APW4a22VPev9cTkzEPtO03frS2BuR/1czA3sk57k9hWopVbsnhyG9
         wqtB3qgQZXTGqNyRM5daJvWnvCqQLbaNTpxQNJZCUtyDUArxuTHxqwaKZ6mT9iu9bYfs
         5B3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3qkYfWFETK6zBf4wXa1Hi398hQXeE5GebQwhI+ncIdg=;
        b=IQImSgb3xKmFszSSoOUj2fGfvtOEIEURklQrXOG+50HkHpO/1cC9vfVy8ayA9OFZmM
         e2uht1ewSUZyCnNyVpIimAkbwcLBFfjg94cImccDg8afM28YW/qwhj4cwgsL+QPuTKMG
         Bpw5r0wDdJxThaEhLZs9ut/zNA5ghz4W4lccHe6a2QZi5+q/vs5LwPnWLwyxfEMKV3d3
         YNKkDGONmgZ6PCPZuHUPyyRIF2xaPKzTZ6nz/t/hHvLP4Wbjtobaom7SrUBV3KMVJbFx
         VCxNbdMG+usIgkGSmKu4JEdx7ntmyDxjXA1tLodxKE4KVRax8IFJi+4Poj8SLysnd9s3
         6qvg==
X-Gm-Message-State: AOAM530kn2eOUpdBPTAORbE2h8iU2V2087O43e5Ox/hu7Mc6tPzS8dXC
        MQnWl+B0sYp0LG6nqjy1gs3Yfw==
X-Google-Smtp-Source: ABdhPJzqCP16mihqtDEJGuadqt0+54o3/v4lzS/VEwkSC5lwNA/9e1HsDMpU5KA7xPyOK2gQe0cgwQ==
X-Received: by 2002:a1c:a952:: with SMTP id s79mr4008010wme.153.1589550489338;
        Fri, 15 May 2020 06:48:09 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id s12sm3556478wmc.7.2020.05.15.06.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 06:48:08 -0700 (PDT)
Date:   Fri, 15 May 2020 14:48:06 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>, Sumit Garg <sumit.garg@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] printk/kdb: Redirect printk messages into kdb in any
 context
Message-ID: <20200515134806.5cw4xxnxw7k3223l@holly.lan>
References: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org>
 <20200512142533.ta4uejwmq5gchtlx@holly.lan>
 <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
 <20200514084230.GO17734@linux-b0ei>
 <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
 <20200515085021.GS17734@linux-b0ei>
 <20200515103308.GD42471@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515103308.GD42471@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 07:33:08PM +0900, Sergey Senozhatsky wrote:
> On (20/05/15 10:50), Petr Mladek wrote:
> > kdb is able to stop kernel even in NMI context where printk() is redirected
> > to the printk_safe() lockless variant. Move the check and redirect to kdb
> > even in this case.
> 
> Can I please have some context what problem does this solve?
> I can see that vkdb_printf() calls into console drivers:
> 
> 	for_each_console(c) {
> 		c->write(c, cp, retlen - (cp - kdb_buffer));
> 		touch_nmi_watchdog();
> 	}
> 
> Is this guaranteed that we never execute this path from NMI?

Absolutely not.

The execution context for kdb is pretty much unique... we are running a
debug mode with all CPUs parked in a holding loop with interrupts
disabled. One CPU is at an unknown exception state and the others are
either handling an IRQ or NMI depending on architecture[1].

However there are a number of factors that IMHO weigh in favour of
allowing kdb to intercept here.

1. kgdb/kdb are designed to work from NMI, modulo the bugs that are
   undoubtedly present.

2. A synchronous breakpoint (including an implicit breakpoint-on-oops)
   from any code that executes with irqs disabled will exhibit most of
   the same problems as an NMI but without waking up all the NMI logic.

3. kdb_trap_printk is only set for *very* narrow time intervals by the
   debug master (the single CPU in the system that is *not* in a
   holding loop). Thus in all cases the system has already successfully
   executed kdb_printf() several times before we ever call the printk()
   interception code.

   Or put another way, even if we did tickle a bug speculated about in
   #1, it won't be the call to printk() that triggers it; we'd never
   get that far!


> If so, can this please be added to the commit message? A more
> detailed commit message will help a lot.

I suspect Petr might prefer any future flames about kdb_printf() to be
pointed at me rather than him ;-) so if adding anything to the commit
message then I'd suggest it be based on the reasoning in #3 above.


Daniel.
