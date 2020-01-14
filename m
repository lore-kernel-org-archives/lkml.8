Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13F3C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD7324672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="suons98s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgANQrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:47:07 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:42939 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgANQq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:46:59 -0500
Received: by mail-pl1-f201.google.com with SMTP id b4so5381726plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 08:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=utFWUT6wlMosbqdVUWks9jGqk+aaGoz4H9C5fn7YGjc=;
        b=suons98sXGv+WZP3A0WOzWUhmDaJzA6cISir0AQCPvyueitlHsxzE44GK+dKUUr7zc
         EMvkPYuT+d8+lefNZ3Dz84eqb0HXbkq4WzC2Jv4RgH72LPXXLTE+wMLzPv7oQfhG0OvT
         FBf+2aPSjBU5WLejdzHOg6Bg+FQnu5P9s387y41rraratirCb495x0yv1zX9d4SFk/7m
         ta4YXNpmQUy1BACaHa95A4ckd1dgWon2VH/Kvtv6C93tJhcFU0WGzAr/WhSn1Gs5NpRY
         9YLfdwOqpeYbcxhPdYcLRu2Qup2ndWwJM4ujCNuOvRflKsxN0XT/zKE102LansKoa+LO
         h65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=utFWUT6wlMosbqdVUWks9jGqk+aaGoz4H9C5fn7YGjc=;
        b=gi4pTMJHGe6sAcvOjJt3Pbe/oP2zhq79aDu4VUnZzDjR91EoSCMYEUrAbU6EvAby/J
         EJ683N2WDBZPvtDaJHh2v8l86Xj+m/yO7hq+EgdiB0S/nqhXSC6udB3S0mj6uymD3arr
         8bXYWGI+bad2vWhZityHd6WQjBytVTGFVCGJB2n/dLbK/74plWYUl1lLYBT9/SUWUH2G
         nonbl8Y+mPV9LzdoQpwiKXWH2JsGikSdslMt1MXMI1f7ElOozgJS35yJuTAnQlKqkfmJ
         sD67S5aUSUgJVH9gyvA/a9vDtep5hysKFHYkq3fg8wTlTs7qcCf85EU3LG8qrSAH0E2r
         3tIA==
X-Gm-Message-State: APjAAAUNcpuwUKSAAslG/lVd37vb+mWQBbaPYT8Uem/1HLr80VKKMTJO
        SRsj2YztodAqA0ee4yz51hsHXJL6SQuv
X-Google-Smtp-Source: APXvYqwCbXHUN96hD1m5fhRfxiQHBzeJoLHzVq40CD8wueDkFEN9quREbNiy+kM8hP5feUtpk9+shhAo33Gm
X-Received: by 2002:a63:30c:: with SMTP id 12mr27766270pgd.276.1579020418779;
 Tue, 14 Jan 2020 08:46:58 -0800 (PST)
Date:   Tue, 14 Jan 2020 08:46:14 -0800
In-Reply-To: <20200114164614.47029-1-brianvv@google.com>
Message-Id: <20200114164614.47029-11-brianvv@google.com>
Mime-Version: 1.0
References: <20200114164614.47029-1-brianvv@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v4 bpf-next 9/9] selftests/bpf: add batch ops testing to array
 bpf map
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested bpf_map_lookup_batch() and bpf_map_update_batch()
functionality.

  $ ./test_maps
      ...
        test_array_map_batch_ops:PASS
      ...

Signed-off-by: Brian Vazquez <brianvv@google.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../bpf/map_tests/array_map_batch_ops.c       | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c

diff --git a/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
new file mode 100644
index 0000000000000..05b7caea6a444
--- /dev/null
+++ b/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include <test_maps.h>
+
+static void map_batch_update(int map_fd, __u32 max_entries, int *keys,
+			     int *values)
+{
+	int i, err;
+
+	DECLARE_LIBBPF_OPTS(bpf_map_batch_opts, opts,
+		.elem_flags = 0,
+		.flags = 0,
+	);
+
+	for (i = 0; i < max_entries; i++) {
+		keys[i] = i;
+		values[i] = i + 1;
+	}
+
+	err = bpf_map_update_batch(map_fd, keys, values, &max_entries, &opts);
+	CHECK(err, "bpf_map_update_batch()", "error:%s\n", strerror(errno));
+}
+
+static void map_batch_verify(int *visited, __u32 max_entries,
+			     int *keys, int *values)
+{
+	int i;
+
+	memset(visited, 0, max_entries * sizeof(*visited));
+	for (i = 0; i < max_entries; i++) {
+		CHECK(keys[i] + 1 != values[i], "key/value checking",
+		      "error: i %d key %d value %d\n", i, keys[i], values[i]);
+		visited[i] = 1;
+	}
+	for (i = 0; i < max_entries; i++) {
+		CHECK(visited[i] != 1, "visited checking",
+		      "error: keys array at index %d missing\n", i);
+	}
+}
+
+void test_array_map_batch_ops(void)
+{
+	struct bpf_create_map_attr xattr = {
+		.name = "array_map",
+		.map_type = BPF_MAP_TYPE_ARRAY,
+		.key_size = sizeof(int),
+		.value_size = sizeof(int),
+	};
+	int map_fd, *keys, *values, *visited;
+	__u32 count, total, total_success;
+	const __u32 max_entries = 10000;
+	bool nospace_err;
+	__u64 batch = 0;
+	int err, step;
+
+	DECLARE_LIBBPF_OPTS(bpf_map_batch_opts, opts,
+		.elem_flags = 0,
+		.flags = 0,
+	);
+
+	xattr.max_entries = max_entries;
+	map_fd = bpf_create_map_xattr(&xattr);
+	CHECK(map_fd == -1,
+	      "bpf_create_map_xattr()", "error:%s\n", strerror(errno));
+
+	keys = malloc(max_entries * sizeof(int));
+	values = malloc(max_entries * sizeof(int));
+	visited = malloc(max_entries * sizeof(int));
+	CHECK(!keys || !values || !visited, "malloc()", "error:%s\n",
+	      strerror(errno));
+
+	/* populate elements to the map */
+	map_batch_update(map_fd, max_entries, keys, values);
+
+	/* test 1: lookup in a loop with various steps. */
+	total_success = 0;
+	for (step = 1; step < max_entries; step++) {
+		map_batch_update(map_fd, max_entries, keys, values);
+		map_batch_verify(visited, max_entries, keys, values);
+		memset(keys, 0, max_entries * sizeof(*keys));
+		memset(values, 0, max_entries * sizeof(*values));
+		batch = 0;
+		total = 0;
+		/* iteratively lookup/delete elements with 'step'
+		 * elements each.
+		 */
+		count = step;
+		nospace_err = false;
+		while (true) {
+			err = bpf_map_lookup_batch(map_fd,
+						total ? &batch : NULL, &batch,
+						keys + total,
+						values + total,
+						&count, &opts);
+
+			CHECK((err && errno != ENOENT), "lookup with steps",
+			      "error: %s\n", strerror(errno));
+
+			total += count;
+			if (err)
+				break;
+
+		}
+
+		if (nospace_err == true)
+			continue;
+
+		CHECK(total != max_entries, "lookup with steps",
+		      "total = %u, max_entries = %u\n", total, max_entries);
+
+		map_batch_verify(visited, max_entries, keys, values);
+
+		total_success++;
+	}
+
+	CHECK(total_success == 0, "check total_success",
+	      "unexpected failure\n");
+
+	printf("%s:PASS\n", __func__);
+
+	free(keys);
+	free(values);
+	free(visited);
+}
-- 
2.25.0.rc1.283.g88dfdc4193-goog

