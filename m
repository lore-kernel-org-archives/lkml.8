Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0827CC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CA420727
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfwMqBEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgCKBSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 21:18:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21249 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727484AbgCKBSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 21:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583889512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=UN0NuvLW7G+cpN7mBoVO9U+atcx/0hxSlzgtOKjyR/Y=;
        b=LfwMqBEVULFuRQTNRx7BEbHgH+1GmSjeRGyDm/nvy5PJEkE1//YVJYmiC4/7Svyuep+XKW
        R5VdlgtvVo3rxmqxlWdwBMnt0NKSpmVNxg4DHObZ3zjFT8pMRD7IU/8TdZHuymX8qkVzc5
        QpBiRAea1nFdzHW5Gba6MC2rE1xOGRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-N22v_7SrOxmD1S135QGAKQ-1; Tue, 10 Mar 2020 21:18:28 -0400
X-MC-Unique: N22v_7SrOxmD1S135QGAKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F3308017DF;
        Wed, 11 Mar 2020 01:18:27 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09D8926195;
        Wed, 11 Mar 2020 01:18:24 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, x86@kernel.org, mhocko@suse.com,
        akpm@linux-foundation.org, bhe@redhat.com
Subject: [PATCH v2] x86/mm: Remove the redundant conditional check
Date:   Wed, 11 Mar 2020 09:18:23 +0800
Message-Id: <20200311011823.27740-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit f70029bbaacb ("mm, memory_hotplug: drop CONFIG_MOVABLE_NODE"),
the dependency on CONFIG_MOVABLE_NODE was removed for N_MEMORY. Before
commit f70029bbaacb, CONFIG_HIGHMEM && !CONFIG_MOVABLE_NODE could make
(N_MEMORY == N_NORMAL_MEMORY) be true. After commit f70029bbaacb, N_MEMORY
doesn't have any chance to be equal to N_NORMAL_MEMORY. So the conditional
check in paging_init() doesn't make sense any more. Let's remove it.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v1->v2:
  Update patch log to make the description clearer per Michal's
  suggestion.

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

