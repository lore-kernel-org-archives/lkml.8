Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66315C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289F620716
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUdABVtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgA0LUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:20:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43547 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726761AbgA0LUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580124006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w0j/py8gkG2r+cYKJfB9pJxwgwWUNcELclm6DIYHEkk=;
        b=JUdABVtwTST7sWMbhDGLtK/cTOXvCykOyBk4pjx2W4Ps/zVKQOM9nK2t3cwqOAZ0mfZEer
        ql2DuRnVxfrcvOt8rp41jPCMpxqrQeyOkfmf7Z99fz0zm5Ov0ac84GSD628qT18YsmDyCF
        /XV/IZJt+x3zpF2lPVr8zwr1vhmauI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-pJrGIMLuMM6FOFdt2B8JZQ-1; Mon, 27 Jan 2020 06:04:41 -0500
X-MC-Unique: pJrGIMLuMM6FOFdt2B8JZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 406621083E95;
        Mon, 27 Jan 2020 11:04:40 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC542863A4;
        Mon, 27 Jan 2020 11:04:38 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v1 3/3] mm/page_ext.c: drop pfn_present() check when onlining
Date:   Mon, 27 Jan 2020 12:04:24 +0100
Message-Id: <20200127110424.5757-4-david@redhat.com>
In-Reply-To: <20200127110424.5757-1-david@redhat.com>
References: <20200127110424.5757-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit c5e79ef561b0 ("mm/memory_hotplug.c: don't allow to
online/offline memory blocks with holes") we disallow to offline any
memory with holes. As all boot memory is online and hotplugged memory
cannot contain holes, we never online memory with holes.

This present check can be dropped.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_ext.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/page_ext.c b/mm/page_ext.c
index 4ade843ff588..a3616f7a0e9e 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -303,11 +303,8 @@ static int __meminit online_page_ext(unsigned long s=
tart_pfn,
 		VM_BUG_ON(!node_state(nid, N_ONLINE));
 	}
=20
-	for (pfn =3D start; !fail && pfn < end; pfn +=3D PAGES_PER_SECTION) {
-		if (!pfn_present(pfn))
-			continue;
+	for (pfn =3D start; !fail && pfn < end; pfn +=3D PAGES_PER_SECTION)
 		fail =3D init_section_page_ext(pfn, nid);
-	}
 	if (!fail)
 		return 0;
=20
--=20
2.24.1

