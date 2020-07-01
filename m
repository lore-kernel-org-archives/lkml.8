Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C8DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 05:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24E420722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 05:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VbppNnlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgGAFlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 01:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGAFlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 01:41:49 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDF8C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 22:41:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x3so4964613pfo.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 22:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MuoRRGNEOgMdkXPcAYRCCVhDFSgthfmjilX5vzrHJIA=;
        b=VbppNnlfx1w1Ms+gw32Cl6BTH9k2oXPA9rtwpRmzpGbNApA0Seun06i0qx1K/re3u5
         BLOTXOi/3TnFY2pEB9mVWu/DT7kgcp3aHnjEUv45X/O7g3B85/WkTggYG3gaLeFdfbKT
         bK326LwFdSKPgrHiRENawAlm6ncfulcSETpebEXpf9jzeJjE43Hlcyon5w8+wTTSqc1y
         D3RJtvNVuyEj+srx32LADFMRraYAMuaA08v3jSmQ67RlgFql+Ca2gcwm2KXY0y8N5dZq
         E77KuHtLz0bFr06UV4/pt/aPFep9d/oBjHHK4BeTQ1N4mUKYlF4VBKRpy2s8dloNjweP
         tb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MuoRRGNEOgMdkXPcAYRCCVhDFSgthfmjilX5vzrHJIA=;
        b=ieQyvYnDtsA/d4VNu9Xp00l/nmdLJb0q6GWQdTZndIUX8YrwS23kR3qu7wopKKHoqn
         uG562PBDcAl+UfTkHY1XDnZRKb9anAx13RIr4mtbSapD7C3R5VY11QhPsq9UW3RP5w6h
         XsC5UmD//qZJUTDGgYjfbzAb6A2OW+2B/TozybUZjmfqmRX1Jh8tdAE0kt4kBeKuKODM
         hnLSH+JTW8TZSoJePIUss2QoqKWeos0VJJee9D7CEENc5Z3VmgOaGa3LAPjCNo1ZPb5M
         6IvqkN+jstdoArMhh0OP5aETc6379X7ap9HpstSWdZnLONxMa4tdAqZ0TsKFFdRS6MOI
         tnuA==
X-Gm-Message-State: AOAM531WjKRlqrS1A4P8Vak8C//yZS4GkPKhGuZ2Icf1b9mDTwA8isx+
        jc+eGEY64NMc5/iSSyOVc3YafLAYVnU=
X-Google-Smtp-Source: ABdhPJxBE3dO9YD+vCs0wuoKb33BLAkPncdm9edyGTDuU+6yUmOIC7Bj/Vc/aQc1pghJiGgZ0UfsKA==
X-Received: by 2002:a05:6a00:1510:: with SMTP id q16mr21419066pfu.164.1593582108665;
        Tue, 30 Jun 2020 22:41:48 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id 198sm4825254pfb.27.2020.06.30.22.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 22:41:47 -0700 (PDT)
Date:   Tue, 30 Jun 2020 22:41:47 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kbusch@kernel.org, ying.huang@intel.com, dan.j.williams@intel.com
Subject: Re: [RFC][PATCH 3/8] mm/vmscan: Attempt to migrate page in lieu of
 discard
In-Reply-To: <039a5704-4468-f662-d660-668071842ca3@linux.alibaba.com>
Message-ID: <alpine.DEB.2.22.394.2006302208460.1685201@chino.kir.corp.google.com>
References: <20200629234503.749E5340@viggo.jf.intel.com> <20200629234509.8F89C4EF@viggo.jf.intel.com> <alpine.DEB.2.22.394.2006301732010.1644114@chino.kir.corp.google.com> <039a5704-4468-f662-d660-668071842ca3@linux.alibaba.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020, Yang Shi wrote:

> > > From: Dave Hansen <dave.hansen@linux.intel.com>
> > > 
> > > If a memory node has a preferred migration path to demote cold pages,
> > > attempt to move those inactive pages to that migration node before
> > > reclaiming. This will better utilize available memory, provide a faster
> > > tier than swapping or discarding, and allow such pages to be reused
> > > immediately without IO to retrieve the data.
> > > 
> > > When handling anonymous pages, this will be considered before swap if
> > > enabled. Should the demotion fail for any reason, the page reclaim
> > > will proceed as if the demotion feature was not enabled.
> > > 
> > Thanks for sharing these patches and kick-starting the conversation, Dave.
> > 
> > Could this cause us to break a user's mbind() or allow a user to
> > circumvent their cpuset.mems?
> > 
> > Because we don't have a mapping of the page back to its allocation
> > context (or the process context in which it was allocated), it seems like
> > both are possible.
> 
> Yes, this could break the memory placement policy enforced by mbind and
> cpuset. I discussed this with Michal on mailing list and tried to find a way
> to solve it, but unfortunately it seems not easy as what you mentioned above.
> The memory policy and cpuset is stored in task_struct rather than mm_struct.
> It is not easy to trace back to task_struct from page (owner field of
> mm_struct might be helpful, but it depends on CONFIG_MEMCG and is not
> preferred way).
> 

Yeah, and Ying made a similar response to this message.

We can do this if we consider pmem not to be a separate memory tier from 
the system perspective, however, but rather the socket perspective.  In 
other words, a node can only demote to a series of exclusive pmem ranges 
and promote to the same series of ranges in reverse order.  So DRAM node 0 
can only demote to PMEM node 2 while DRAM node 1 can only demote to PMEM 
node 3 -- a pmem range cannot be demoted to, or promoted from, more than 
one DRAM node.

This naturally takes care of mbind() and cpuset.mems if we consider pmem 
just to be slower volatile memory and we don't need to deal with the 
latency concerns of cross socket migration.  A user page will never be 
demoted to a pmem range across the socket and will never be promoted to a 
different DRAM node that it doesn't have access to.

That can work with the NUMA abstraction for pmem, but it could also 
theoretically be a new memory zone instead.  If all memory living on pmem 
is migratable (the natural way that memory hotplug is done, so we can 
offline), this zone would live above ZONE_MOVABLE.  Zonelist ordering 
would determine whether we can allocate directly from this memory based on 
system config or a new gfp flag that could be set for users of a mempolicy 
that allows allocations directly from pmem.  If abstracted as a NUMA node 
instead, interleave over nodes {0,2,3} or a cpuset.mems of {0,2,3} doesn't 
make much sense.

Kswapd would need to be enlightened for proper pgdat and pmem balancing 
but in theory it should be simpler because it only has its own node to 
manage.  Existing per-zone watermarks might be easy to use to fine tune 
the policy from userspace: the scale factor determines how much memory we 
try to keep free on DRAM for migration from pmem, for example.  We also 
wouldn't have to deal with node hotplug or updating of demotion/promotion 
node chains.

Maybe the strongest advantage of the node abstraction is the ability to 
use autonuma and migrate_pages()/move_pages() API for moving pages 
explicitly?  Mempolicies could be used for migration to "top-tier" memory, 
i.e. ZONE_NORMAL or ZONE_MOVABLE, instead.
