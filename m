Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E579CC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3972081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1FX73XP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgAMLeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:34:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40638 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726976AbgAMLeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578915253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kyGfBKPVwrfDGFfgsI1JO/W6pedXQ+uX9GngeESCU9E=;
        b=N1FX73XPCTjXlk186FqnzfEx1GnDsfs5YqszwX/iLbHkmIB3IPgBkdrFgFnkUXQ8ano2ZF
        SfYI06eTasROxqBUx7AIyLa/JW3OdTCoB/KMF6sRrYuuiXTqGjDZ71+VDXfaEsMxeWSAro
        X/KYe9kmogClpG2JNfWhEq4rh+TPbo0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-kx3i3PFMM_q8K1ChXbtEPQ-1; Mon, 13 Jan 2020 06:34:10 -0500
X-MC-Unique: kx3i3PFMM_q8K1ChXbtEPQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E648DBED;
        Mon, 13 Jan 2020 11:34:08 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-201.ams2.redhat.com [10.36.117.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F5C47C468;
        Mon, 13 Jan 2020 11:34:02 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1 2/2] drivers/base/memory.c: get rid of find_memory_block()
Date:   Mon, 13 Jan 2020 12:33:54 +0100
Message-Id: <20200113113354.6341-3-david@redhat.com>
In-Reply-To: <20200113113354.6341-1-david@redhat.com>
References: <20200113113354.6341-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No longer needed, remove it.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c  | 9 +--------
 include/linux/memory.h | 1 -
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 2cf3542b04d0..8b3ab910b812 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -590,13 +590,6 @@ static struct memory_block *find_memory_block_by_id(=
unsigned long block_id)
 	return mem;
 }
=20
-struct memory_block *find_memory_block(struct mem_section *section)
-{
-	unsigned long block_id =3D base_memory_block_id(__section_nr(section));
-
-	return find_memory_block_by_id(block_id);
-}
-
 static struct attribute *memory_memblk_attrs[] =3D {
 	&dev_attr_phys_index.attr,
 	&dev_attr_state.attr,
@@ -700,7 +693,7 @@ static void unregister_memory(struct memory_block *me=
mory)
=20
 	WARN_ON(radix_tree_delete(&memory_blocks, memory->dev.id) =3D=3D NULL);
=20
-	/* drop the ref. we got via find_memory_block() */
+	/* drop the ref. we got via find_memory_block_by_id() */
 	put_device(&memory->dev);
 	device_unregister(&memory->dev);
 }
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 3ab4aa2d67ae..0b0732a94972 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -113,7 +113,6 @@ void remove_memory_block_devices(unsigned long start,=
 unsigned long size);
 extern void memory_dev_init(void);
 extern int memory_notify(unsigned long val, void *v);
 extern int memory_isolate_notify(unsigned long val, void *v);
-extern struct memory_block *find_memory_block(struct mem_section *);
 typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
 extern int walk_memory_blocks(unsigned long start, unsigned long size,
 			      void *arg, walk_memory_blocks_func_t func);
--=20
2.24.1

