Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C05C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34682051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="OHwtUxke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbgCPMUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:20:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39273 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbgCPMUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:20:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id j15so13865751lfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 05:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J8YUTClzRgvng0fzkDnAw6wm4bet3cBK2RMWpNTw50E=;
        b=OHwtUxkeYyduPn5JOxhuQR6L/s5Rpj50a+jiGUkG+EcQB/+vKpyNFpTgnwR4AKIbP4
         TLWmj2PcNh6QFPo1YymyBhqrd/0wVX3C5vU/H9Z0a8bxfDpJQzSMJmRiaW+c7WPinTc0
         yFKj4SJah/mRy9NJK5SnSDz2AlttQJgrsO7tEcehbWeWQTw8Ce1bQpYp93Sx7nfUTpQ/
         dRsK2yY1dyNjg3cx6PybicSXjMIvS5oA2PGusg4UfMRiSL//+RxWmabACi45OPXmW5Sh
         096RJdC2OtLBjLIru6TJgzTpymavrdzXxeqBkFXa50VJyyz1XzvajZmHJW6W6u0nqAW7
         5fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J8YUTClzRgvng0fzkDnAw6wm4bet3cBK2RMWpNTw50E=;
        b=oLZc4SBTDCBsXPlA5Zk89wFcz/e/Z+I6M2RIeEY9xwlmJM0nc5fkxmz9nlAHkfIZKa
         skRIIkMomJMjPiVawKCk7cdX7BKlqk5nikIcGsQ77IEv7Co0i8PQTxzXZ7zsWgsVDy0/
         2lXTnkZfYNfAcJyxbESj2jVqJGVQijzrTx+LPndK7RPu/5KPxO3ZgBDAzRt1KdW9Pg95
         RryDjK3LS9YCuLx+hKYjR7fCb4SutIn6jnx4+M58eb2dTVzjV+C4FM4Hq/k0VnEnIQQX
         +Wms5VGsb4alk6uDhZzQnxoiK0zt1Ee91gHLw+tvSM6VrrPNxNUeWBH4a6s3wfsApOX4
         HD/Q==
X-Gm-Message-State: ANhLgQ28BJkZ5JTaiUXcpWtKbb4ZM/hTfNJkv2ekaNguDpU/vk4KV9pI
        TfMua+C/kMFh2pUuGWNXAOu7Sw==
X-Google-Smtp-Source: ADFU+vtYrnwB4BW815GverT2AqJB2YjKH7It9G4GEeOtBlqCITjbpOAvpuGmle+K2+n6HRxArZuPrg==
X-Received: by 2002:a19:4f07:: with SMTP id d7mr97465lfb.30.1584361196442;
        Mon, 16 Mar 2020 05:19:56 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c20sm29388070lfb.60.2020.03.16.05.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 05:19:55 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D3FE0102588; Mon, 16 Mar 2020 15:19:55 +0300 (+03)
Date:   Mon, 16 Mar 2020 15:19:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Salman Qazi <sqazi@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] mm: clear 1G pages with streaming stores on x86
Message-ID: <20200316121955.tqmhu57evzafc2cl@box>
References: <20200307010353.172991-1-cannonmatthews@google.com>
 <20200309000820.f37opzmppm67g6et@box>
 <20200309090630.GC8447@dhcp22.suse.cz>
 <20200309153831.GK1454533@tassilo.jf.intel.com>
 <20200309183704.GA1573@bombadil.infradead.org>
 <CAJfu=UfPKZwqjGR5AdhFRo_je7X5q2=zpBSBQkrbh2KhYrOJiA@mail.gmail.com>
 <20200311005447.jkpsaghrpk3c4rwu@box>
 <20200316101856.GH11482@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316101856.GH11482@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 11:18:56AM +0100, Michal Hocko wrote:
> On Wed 11-03-20 03:54:47, Kirill A. Shutemov wrote:
> > On Tue, Mar 10, 2020 at 05:21:30PM -0700, Cannon Matthews wrote:
> > > On Mon, Mar 9, 2020 at 11:37 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Mon, Mar 09, 2020 at 08:38:31AM -0700, Andi Kleen wrote:
> > > > > > Gigantic huge pages are a bit different. They are much less dynamic from
> > > > > > the usage POV in my experience. Micro-optimizations for the first access
> > > > > > tends to not matter at all as it is usually pre-allocation scenario. On
> > > > > > the other hand, speeding up the initialization sounds like a good thing
> > > > > > in general. It will be a single time benefit but if the additional code
> > > > > > is not hard to maintain then I would be inclined to take it even with
> > > > > > "artificial" numbers state above. There really shouldn't be other downsides
> > > > > > except for the code maintenance, right?
> > > > >
> > > > > There's a cautious tale of the old crappy RAID5 XOR assembler functions which
> > > > > were optimized a long time ago for the Pentium1, and stayed around,
> > > > > even though the compiler could actually do a better job.
> > > > >
> > > > > String instructions are constantly improving in performance (Broadwell is
> > > > > very old at this point) Most likely over time (and maybe even today
> > > > > on newer CPUs) you would need much more sophisticated unrolled MOVNTI variants
> > > > > (or maybe even AVX-*) to be competitive.
> > > >
> > > > Presumably you have access to current and maybe even some unreleased
> > > > CPUs ... I mean, he's posted the patches, so you can test this hypothesis.
> > > 
> > > I don't have the data at hand, but could reproduce it if strongly
> > > desired, but I've also tested this on skylake and  cascade lake, and
> > > we've had success running with this for a while now.
> > > 
> > > When developing this originally, I tested all of this compared with
> > > AVX-* instructions as well as the string ops, they all seemed to be
> > > functionally equivalent, and all were beat out by this MOVNTI thing for
> > > large regions of 1G pages.
> > > 
> > > There is probably room to further optimize the MOVNTI stuff with better
> > > loop unrolling or optimizations, if anyone has specific suggestions I'm
> > > happy to try to incorporate them, but this has shown to be effective as
> > > written so far, and I think I lack that assembly expertise to micro
> > > optimize further on my own.
> > 
> > Andi's point is that string instructions might be a better bet in a long
> > run. You may win something with MOVNTI on current CPUs, but it may become
> > a burden on newer microarchitectures when string instructions improves.
> > Nobody realistically would re-validate if MOVNTI microoptimazation still
> > make sense for every new microarchitecture.
> 
> While this might be true, isn't that easily solveable by the existing
> ALTERNATIVE and cpu features framework. Can we have a feature bit to
> tell that movnti is worthwile for large data copy routines. Probably
> something for x86 maintainers.

It still need somody to test which approach is better for the CPU.
See X86_FEATURE_REP_GOOD.

-- 
 Kirill A. Shutemov
