Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C7DC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D4282080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="s4MbRGJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbgIGRXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbgIGNpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:45:15 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DC1C0617A1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 06:41:30 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id 23so2854988wmk.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=QC9NTo7nxtZYJpQO/i/DXWRBIzGZiJeRrgmmIrmcLsY=;
        b=s4MbRGJaHgZspQUWINVYJ4pv8oUtjLjvmGIgxMKTQ5dpZP+CTosv0PbYmzzxxGGXV1
         lu//CLYOxuze23vL1Bsidfemp47rjnE9diiVDGA8zX6qY7htd9eYMagMAyg+h08jG0Of
         2+B5S4bbYrx0Z+7QhYZpW1sYioo4B4NxC0mipIVfVaGUKBPBaaVG8jiHoIJ0FFzS2VmY
         abMTL8QLr3mcS0n8SK1Y6ohWVxow8eGg9rJ3VpEmH5/fbCLItYW8VkWRtMRorA/nE0NY
         8z30jLgXskcLoNjNbRF5RWlrDlZjgSCM2YaL1KafEg8a9O1f/ASIE+LMY5azSFzU/NJo
         KtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QC9NTo7nxtZYJpQO/i/DXWRBIzGZiJeRrgmmIrmcLsY=;
        b=PDiu5N6Ns+JZWhrni15x7D2NswFoOsRIYE/TXSHr0D2zK6ei/6GwO/fU3geTWE8FBI
         bIjaOqK8ujLW7S2OoLbv8+qSfk7D6iR6DhmRS6AOlP5CLzRZaoDk66bPpdaV2XOL9648
         PqMxWhcQkARXeefh1QZS+elsCbKtupVVO/KFnXPMIHSbcSz5U4bSioU46sTAe6rrEb9v
         5MM6FyFak7W2AupaliKDkStzi8U+7ray/dR/b+Or77J1jQgyEAtXTXM2+zWzf28WhI1W
         x9fxGBn16roXya35p5MM1vG9TeUKrXWCI9NNty/BSGjF5dnlv1niQSmpfFCk+PcAl9Ae
         lC0w==
X-Gm-Message-State: AOAM532b7HLAu4SO1D6SBfOf5XEsj9i0MRX8n6Xt5mgfGioqIrwVStzg
        IvrrqofrU+k1ut77lEtC+zP96uvgNQ==
X-Google-Smtp-Source: ABdhPJwfBXSFasOjomiIxo9IXspK1cNnb4LrYot1/kxO1J7dSMNEmNNlULqP5o8LlWMBrqdqJrkBo5GUVQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a5d:6551:: with SMTP id z17mr20816665wrv.200.1599486089420;
 Mon, 07 Sep 2020 06:41:29 -0700 (PDT)
Date:   Mon,  7 Sep 2020 15:40:53 +0200
In-Reply-To: <20200907134055.2878499-1-elver@google.com>
Message-Id: <20200907134055.2878499-9-elver@google.com>
Mime-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH RFC 08/10] kfence, lockdep: make KFENCE compatible with lockdep
From:   Marco Elver <elver@google.com>
To:     elver@google.com, glider@google.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, cl@linux.com, rientjes@google.com,
        iamjoonsoo.kim@lge.com, mark.rutland@arm.com, penberg@kernel.org
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, dvyukov@google.com,
        edumazet@google.com, gregkh@linuxfoundation.org, mingo@redhat.com,
        jannh@google.com, corbet@lwn.net, keescook@chromium.org,
        peterz@infradead.org, cai@lca.pw, tglx@linutronix.de,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep checks that dynamic key registration is only performed on keys
that are not static objects. With KFENCE, it is possible that such a
dynamically allocated key is a KFENCE object which may, however, be
allocated from a static memory pool (if HAVE_ARCH_KFENCE_STATIC_POOL).

Therefore, ignore KFENCE-allocated objects in static_obj().

Co-developed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/locking/lockdep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 54b74fabf40c..0cf5d5ecbd31 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -38,6 +38,7 @@
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/kallsyms.h>
+#include <linux/kfence.h>
 #include <linux/interrupt.h>
 #include <linux/stacktrace.h>
 #include <linux/debug_locks.h>
@@ -755,6 +756,13 @@ static int static_obj(const void *obj)
 	if (arch_is_kernel_initmem_freed(addr))
 		return 0;
 
+	/*
+	 * KFENCE objects may be allocated from a static memory pool, but are
+	 * not actually static objects.
+	 */
+	if (is_kfence_address(obj))
+		return 0;
+
 	/*
 	 * static variable?
 	 */
-- 
2.28.0.526.ge36021eeef-goog

