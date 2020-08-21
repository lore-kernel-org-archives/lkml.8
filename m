Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE92C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82AFB20748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="J0Zuusdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgHUKbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgHUKaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:30:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35DBC061347
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:30:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w13so1153499wrk.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TjJYEZAqPyuHvntT520Xn6gOnSfqEAJLMPb1j99RvjA=;
        b=J0ZuusdqZACDGHPgbETvqMoYBp+ZD+25Wt7/5fLbVQ+SdNXc93CNBCDR5jEGb4hiyq
         vAMYAavy1QAgLN7QxHwdB8EEyC9oR1PSsAE9OfFn2LzxxaQyBEPA4hpbR4xDUeb3SKI5
         TPQ596yt3YIW+9CwaoSDG+vI7K79hndieqDmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TjJYEZAqPyuHvntT520Xn6gOnSfqEAJLMPb1j99RvjA=;
        b=KlgTxzcJbx5XQ4IKGYzzovB7GUWIQempaUUSgJ0ozmiwUGnYektAPeqYuLEQrEoN/h
         Od80HzNVM7xHhr83mx0n920JmWT+hoyeXe3BlHp8LpfOXOzoHWW3lxf804Xga9EOnanR
         PKs+719fAVQiFZZ/T21pyrXIe0eq10FInKFEXlaPl+GV4Oq7BGw04lfzzkzSOVkzcmhQ
         zEWLjqMstOeUjg0Hosb3b8KpZubRvtz6JSrnzR49hqCiSq6KKFYab5kTIitusgaI8ZP0
         fGhY9p562hOjMx2WvaltxpzYJXO/2HY9f3ZgKzY3D4TOYalrkLDXCHul+eP+rDIvfkdr
         noEw==
X-Gm-Message-State: AOAM532BLvJW7WYFUDnzJBppCgEQW3mwXH3nXl5HeqmxR/katrjt9g8W
        JjDUAXRKQlM32Z0MHvja1GNehA==
X-Google-Smtp-Source: ABdhPJyd0OcsCVNqrs4nlbvYPtY5Yh69Msxb6a4G4jwOnN7xVsKcCXOB/aB5RM6yfzPML6QpvBCBpw==
X-Received: by 2002:a5d:6a8d:: with SMTP id s13mr2263903wru.201.1598005812494;
        Fri, 21 Aug 2020 03:30:12 -0700 (PDT)
Received: from antares.lan (2.2.9.a.d.9.4.f.6.1.8.9.f.9.8.5.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:589f:9816:f49d:a922])
        by smtp.gmail.com with ESMTPSA id o2sm3296885wrj.21.2020.08.21.03.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:30:11 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     jakub@cloudflare.com, john.fastabend@gmail.com, yhs@fb.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 3/6] bpf: sockmap: call sock_map_update_elem directly
Date:   Fri, 21 Aug 2020 11:29:45 +0100
Message-Id: <20200821102948.21918-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821102948.21918-1-lmb@cloudflare.com>
References: <20200821102948.21918-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't go via map->ops to call sock_map_update_elem, since we know
what function to call in bpf_map_update_value. Since we currently
don't allow calling map_update_elem from BPF context, we can remove
ops->map_update_elem and rename the function to sock_map_update_elem_sys.

Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/linux/bpf.h  | 7 +++++++
 kernel/bpf/syscall.c | 5 +++--
 net/core/sock_map.c  | 6 ++----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cef4ef0d2b4e..cf3416d1b8c2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1635,6 +1635,7 @@ int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
 			 struct bpf_prog *old, u32 which);
 int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
 int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
+int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 flags);
 void sock_map_unhash(struct sock *sk);
 void sock_map_close(struct sock *sk, long timeout);
 #else
@@ -1656,6 +1657,12 @@ static inline int sock_map_prog_detach(const union bpf_attr *attr,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value,
+					   u64 flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_BPF_STREAM_PARSER */
 
 #if defined(CONFIG_INET) && defined(CONFIG_BPF_SYSCALL)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2f343ce15747..5867cf615a3c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -157,10 +157,11 @@ static int bpf_map_update_value(struct bpf_map *map, struct fd f, void *key,
 	if (bpf_map_is_dev_bound(map)) {
 		return bpf_map_offload_update_elem(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_CPUMAP ||
-		   map->map_type == BPF_MAP_TYPE_SOCKHASH ||
-		   map->map_type == BPF_MAP_TYPE_SOCKMAP ||
 		   map->map_type == BPF_MAP_TYPE_STRUCT_OPS) {
 		return map->ops->map_update_elem(map, key, value, flags);
+	} else if (map->map_type == BPF_MAP_TYPE_SOCKHASH ||
+		   map->map_type == BPF_MAP_TYPE_SOCKMAP) {
+		return sock_map_update_elem_sys(map, key, value, flags);
 	} else if (IS_FD_PROG_ARRAY(map)) {
 		return bpf_fd_array_map_update_elem(map, f.file, key, value,
 						    flags);
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 905e2dd765aa..48e83f93ee66 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -562,8 +562,8 @@ static bool sock_map_sk_state_allowed(const struct sock *sk)
 static int sock_hash_update_common(struct bpf_map *map, void *key,
 				   struct sock *sk, u64 flags);
 
-static int sock_map_update_elem(struct bpf_map *map, void *key,
-				void *value, u64 flags)
+int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value,
+			     u64 flags)
 {
 	struct socket *sock;
 	struct sock *sk;
@@ -687,7 +687,6 @@ const struct bpf_map_ops sock_map_ops = {
 	.map_free		= sock_map_free,
 	.map_get_next_key	= sock_map_get_next_key,
 	.map_lookup_elem_sys_only = sock_map_lookup_sys,
-	.map_update_elem	= sock_map_update_elem,
 	.map_delete_elem	= sock_map_delete_elem,
 	.map_lookup_elem	= sock_map_lookup,
 	.map_release_uref	= sock_map_release_progs,
@@ -1181,7 +1180,6 @@ const struct bpf_map_ops sock_hash_ops = {
 	.map_alloc		= sock_hash_alloc,
 	.map_free		= sock_hash_free,
 	.map_get_next_key	= sock_hash_get_next_key,
-	.map_update_elem	= sock_map_update_elem,
 	.map_delete_elem	= sock_hash_delete_elem,
 	.map_lookup_elem	= sock_hash_lookup,
 	.map_lookup_elem_sys_only = sock_hash_lookup_sys,
-- 
2.25.1

