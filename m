Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1EEC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2329D206B9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943971;
	bh=p5ugadPsmhcjh23JmZonac+q3eB3bP8CBYsJAi/EQcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WU1Ng2nkJuEcP+dWlvWXN7/BEsO34g3F7HiFVUqxOxFcHPetDCdV2MtAKefv/8PxN
	 NBcMH6iF3UOcqamEV9UxT7ooAgnYClX1TnEhJjGIT1/rchBVEDVtJumXnrVue0P28c
	 jB5v9SGjVQr+0lbBnW/wzItoqTBbxiJx49ddgUnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgEHNTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728866AbgEHMmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:42:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A6F020731;
        Fri,  8 May 2020 12:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941728;
        bh=p5ugadPsmhcjh23JmZonac+q3eB3bP8CBYsJAi/EQcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n1vlHI8uZvK2i72PqZlDleLRB8HKnrn4AIAVkSbvvIJxQ+oBuufgNkRhtEYS8Rc6D
         m+XwSsPUXHMh3VNQa1VmPwZQsmOT5wvrIK5o9etSEZPZFG1wILr8aDdeERIO6l3W7S
         YNgUPdffoDgzqvhPEEOJyfT8VKK55Zf9f8VcIW2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        "David S. Miller" <davem@davemloft.net>,
        Vladimir Davydov <vdavydov@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 110/312] net: tcp_memcontrol: properly detect ancestor socket pressure
Date:   Fri,  8 May 2020 14:31:41 +0200
Message-Id: <20200508123132.226278681@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>

commit 8c2c2358b236530bc2c79b4c2a447cbdbc3d96d7 upstream.

When charging socket memory, the code currently checks only the local
page counter for excess to determine whether the memcg is under socket
pressure.  But even if the local counter is fine, one of the ancestors
could have breached its limit, which should also force this child to
enter socket pressure.  This currently doesn't happen.

Fix this by using page_counter_try_charge() first.  If that fails, it
means that either the local counter or one of the ancestors are in
excess of their limit, and the child should enter socket pressure.

Fixes: 3e32cb2e0a12 ("mm: memcontrol: lockless page counters")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: David S. Miller <davem@davemloft.net>
Reviewed-by: Vladimir Davydov <vdavydov@virtuozzo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/sock.h |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1204,11 +1204,13 @@ static inline void memcg_memory_allocate
 					      unsigned long amt,
 					      int *parent_status)
 {
-	page_counter_charge(&prot->memory_allocated, amt);
+	struct page_counter *counter;
+
+	if (page_counter_try_charge(&prot->memory_allocated, amt, &counter))
+		return;
 
-	if (page_counter_read(&prot->memory_allocated) >
-	    prot->memory_allocated.limit)
-		*parent_status = OVER_LIMIT;
+	page_counter_charge(&prot->memory_allocated, amt);
+	*parent_status = OVER_LIMIT;
 }
 
 static inline void memcg_memory_allocated_sub(struct cg_proto *prot,


