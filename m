Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ABEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 01:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BCC62224D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 01:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX6h3ZYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHMBzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 21:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgHMBzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 21:55:04 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48670C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 18:55:04 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 128so2023096pgd.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 18:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=riMxm4J7KwZ/og2C888HhsGYQe6mih3KUJYo+bdkjBA=;
        b=nX6h3ZYwqFYvgEYQ0L4spKpFhkhFRBUJqgSSrPIeCGgqxcGp4QTE3t3GpX00X/Z0RH
         apB8O2GSIJHJEeHwUrHejbwBVmRe0mesd9f6QdUeXwXuaq3DJ20GWoRjhquT0zSgK0AL
         wTYTi8AJiDfkReyQK038kpCZ2YxBmRHCqRshthynu+6WqFER2QCp6rypLwcQBeMWVyOE
         fmtgOeu/vfaoM+ggSTKesrYw/nZ9escREGLqvYbMDidhzV1Y6TqM2vQhSUXyQk4tvlI7
         gMZHW3FTMwfNkw5BJsf4sg6ssePWk4KOUHEop9wvcbGT77vm5Jj2mBr2uo05R1OWiLKb
         QXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=riMxm4J7KwZ/og2C888HhsGYQe6mih3KUJYo+bdkjBA=;
        b=RU0TW1lB+/FdAwBaZli3Gqrba2CcpjpXuokR//x9WA7jv4mo71N9FmggmcOWtm2UrG
         pXUsxLlmbqmAoNDDKWQt0PzXqXzj78c9hv4gHSEc6UeIhqarS1dLF0rxKnAC0C1TxBFZ
         FzMDLFTNDf9dEvF5ylJQWSrnzGSfpEOm6e61+u479QnW8Q7QIlRL04P5dczDLzXujGvA
         dUyqYKR2NeZgYaXfqHnVEGhCDLz8FHkr7l1zSBzrduUvVNWujzj2em5SVyoRANid4L8v
         FnOfuSCF3g5XsyvTW1n9ioZfnr0aBPYHltzZITRfBzc4D6sqJ4Payo/ejRLZlijMXe5F
         v9Gw==
X-Gm-Message-State: AOAM531CgVINMiw8kwzhpWgoC7LE46yTMhB12iV4MDanNpeWGm0jgNI/
        Kd54fMBrvKmPV96ZY6ht8XM7wa9m
X-Google-Smtp-Source: ABdhPJy0wnoobTz63k5gsGOLKOCbkUukqFlVXukUUfl/UJqaVRDMDoXpj647IjWHXd6TJGkjtxUxjw==
X-Received: by 2002:a62:18ce:: with SMTP id 197mr2117068pfy.85.1597283703750;
        Wed, 12 Aug 2020 18:55:03 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id a5sm3647493pfi.79.2020.08.12.18.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 18:55:02 -0700 (PDT)
Date:   Thu, 13 Aug 2020 10:55:00 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhang.lyra@gmail.com,
        ruifeng.zhang1@unisoc.com, cixi.geng1@unisoc.com,
        Orson Zhai <orson.zhai@unisoc.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jon DeVree <nuxi@vault24.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH] printk: Change timestamp to triplet as mono, boot
 and real
Message-ID: <20200813015500.GC2020879@jagdpanzerIV.localdomain>
References: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
 <20200811094413.GA12903@alley>
 <87zh7175hj.fsf@nanos.tec.linutronix.de>
 <20200811130218.GI6215@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811130218.GI6215@alley>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/08/11 15:02), Petr Mladek wrote:
> On Tue 2020-08-11 14:05:12, Thomas Gleixner wrote:
> > Petr Mladek <pmladek@suse.com> writes:
> > > At least "crash" tool would need an update anyway. AFAIK, it checks
> > > the size of struct printk_log and refuses to read it when it changes.
> > >
> > > It means that the hack with VMCOREINFO_FIELD_OFFSET probably is not
> > > needed because we would need to update the crashdump-related tools anyway.
> > >
> > > Well, the timing is good. We are about to switch the printk ring
> > > buffer into a lockless one. It requires updating the crashdump tools
> > > as well. We could do this at the same time. The lockless ring buffer
> > > already is in linux-next. It is aimed for 5.10 or 5.11.
> > ...
> > > It would be great to synchronize all these changes changes of the
> > > printk log buffer structures.
> > 
> > I agree that having one update is a good thing, but pretty please can we
> > finally make progress with this and not create yet another dependency?
> 
> To make it clear. I definitely do not want to block lockless printk by
> this.
> 
> BTW: I am not 100% convinced that storing all three timestamps is
> worth it. It increases the code complexity, metadata size. It needs
> an interface with the userspace that has to stay backward compatible.

Can we, perhaps, store those various "alternative" timestamps in dict so
then whoever wants to read them can just parse the dict key:value pairs
attach to each printk message?

> Also it still will be racy because the timestamp is taken when the message
> is printed. It might be "long" before or after the event that
> it talks about.
>
> There is still the alternative to print all three timestamps regularly
> for those interested. It is less user convenient but much easier
> to maintain.

Yes, that's a nice alternative.

	-ss
