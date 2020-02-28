Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B279C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E107246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyVx6qxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgB1N03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:26:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35200 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgB1N02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:26:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id m3so3194714wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 05:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G176JDCH3XW9kr61rhZzKaF+4Uav7HxyXRaan6nABBQ=;
        b=gyVx6qxEStx/VRQRIWQ2uoTCjn3PPSiZ4mcY3ZcfEWHRT/+n1MPlEhim4yuHUfLXBW
         PEM9j0aEPzh43bIbZkcpPUhB5oefs80KXx4N4f2etErmfkyIEVt2ZZhnBxxEJxa9u4kF
         tqpK6XQXhmvllw7SNGa+Lf++Em8O1nz6+4BOBOiaHDwQHzlpFZAgYHDawYK9mbFvqGOR
         1GknBSjGAO6nmxNU3j5mgmB5T5CMu66IHO9iLOL9K4PZLhfWcvkHOjt3GpI1jD2Rjwtw
         wvgRvtR0oUmEMUZC1v3MHhCcW8uAqNGUIQ9cBOQzSx0yApCO1xpIA3VdMK3aPAwXI3C9
         Ux1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=G176JDCH3XW9kr61rhZzKaF+4Uav7HxyXRaan6nABBQ=;
        b=TKvNnUqGTTZ6pTk85iRm0wnoKm+UQfP+TdkDLYKTE5Apdtwwwmy9Xeu2HiH++sMWWp
         ORYo441sfywnHuE4SogiUS9xJ3dv7igxtT9M9vk1paDTKxbOXeQngj2hpFIh5E6riCIU
         vf80r72+pkdJgxkaQCiEcbikH5RZZp2W2TuI+d7HbP9tab8NvJDPkjfpkjfxy2ekiUTN
         6IspmVHFzHdxls7ZmFmLfNVT0PUkoAxeFRprwF42zt5HgiiEeBhc8C3VFqxgb0/WTiFP
         1q87Wgz72mqSCowu6QAZq9yl/Ir5rmYgeg5k3v6m6I+G8A3Gm/aBsk1UBNSUYyQtJEvM
         E6rQ==
X-Gm-Message-State: APjAAAVZxwZfsy8rSSGh6RYyy/ILJSLrP3XdF1X0P4DibJiLvGXYvfqm
        1xVJg/An6e/0Xzus67o5LmKnlw+q
X-Google-Smtp-Source: APXvYqzAwzgwO/3s8vHlU1Pgdz4sVWNGAGia3NU6Y3MNBChbL1sFdL16nOo8WePCHOCIke9e1AH5OA==
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr4768927wmi.58.1582896387082;
        Fri, 28 Feb 2020 05:26:27 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id b14sm1901086wrn.75.2020.02.28.05.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 05:26:26 -0800 (PST)
Date:   Fri, 28 Feb 2020 13:26:26 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v2 2/2] mm/memory_hotplug: cleanup __add_pages()
Message-ID: <20200228132626.h4udu6rp3jhzppt3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200228095819.10750-1-david@redhat.com>
 <20200228095819.10750-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228095819.10750-3-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 10:58:19AM +0100, David Hildenbrand wrote:
>Let's drop the basically unused section stuff and simplify. The logic
>now matches the logic in __remove_pages().
>
>Cc: Segher Boessenkool <segher@kernel.crashing.org>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Wei Yang <richardw.yang@linux.intel.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
> mm/memory_hotplug.c | 18 +++++++-----------
> 1 file changed, 7 insertions(+), 11 deletions(-)
>
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 8fe7e32dad48..1a00b5a37ef6 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -307,8 +307,9 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
> int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
> 		struct mhp_restrictions *restrictions)
> {
>+	const unsigned long end_pfn = pfn + nr_pages;
>+	unsigned long cur_nr_pages;
> 	int err;
>-	unsigned long nr, start_sec, end_sec;
> 	struct vmem_altmap *altmap = restrictions->altmap;
> 
> 	err = check_hotplug_memory_addressable(pfn, nr_pages);
>@@ -331,18 +332,13 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
> 	if (err)
> 		return err;
> 
>-	start_sec = pfn_to_section_nr(pfn);
>-	end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
>-	for (nr = start_sec; nr <= end_sec; nr++) {
>-		unsigned long pfns;
>-
>-		pfns = min(nr_pages, PAGES_PER_SECTION
>-				- (pfn & ~PAGE_SECTION_MASK));
>-		err = sparse_add_section(nid, pfn, pfns, altmap);
>+	for (; pfn < end_pfn; pfn += cur_nr_pages) {
>+		/* Select all remaining pages up to the next section boundary */
>+		cur_nr_pages = min(end_pfn - pfn,
>+				   SECTION_ALIGN_UP(pfn + 1) - pfn);
>+		err = sparse_add_section(nid, pfn, cur_nr_pages, altmap);
> 		if (err)
> 			break;
>-		pfn += pfns;
>-		nr_pages -= pfns;
> 		cond_resched();
> 	}
> 	vmemmap_populate_print_last();
>-- 
>2.24.1

-- 
Wei Yang
Help you, Help me
