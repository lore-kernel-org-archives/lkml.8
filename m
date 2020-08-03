Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA4DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19581208B3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457771;
	bh=HmViFfTeuoqo2TmTzNPF8HktHsQ5kxq3RpEg7IDwKwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=STGHoIYlcBfKBnFU0U7lBcj4vdwAorAMikg4wAWdXwh+2HHv9tJqEBsUcaUUFZVmf
	 sfz8ArJS64ZuJBxYix17+e3nfGmW57/kDvFHXz3FztPkUv5NqJ52dr5fbqLxvKKrYs
	 7JnjVoPaFkn1qTYlTkrv/zoiFReizL5kKUl8BAOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgHCM3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:29:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728908AbgHCM32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:29:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D955E22B45;
        Mon,  3 Aug 2020 12:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457767;
        bh=HmViFfTeuoqo2TmTzNPF8HktHsQ5kxq3RpEg7IDwKwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bl9p5GiaLWn4U5/WoDN3IuK/fhai+Wa3NWohfQjaLhZPy1QV4TZdTEHLyFWyTzlSM
         IM00+qp2Fsi3BTt/5AeK8p66SDkcBzfeB8WX6yqo4fFn4AQwu10hEHXECs9J27oUwD
         lwgxupcCeys3Ti0DLFS2rA1w/r5rRAAMSHkDbU3k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 59/90] bpf: Fix map leak in HASH_OF_MAPS map
Date:   Mon,  3 Aug 2020 14:19:21 +0200
Message-Id: <20200803121900.478974297@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

[ Upstream commit 1d4e1eab456e1ee92a94987499b211db05f900ea ]

Fix HASH_OF_MAPS bug of not putting inner map pointer on bpf_map_elem_update()
operation. This is due to per-cpu extra_elems optimization, which bypassed
free_htab_elem() logic doing proper clean ups. Make sure that inner map is put
properly in optimized case as well.

Fixes: 8c290e60fa2a ("bpf: fix hashmap extra_elems logic")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Song Liu <songliubraving@fb.com>
Link: https://lore.kernel.org/bpf/20200729040913.2815687-1-andriin@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/hashtab.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 22066a62c8c97..039d64b1bfb7d 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -675,15 +675,20 @@ static void htab_elem_free_rcu(struct rcu_head *head)
 	preempt_enable();
 }
 
-static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
+static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
 {
 	struct bpf_map *map = &htab->map;
+	void *ptr;
 
 	if (map->ops->map_fd_put_ptr) {
-		void *ptr = fd_htab_map_get_ptr(map, l);
-
+		ptr = fd_htab_map_get_ptr(map, l);
 		map->ops->map_fd_put_ptr(ptr);
 	}
+}
+
+static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
+{
+	htab_put_fd_value(htab, l);
 
 	if (htab_is_prealloc(htab)) {
 		__pcpu_freelist_push(&htab->freelist, &l->fnode);
@@ -735,6 +740,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			 */
 			pl_new = this_cpu_ptr(htab->extra_elems);
 			l_new = *pl_new;
+			htab_put_fd_value(htab, old_elem);
 			*pl_new = old_elem;
 		} else {
 			struct pcpu_freelist_node *l;
-- 
2.25.1



