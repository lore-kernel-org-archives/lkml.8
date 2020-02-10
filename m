Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761B8C35250
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 06:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4472C20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 06:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgBJGHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 01:07:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:7683 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgBJGHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 01:07:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 22:07:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,424,1574150400"; 
   d="scan'208";a="221454434"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 09 Feb 2020 22:07:46 -0800
Date:   Mon, 10 Feb 2020 14:08:04 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        david@redhat.com
Subject: Re: [PATCH 7/7] mm/hotplug: fix hot remove failure in
 SPARSEMEM|!VMEMMAP case
Message-ID: <20200210060804.GF7326@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200209104826.3385-1-bhe@redhat.com>
 <20200209104826.3385-8-bhe@redhat.com>
 <20200209235202.GC8705@richard>
 <20200210034105.GA8965@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210034105.GA8965@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 11:41:05AM +0800, Baoquan He wrote:
>On 02/10/20 at 07:52am, Wei Yang wrote:
>> >---
>> > mm/sparse.c | 4 +++-
>> > 1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/mm/sparse.c b/mm/sparse.c
>> >index 623755e88255..345d065ef6ce 100644
>> >--- a/mm/sparse.c
>> >+++ b/mm/sparse.c
>> >@@ -854,13 +854,15 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>> > 			ms->usage = NULL;
>> > 		}
>> > 		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
>> >-		ms->section_mem_map = (unsigned long)NULL;
>> > 	}
>> > 
>> > 	if (section_is_early && memmap)
>> > 		free_map_bootmem(memmap);
>> > 	else
>> > 		depopulate_section_memmap(pfn, nr_pages, altmap);
>> 
>> The crash happens in depopulate_section_memmap() when trying to get memmap by
>> pfn_to_page(). Can we pass memmap directly?
>
>Yes, that's also a good idea. While it needs to add a parameter for
>depopulate_section_memmap(), the parameter is useless for VMEMMAP
>though, I personally prefer the current fix which is a little simpler.
>

Not a new parameter, but replace pfn with memmap.

Not sure why the parameter is useless for VMEMMAP? memmap will be assigned to
start and finally pass to vmemmap_free().

>Anyway, both is fine to me, I can update if you think passing memmap is
>better.
>
>> 
>> >+
>> >+	if(!rc)
>> >+		ms->section_mem_map = (unsigned long)NULL;
>> > }
>> > 
>> > static struct page * __meminit section_activate(int nid, unsigned long pfn,
>> >-- 
>> >2.17.2
>> 
>> -- 
>> Wei Yang
>> Help you, Help me
>> 

-- 
Wei Yang
Help you, Help me
