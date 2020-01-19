Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DC0C33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 19:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB1C20679
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 19:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QlOdTQSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgASTk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 14:40:58 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:37140 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgASTk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 14:40:58 -0500
Received: by mail-pj1-f73.google.com with SMTP id dw15so9121355pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 11:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GYu7/zxMNd86d8ZFJUTXCcQyLaKeKY/49TH/Y+j6Gqg=;
        b=QlOdTQSL0z+vkc6smWiyAQv9TSrlVmSbT/+AQt+zaKA98cZi+qyrt0DbZ0Xs7MFC20
         5aamMs9qMUFIv4nItetzHFmLGTOon1t7k/NHKm/1WDKitaeMEIBoRwXp/gbkCHU/iqrr
         GQRhGd+/iL+Rj4LFLSMeHGRb6GINCcrUFdWgfK2CJgIZk8C2B8kWld7dCCpbzHjeJRD5
         +Z/Hz23oeNBgx79zWK2FGFUjAj4Jue7OPGOw8u7g4AHGoHZxvk+YO2X9LQAbGhqtOK+F
         Wv4BH83ZnfubP878cLqqML9UPDyyFiXnac8MW1chjhuLxiIgB4Y+BWtjdr798IKXSmGq
         vppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GYu7/zxMNd86d8ZFJUTXCcQyLaKeKY/49TH/Y+j6Gqg=;
        b=MKH9zc4nY3ofHPyYM2npVRGIuoOsLpvP3RYgm9I+Kn/zf2TgnfDDNsUsbQl3ouUeP/
         xM5JCxp5kj4retytKNrIN1/vbbbAG3e73aMn9awYfuYm8uK6k3NUSuIfMXiY04glpKgb
         cnr4b8LAMJjrwBx20adcZVuAYBgzrAKe73dvlwNG5dDnrBHCft+WxMEMf1sfFGeA7GF+
         7wT7jVuPYDB6M3aIdLDHdmEE0fP+4YQExaWL4hdHa2O2keA+omSboykUoWd08ArS6Z0a
         DpBL18KWA2O8XKZGpyhVpy6YJ+lnMM4zm4cGzjmR9U8hZZWLSykY2D2zWjJPI/7aItJ7
         EV4g==
X-Gm-Message-State: APjAAAWBAxY0MgvjFlWYXC4sKHRJ+W5xoJVGrHRJG+MUzZaGfjJx4+8D
        BM4Es7XQfbh4KDewcNWH6gU+pH/51P6O
X-Google-Smtp-Source: APXvYqxuXDpCo3mn2kxa6NMICU35MJWDGVxXH9/az/hajnPP/dt1PwbFij25BEGseYexTQgSbHlar3gYhHgz
X-Received: by 2002:a63:7311:: with SMTP id o17mr53720220pgc.29.1579462857433;
 Sun, 19 Jan 2020 11:40:57 -0800 (PST)
Date:   Sun, 19 Jan 2020 11:40:40 -0800
Message-Id: <20200119194040.128369-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 bpf-next] bpf: Fix memory leaks in generic update/delete
 batch ops
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generic update/delete batch ops functions were using __bpf_copy_key
without properly freeing the memory. Handle the memory allocation and
copy_from_user separately.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: aa2e93b8e58e ("bpf: Add generic support for update and delete batch ops")
Signed-off-by: Brian Vazquez <brianvv@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
v1->v2:
 - Put Fixes subject in a single line (Yonghong Song)
---
 kernel/bpf/syscall.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c26a71460f02f..9a840c57f6df7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1239,12 +1239,15 @@ int generic_map_delete_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
+	key = kmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
+	if (!key)
+		return -ENOMEM;
+
 	for (cp = 0; cp < max_count; cp++) {
-		key = __bpf_copy_key(keys + cp * map->key_size, map->key_size);
-		if (IS_ERR(key)) {
-			err = PTR_ERR(key);
+		err = -EFAULT;
+		if (copy_from_user(key, keys + cp * map->key_size,
+				   map->key_size))
 			break;
-		}
 
 		if (bpf_map_is_dev_bound(map)) {
 			err = bpf_map_offload_delete_elem(map, key);
@@ -1264,6 +1267,8 @@ int generic_map_delete_batch(struct bpf_map *map,
 	}
 	if (copy_to_user(&uattr->batch.count, &cp, sizeof(cp)))
 		err = -EFAULT;
+
+	kfree(key);
 	return err;
 }
 
@@ -1294,18 +1299,21 @@ int generic_map_update_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
+	key = kmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
+	if (!key)
+		return -ENOMEM;
+
 	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
-	if (!value)
+	if (!value) {
+		kfree(key);
 		return -ENOMEM;
+	}
 
 	for (cp = 0; cp < max_count; cp++) {
-		key = __bpf_copy_key(keys + cp * map->key_size, map->key_size);
-		if (IS_ERR(key)) {
-			err = PTR_ERR(key);
-			break;
-		}
 		err = -EFAULT;
-		if (copy_from_user(value, values + cp * value_size, value_size))
+		if (copy_from_user(key, keys + cp * map->key_size,
+		    map->key_size) ||
+		    copy_from_user(value, values + cp * value_size, value_size))
 			break;
 
 		err = bpf_map_update_value(map, f, key, value,
-- 
2.25.0.341.g760bfbb309-goog

