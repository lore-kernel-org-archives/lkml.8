Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8066BC38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 15:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B15320732
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 15:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xjd8dKqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgDRPVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 11:21:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31989 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725903AbgDRPVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 11:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587223301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JvLhttfS/P2TlDwSsVUBOcQQgfZrp/EhHMfZ+MkQwFg=;
        b=Xjd8dKqqrgOLD6UDmwe9PzSpytK+V9Csw6Yz09+Vf9id66uiVr/SE1iPRSWfrEm61ZlcYb
        TN/XM/6fep6kMq8ZDDgOa+Z3x6jkfm76PxcmWFG1kGZTrMw86/JkjE9gPSUnM5SoFkGTXg
        cFjNauoBzQ4IZaURwmNkjvm7ZGnhMn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-CdiyjcWqPtiVODUaXU5P7g-1; Sat, 18 Apr 2020 11:21:37 -0400
X-MC-Unique: CdiyjcWqPtiVODUaXU5P7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12C81800D5C;
        Sat, 18 Apr 2020 15:21:35 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9058D5C1C3;
        Sat, 18 Apr 2020 15:21:31 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 03IFLVw4030597;
        Sat, 18 Apr 2020 11:21:31 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 03IFLR2e030593;
        Sat, 18 Apr 2020 11:21:28 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sat, 18 Apr 2020 11:21:27 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     David Laight <David.Laight@ACULAB.COM>
cc:     Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: RE: [PATCH] x86: introduce memcpy_flushcache_clflushopt
In-Reply-To: <69c2e011c5814255926f309dd50e6d67@AcuMS.aculab.com>
Message-ID: <alpine.LRH.2.02.2004181110160.30139@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2004071029270.8662@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4goJ2jbXNVZbMUKtRUominhuMhuTKrMh=fnhrfvC4jyjw@mail.gmail.com> <alpine.LRH.2.02.2004081439080.13932@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4grNHvyYEc4W6PkymhEJvLb17tXbC3JZdqvtFxmMZ8DCQ@mail.gmail.com> <alpine.LRH.2.02.2004090612320.27517@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2004160411460.7833@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gpe8u=zNrRhvd9ioVNGbOJfRUXzFZuV--be6Hbj0xXtQ@mail.gmail.com> <alpine.LRH.2.02.2004170831530.16047@file01.intranet.prod.int.rdu2.redhat.com> <69c2e011c5814255926f309dd50e6d67@AcuMS.aculab.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Apr 2020, David Laight wrote:

> From: Mikulas Patocka
> > Sent: 17 April 2020 13:47
> ...
> > Index: linux-2.6/drivers/md/dm-writecache.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/md/dm-writecache.c	2020-04-17 14:06:35.139999000 +0200
> > +++ linux-2.6/drivers/md/dm-writecache.c	2020-04-17 14:06:35.129999000 +0200
> > @@ -1166,7 +1166,10 @@ static void bio_copy_block(struct dm_wri
> >  			}
> >  		} else {
> >  			flush_dcache_page(bio_page(bio));
> > -			memcpy_flushcache(data, buf, size);
> > +			if (likely(size > 512))
> > +				memcpy_flushcache_clflushopt(data, buf, size);
> > +			else
> > +				memcpy_flushcache(data, buf, size);
> 
> Hmmm... have you looked at how long clflush actually takes?
> It isn't too bad if you just do a small number, but using it
> to flush large buffers can be very slow.

Yes, I have. It's here: 
http://people.redhat.com/~mpatocka/testcases/pmem/microbenchmarks/pmem.txt

sequential write 8 + clflush	- 0.3 GB/s on nvdimm
sequential write 8 + clflushopt - 1.6 GB/s on nvdimm
sequential write-nt 8 bytes	- 1.3 GB/s on nvdimm

> I've an Ivy bridge system where the X-server process requests the
> frame buffer be flushed out every 10 seconds (no idea why).
> With my 2560x1440 monitor this takes over 3ms.
> 
> This really needs a cond_resched() every few clflush instructions.
> 
> 	David

AFAIK Ivy Bridge doesn't have clflushopt, it only has clflush. clflush 
only allows one outstanding cacle line flush, so it's very slow. 
clflushopt and clwb relaxed this restriction and there can be multiple 
cache-invalidation requests in flight until the user serializes it with 
the sfence instruction.

The patch checks for clflushopt with 
"static_cpu_has(X86_FEATURE_CLFLUSHOPT)" and if it is not present, it 
falls back to non-temporal stores.

Mikulas

