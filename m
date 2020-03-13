Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C56BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D022074B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgCMLit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:38:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:47470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgCMLis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:38:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B13BBABEF;
        Fri, 13 Mar 2020 11:38:46 +0000 (UTC)
Subject: Re: [PATCH 1/3] powerpc/numa: Set numa_node for all possible cpus
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Joonsoo Kim <js1304@gmail.com>
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christopher Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20200311110237.5731-2-srikar@linux.vnet.ibm.com>
 <20200311115735.GM23944@dhcp22.suse.cz>
 <20200312052707.GA3277@linux.vnet.ibm.com>
 <C5560C71-483A-41FB-BDE9-526F1E0CFA36@linux.vnet.ibm.com>
 <5e5c736a-a88c-7c76-fc3d-7bc765e8dcba@suse.cz>
 <20200312131438.GB3277@linux.vnet.ibm.com>
 <61437352-8b54-38fa-4471-044a65c9d05a@suse.cz>
 <20200312161310.GC3277@linux.vnet.ibm.com>
 <e115048c-be38-c298-b8d1-d4b513e7d2fb@suse.cz>
 <CAAmzW4OFy51BhAT62tdVQD52NNMWm+UPgoGAX97omY7P+nJ+5w@mail.gmail.com>
 <20200313110440.GA25144@linux.vnet.ibm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <06be5908-9af6-2892-0333-e9558b2cf474@suse.cz>
Date:   Fri, 13 Mar 2020 12:38:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313110440.GA25144@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/20 12:04 PM, Srikar Dronamraju wrote:
>> I lost all the memory about it. :)
>> Anyway, how about this?
>> 
>> 1. make node_present_pages() safer
>> static inline node_present_pages(nid)
>> {
>> if (!node_online(nid)) return 0;
>> return (NODE_DATA(nid)->node_present_pages);
>> }
>> 
> 
> Yes this would help.

Looks good, yeah.

>> 2. make node_to_mem_node() safer for all cases
>> In ppc arch's mem_topology_setup(void)
>> for_each_present_cpu(cpu) {
>>  numa_setup_cpu(cpu);
>>  mem_node = node_to_mem_node(numa_mem_id());
>>  if (!node_present_pages(mem_node)) {
>>   _node_numa_mem_[numa_mem_id()] = first_online_node;
>>  }
>> }
>> 
> 
> But here as discussed above, we miss the case of possible but not present nodes.
> For such nodes, the above change may not update, resulting in they still
> having 0. And node 0 can be only possible but not present.

So is there other way to do the setup so that node_to_mem_node() returns an
online+present node when called for any possible node?

