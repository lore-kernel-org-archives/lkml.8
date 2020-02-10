Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2730C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 03:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8633F21556
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 03:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ms322bi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgBJDZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 22:25:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40629 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726944AbgBJDZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 22:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581305124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jyRyYT0aG+L0dqAUJI/hqVxX9ssgslD06ddofm7ugZo=;
        b=Ms322bi3LqPeOs4RXfTZiIUj6bMgMSzbpgUhLwtHBP59ejJlg+zB97f0Ta0Kqo0IMdeRXF
        H6w1hM8YXSEupvlUCyR+w1J56z3hlxXJpbbP57qUTX3Da89H670W37CQYonfDsDjvtPd8N
        V4f0tMFRb/g9tU8+DHY8STxyCmwHuvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-KPCqclYKNOWfuGwl73F8wA-1; Sun, 09 Feb 2020 22:25:20 -0500
X-MC-Unique: KPCqclYKNOWfuGwl73F8wA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D980713F5;
        Mon, 10 Feb 2020 03:25:18 +0000 (UTC)
Received: from localhost (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29ECA790DA;
        Mon, 10 Feb 2020 03:25:14 +0000 (UTC)
Date:   Mon, 10 Feb 2020 11:25:12 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        david@redhat.com
Subject: Re: [PATCH 1/7] mm/sparse.c: Introduce new function
 fill_subsection_map()
Message-ID: <20200210032512.GY8965@MiWiFi-R3L-srv>
References: <20200209104826.3385-1-bhe@redhat.com>
 <20200209104826.3385-2-bhe@redhat.com>
 <20200209230556.GA7326@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200209230556.GA7326@richard>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/20 at 07:05am, Wei Yang wrote:
> >-static struct page * __meminit section_activate(int nid, unsigned long pfn,
> >-		unsigned long nr_pages, struct vmem_altmap *altmap)
> >+/**
> >+ * fill_subsection_map - fill subsection map of a memory region
> >+ * @pfn - start pfn of the memory range
> >+ * @nr_pages - number of pfns to add in the region
> >+ *
> >+ * This clears the related subsection map inside one section, and only
> 
> s/clears/fills/ ?

Good catch, thanks for your careful review.

I will wait a while to see if there's any input from other reviewers,
then update this post accordingly together.

> 
> >+ * intended for hotplug.
> >+ *
> >+ * Return:
> >+ * * 0		- On success.
> >+ * * -EINVAL	- Invalid memory region.
> >+ * * -EEXIST	- Subsection map has been set.
> >+ */
> >+static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
> > {
> >-	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> > 	struct mem_section *ms = __pfn_to_section(pfn);
> >-	struct mem_section_usage *usage = NULL;
> >+	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> > 	unsigned long *subsection_map;
> >-	struct page *memmap;
> > 	int rc = 0;
> > 
> > 	subsection_mask_set(map, pfn, nr_pages);
> > 
> >-	if (!ms->usage) {
> >-		usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
> >-		if (!usage)
> >-			return ERR_PTR(-ENOMEM);
> >-		ms->usage = usage;
> >-	}
> > 	subsection_map = &ms->usage->subsection_map[0];
> > 
> > 	if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
> >@@ -816,6 +820,25 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
> > 		bitmap_or(subsection_map, map, subsection_map,
> > 				SUBSECTIONS_PER_SECTION);
> > 
> >+	return rc;
> >+}
> >+
> >+static struct page * __meminit section_activate(int nid, unsigned long pfn,
> >+		unsigned long nr_pages, struct vmem_altmap *altmap)
> >+{
> >+	struct mem_section *ms = __pfn_to_section(pfn);
> >+	struct mem_section_usage *usage = NULL;
> >+	struct page *memmap;
> >+	int rc = 0;
> >+
> >+	if (!ms->usage) {
> >+		usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
> >+		if (!usage)
> >+			return ERR_PTR(-ENOMEM);
> >+		ms->usage = usage;
> >+	}
> >+
> >+	rc = fill_subsection_map(pfn, nr_pages);
> > 	if (rc) {
> > 		if (usage)
> > 			ms->usage = NULL;
> >-- 
> >2.17.2
> 
> -- 
> Wei Yang
> Help you, Help me
> 

