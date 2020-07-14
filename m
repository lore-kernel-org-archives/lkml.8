Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009C8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B4521897
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGNKIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 06:08:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:59702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgGNKIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:08:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 86DE6ADCA;
        Tue, 14 Jul 2020 10:08:51 +0000 (UTC)
Date:   Tue, 14 Jul 2020 12:08:46 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     nao.horiguchi@gmail.com, linux-mm@kvack.org, mhocko@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        tony.luck@intel.com, david@redhat.com,
        aneesh.kumar@linux.vnet.ibm.com, zeil@yandex-team.ru,
        naoya.horiguchi@nec.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/15] HWPOISON: soft offline rework
Message-ID: <20200714100839.GA1939@linux>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
 <20200630050803.GA2747@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630050803.GA2747@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 01:08:03AM -0400, Qian Cai wrote:
> Even after applied the compling fix,
> 
> https://lore.kernel.org/linux-mm/20200628065409.GA546944@u2004/
> 
> madvise(MADV_SOFT_OFFLINE) will fail with EIO with hugetlb where it
> would succeed without this series. Steps:
> 
> # git clone https://github.com/cailca/linux-mm
> # cd linux-mm; make
> # ./random 1 (Need at least two NUMA memory nodes)
>  start: migrate_huge_offline
> - use NUMA nodes 0,4.
> - mmap and free 8388608 bytes hugepages on node 0
> - mmap and free 8388608 bytes hugepages on node 4
> madvise: Input/output error

Ok, sorry for the lateness, but I had to re-fetch the code on my brain again.

I just finished v4 of this patchset and it seems this problem is gone:

# ./random 1
- start: migrate_huge_offline
- use NUMA nodes 0,1.
- mmap and free 8388608 bytes hugepages on node 0
- mmap and free 8388608 bytes hugepages on node 1
- pass: mmap_offline_node_huge
- start: hotplug_memory
offline: Device or resource busy
offline: Device or resource busy
offline: Device or resource busy
offline: Device or resource busy
offline: Device or resource busy
offline: Device or resource busy
offline: Device or resource busy
offline: Device or resource busy
offline: Invalid argument
offline: Device or resource busy
offline: Invalid argument
offline: Device or resource busy
offline: Device or resource busy
offline: Device or resource busy
offline: Device or resource busy
- pass: hotplug_memory

The test seems to suceed and no crash on the kernel side.

I will just run some more tests to make sure the thing is solid enough
and then I will post v4.

Thanks

-- 
Oscar Salvador
SUSE L3
