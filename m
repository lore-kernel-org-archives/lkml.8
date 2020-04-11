Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82347C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C317206E9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648416;
	bh=h08k/XGB9YiKKAdTyYQIrzIjmYkhYs7ZSTs9y0CzzVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p3yMoqQRj5Mz3/jdng6QoOzknYnduA6igDiPgSqFZ0xOGyRP3VCZbnfMzN+i/KhOF
	 yfqN4wZYx9omC5k8JYJZlllV/bh9ue4QCVrZbBut/Eup7IVdIzPfRrzB81jFfCsS9t
	 ui6iN3CDT3mI1VcAnKjQF91GgaactDkuTzOLYO0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbgDKXkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727919AbgDKXH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:07:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE7FF20787;
        Sat, 11 Apr 2020 23:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646447;
        bh=h08k/XGB9YiKKAdTyYQIrzIjmYkhYs7ZSTs9y0CzzVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/835YQ1eNIDhLkRpzm8i108HL7ND/KuyET/gCOxgrgvJKcUgkxWN6aq0OP1l7Fui
         Fhj1zJT0iIgTH2yq9ne1CA/VwxErlG32O9+N6Z/38QQsQhsCEjnL5VWqRWvvyckMpq
         HQGlSumYC82iCqDERcec3WpLUxVEqmgVpS9LUEWQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 018/121] selftests/bpf: Fix test_progs's parsing of test numbers
Date:   Sat, 11 Apr 2020 19:05:23 -0400
Message-Id: <20200411230706.23855-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

[ Upstream commit fc32490bff855a539d253c8a52c5a1ba51d1325a ]

When specifying disjoint set of tests, test_progs doesn't set skipped test's
array elements to false. This leads to spurious execution of tests that should
have been skipped. Fix it by explicitly initializing them to false.

Fixes: 3a516a0a3a7b ("selftests/bpf: add sub-tests support for test_progs")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Link: https://lore.kernel.org/bpf/20200314013932.4035712-2-andriin@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_progs.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 7fa7d08a8104d..849c1e8b8e3dc 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -361,7 +361,7 @@ static int libbpf_print_fn(enum libbpf_print_level level,
 
 int parse_num_list(const char *s, struct test_selector *sel)
 {
-	int i, set_len = 0, num, start = 0, end = -1;
+	int i, set_len = 0, new_len, num, start = 0, end = -1;
 	bool *set = NULL, *tmp, parsing_end = false;
 	char *next;
 
@@ -396,18 +396,19 @@ int parse_num_list(const char *s, struct test_selector *sel)
 			return -EINVAL;
 
 		if (end + 1 > set_len) {
-			set_len = end + 1;
-			tmp = realloc(set, set_len);
+			new_len = end + 1;
+			tmp = realloc(set, new_len);
 			if (!tmp) {
 				free(set);
 				return -ENOMEM;
 			}
+			for (i = set_len; i < start; i++)
+				tmp[i] = false;
 			set = tmp;
+			set_len = new_len;
 		}
-		for (i = start; i <= end; i++) {
+		for (i = start; i <= end; i++)
 			set[i] = true;
-		}
-
 	}
 
 	if (!set)
-- 
2.20.1

