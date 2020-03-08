Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4881CC10F25
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 01:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091BF206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 01:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrfRkvL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgCHBfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 20:35:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56532 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726252AbgCHBfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 20:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583631319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=cZPB2ozd/CQzSBVuXVXyRx4Ij0GveypYhrYtlgrnwto=;
        b=VrfRkvL6eXttTCxYhHZpnQcPR3j3dIBTq4bL90Kxu3HFkQZA36T1IQkUltVjNMs1df2nDH
        Sl/4/nOvR4HT++jlUib6+PbSR2ojzXN+pdKI6yJXsUnmF7iWvkOpmHzj+YzhfZ0O8BM+HT
        F9dxs4oYv62UkjVLgFSRaYYNEbKZVTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-mWMxPYeDMM2RVUsW6w35Uw-1; Sat, 07 Mar 2020 20:35:17 -0500
X-MC-Unique: mWMxPYeDMM2RVUsW6w35Uw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AED718B5FA0;
        Sun,  8 Mar 2020 01:35:15 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-26.pek2.redhat.com [10.72.12.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F01CD5C1B2;
        Sun,  8 Mar 2020 01:35:12 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        x86@kernel.org, bhe@redhat.com
Subject: [PATCH] x86/mm: Remove the redundant conditional check
Date:   Sun,  8 Mar 2020 09:35:11 +0800
Message-Id: <20200308013511.12792-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit f70029bbaacbfa8f0 ("mm, memory_hotplug: drop CONFIG_MOVABLE_NODE"),
the dependency on CONFIG_MOVABLE_NODE was removed for N_MEMORY, so the
conditional check in paging_init() doesn't make any sense any more.
Remove it.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/init_64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index abbdecb75fad..0a14711d3a93 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -818,8 +818,7 @@ void __init paging_init(void)
 	 *	 will not set it back.
 	 */
 	node_clear_state(0, N_MEMORY);
-	if (N_MEMORY != N_NORMAL_MEMORY)
-		node_clear_state(0, N_NORMAL_MEMORY);
+	node_clear_state(0, N_NORMAL_MEMORY);
 
 	zone_sizes_init();
 }
-- 
2.17.2

