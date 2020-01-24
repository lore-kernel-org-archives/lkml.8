Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C223C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1053E206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aGYdZJEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391977AbgAXLiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:38:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38142 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404132AbgAXL36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:29:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so1378554wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 03:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cJ4TZV5cXZ/8q9QBQvb7gjQiJz0uB/MAQITB1sj0NIA=;
        b=aGYdZJEshwF1cDJSP1sWdrNLBZhS7I1RyF6A+y71axz3sMiUBhYP2IE6Kd9mNUgg5W
         IECZ+kHefZaSIFM+5Bg2JehMCd3qN0v0qS3ULjoDIz6rpsX8FxCiZGK6BXNJbtHF3X4T
         sv57upHc3Gx34c2KFseWNntiHUPIsA2RuSJ9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cJ4TZV5cXZ/8q9QBQvb7gjQiJz0uB/MAQITB1sj0NIA=;
        b=iWO1M2YbucC4DsN4rvHl6zxgSCC7iW0x2T0cDG9BRCzcCl5vZkXTvBK9t/iMgBuXy2
         ERzC6hHj08dGjkzR9DkbX8H2VzJnEH+mDQlv2UqoLU4n8AV8sq4P27AtlgFHvWd2POUE
         PPG/+46fPxYCYClw4YBRQUJFdEa+SSvzzrWMoXzkGfyQkm70v//M+sIup/R1/NVbe31Y
         4A4UhimPImBL0MAV7Yzm4f4XPQKsg861rpxjafLkL/Hyirkas9S0M5HeCm7A0GC7Sziy
         TJNH2z6w3D3re3d23inVjS2RhuuU9XVbCIrky1SYiqzI4EJY4InbuJR1YBL2ljOrx0dR
         Zuew==
X-Gm-Message-State: APjAAAXDMQXjJwBxH+hVTh6c9TGXVBnPBvBg0H+T4oAOU5S0VP0wEba+
        puxB+2AuAGkCr8pmxrj/6eNDIjM/dXklQA==
X-Google-Smtp-Source: APXvYqxsibd4gK6MTr1ppba1secKSIQp1ayf0Ni0amvJDL4rkRNpwnjnQZ1jK6nkDlO+g5yIu8e9hQ==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr2846104wmi.166.1579865397394;
        Fri, 24 Jan 2020 03:29:57 -0800 (PST)
Received: from antares.lan (3.a.c.b.c.e.9.a.8.e.c.d.e.4.1.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:614e:dce8:a9ec:bca3])
        by smtp.gmail.com with ESMTPSA id n189sm6808688wme.33.2020.01.24.03.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 03:29:56 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 4/4] selftests: bpf: reset global state between reuseport test runs
Date:   Fri, 24 Jan 2020 11:27:54 +0000
Message-Id: <20200124112754.19664-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124112754.19664-1-lmb@cloudflare.com>
References: <20200123165934.9584-1-lmb@cloudflare.com>
 <20200124112754.19664-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is a lot of false positives if a single reuseport test
fails. This is because expected_results and the result map are not cleared.

Zero both after individual test runs, which fixes the mentioned false
positives.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Fixes: 91134d849a0e ("bpf: Test BPF_PROG_TYPE_SK_REUSEPORT")
---
 .../selftests/bpf/prog_tests/select_reuseport.c  | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index e7e56929751c..098bcae5f827 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -33,7 +33,7 @@
 #define REUSEPORT_ARRAY_SIZE 32
 
 static int result_map, tmp_index_ovr_map, linum_map, data_check_map;
-static enum result expected_results[NR_RESULTS];
+static __u32 expected_results[NR_RESULTS];
 static int sk_fds[REUSEPORT_ARRAY_SIZE];
 static int reuseport_array = -1, outer_map = -1;
 static int select_by_skb_data_prog;
@@ -697,7 +697,19 @@ static void setup_per_test(int type, sa_family_t family, bool inany,
 
 static void cleanup_per_test(bool no_inner_map)
 {
-	int i, err;
+	int i, err, zero = 0;
+
+	memset(expected_results, 0, sizeof(expected_results));
+
+	for (i = 0; i < NR_RESULTS; i++) {
+		err = bpf_map_update_elem(result_map, &i, &zero, BPF_ANY);
+		RET_IF(err, "reset elem in result_map",
+		       "i:%u err:%d errno:%d\n", i, err, errno);
+	}
+
+	err = bpf_map_update_elem(linum_map, &zero, &zero, BPF_ANY);
+	RET_IF(err, "reset line number in linum_map", "err:%d errno:%d\n",
+	       err, errno);
 
 	for (i = 0; i < REUSEPORT_ARRAY_SIZE; i++)
 		close(sk_fds[i]);
-- 
2.20.1

