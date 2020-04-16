Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376B1C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1245121973
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSEn7hJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505515AbgDPKvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:51:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60906 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2505583AbgDPKuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587034202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zRYNtBUkNWEzX+BKNPgl2EfmanwkifXZxxgsKaVH4Bg=;
        b=iSEn7hJN9+hZl0zfcCaxDOGhzemLgpFFAeXoyS9B7Nf5T+DPIR0pqcz/OEnQAUoOLpBe+1
        AzwhKOcq+xh3Zv+ek0QBU9otpBcmymas9/IcCPy1CG6p4Eqj6w6dSXrhO+PeD0rmMWPLS9
        01muFseqDMU352DnSwdGnWIEr1mxBbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-AEPnD6C3MwiUVmbkj9l5vg-1; Thu, 16 Apr 2020 06:47:16 -0400
X-MC-Unique: AEPnD6C3MwiUVmbkj9l5vg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84E0B107B26F;
        Thu, 16 Apr 2020 10:47:15 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-9.ams2.redhat.com [10.36.114.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C518E1036D03;
        Thu, 16 Apr 2020 10:47:13 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH RFC 1/2] mm/memory_hotplug: no need to init new pgdat with node_start_pfn
Date:   Thu, 16 Apr 2020 12:47:06 +0200
Message-Id: <20200416104707.20219-2-david@redhat.com>
In-Reply-To: <20200416104707.20219-1-david@redhat.com>
References: <20200416104707.20219-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A hotadded node/pgdat will span no pages at all, until memory is moved to
the zone/node via move_pfn_range_to_zone() -> resize_pgdat_range - e.g.,
when onlining memory blocks. We don't have to initialize the
node_start_pfn to the memory we are adding.

Note: we'll also end up with pgdat->node_start_pfn =3D=3D 0 when offlined=
 the
last memory block belonging to a node (via remove_pfn_range_from_zone()->
update_pgdat_span()).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 47cf6036eb31..9b15ce465be2 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -866,10 +866,9 @@ static void reset_node_present_pages(pg_data_t *pgda=
t)
 }
=20
 /* we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLU=
G */
-static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
+static pg_data_t __ref *hotadd_new_pgdat(int nid)
 {
 	struct pglist_data *pgdat;
-	unsigned long start_pfn =3D PFN_DOWN(start);
=20
 	pgdat =3D NODE_DATA(nid);
 	if (!pgdat) {
@@ -899,9 +898,8 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64=
 start)
 	}
=20
 	/* we can use NODE_DATA(nid) from here */
-
 	pgdat->node_id =3D nid;
-	pgdat->node_start_pfn =3D start_pfn;
+	pgdat->node_start_pfn =3D 0;
=20
 	/* init node's zones as empty zones, we don't have any present pages.*/
 	free_area_init_core_hotplug(nid);
@@ -936,7 +934,6 @@ static void rollback_node_hotadd(int nid)
 /**
  * try_online_node - online a node if offlined
  * @nid: the node ID
- * @start: start addr of the node
  * @set_node_online: Whether we want to online the node
  * called by cpu_up() to online a node without onlined memory.
  *
@@ -945,7 +942,7 @@ static void rollback_node_hotadd(int nid)
  * 0 -> the node is already online
  * -ENOMEM -> the node could not be allocated
  */
-static int __try_online_node(int nid, u64 start, bool set_node_online)
+static int __try_online_node(int nid, bool set_node_online)
 {
 	pg_data_t *pgdat;
 	int ret =3D 1;
@@ -953,7 +950,7 @@ static int __try_online_node(int nid, u64 start, bool=
 set_node_online)
 	if (node_online(nid))
 		return 0;
=20
-	pgdat =3D hotadd_new_pgdat(nid, start);
+	pgdat =3D hotadd_new_pgdat(nid);
 	if (!pgdat) {
 		pr_err("Cannot online node %d due to NULL pgdat\n", nid);
 		ret =3D -ENOMEM;
@@ -977,7 +974,7 @@ int try_online_node(int nid)
 	int ret;
=20
 	mem_hotplug_begin();
-	ret =3D  __try_online_node(nid, 0, true);
+	ret =3D  __try_online_node(nid, true);
 	mem_hotplug_done();
 	return ret;
 }
@@ -1031,7 +1028,7 @@ int __ref add_memory_resource(int nid, struct resou=
rce *res)
 	 */
 	memblock_add_node(start, size, nid);
=20
-	ret =3D __try_online_node(nid, start, false);
+	ret =3D __try_online_node(nid, false);
 	if (ret < 0)
 		goto error;
 	new_node =3D ret;
--=20
2.25.1

