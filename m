Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97260C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED94221F7
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941849;
	bh=VRxS27w5NyBSYvgCdwjl39Uzk3T+kmTZHMYCVLkfnd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kNzVXNUfTo4BNfiflhuiOFpCRv4PvxjGMOHSBg2MT6sJ/6rpQ8oXZlwHgT5+fk0ZX
	 ITOIAFCuJJ8qCiadSykuKtneCmeo7eyKU7syl0IhEefoXmQWDT5lW6Pk/2aDPd+53O
	 gpD7LcLTaN1wEMZi0PLic/BckLhD62wV1Wqw+UQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgEHMoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729139AbgEHMoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:44:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CF68206B8;
        Fri,  8 May 2020 12:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941842;
        bh=VRxS27w5NyBSYvgCdwjl39Uzk3T+kmTZHMYCVLkfnd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pNszuIjG8ZA7JZS0ToAYbKQjycEcKktlAXYj/COKZMNk8r6GNPUCNcsQpmFau4Ks4
         BitQ7fFWu71BL7eFO83rc7Rz1vjTaRKGKfUFlm6tqZRACIukNJedsIaS/PFzXqFECD
         m4Q74vqNYyusopbEsOuOt0roDNzAJGMUQ/XtK6sY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 187/312] ipv4: Fix memory leak in exception case for splitting tries
Date:   Fri,  8 May 2020 14:32:58 +0200
Message-Id: <20200508123137.627141891@linuxfoundation.org>
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

From: Alexander Duyck <alexander.h.duyck@intel.com>

commit 3114cdfe66c156345b0ae34e2990472f277e0c1b upstream.

Fix a small memory leak that can occur where we leak a fib_alias in the
event of us not being able to insert it into the local table.

Fixes: 0ddcf43d5d4a0 ("ipv4: FIB Local/MAIN table collapse")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Acked-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/fib_trie.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1714,8 +1714,10 @@ struct fib_table *fib_trie_unmerge(struc
 				local_l = fib_find_node(lt, &local_tp, l->key);
 
 			if (fib_insert_alias(lt, local_tp, local_l, new_fa,
-					     NULL, l->key))
+					     NULL, l->key)) {
+				kmem_cache_free(fn_alias_kmem, new_fa);
 				goto out;
+			}
 		}
 
 		/* stop loop if key wrapped back to 0 */


