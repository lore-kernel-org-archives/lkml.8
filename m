Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085F1C3F2D6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F972073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YAqiAObC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgCFPhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:37:24 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41264 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgCFPhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:37:24 -0500
Received: by mail-qk1-f194.google.com with SMTP id b5so2651805qkh.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 07:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=j6sXql4oSXT6Q/ws5TYxgRAPlqnRvsWRJL+OU5ImErY=;
        b=YAqiAObC9L8ErnG6/sYX0Zx1A4YfyyMtalpuashj3Fr1rvx0oV1OTzOsf1WWd5r0Ca
         i+rVg+EPA+7B8n4SzAQBM96nGiG7YpOWr3ldTbt4yPhe+3suFzHaAuvNWtiPfdWgFQbB
         pkC+mQsm5hMdAydfzA3Znr9vsufyjEQL10k4hXn7OL81+feViHmmYOG/rgMttm5whuRf
         7HUsfjEYrCq2jLdGGJkmywIhcwW8IJHjIsLL+MlYXHPgaJQHc4Oc2VasPVdIWN4zzAEm
         gBTHTQQcFMLOG2dgiAClPkxa6C2ODhB5T3Q1grlW+yo2942vwg11v77ivtsKG77Cy7F7
         4fDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j6sXql4oSXT6Q/ws5TYxgRAPlqnRvsWRJL+OU5ImErY=;
        b=sO1ad0N0H2+0VgVTnzPSD6qPDZa+7KyeKlicAxzLBGkvoqbGr+nDgwPOPdBesCPp+Y
         2BIVFDinFr7ek/af/w5m4v8XLWe0uImelyM80DZx/k9OZPIjy7VX+tpnPA9XNL80vsWJ
         RLzCaB3OY3j7FO0V7t4hKoO8SZEnRjVmK7o5mlQbHiTOm/GM6XtLYT+KY0Jwx9lkod1X
         QSioHL4p0zkA/3B74QDyoa52349YEffSvWsc0pBJWsNlSMD/CcByq3HMdPQIVERBp7HC
         ifZTB5uzLE/cqQTrysOL1U8ByxDei8DBi4DfkPRb7p6crStsaBglyZuZKYL2vaH5T9FK
         ZMrg==
X-Gm-Message-State: ANhLgQ1tctBiOq9qdqd4tGSyzlIj9sixuvhBLP1r3ED/s54kcxwFPFel
        RM1dJksRrUUsFb0dJgmHC7uWLA==
X-Google-Smtp-Source: ADFU+vssYst3rQrdo3Lx7+NOozn/HbgaawMN4v1NWOduUezf5Zgkw4/bA/AC8DrCvilHOguU7M7DHA==
X-Received: by 2002:a37:a80c:: with SMTP id r12mr3278127qke.241.1583509043047;
        Fri, 06 Mar 2020 07:37:23 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t3sm16038837qkt.114.2020.03.06.07.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2020 07:37:22 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        walter-zh.wu@mediatek.com, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] kasan/tags: fix -Wdeclaration-after-statement warn
Date:   Fri,  6 Mar 2020 10:37:10 -0500
Message-Id: <1583509030-27939-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit "kasan: detect negative size in memory operation
function" introduced a compilation warning,

mm/kasan/tags_report.c:51:27: warning: ISO C90 forbids mixing
declarations and code [-Wdeclaration-after-statement]
        struct kasan_alloc_meta *alloc_meta;

Fix it by moving a code around a bit where there is no strict
dependency.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/kasan/tags_report.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/kasan/tags_report.c b/mm/kasan/tags_report.c
index 1d412760551a..bee43717d6f0 100644
--- a/mm/kasan/tags_report.c
+++ b/mm/kasan/tags_report.c
@@ -36,17 +36,6 @@
 
 const char *get_bug_type(struct kasan_access_info *info)
 {
-	/*
-	 * If access_size is a negative number, then it has reason to be
-	 * defined as out-of-bounds bug type.
-	 *
-	 * Casting negative numbers to size_t would indeed turn up as
-	 * a large size_t and its value will be larger than ULONG_MAX/2,
-	 * so that this can qualify as out-of-bounds.
-	 */
-	if (info->access_addr + info->access_size < info->access_addr)
-		return "out-of-bounds";
-
 #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
 	struct kasan_alloc_meta *alloc_meta;
 	struct kmem_cache *cache;
@@ -71,6 +60,17 @@ const char *get_bug_type(struct kasan_access_info *info)
 	}
 
 #endif
+	/*
+	 * If access_size is a negative number, then it has reason to be
+	 * defined as out-of-bounds bug type.
+	 *
+	 * Casting negative numbers to size_t would indeed turn up as
+	 * a large size_t and its value will be larger than ULONG_MAX/2,
+	 * so that this can qualify as out-of-bounds.
+	 */
+	if (info->access_addr + info->access_size < info->access_addr)
+		return "out-of-bounds";
+
 	return "invalid-access";
 }
 
-- 
1.8.3.1

