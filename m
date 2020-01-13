Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E93C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAB0207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clRlbdTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgAMLeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:34:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29737 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726976AbgAMLeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578915245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=guHP6gmPLHnYDv84/p3VqN+5T6PCoPVZ6ZGFO+HTAL8=;
        b=clRlbdTUIwye99XBQHb3g1fq4X6u6DramGL1Ccxfhx0DneNRD41xDQzsVnJKx7QGpIoR7N
        fG+IJgwLiZ8oQUxvMLZimd456h1hOY1pInndhrvcLX7quwjBgF/FmqzuU+FgeOtt5mchCs
        kg6FiyCRfumd2cQyq6UuqAmETfph20E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-IqsPQAN5NBCONk0g_mWc3g-1; Mon, 13 Jan 2020 06:34:03 -0500
X-MC-Unique: IqsPQAN5NBCONk0g_mWc3g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F1B0800D41;
        Mon, 13 Jan 2020 11:34:02 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-201.ams2.redhat.com [10.36.117.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AD817C468;
        Mon, 13 Jan 2020 11:34:00 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1 1/2] mm/memory_hotplug: pass in nid to online_pages()
Date:   Mon, 13 Jan 2020 12:33:53 +0100
Message-Id: <20200113113354.6341-2-david@redhat.com>
In-Reply-To: <20200113113354.6341-1-david@redhat.com>
References: <20200113113354.6341-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to lookup the memory block, we can directly pass in the nid.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c          |  6 +++---
 include/linux/memory_hotplug.h |  3 ++-
 mm/memory_hotplug.c            | 13 ++-----------
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 2604a15c728b..2cf3542b04d0 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -236,7 +236,7 @@ static bool pages_correctly_probed(unsigned long star=
t_pfn)
  */
 static int
 memory_block_action(unsigned long start_section_nr, unsigned long action=
,
-		    int online_type)
+		    int online_type, int nid)
 {
 	unsigned long start_pfn;
 	unsigned long nr_pages =3D PAGES_PER_SECTION * sections_per_block;
@@ -249,7 +249,7 @@ memory_block_action(unsigned long start_section_nr, u=
nsigned long action,
 		if (!pages_correctly_probed(start_pfn))
 			return -EBUSY;
=20
-		ret =3D online_pages(start_pfn, nr_pages, online_type);
+		ret =3D online_pages(start_pfn, nr_pages, online_type, nid);
 		break;
 	case MEM_OFFLINE:
 		ret =3D offline_pages(start_pfn, nr_pages);
@@ -275,7 +275,7 @@ static int memory_block_change_state(struct memory_bl=
ock *mem,
 		mem->state =3D MEM_GOING_OFFLINE;
=20
 	ret =3D memory_block_action(mem->start_section_nr, to_state,
-				mem->online_type);
+				  mem->online_type, mem->nid);
=20
 	mem->state =3D ret ? from_state_req : to_state;
=20
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplu=
g.h
index 820689093894..f4d59155f3d4 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -94,7 +94,8 @@ extern int zone_grow_free_lists(struct zone *zone, unsi=
gned long new_nr_pages);
 extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_page=
s);
 extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
 /* VM interface that may be used by firmware interface */
-extern int online_pages(unsigned long, unsigned long, int);
+extern int online_pages(unsigned long pfn, unsigned long nr_pages,
+			int online_type, int nid);
 extern struct zone *test_pages_in_a_zone(unsigned long start_pfn,
 					 unsigned long end_pfn);
 extern unsigned long __offline_isolated_pages(unsigned long start_pfn,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 5ee2c6e10934..fb1c878d054d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -758,27 +758,18 @@ struct zone * zone_for_pfn_range(int online_type, i=
nt nid, unsigned start_pfn,
 	return default_zone_for_pfn(nid, start_pfn, nr_pages);
 }
=20
-int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int on=
line_type)
+int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
+		       int online_type, int nid)
 {
 	unsigned long flags;
 	unsigned long onlined_pages =3D 0;
 	struct zone *zone;
 	int need_zonelists_rebuild =3D 0;
-	int nid;
 	int ret;
 	struct memory_notify arg;
-	struct memory_block *mem;
=20
 	mem_hotplug_begin();
=20
-	/*
-	 * We can't use pfn_to_nid() because nid might be stored in struct page
-	 * which is not yet initialized. Instead, we find nid from memory block=
.
-	 */
-	mem =3D find_memory_block(__pfn_to_section(pfn));
-	nid =3D mem->nid;
-	put_device(&mem->dev);
-
 	/* associate pfn range with the zone */
 	zone =3D zone_for_pfn_range(online_type, nid, pfn, nr_pages);
 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL);
--=20
2.24.1

