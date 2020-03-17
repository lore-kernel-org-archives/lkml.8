Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFDAC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334B9205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584453689;
	bh=W4cb0pB6ZyoPPyRigDMdBWytJQ434GL6TYL4QjTz4Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VjWcv58l0C6pg2nNA2Bj15z0dDDAv0HEgC9mn25iD04rb4tSHpfK/T0WBUNkCd56K
	 7AUisvQQbiQGLUECfMkTYgesoYhm+MgFMmvTBLkLeni96YZ773bkDN58Ey6c76ifas
	 lDVyYNGJR2AbVUF0WBbgB56msYESKLRp6lqqFZME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgCQOB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:01:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41938 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgCQOB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:01:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id f11so9042077wrp.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 07:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ItWRufudZgPZEpQ32ItzaAQQhZEgI2/DOHgrwuATrtI=;
        b=AKe2A5VVlB745pcJoCozKTovRj+h68UfzaTz8kcEWm1FYg2s6mXpYIK6W0NRwcKtiZ
         d8gAPj/EBOMSV7bAFFR3B92falxQmjz574rRHh4xJga2SunEIl8+DDAJ9R6b75VIAwqW
         9pdrOb76du9+eG1L4UZGvgg2FDOYMwerO4nvJW0DwwgIhD06n9K95ffMxo3Twg5S2V+2
         AncuofGHzscOfVUJ2uaf0fKlvqgBJXNVmGwv5DwcrNLG6ccNDv709RSP2xVB82mkLqNs
         WxwfCy5zqIPzmyI3JR9ogQJsJPwELobkL3tcI00n251wtHQ/3CfZET2Ps3SDgqio+jVy
         eh4g==
X-Gm-Message-State: ANhLgQ0AkxSqOQ+O9shpPJJjQhIr8qmKpAWKG5IPLeU4N6AW60xwS+pu
        Mk97XQ/hzZDK0DqBDO0iZzY=
X-Google-Smtp-Source: ADFU+vsk+GnF+GCqWZCG5DiJVF86NmS3oKrA4V8mLX0Ld4u7mVLgCXVsm/cY7ocNSYufa/6j734rhQ==
X-Received: by 2002:adf:e883:: with SMTP id d3mr6169893wrm.75.1584453685337;
        Tue, 17 Mar 2020 07:01:25 -0700 (PDT)
Received: from localhost (ip-37-188-255-121.eurotel.cz. [37.188.255.121])
        by smtp.gmail.com with ESMTPSA id q8sm81107wrc.8.2020.03.17.07.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 07:01:24 -0700 (PDT)
Date:   Tue, 17 Mar 2020 15:01:22 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Christopher Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 1/3] powerpc/numa: Set numa_node for all possible cpus
Message-ID: <20200317140122.GQ26018@dhcp22.suse.cz>
References: <20200311115735.GM23944@dhcp22.suse.cz>
 <20200312052707.GA3277@linux.vnet.ibm.com>
 <C5560C71-483A-41FB-BDE9-526F1E0CFA36@linux.vnet.ibm.com>
 <5e5c736a-a88c-7c76-fc3d-7bc765e8dcba@suse.cz>
 <20200312131438.GB3277@linux.vnet.ibm.com>
 <61437352-8b54-38fa-4471-044a65c9d05a@suse.cz>
 <20200312161310.GC3277@linux.vnet.ibm.com>
 <e115048c-be38-c298-b8d1-d4b513e7d2fb@suse.cz>
 <20200316090652.GC11482@dhcp22.suse.cz>
 <65b99db6-3bdf-6caa-74e5-6d6b681f16b5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b99db6-3bdf-6caa-74e5-6d6b681f16b5@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-03-20 14:44:45, Vlastimil Babka wrote:
> On 3/16/20 10:06 AM, Michal Hocko wrote:
> > On Thu 12-03-20 17:41:58, Vlastimil Babka wrote:
> > [...]
> >> with nid present in:
> >> N_POSSIBLE - pgdat might not exist, node_to_mem_node() must return some online
> > 
> > I would rather have a dummy pgdat for those. Have a look at 
> > $ git grep "NODE_DATA.*->" | wc -l
> > 63
> > 
> > Who knows how many else we have there. I haven't looked more closely.
> > Besides that what is a real reason to not have pgdat ther and force all
> > users of a $random node from those that the platform considers possible
> > for special casing? Is that a memory overhead? Is that really a thing?
> 
> I guess we can ignore memory overhead. I guess there only might be some concern
> that for nodes that are initially offline, we will allocate the pgdat on a
> different node, and after they are online, it will stay on a different node with
> more access latency from local cpus. If we only allocate for online nodes, it
> can always be local? But I guess it doesn't matter that much.

This is not the case even now because of chicke&egg. You need a memory
to allocate from and that memory has to be managed somewhere per node
(pgdat). Keep in mind we do not have the bootmem allocator for the
hotplug. Have a look at hotadd_new_pgdat and when it is called. There
are some attempts to allocate memmap from the hotpluged memory but I am
not sure we can do the whole thing without pgdat in place. If we can
then can come up with some replace the pgdat magic. But still I am not
even sure this is something we really have to optimize for.
-- 
Michal Hocko
SUSE Labs
