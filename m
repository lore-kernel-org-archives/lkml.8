Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2767AC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0463A2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SO7VsIzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502601AbgDPIol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:44:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32007 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2501961AbgDPIdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587025983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x6uigvF/bqZ4XEJh+/Tp1y2eX448wtyf+x6UNwQLqPY=;
        b=SO7VsIzB47+T1G+5I1oHNdbrD6NB4ZG+PgZkF/JKzT0vqErjBgZVPvXb8m0BP0GLTBlY8U
        9DtjrjvJx6hdHCNrf+1R8GJ+Vgd2lAmXBwpOqjoWcexOINRbz7gt8aMUJZtBJQeUD6EGAX
        MJ+vB4QEepOtQu2MpNaKwTonm1AhOXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-IrgZkNNJM023eKiYKLtW2A-1; Thu, 16 Apr 2020 04:24:28 -0400
X-MC-Unique: IrgZkNNJM023eKiYKLtW2A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1A5310CE780;
        Thu, 16 Apr 2020 08:24:26 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A80E119DED;
        Thu, 16 Apr 2020 08:24:24 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 03G8ONMg008685;
        Thu, 16 Apr 2020 04:24:23 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 03G8OKM4008681;
        Thu, 16 Apr 2020 04:24:21 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 16 Apr 2020 04:24:20 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Dan Williams <dan.j.williams@intel.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH] memcpy_flushcache: use cache flusing for larger
 lengths
In-Reply-To: <alpine.LRH.2.02.2004090612320.27517@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2004160411460.7833@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2004071029270.8662@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4goJ2jbXNVZbMUKtRUominhuMhuTKrMh=fnhrfvC4jyjw@mail.gmail.com> <alpine.LRH.2.02.2004081439080.13932@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4grNHvyYEc4W6PkymhEJvLb17tXbC3JZdqvtFxmMZ8DCQ@mail.gmail.com> <alpine.LRH.2.02.2004090612320.27517@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Apr 2020, Mikulas Patocka wrote:

> With dm-writecache on emulated pmem (with the memmap argument), we get
> 
> With the original kernel:
> 8508 - 11378
> real    0m4.960s
> user    0m0.638s
> sys     0m4.312s
> 
> With dm-writecache hacked to use cached writes + clflushopt:
> 8505 - 11378
> real    0m4.151s
> user    0m0.560s
> sys     0m3.582s

I did some multithreaded tests: 
http://people.redhat.com/~mpatocka/testcases/pmem/microbenchmarks/pmem-multithreaded.txt

And it turns out that for singlethreaded access, write+clwb performs 
better, while for multithreaded access, non-temporal stores perform 
better.

1       sequential write-nt 8 bytes             1.3 GB/s
2       sequential write-nt 8 bytes             2.5 GB/s
3       sequential write-nt 8 bytes             2.8 GB/s
4       sequential write-nt 8 bytes             2.8 GB/s
5       sequential write-nt 8 bytes             2.5 GB/s

1       sequential write 8 bytes + clwb         1.6 GB/s
2       sequential write 8 bytes + clwb         2.4 GB/s
3       sequential write 8 bytes + clwb         1.7 GB/s
4       sequential write 8 bytes + clwb         1.2 GB/s
5       sequential write 8 bytes + clwb         0.8 GB/s

For one thread, we can see that write-nt 8 bytes has 1.3 GB/s and write 
8+clwb has 1.6 GB/s, but for multiple threads, write-nt has better 
throughput.

The dm-writecache target is singlethreaded (all the copying is done while 
holding the writecache lock), so it benefits from clwb.

Should memcpy_flushcache be changed to write+clwb? Or are there some 
multithreaded users of memcpy_flushcache that would be hurt by this 
change?

Mikulas

