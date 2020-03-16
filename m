Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F35C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9932C20724
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIDQ5L0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbgCPKWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:22:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35706 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730478AbgCPKWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584354127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Vv1cQFCqZ1YUMKAqTsznQf04tGJGAJ2S0nm59ugBb9M=;
        b=fIDQ5L0/5rRCw6N7gh8xkfXV0ZVVD4jkWgvgcbrfr1tcP0eKZGRpJ1MPFCN4JK0RpRpYEx
        7uNgeT1NLkffznN0lLgULuDUD70aK6t3u4Ry48aN+vRJGrvYcY2a0VQsUJaAfStEUrTBCX
        5rpY83R9Gx+HMh7mR3Bt/DQkrAi/h1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-JE4Ec69iOQOXSHxLJsY6Rw-1; Mon, 16 Mar 2020 06:22:03 -0400
X-MC-Unique: JE4Ec69iOQOXSHxLJsY6Rw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACBCBDBCB;
        Mon, 16 Mar 2020 10:22:01 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-129.pek2.redhat.com [10.72.12.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F9BF1BC6D;
        Mon, 16 Mar 2020 10:21:58 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mhocko@suse.com, akpm@linux-foundation.org,
        david@redhat.com, willy@infradead.org, richard.weiyang@gmail.com,
        vbabka@suse.cz, bhe@redhat.com
Subject: [PATCH v4 2/2] mm/sparse.c: allocate memmap preferring the given node
Date:   Mon, 16 Mar 2020 18:21:50 +0800
Message-Id: <20200316102150.16487-2-bhe@redhat.com>
In-Reply-To: <20200316102150.16487-1-bhe@redhat.com>
References: <20200316102150.16487-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating memmap for hot added memory with the classic sparse, the
specified 'nid' is ignored in populate_section_memmap().

While in allocating memmap for the classic sparse during boot, the node
given by 'nid' is preferred. And VMEMMAP prefers the node of 'nid' in
both boot stage and memory hot adding. So seems no reason to not respect
the node of 'nid' for the classic sparse when hot adding memory.

Use kvmalloc_node instead to use the passed in 'nid'.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/sparse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index d01d09cc7d99..513d765e8c72 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -719,8 +719,8 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
 struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
-	return kvmalloc(array_size(sizeof(struct page),
-			PAGES_PER_SECTION), GFP_KERNEL);
+	return kvmalloc_node(array_size(sizeof(struct page),
+			     PAGES_PER_SECTION), GFP_KERNEL, nid);
 }
 
 static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
-- 
2.17.2

