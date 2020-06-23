Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DAFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5F42080C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944341;
	bh=HyBWi6ZBAIlUUOfToCWd6cHLJVFRuzMfk3C+mFEBJCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mEZDajMBohB9SidOjEWuq5OVMdq+geJ6mt0WoOmq5qY0PQ7mckgGgZ6aoAPxWMuLV
	 DMnz9iaA47fUjLZf29yk2qOFvw+qgGz0c1XTNKZYz0MJ+OKAelwdRS6h/9kiV2Hrl4
	 loowbHpLcsVDJ7tAUZU5v8F7l07KtWjV7/eJRYcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390662AbgFWUcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391260AbgFWUcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:32:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEF412072E;
        Tue, 23 Jun 2020 20:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944325;
        bh=HyBWi6ZBAIlUUOfToCWd6cHLJVFRuzMfk3C+mFEBJCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iByxOxc2gsiVGiAFdPl5mlqMgSZuGHiYkZfuHYSzU1HEEdqwy4eWFKOc5wMSgG1ux
         tf32MzfMPY2Px6oh4ScXLWe/1wF3h44T00RzgwjR6mLvyc6Q0VUm59Od5sL5/YxjyJ
         H8H3Z26OUYJ0+DsumxGEhkfxWINDxDTI2qx1hHhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Ignatov <rdna@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 259/314] bpf: Fix memlock accounting for sock_hash
Date:   Tue, 23 Jun 2020 21:57:34 +0200
Message-Id: <20200623195351.327582508@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Ignatov <rdna@fb.com>

[ Upstream commit 60e5ca8a64bad8f3e2e20a1e57846e497361c700 ]

Add missed bpf_map_charge_init() in sock_hash_alloc() and
correspondingly bpf_map_charge_finish() on ENOMEM.

It was found accidentally while working on unrelated selftest that
checks "map->memory.pages > 0" is true for all map types.

Before:
	# bpftool m l
	...
	3692: sockhash  name m_sockhash  flags 0x0
		key 4B  value 4B  max_entries 8  memlock 0B

After:
	# bpftool m l
	...
	84: sockmap  name m_sockmap  flags 0x0
		key 4B  value 4B  max_entries 8  memlock 4096B

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Andrey Ignatov <rdna@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20200612000857.2881453-1-rdna@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock_map.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index b22e9f1191803..6bbc118bf00e9 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -837,11 +837,15 @@ static struct bpf_map *sock_hash_alloc(union bpf_attr *attr)
 		err = -EINVAL;
 		goto free_htab;
 	}
+	err = bpf_map_charge_init(&htab->map.memory, cost);
+	if (err)
+		goto free_htab;
 
 	htab->buckets = bpf_map_area_alloc(htab->buckets_num *
 					   sizeof(struct bpf_htab_bucket),
 					   htab->map.numa_node);
 	if (!htab->buckets) {
+		bpf_map_charge_finish(&htab->map.memory);
 		err = -ENOMEM;
 		goto free_htab;
 	}
-- 
2.25.1



