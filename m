Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AD1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C5420658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qd68ifIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHSSAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:00:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51531 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726795AbgHSSAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597860011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gE/GAgO7YH16OtnzBQNdKgx7V2xA2VuhWyyTc5xlM/k=;
        b=Qd68ifIzSTkBFeMQLdmuaIBV6Tmy70HW0CAHdCNm25wFsy29RUbLONDlPySfbKio3L+HPn
        bWd2vcGjXd1S0R69zara9d9vDlYqappld+Vl8p9wB7Tlth2EPzrpcM56isQUIk3hmfjVrh
        0nwFsR56X3kXw+Zvf/EHFBVwWVXQJUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-kxZNh4N4P7efEJtzlQ3ovg-1; Wed, 19 Aug 2020 14:00:10 -0400
X-MC-Unique: kxZNh4N4P7efEJtzlQ3ovg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0F5D100A954;
        Wed, 19 Aug 2020 18:00:08 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-11.ams2.redhat.com [10.36.114.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6BC710013C4;
        Wed, 19 Aug 2020 18:00:06 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 02/10] mm/memory_hotplug: enforce section granularity when onlining/offlining
Date:   Wed, 19 Aug 2020 19:59:49 +0200
Message-Id: <20200819175957.28465-3-david@redhat.com>
In-Reply-To: <20200819175957.28465-1-david@redhat.com>
References: <20200819175957.28465-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Already two people (including me) tried to offline subsections, because
the function looks like it can deal with it. But we really can only
online/offline full sections that are properly aligned (e.g., we can only
mark full sections online/offline via SECTION_IS_ONLINE).

Add a simple safety net to document the restriction now. Current users
(core and powernv/memtrace) respect these restrictions.

Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c781d386d87f9..6856702af68d9 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -801,6 +801,11 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	int ret;
 	struct memory_notify arg;
 
+	/* We can only online full sections (e.g., SECTION_IS_ONLINE) */
+	if (WARN_ON_ONCE(!nr_pages ||
+			 !IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION)))
+		return -EINVAL;
+
 	mem_hotplug_begin();
 
 	/* associate pfn range with the zone */
@@ -1483,6 +1488,11 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	struct memory_notify arg;
 	char *reason;
 
+	/* We can only offline full sections (e.g., SECTION_IS_ONLINE) */
+	if (WARN_ON_ONCE(!nr_pages ||
+			 !IS_ALIGNED(start_pfn | nr_pages, PAGES_PER_SECTION)))
+		return -EINVAL;
+
 	mem_hotplug_begin();
 
 	/*
-- 
2.26.2

