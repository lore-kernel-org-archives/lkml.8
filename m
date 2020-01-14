Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CFAC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AB724672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgANMEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:04:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:41866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgANMEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:04:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9E1C9AE34;
        Tue, 14 Jan 2020 12:04:32 +0000 (UTC)
Subject: [PATCH] mm, debug: always print flags in dump_page()
To:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>, Qian Cai <cai@lca.pw>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org, Ralph Campbell <rcampbell@nvidia.com>
References: <49fa7dea-00ac-155f-e7b7-eeca206556b5@arm.com>
 <6A58E80B-7A5F-4CAD-ACF1-89BCCBE4D3B1@lca.pw>
 <a0bfcebe-a0f4-95ef-0973-8edd3780d013@redhat.com>
 <f6487dc1-c962-67aa-131e-2eec4f6ca686@arm.com>
 <20200114091013.GD19428@dhcp22.suse.cz>
 <1f3ff7fc-2f6b-d8e5-85a5-078f0e1a0daf@suse.cz>
 <20200114113230.GM19428@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9f884d5c-ca60-dc7b-219c-c081c755fab6@suse.cz>
Date:   Tue, 14 Jan 2020 13:04:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200114113230.GM19428@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/20 12:32 PM, Michal Hocko wrote:
> On Tue 14-01-20 11:23:52, Vlastimil Babka wrote:
>> On 1/14/20 10:10 AM, Michal Hocko wrote:
>> > [Cc Ralph]
>> >> The reason is dump_page() does not print page->flags universally
>> >> and only does so for KSM, Anon and File pages while excluding
>> >> reserved pages at boot. Wondering should not we make printing
>> >> page->flags universal ?
>> > 
>> > We used to do that and this caught me as a surprise when looking again.
>> > This is a result of 76a1850e4572 ("mm/debug.c: __dump_page() prints an
>> > extra line") which is a cleanup patch and I suspect this result was not
>> > anticipated.
>> > 
>> > The following will do the trick but I cannot really say I like the code
>> > duplication. pr_cont in this case sounds like a much cleaner solution to
>> > me.
>> 
>> How about this then?
> 
> Yes makes sense as well.

Ok here's a proper formatted patch

----8<----
From 7b673c45bc16526586ae8ea6fba416a547baa04e Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 14 Jan 2020 12:52:48 +0100
Subject: [PATCH] mm, debug: always print flags in dump_page()

Commit 76a1850e4572 ("mm/debug.c: __dump_page() prints an extra line")
inadvertently removed printing of page flags for pages that are neither
anon nor ksm nor have a mapping. Fix that.

Using pr_cont() again would be a solution, but the commit explicitly removed
its use. Avoiding the danger of mixing up split lines from multiple CPUs might
be beneficial for near-panic dumps like this, so fix this without reintroducing
pr_cont().

Reported-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reported-by: Michal Hocko <mhocko@kernel.org>
Fixes: 76a1850e4572 ("mm/debug.c: __dump_page() prints an extra line")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/debug.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index 0461df1207cb..6a52316af839 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -47,6 +47,7 @@ void __dump_page(struct page *page, const char *reason)
 	struct address_space *mapping;
 	bool page_poisoned = PagePoisoned(page);
 	int mapcount;
+	char *type = "";
 
 	/*
 	 * If struct page is poisoned don't access Page*() functions as that
@@ -78,9 +79,9 @@ void __dump_page(struct page *page, const char *reason)
 			page, page_ref_count(page), mapcount,
 			page->mapping, page_to_pgoff(page));
 	if (PageKsm(page))
-		pr_warn("ksm flags: %#lx(%pGp)\n", page->flags, &page->flags);
+		type = "ksm ";
 	else if (PageAnon(page))
-		pr_warn("anon flags: %#lx(%pGp)\n", page->flags, &page->flags);
+		type = "anon ";
 	else if (mapping) {
 		if (mapping->host && mapping->host->i_dentry.first) {
 			struct dentry *dentry;
@@ -88,10 +89,11 @@ void __dump_page(struct page *page, const char *reason)
 			pr_warn("%ps name:\"%pd\"\n", mapping->a_ops, dentry);
 		} else
 			pr_warn("%ps\n", mapping->a_ops);
-		pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
 	}
 	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
 
+	pr_warn("%sflags: %#lx(%pGp)\n", type, page->flags, &page->flags);
+
 hex_only:
 	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
-- 
2.24.1

