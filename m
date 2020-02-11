Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BC2C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C28E214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ImQAEYyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgBKNya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:54:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44386 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729768AbgBKNy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:54:27 -0500
Received: by mail-qk1-f193.google.com with SMTP id v195so10064708qkb.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 05:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lYlTJ1jY8JnxpacazgipCT1s12isYW6IzQVTCcofmsU=;
        b=ImQAEYycKiLH6JQH4FTn5G26YRERLBu5hGWzQ+xekv40zttKFB/EdVLMpnF8LWt3ms
         3QIstbyO2U5Z+QsTOntYhs89pUgnni8DOSvEbl6QBm/t13cxLl38kGSwhwfm+Ef3yYL/
         dPkNPep87NC3f2BQ2Fq8S14ODKLXWpx5jN5hU2SDuScS/DGL0QMPzQCWnfKRFflz5vdc
         nZan2gpH/dLxyxsM0oD8m0mbmuzOQ93/U2TKGRt4P5WG024V9vSSfHS7dCFgPu7D7aXd
         sdR6ylo3YxM3Yrl0snU/HXsKpcdJJTQEPESs3RlwbLsSo3rsSXzz4DdPIwrWao0D5z59
         EHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lYlTJ1jY8JnxpacazgipCT1s12isYW6IzQVTCcofmsU=;
        b=hHypf9O877QDq8xoewvQvNUvx/5y6VrJuAQgzpFIelHZAgBKNya7EieU6xw1BD5SeN
         /rMTRM0UIRsDdDZi5KUSVyOYZejTJh2rozG+XMhmET4IZSGgz9hTOxnQarG56rfJzyxF
         iN/W2igz1/NzrDIcb9BCqq9wz/WqGOkomFBGLepyRlmKKM02VN0fO3gowxKWAYgtqEo9
         BkYgTQnSNKDT2T5F8EhyxlVCiGyeVUp8a+RoCorXjNjwCSn3/GQonP2SiuKOr8SyUuZn
         VsQx+s7ytOd6i/8ldFF3IePYeUSMnbrXiBZMxANPEYjcaM8aNnyUIXRZWRtqrOsQMhwn
         N7qA==
X-Gm-Message-State: APjAAAW83rUNCd7alVJtVkLNk4pxRLPtWtVfcYR1BcZa+p7+mlTYcbiG
        Wa0PbYGtfX3ZuZ9PDrMxea1POMPCE1/Wpg==
X-Google-Smtp-Source: APXvYqzWifYO5OED9CyywC9hb+H9plH1pF7jNNf1kQ0cIQ1vOnTCatRdFH1bv0yQEn2PJxiG+tltbg==
X-Received: by 2002:a37:7b84:: with SMTP id w126mr6180914qkc.280.1581429266697;
        Tue, 11 Feb 2020 05:54:26 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z6sm2077181qto.86.2020.02.11.05.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 05:54:26 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     will@kernel.org, elver@google.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] locking/osq_lock: annotate a data race in osq_lock
Date:   Tue, 11 Feb 2020 08:54:15 -0500
Message-Id: <1581429255-12542-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prev->next could be accessed concurrently as noticed by KCSAN,

 write (marked) to 0xffff9d3370dbbe40 of 8 bytes by task 3294 on cpu 107:
  osq_lock+0x25f/0x350
  osq_wait_next at kernel/locking/osq_lock.c:79
  (inlined by) osq_lock at kernel/locking/osq_lock.c:185
  rwsem_optimistic_spin
  <snip>

 read to 0xffff9d3370dbbe40 of 8 bytes by task 3398 on cpu 100:
  osq_lock+0x196/0x350
  osq_lock at kernel/locking/osq_lock.c:157
  rwsem_optimistic_spin
  <snip>

Since the write only stores NULL to prev->next and the read tests if
prev->next equals to this_cpu_ptr(&osq_node). Even if the value is
shattered, the code is still working correctly. Thus, mark it as an
intentional data race using the data_race() macro.

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: insert some code comments.

 kernel/locking/osq_lock.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 1f7734949ac8..f733bcd99e8a 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -154,7 +154,11 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	 */
 
 	for (;;) {
-		if (prev->next == node &&
+		/*
+		 * cpu_relax() below implies a compiler barrier which would
+		 * prevent this comparison being optimized away.
+		 */
+		if (data_race(prev->next == node) &&
 		    cmpxchg(&prev->next, node, NULL) == node)
 			break;
 
-- 
1.8.3.1

