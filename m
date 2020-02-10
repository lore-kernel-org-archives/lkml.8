Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D59C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 03:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48AE206ED
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 03:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blLQahos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBJDgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 22:36:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59911 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727254AbgBJDgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 22:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581305796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lTuxfPbb6227xDCDjuRdfuxy4DLz08JTlzUDeWBWd+U=;
        b=blLQahosxJu9XgsLSNlj7pheMMD5+n5HATG1ryTCm8NswSmey6Z2oLCulGlBkdubaQ3of2
        9glfaD0E7BFgDjVvIgAQ6PCdq9/9r3FgXKoRB2dwk9XtfNqDWZ0kgTnh+ijmBVTgUc9A0g
        Ck34a4Q4R6WEWO2qVzbMDKclMLVod+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-spqzCyNfNzOURPVaw2RKOw-1; Sun, 09 Feb 2020 22:36:34 -0500
X-MC-Unique: spqzCyNfNzOURPVaw2RKOw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71600100726D;
        Mon, 10 Feb 2020 03:36:33 +0000 (UTC)
Received: from localhost (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FE755C1D4;
        Mon, 10 Feb 2020 03:36:30 +0000 (UTC)
Date:   Mon, 10 Feb 2020 11:36:27 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        david@redhat.com
Subject: Re: [PATCH 2/7] mm/sparse.c: Introduce a new function
 clear_subsection_map()
Message-ID: <20200210033627.GZ8965@MiWiFi-R3L-srv>
References: <20200209104826.3385-1-bhe@redhat.com>
 <20200209104826.3385-3-bhe@redhat.com>
 <20200209230713.GB7326@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200209230713.GB7326@richard>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/20 at 07:07am, Wei Yang wrote:
> On Sun, Feb 09, 2020 at 06:48:21PM +0800, Baoquan He wrote:
> >Wrap the codes clearing subsection map of one memory region in
> >section_deactivate() into clear_subsection_map().
> >
> 
> Patch 1 and 2 server the same purpose -- to #ifdef the VMEMMAP.

Hmm, I didn't say patch 1 and 2 are preparation works because they had
better be done even if we don't take off subsection map from
SPARSEMEM|!VMEMMAP case. Wrapping the subsection map filling and clearing
codes into separate new functions, can make section_activate() and
section_deactivate() much clearer on code logic.

If you don't mind, I will keep them for now, and see what other people
will say.

Thanks
Baoquan

> 
> >---
> > mm/sparse.c | 44 +++++++++++++++++++++++++++++++++++++-------
> > 1 file changed, 37 insertions(+), 7 deletions(-)
> >
> >diff --git a/mm/sparse.c b/mm/sparse.c
> >index 9ad741ccbeb6..696f6b9f706e 100644
> >--- a/mm/sparse.c
> >+++ b/mm/sparse.c
> >@@ -726,14 +726,25 @@ static void free_map_bootmem(struct page *memmap)
> > }
> > #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> > 
> >-static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >-		struct vmem_altmap *altmap)
> >+/**
> >+ * clear_subsection_map - Clear subsection map of one memory region
> >+ *
> >+ * @pfn - start pfn of the memory range
> >+ * @nr_pages - number of pfns to add in the region
> >+ *
> >+ * This is only intended for hotplug, and clear the related subsection
> >+ * map inside one section.
> >+ *
> >+ * Return:
> >+ * * -EINVAL	- Section already deactived.
> >+ * * 0		- Subsection map is emptied.
> >+ * * 1		- Subsection map is not empty.
> >+ */
> >+static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> > {
> > 	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> > 	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
> > 	struct mem_section *ms = __pfn_to_section(pfn);
> >-	bool section_is_early = early_section(ms);
> >-	struct page *memmap = NULL;
> > 	unsigned long *subsection_map = ms->usage
> > 		? &ms->usage->subsection_map[0] : NULL;
> > 
> >@@ -744,8 +755,28 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> > 	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
> > 				"section already deactivated (%#lx + %ld)\n",
> > 				pfn, nr_pages))
> >-		return;
> >+		return -EINVAL;
> >+
> >+	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> > 
> >+	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
> >+		return 0;
> >+
> >+	return 1;
> >+}
> >+
> >+static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >+		struct vmem_altmap *altmap)
> >+{
> >+	struct mem_section *ms = __pfn_to_section(pfn);
> >+	bool section_is_early = early_section(ms);
> >+	struct page *memmap = NULL;
> >+	int rc;
> >+
> >+
> >+	rc = clear_subsection_map(pfn, nr_pages);
> >+	if(IS_ERR_VALUE((unsigned long)rc))
> >+		return;
> > 	/*
> > 	 * There are 3 cases to handle across two configurations
> > 	 * (SPARSEMEM_VMEMMAP={y,n}):
> >@@ -763,8 +794,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> > 	 *
> > 	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
> > 	 */
> >-	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> >-	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
> >+	if (!rc) {
> > 		unsigned long section_nr = pfn_to_section_nr(pfn);
> > 
> > 		/*
> >-- 
> >2.17.2
> 
> -- 
> Wei Yang
> Help you, Help me
> 

