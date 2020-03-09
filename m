Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556CBC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2878B2051A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="vhJLcMYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgCILNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:13:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38150 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgCILNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:13:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id n2so2632384wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QaTFcTkFq4Xguxn8bSzfnksfS0c2jnlyVSoCBPs8eek=;
        b=vhJLcMYmm/qr33TiAo7JT5z9HUaVRDrZxOEz87v6imXUfpQppv5xXULXiHOZUArRRp
         FFGy2atvM1OycOehbNrLU6P63rckxQ5xm5mpMolVJvbPuKMVwijc1yTXJj+7Q6XXNB9u
         mCjeJOvp1kRypn4zZL6FicO2iv+f6FuzwaSm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QaTFcTkFq4Xguxn8bSzfnksfS0c2jnlyVSoCBPs8eek=;
        b=rHh4It/O8yuBVNacLOLupT0mmRvR2D4sEZ/SlGmOq3n6liZrLQPoc0e9tlOKyvOmZm
         jDNMnd9d7Xyu2JaTk3M+/cZfo0Hp3M7/QXlYGje+YIvA9f7EzyGg6ogXij3tPKV6NKtV
         Mg7nHt9s/FJta8//NOEKUua6CCl1lYK5yGjO+FQ/1JZbC4nQSqWHHKrtbSFoRKmJ9MIf
         LkNUhCD7H4B45F+Ri2wC3ecPaCru7aYnmV/VSSufnXJoaXN0eoQwkVNf1Ust3LBQd22B
         HUd7wntdDErI19VpalSf8d2rupiU53YHcXQvKGRGHgmjO1j572LS1EWSWw962FVP0DoY
         0RmQ==
X-Gm-Message-State: ANhLgQ31j6U/dxPH/ctIiKVK3G54zJrNTO0tG0bOvgq29V7EruLd3WXW
        q2j+0mqJxeRhxrDaIuu8BN/XXw==
X-Google-Smtp-Source: ADFU+vtelcGYQQ7cq2t6WKsONlaRaq72BxVgq3eY1uel/I49QzMryenNk1JX3ZTxqPj2w/PQTT0LSA==
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr18926382wml.57.1583752408076;
        Mon, 09 Mar 2020 04:13:28 -0700 (PDT)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:3dcc:c1d:7f05:4873])
        by smtp.gmail.com with ESMTPSA id a5sm25732846wmb.37.2020.03.09.04.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:13:27 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 11/12] selftests: bpf: enable UDP sockmap reuseport tests
Date:   Mon,  9 Mar 2020 11:12:42 +0000
Message-Id: <20200309111243.6982-12-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309111243.6982-1-lmb@cloudflare.com>
References: <20200309111243.6982-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the guard that disables UDP tests now that sockmap
has support for them.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/select_reuseport.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index a1dd13b34d4b..821b4146b7b6 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -805,12 +805,6 @@ static void test_config(int sotype, sa_family_t family, bool inany)
 	char s[MAX_TEST_NAME];
 	const struct test *t;
 
-	/* SOCKMAP/SOCKHASH don't support UDP yet */
-	if (sotype == SOCK_DGRAM &&
-	    (inner_map_type == BPF_MAP_TYPE_SOCKMAP ||
-	     inner_map_type == BPF_MAP_TYPE_SOCKHASH))
-		return;
-
 	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
 		if (t->need_sotype && t->need_sotype != sotype)
 			continue; /* test not compatible with socket type */
-- 
2.20.1

