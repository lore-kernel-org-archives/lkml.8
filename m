Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82418C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6472088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593679290;
	bh=LoRUe1edvsn6l/5pldIiPBt3a+FKf9dJpkgBU5TxzIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YprceR7fixETWfjcHgmICw0i8OXyYD3elkqBGNxnRDCIiGSV2Wzgwt/0A+NLHWMsL
	 a3D8favEd9hz7aeOHC5iEv0Yq0/o916Sa0eKMjZejRtQFJMUEimLn+95B5qEoGvXqd
	 fEpL9M0vYo/OIHR/XPw8J1uzYj1QHcPZ7jL0vqg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgGBIl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:41:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36848 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgGBIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:41:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id dg28so22740273edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 01:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vdQTX1b30r2E+b4wWTLdokaa3kzfoASml+gbdox2kjk=;
        b=ATuowIW18+XeWU631QmLW8sTuo2pz2awUEkIGexuEf0dzV/ix6GhRjlb2UfE+zuwII
         S1BoHcjXHVGienPHo6mwn7PxfeG4vU4cIdlQXdI0ge58K8sxgjLr6BhAE98PhYgEI5KT
         IU71vIBZmJrE3BubTv4fYCkeIPMnRPcB4335yWWSR8lnhk6MkcpkVZ1F5Gv1fyRk9i+G
         9q/PfP9yRskAKkPfRakBF6tPYO5nXwNCoC/+WGNeQyfVepZAYhVfo7VecNc3YQpZ2bW1
         KrOHbHtUJro6CVW0b7rVTjM1ZxB+K5Isk9jGIoPICdsQ4YXs8fwNyVZIRct3vfH6OAny
         OkOA==
X-Gm-Message-State: AOAM533SV3Yif04CMFnmrqi1DpMGbqbTtZCllEWutM8ZQYXew4QFCAp9
        FWh73jnBnXNLTmlKkj3xg2k=
X-Google-Smtp-Source: ABdhPJx82pvZRUddpNf0SPn9KfR7GaUxvmymKbtIogkNF4m5l4Wwf1H8niTtAXXHyeDwlVqAXnpEAw==
X-Received: by 2002:a05:6402:3113:: with SMTP id dc19mr32377784edb.20.1593679285570;
        Thu, 02 Jul 2020 01:41:25 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id a13sm8755656edk.58.2020.07.02.01.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 01:41:24 -0700 (PDT)
Date:   Thu, 2 Jul 2020 10:41:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Christopher Lameter <cl@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
Message-ID: <20200702084123.GC18446@dhcp22.suse.cz>
References: <20200624092846.9194-1-srikar@linux.vnet.ibm.com>
 <20200624092846.9194-4-srikar@linux.vnet.ibm.com>
 <20200701084200.GN2369@dhcp22.suse.cz>
 <20200701100442.GB17918@linux.vnet.ibm.com>
 <184102af-ecf2-c834-db46-173ab2e66f51@redhat.com>
 <20200701110145.GC17918@linux.vnet.ibm.com>
 <0468f965-8762-76a3-93de-3987cf859927@redhat.com>
 <12945273-d788-710d-e8d7-974966529c7d@redhat.com>
 <20200701122110.GT2369@dhcp22.suse.cz>
 <20200702064408.GD17918@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702064408.GD17918@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-07-20 12:14:08, Srikar Dronamraju wrote:
> * Michal Hocko <mhocko@kernel.org> [2020-07-01 14:21:10]:
> 
> > > >>>>>>
> > > >>>>>> 2. Also existence of dummy node also leads to inconsistent information. The
> > > >>>>>> number of online nodes is inconsistent with the information in the
> > > >>>>>> device-tree and resource-dump
> > > >>>>>>
> > > >>>>>> 3. When the dummy node is present, single node non-Numa systems end up showing
> > > >>>>>> up as NUMA systems and numa_balancing gets enabled. This will mean we take
> > > >>>>>> the hit from the unnecessary numa hinting faults.
> > > >>>>>
> > > >>>>> I have to say that I dislike the node online/offline state and directly
> > > >>>>> exporting that to the userspace. Users should only care whether the node
> > > >>>>> has memory/cpus. Numa nodes can be online without any memory. Just
> > > >>>>> offline all the present memory blocks but do not physically hot remove
> > > >>>>> them and you are in the same situation. If users are confused by an
> > > >>>>> output of tools like numactl -H then those could be updated and hide
> > > >>>>> nodes without any memory&cpus.
> > > >>>>>
> > > >>>>> The autonuma problem sounds interesting but again this patch doesn't
> > > >>>>> really solve the underlying problem because I strongly suspect that the
> > > >>>>> problem is still there when a numa node gets all its memory offline as
> > > >>>>> mentioned above.
> > 
> > I would really appreciate a feedback to these two as well.
> 
> 1. Its not just numactl that's to be fixed but all tools/utilities that
> depend on /sys/devices/system/node/online. Are we saying to not rely/believe
> in the output given by the kernel but do further verification?  

No, what we are saying is that even an online node might have zero
number of online pages/cpus. So the online status is not really
something that matters. If people are confused by that output then user
space tools can make their confusion go away. I really do not understand
why the kernel should do any logic there.

> Also how would the user space differentiate between the case where the
> Kernel missed marking a node as offline to the case where the memory was
> offlined on a cpuless node but node wasn't offline?.

What I am arguing is that those two shouldn't be any different. Really!

> 2. Regarding the autonuma, the case of offline memory is user/admin driven,
> so if there is a performance hit, its something that's driven by his
> user/admin actions. Also how often do we see users offline complete memory
> of cpuless node on a 2 node system?

How often do we see crippled HW configurations like that? Really if
autonuma should be made more clever for one case it should recognize the
other as well.

> > > [    0.009726] SRAT: PXM 1 -> APIC 0x00 -> Node 0
> > > [    0.009727] SRAT: PXM 1 -> APIC 0x01 -> Node 0
> > > [    0.009727] SRAT: PXM 1 -> APIC 0x02 -> Node 0
> > > [    0.009728] SRAT: PXM 1 -> APIC 0x03 -> Node 0
> > > [    0.009731] ACPI: SRAT: Node 0 PXM 1 [mem 0x00000000-0x0009ffff]
> > > [    0.009732] ACPI: SRAT: Node 0 PXM 1 [mem 0x00100000-0xbfffffff]
> > > [    0.009733] ACPI: SRAT: Node 0 PXM 1 [mem 0x100000000-0x13fffffff]
> > 
> > This begs a question whether ppc can do the same thing?
> 
> Certainly ppc can be made to adapt to this situation but that would be a
> workaround. Do we have a reason why we think node 0 is unique and special?

It is not. As replied in other email in this thread. I would hope for
having less hacks in the numa initialization. Cleaning up the mess is
would be a lot of work and testing on all NUMA capable architectures.
This is a heritage from the past I am afraid. All that I am arguing here
is that your touch to the generic code with a very simple looking patch
might have side effects which are pretty much impossible to review.
Moreover it seems that nothing but ppc really needs this treatment.
So fixing it in ppc specific code sounds much more safe.

Normally I would really push for a generic solution but after getting
burned several times in this area I do not dare anymore. The problem is
not in the code complexity but in how spread it is in places where you
do not expect side effects.

-- 
Michal Hocko
SUSE Labs
