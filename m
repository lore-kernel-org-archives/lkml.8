Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F1FC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1DCD2222D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ufe0gGKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390840AbgDPS2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgDPS2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:28:20 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BC2C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 11:28:20 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s3so2021844eji.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 11:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2C8tnZUkXvDOPI4LGiThjtqlJf5lF5YB6Qvi7NuNHc=;
        b=ufe0gGKl/pOUpmSwLR6hxD/PkZvSZu5TScGHSAHidmhiqKc5HZ46e4LaVrkmeCkgXf
         lAVkYHHT0xteZuZpfvMh3t4czdzuMQo4R2sk7zePN1b13RTn8yByroQPIaYlycwjGZqC
         SxY3TvQPv81rkc1OUHRrOZx3qY6Bx8pKeJAYLSHXOOoL0I1EaBtd/f7Ilhyp7UXiLJ0f
         rL6qmn86Ld467VRhTFJtgSlcMJJfgv9+kXp/rUQKJXT9qrNqps+TQGGjMdWrSSySRnmE
         NC0/3a6yEptRW084OcW4s7aGfWZ/MeMiBVRsEOCogw1Il1OfnlxztY31JHO6N1n0KSp9
         unVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2C8tnZUkXvDOPI4LGiThjtqlJf5lF5YB6Qvi7NuNHc=;
        b=nP4GLvNWMsxQc6mj5k4V0f4oWCPATyam6JNFxdtqhZ4+DX6Z36fpYJs6rDYTcPGxDu
         C4AV0OwSgTGfEXUvxPKat6n2TG5zj60+b5RkxbW2hwG5KMtXt9DNPOI6x+emeEomz7r6
         GD0X3k9+ciYXEhscznRCvnZyn6NGxLep6M15KFqKfX1B+IHjgsQBKmvGM0u9RJ3+YSLX
         Ic5O7K20zB38tMy+XcfYvCubZ5lHs8bQyw2BB++STBG2fbCstQqrsg3nQvWT7fXsA8Ox
         L+fITQOOxTR/BXnw+Et9Awo32xzxNxxmo2d5rxcuMo+NFZepqytLUrkcMhgukBhmUAzb
         E5IQ==
X-Gm-Message-State: AGi0Pubr8QQ5tOFr+5qppok53+SkhaAxsbE7XNCy+azuMLR6y/FP+2P6
        6a9gZu804nb2NqAMrSsezNclWH+ivgc2HNrp7i60lA==
X-Google-Smtp-Source: APiQypKg5p3UtDDDUAC5BeiqxcINJ4Q5ZLFEWimvcVbhxmgl2NSkS3aW+g4Sb0nCEKd7xDOZovcvge0jB7LET6eTihM=
X-Received: by 2002:a17:906:90cc:: with SMTP id v12mr10995580ejw.211.1587061699158;
 Thu, 16 Apr 2020 11:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2004071029270.8662@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4goJ2jbXNVZbMUKtRUominhuMhuTKrMh=fnhrfvC4jyjw@mail.gmail.com>
 <alpine.LRH.2.02.2004081439080.13932@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4grNHvyYEc4W6PkymhEJvLb17tXbC3JZdqvtFxmMZ8DCQ@mail.gmail.com>
 <alpine.LRH.2.02.2004090612320.27517@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2004160411460.7833@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2004160411460.7833@file01.intranet.prod.int.rdu2.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 16 Apr 2020 11:28:08 -0700
Message-ID: <CAPcyv4gpe8u=zNrRhvd9ioVNGbOJfRUXzFZuV--be6Hbj0xXtQ@mail.gmail.com>
Subject: Re: [PATCH] memcpy_flushcache: use cache flusing for larger lengths
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 1:24 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Thu, 9 Apr 2020, Mikulas Patocka wrote:
>
> > With dm-writecache on emulated pmem (with the memmap argument), we get
> >
> > With the original kernel:
> > 8508 - 11378
> > real    0m4.960s
> > user    0m0.638s
> > sys     0m4.312s
> >
> > With dm-writecache hacked to use cached writes + clflushopt:
> > 8505 - 11378
> > real    0m4.151s
> > user    0m0.560s
> > sys     0m3.582s
>
> I did some multithreaded tests:
> http://people.redhat.com/~mpatocka/testcases/pmem/microbenchmarks/pmem-multithreaded.txt
>
> And it turns out that for singlethreaded access, write+clwb performs
> better, while for multithreaded access, non-temporal stores perform
> better.
>
> 1       sequential write-nt 8 bytes             1.3 GB/s
> 2       sequential write-nt 8 bytes             2.5 GB/s
> 3       sequential write-nt 8 bytes             2.8 GB/s
> 4       sequential write-nt 8 bytes             2.8 GB/s
> 5       sequential write-nt 8 bytes             2.5 GB/s
>
> 1       sequential write 8 bytes + clwb         1.6 GB/s
> 2       sequential write 8 bytes + clwb         2.4 GB/s
> 3       sequential write 8 bytes + clwb         1.7 GB/s
> 4       sequential write 8 bytes + clwb         1.2 GB/s
> 5       sequential write 8 bytes + clwb         0.8 GB/s
>
> For one thread, we can see that write-nt 8 bytes has 1.3 GB/s and write
> 8+clwb has 1.6 GB/s, but for multiple threads, write-nt has better
> throughput.
>
> The dm-writecache target is singlethreaded (all the copying is done while
> holding the writecache lock), so it benefits from clwb.
>
> Should memcpy_flushcache be changed to write+clwb? Or are there some
> multithreaded users of memcpy_flushcache that would be hurt by this
> change?

Maybe this is asking for a specific memcpy_flushcache_inatomic()
implementation for your use case, but leave nt-writes for the general
case?
