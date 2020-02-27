Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5825EC35DF9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26696246AD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RAltTZst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbgB0SDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:03:49 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40423 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730545AbgB0SDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:03:48 -0500
Received: by mail-qk1-f194.google.com with SMTP id m2so230550qka.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YVEntATD8Di4X+bfE0q+dQjUPZodyWiwMumJsgAjImQ=;
        b=RAltTZstLeabLiJ0d66x7j4b8d0dFG+sPOHfpbO/cFKDi0l5MP5SaBmzQZcj23Dj9O
         F/bYYNBZZSSfyS9/dujI6RC7S6GQGiGhjfoRC4Je5Ph5T17ppPj/nNg6eK7g8v4ebWzu
         Qxmk3XbPh4QJMBWSZz4NrK//VIcI+eMAy0MaVJAPx5AhdQtsNg6OJfWlFI3uTppHsXSP
         NLDKJ/17oMjJmVhx6/pQNGEX+CmviRc1utdWSmUNrTHklbQUwh86mk+awHvAFbaKoddd
         0oAlTI+2vm+ko8Vd1wYitYFGuU7IYpDc+5ksP1iJZ4Sf+eRw2yMQhLqeo1YoqRFOoTVh
         Z2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YVEntATD8Di4X+bfE0q+dQjUPZodyWiwMumJsgAjImQ=;
        b=m0rJUqApZgV5x/ml6gdTXfIrb3I5hBJghccxsTfs5n2t/dVQ4KA38xWQdN1DAtsF7n
         uy67J/A+NMP931RQcfXarlD/CjJyIgp07qh7eux1t/tiqAk07LLGxMq65J3bez46zGlZ
         8x6nBAlIykc9IPhIhNqiCnidYSRcg39l7O2hhX6xq/LJxVbVTDvYgQvI0eEnt7sDkTEd
         ot2AvhBdsY/OIjjVkaVG4FFom0aJVq2Ltk3Ki5sPYHDzqA3u/aGN/xsqpfHy9xzisxQc
         XQo/ZgtBv9uUjK5GeWH/kElaTC6vsqHIWhbWq6nXB09XUtJlyugChpQsBBffeafKexAU
         LyHA==
X-Gm-Message-State: APjAAAX/4VvLlfLiAM/aM5oUjuTp4xmzYxohFI/ISS8CsYn6unZ2dTnT
        /C2AGu2zO0WUKJK/EG+d3a5dHg==
X-Google-Smtp-Source: APXvYqy6UDThfoJk2c6gSaNxuGupf3hgdusGohKCaZ7APtBt0Z8E4pxTDMcVw55YbgzfmGfI1mrhOg==
X-Received: by 2002:a37:4e53:: with SMTP id c80mr533140qkb.58.1582826627303;
        Thu, 27 Feb 2020 10:03:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id e64sm3551886qtd.45.2020.02.27.10.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 10:03:46 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7NVi-0008Pb-Fb; Thu, 27 Feb 2020 14:03:46 -0400
Date:   Thu, 27 Feb 2020 14:03:46 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Badger <ebadger@gigaio.com>
Subject: Re: [PATCH v3 0/7] Allow setting caching mode in arch_add_memory()
 for P2PDMA
Message-ID: <20200227180346.GM31668@ziepe.ca>
References: <20200221182503.28317-1-logang@deltatee.com>
 <20200227171704.GK31668@ziepe.ca>
 <e8781f85-3fc7-b9ce-c751-606803cbdc77@deltatee.com>
 <20200227174311.GL31668@ziepe.ca>
 <CAPcyv4iek=EmNk9JgXq=-HcZjd9Kz4m2+qXMhnDWMshFKFZPXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iek=EmNk9JgXq=-HcZjd9Kz4m2+qXMhnDWMshFKFZPXQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 09:55:04AM -0800, Dan Williams wrote:
> On Thu, Feb 27, 2020 at 9:43 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Feb 27, 2020 at 10:21:50AM -0700, Logan Gunthorpe wrote:
> > >
> > >
> > > On 2020-02-27 10:17 a.m., Jason Gunthorpe wrote:
> > > >> Instead of this, this series proposes a change to arch_add_memory()
> > > >> to take the pgprot required by the mapping which allows us to
> > > >> explicitly set pagetable entries for P2PDMA memory to WC.
> > > >
> > > > Is there a particular reason why WC was selected here? I thought for
> > > > the p2pdma cases there was no kernel user that touched the memory?
> > >
> > > Yes, that's correct. I choose WC here because the existing users are
> > > registering memory blocks without side effects which fit the WC
> > > semantics well.
> >
> > Hm, AFAIK WC memory is not compatible with the spinlocks/mutexs/etc in
> > Linux, so while it is true the memory has no side effects, there would
> > be surprising concurrency risks if anything in the kernel tried to
> > write to it.
> >
> > Not compatible means the locks don't contain stores to WC memory the
> > way you would expect. AFAIK on many CPUs extra barriers are required
> > to keep WC stores ordered, the same way ARM already has extra barriers
> > to keep UC stores ordered with locking..
> >
> > The spinlocks are defined to contain UC stores though.
> 
> How are spinlocks and mutexes getting into p2pdma ranges in the first
> instance? Even with UC, the system has bigger problems if it's trying
> to send bus locks targeting PCI, see the flurry of activity of trying
> to trigger faults on split locks [1].

This is not what I was trying to explain.

Consider

 static spinlock lock; // CPU DRAM
 static idx = 0;
 u64 *wc_memory = [..];

 spin_lock(&lock);
 wc_memory[0] = idx++;
 spin_unlock(&lock);

You'd expect that the PCI device will observe stores where idx is
strictly increasing, but this is not guarenteed. idx may decrease, idx
may skip. It just won't duplicate.

Or perhaps

 wc_memory[0] = foo;
 writel(doorbell)

foo is not guarenteed observable by the device before doorbell reaches
the device.

All of these are things that do not happen with UC or NC memory, and
are surprising violations of our programming model.

Generic kernel code should never touch WC memory unless the code is
specifically designed to handle it.

Jason
