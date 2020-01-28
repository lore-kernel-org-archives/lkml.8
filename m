Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE129C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7967E246A3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221790;
	bh=t3GstT3n/BTtWN7Fn+kEjo9yps4SF0mEKLSbudgHL2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uUraXdwOS2yk0j7i8DEY1iCb/bjs7AQoEAHFoMiVqy5CSRvDyBZ9ogwglm9AvZu8X
	 zhiop99PNa1UWKOqkgj+Rwv3QwL8dMSXkBvh8UvG70UEYVEzj6g+nnVbRa0NZMkyMt
	 UO9E82nlq4hyl47Nr7oK4VlBX4Hqt5BgmXyhNmI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387405AbgA1O3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:29:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733167AbgA1O3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:29:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3F8921739;
        Tue, 28 Jan 2020 14:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221780;
        bh=t3GstT3n/BTtWN7Fn+kEjo9yps4SF0mEKLSbudgHL2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bv3JHbFn/z2nCqoHZ2eohcQHh3ju3/oh4IaEVNfeeKG2W7OJJSU2D/fFccWAkMhJ1
         XpvCjXkJEpd7GVavLuqbqziuCmnqR0DTqFNOgdmtTB9SZDqu2uCLJ+82MDoSiyKUL0
         odRi75dRnu1QIwF32Nm3N4P4qT98ILSwfUeOT03Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Qian Cai <cai@lca.pw>, Wei Yang <richard.weiyang@gmail.com>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>,
        Andrew Banman <andrew.banman@hpe.com>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Travis <mike.travis@hpe.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oscar Salvador <osalvador@suse.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 78/92] mm/memory_hotplug: make __remove_section() never fail
Date:   Tue, 28 Jan 2020 15:08:46 +0100
Message-Id: <20200128135819.450509917@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135809.344954797@linuxfoundation.org>
References: <20200128135809.344954797@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

commit 9d1d887d785b4fe0590bd3c5e71acaa3908044e2 upstream.

Let's just warn in case a section is not valid instead of failing to
remove somewhere in the middle of the process, returning an error that
will be mostly ignored by callers.

Link: http://lkml.kernel.org/r/20190409100148.24703-4-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Arun KS <arunks@codeaurora.org>
Cc: Mathieu Malaterre <malat@debian.org>
Cc: Andrew Banman <andrew.banman@hpe.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Oscar Salvador <osalvador@suse.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory_hotplug.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -478,15 +478,15 @@ static void __remove_zone(struct zone *z
 	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 }
 
-static int __remove_section(struct zone *zone, struct mem_section *ms,
-		unsigned long map_offset, struct vmem_altmap *altmap)
+static void __remove_section(struct zone *zone, struct mem_section *ms,
+			     unsigned long map_offset,
+			     struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn;
 	int scn_nr;
-	int ret = -EINVAL;
 
-	if (!valid_section(ms))
-		return ret;
+	if (WARN_ON_ONCE(!valid_section(ms)))
+		return;
 
 	unregister_memory_section(ms);
 
@@ -495,7 +495,6 @@ static int __remove_section(struct zone
 	__remove_zone(zone, start_pfn);
 
 	sparse_remove_one_section(zone, ms, map_offset, altmap);
-	return 0;
 }
 
 /**
@@ -515,7 +514,7 @@ int __remove_pages(struct zone *zone, un
 {
 	unsigned long i;
 	unsigned long map_offset = 0;
-	int sections_to_remove, ret = 0;
+	int sections_to_remove;
 
 	/* In the ZONE_DEVICE case device driver owns the memory region */
 	if (is_dev_zone(zone)) {
@@ -536,16 +535,13 @@ int __remove_pages(struct zone *zone, un
 		unsigned long pfn = phys_start_pfn + i*PAGES_PER_SECTION;
 
 		cond_resched();
-		ret = __remove_section(zone, __pfn_to_section(pfn), map_offset,
-				altmap);
+		__remove_section(zone, __pfn_to_section(pfn), map_offset,
+				 altmap);
 		map_offset = 0;
-		if (ret)
-			break;
 	}
 
 	set_zone_contiguous(zone);
-
-	return ret;
+	return 0;
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 


