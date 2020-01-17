Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7C7C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449EB21D56
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mSNZ/egw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgAQW4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:56:15 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:46039 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgAQW4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:56:15 -0500
Received: by mail-pg1-f201.google.com with SMTP id q1so15247150pge.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 14:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YjsrWHQk2Ef6EHqeIvIXkz/PqYhiYpHlX5C3YmPgP0Q=;
        b=mSNZ/egwZMUmNm1xCRqbVDVxIgJ6PFHFMD97bYM6PSRiI0fnVpa/c12S1s1e8l9lw3
         4kJDr5myZh+2kfmLJaaAEkMEyaQ7kZLp+1occpsd9NPK1bruNXoY8zJc7ak14IL03QZe
         tQYueFop0SCDJZTSzY7KkD4Cg5Snz5DeVEVNli2apaOIfDqXOylKHzuofDWMjNrZJU8N
         hUtED5YDA2ThS+KjvTVPVSZ9hp2yCUvcNaBB5hVRNC1Y8D5MByJpTWoP+2uK4ggVt1x8
         DIfsFSUPEoYc7WqM2Q1f9BmZlW5m8ZrGf39dOPe9VBVxkRcYilUThhxblU6pZgYALu5p
         SGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YjsrWHQk2Ef6EHqeIvIXkz/PqYhiYpHlX5C3YmPgP0Q=;
        b=kIFN2tRIon0zT0M/eBO+w9T0VE/S8o7845bxyH5m/0gMAzuZawkY3r4I2vz3N3G6E8
         VuIGXgKzpgIOtQ9hHqIdkIE7+Zjq07zDGmKkiI+jxzXJ8QVJyqg1vQeU18RohuWFAqCi
         oJQSV9gTifA6o2c3ONOJzZgqJwo4quRvwJq6ImZoUy8lUDV2EOoT8eAovfXzNhMoerBv
         C9eK7aaehdG2WKDuk2q6EB5uzXyQC+assOEEpaur/UHmauFrqUldmCPd5+oTBjtR/3+O
         +14QuTcfhWyxj6Ts/bOKBQBD0VhApRywuPPVbFHqD80wH59ddqQBfSFqmV6hIWfFDaeu
         fIjg==
X-Gm-Message-State: APjAAAVnEsQZXaAL8wc/sAmyRRmEqkwk/BgSiV243mNPoxnP7ujs2z1r
        jVSXDob+9Lh2+CqNEFu1+3dDk6uAgdZI
X-Google-Smtp-Source: APXvYqyz6Htr5YrcybMBordUJnmC5nMxj+CYUOrxzx3s7H3o4YTtrCUUGDPO0qBaXmphcnbRdVW3Yra5sMzi
X-Received: by 2002:a63:3f82:: with SMTP id m124mr48101369pga.431.1579301774378;
 Fri, 17 Jan 2020 14:56:14 -0800 (PST)
Date:   Fri, 17 Jan 2020 14:56:08 -0800
Message-Id: <20200117225608.220838-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH bpf-next] bpf: Fix memory leaks in generic update/delete batch ops
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generic update/delete batch ops functions were using __bpf_copy_key
without properly freeing the memory. Handle the memory allocation and
copy_from_user separately.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: aa2e93b8e58e ("bpf: Add generic support for update and delete
batch ops")
Signed-off-by: Brian Vazquez <brianvv@google.com>
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

