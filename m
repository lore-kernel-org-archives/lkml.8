Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F72C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ADCE2083E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYwqvUur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgH3V0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 17:26:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30472 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726225AbgH3V0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 17:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598822798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=433hylRzd7tAV1qS/y1gHwbMIYEXzinu0vCj4lzPHz4=;
        b=NYwqvUur/jzuGoL7XbRb+3e7f4ATM39/8WeNcqm1vTtux+omF0f+bBk2m7DP6wedtLdsfr
        so78Y5/iFPEX+VxCeW7GC4aXi3yS9nXb3PrH6e0yt5H1GlvvyGvv8SNNCAa9hWyVotkSM4
        f+gnT6XL4qB+8geuwosse4rn2+Ax2uw=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-6lFMd1qsN5eLAEw-Vis-qA-1; Sun, 30 Aug 2020 17:26:36 -0400
X-MC-Unique: 6lFMd1qsN5eLAEw-Vis-qA-1
Received: by mail-oo1-f70.google.com with SMTP id g2so3466695oon.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 14:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=433hylRzd7tAV1qS/y1gHwbMIYEXzinu0vCj4lzPHz4=;
        b=IX+C0Pqq9n//jDO7kC/SJ74hwiHqb4dczYoFysXUCV4ginb8ABL2Cd2E/A9DRywm0j
         +jZXKjjvJgtchvp9kavsYbEixzGUe2x1o7yqydufC4uTavNI7HWRDTamHhWtrUklSlVv
         T/IaRcezSfeFzTNV4P5UbGZt0M7Im+x2YNlo3ds5vaVpqTf+DQyT9qkDyZlLQcmjGUB3
         8LVrwVf2+AKvXuv1jJszjdeIQ3o4pbdnciW6+FpDpjkqMNXkXEJIg21/LMeaUGeK7g4q
         uexwTnUabmB7H4Phr2gxmNBMIPEe10ysZGG7bC9MQPwd2YZpdqI0eAFpGDbKR96LZVq1
         YOHw==
X-Gm-Message-State: AOAM5317GqWqvocZvAwa8NRbjUA+0I/ZcsrvvvRQWDJhQRFamFCII8m3
        kSWuQZFRWWbVr2O8NkSVN7DUHq+3KL7J0un9bkB2KHywsdWtv2J50oSNg1abNcClFG4/pGBvqNG
        myw8YdRDUeExVHm/VPa6qbZ6j
X-Received: by 2002:a9d:3b7:: with SMTP id f52mr3903195otf.45.1598822795191;
        Sun, 30 Aug 2020 14:26:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybDLDpnxY9uSLFo6hRHL0aNUMXIi9WnqSA61aLSjk3opsO/+Bibt61vu94GFaJ8D6B6GCGfw==
X-Received: by 2002:a9d:3b7:: with SMTP id f52mr3903187otf.45.1598822794964;
        Sun, 30 Aug 2020 14:26:34 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p11sm699264oif.11.2020.08.30.14.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 14:26:34 -0700 (PDT)
From:   trix@redhat.com
To:     pshelar@ovn.org, davem@davemloft.net, kuba@kernel.org,
        natechancellor@gmail.com, ndesaulniers@google.com
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] net: openvswitch: pass NULL for unused parameters
Date:   Sun, 30 Aug 2020 14:26:30 -0700
Message-Id: <20200830212630.32241-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags these problems

flow_table.c:713:2: warning: The expression is an uninitialized
  value. The computed value will also be garbage
        (*n_mask_hit)++;
        ^~~~~~~~~~~~~~~
flow_table.c:748:5: warning: The expression is an uninitialized
  value. The computed value will also be garbage
                                (*n_cache_hit)++;
                                ^~~~~~~~~~~~~~~~

These are not problems because neither parameter is used
by the calling function.

Looking at all of the calling functions, there are many
cases where the results are unused.  Passing unused
parameters is a waste.

In the case where the output mask index parameter of flow_lookup()
is not used by the caller, it is always has a value of 0.

To avoid passing unused parameters, rework the
masked_flow_lookup() and flow_lookup() routines to check
for NULL parameters and change the unused parameters to NULL.

