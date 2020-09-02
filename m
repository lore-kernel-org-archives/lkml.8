Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91297C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6002065E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgIBLcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 07:32:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:46644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgIBLcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 07:32:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E84D4B18C;
        Wed,  2 Sep 2020 11:32:05 +0000 (UTC)
Date:   Wed, 2 Sep 2020 13:32:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Roman Gushchin <guro@fb.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        stable <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 00/28] The new cgroup slab memory controller
Message-ID: <20200902113204.GD4617@dhcp22.suse.cz>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200130020626.GA21973@in.ibm.com>
 <20200130024135.GA14994@xps.DHCP.thefacebook.com>
 <CA+CK2bCQcnTpzq2wGFa3D50PtKwBoWbDBm56S9y8c+j+pD+KSw@mail.gmail.com>
 <20200813000416.GA1592467@carbon.dhcp.thefacebook.com>
 <CA+CK2bDDToW=Q5RgeWkoN3_rUr3pyWGVb9MraTzM+DM3OZ+tdg@mail.gmail.com>
 <CA+CK2bBEHFuLLg79_h6bv4Vey+B0B2YXyBxTBa=Le12OKbNdwA@mail.gmail.com>
 <6469324e-afa2-18b4-81fb-9e96466c1bf3@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6469324e-afa2-18b4-81fb-9e96466c1bf3@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-09-20 11:53:00, Vlastimil Babka wrote:
> >> > > Thread #2: ccs killer kthread
> >> > >    css_killed_work_fn
> >> > >      cgroup_mutex  <- Grab this Mutex
> >> > >      mem_cgroup_css_offline
> >> > >        memcg_offline_kmem.part
> >> > >           memcg_deactivate_kmem_caches
> >> > >             get_online_mems
> >> > >               mem_hotplug_lock <- waits for Thread#1 to get read access

And one more thing. THis has been brought up several times already.
Maybe I have forgoten but why do we take hotplug locks in this path in
the first place? Memory hotplug notifier takes slab_mutex so this
shouldn't be really needed.
-- 
Michal Hocko
SUSE Labs