For the mask index parameter, use a local pointer to a value of
0 if user passed in NULL.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2
- fix spelling
- add mask index to NULL parameters
---
net/openvswitch/flow_table.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index e2235849a57e..eac25596e4f4 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -710,7 +710,8 @@ static struct sw_flow *masked_flow_lookup(struct table_instance *ti,
 	ovs_flow_mask_key(&masked_key, unmasked, false, mask);
 	hash = flow_hash(&masked_key, &mask->range);
 	head = find_bucket(ti, hash);
-	(*n_mask_hit)++;
+	if (n_mask_hit)
+		(*n_mask_hit)++;
 
 	hlist_for_each_entry_rcu(flow, head, flow_table.node[ti->node_ver],
 				lockdep_ovsl_is_held()) {
@@ -730,12 +731,17 @@ static struct sw_flow *flow_lookup(struct flow_table *tbl,
 				   const struct sw_flow_key *key,
 				   u32 *n_mask_hit,
 				   u32 *n_cache_hit,
-				   u32 *index)
+				   u32 *in_index)
 {
 	u64 *usage_counters = this_cpu_ptr(ma->masks_usage_cntr);
 	struct sw_flow *flow;
 	struct sw_flow_mask *mask;
 	int i;
+	u32 idx = 0;
+	u32 *index = &idx;
+
+	if (in_index)
+		index = in_index;
 
 	if (likely(*index < ma->max)) {
 		mask = rcu_dereference_ovsl(ma->masks[*index]);
@@ -745,7 +751,8 @@ static struct sw_flow *flow_lookup(struct flow_table *tbl,
 				u64_stats_update_begin(&ma->syncp);
 				usage_counters[*index]++;
 				u64_stats_update_end(&ma->syncp);
-				(*n_cache_hit)++;
+				if (n_cache_hit)
+					(*n_cache_hit)++;
 				return flow;
 			}
 		}
@@ -796,13 +803,9 @@ struct sw_flow *ovs_flow_tbl_lookup_stats(struct flow_table *tbl,
 
 	*n_mask_hit = 0;
 	*n_cache_hit = 0;
-	if (unlikely(!skb_hash || mc->cache_size == 0)) {
-		u32 mask_index = 0;
-		u32 cache = 0;
-
-		return flow_lookup(tbl, ti, ma, key, n_mask_hit, &cache,
-				   &mask_index);
-	}
+	if (unlikely(!skb_hash || mc->cache_size == 0))
+		return flow_lookup(tbl, ti, ma, key, n_mask_hit, NULL,
+				   NULL);
 
 	/* Pre and post recirulation flows usually have the same skb_hash
 	 * value. To avoid hash collisions, rehash the 'skb_hash' with
@@ -849,11 +852,7 @@ struct sw_flow *ovs_flow_tbl_lookup(struct flow_table *tbl,
 {
 	struct table_instance *ti = rcu_dereference_ovsl(tbl->ti);
 	struct mask_array *ma = rcu_dereference_ovsl(tbl->mask_array);
-	u32 __always_unused n_mask_hit;
-	u32 __always_unused n_cache_hit;
-	u32 index = 0;
-
-	return flow_lookup(tbl, ti, ma, key, &n_mask_hit, &n_cache_hit, &index);
+	return flow_lookup(tbl, ti, ma, key, NULL, NULL, NULL);
 }
 
 struct sw_flow *ovs_flow_tbl_lookup_exact(struct flow_table *tbl,
@@ -865,7 +864,6 @@ struct sw_flow *ovs_flow_tbl_lookup_exact(struct flow_table *tbl,
 	/* Always called under ovs-mutex. */
 	for (i = 0; i < ma->max; i++) {
 		struct table_instance *ti = rcu_dereference_ovsl(tbl->ti);
-		u32 __always_unused n_mask_hit;
 		struct sw_flow_mask *mask;
 		struct sw_flow *flow;
 
@@ -873,7 +871,7 @@ struct sw_flow *ovs_flow_tbl_lookup_exact(struct flow_table *tbl,
 		if (!mask)
 			continue;
 
-		flow = masked_flow_lookup(ti, match->key, mask, &n_mask_hit);
+		flow = masked_flow_lookup(ti, match->key, mask, NULL);
 		if (flow && ovs_identifier_is_key(&flow->id) &&
 		    ovs_flow_cmp_unmasked_key(flow, match)) {
 			return flow;
-- 
2.18.1

