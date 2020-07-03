Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1986C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93EB520772
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f3HS4AQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgGCNkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgGCNkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:40:49 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC2EC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 06:40:49 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id y204so23886461wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3lMmHnjpBeXU7bC7LazFD6+XAe//tACHyc53+6mLoHk=;
        b=f3HS4AQx1Y+8vqBhOgefZNnQpp5bLpjpN1J/CtgcF7oouLAE9LhlGvZqsg7iDaPUyF
         3gK5iII8OmnTgFAp6PzMeO156pxXmeyn5w1kIbASNvGEqWlAD8xQNWnvccVOk/ui0qmo
         NRRKv5OlXNRSSJ3IXDMGexM4/8bvtluotyNcbIzKAwl3ZjyMHkh3DvE13lMyNKsgDoNc
         B5bf5KzW6XTZvaHSBn9IknscfpcDrlBOWvnsYyhERzfs58ERLQJYqW0X7Lu9FuvOTo2E
         oZHz6qte+lVKQgcuKxdA4YIo7BYLo7DPwuWelPShxtbG+NGT2Imujj3NOmgsSA7eWg1O
         Fa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3lMmHnjpBeXU7bC7LazFD6+XAe//tACHyc53+6mLoHk=;
        b=ZL5sVxZ9ay+0gxYctwLuwyJ/ucxYNCdQTtmwkAbRp+yfWbJjvzNLaTqsQ8t9EVAErX
         /BL4HA00Gple1bWPIjNbJ+9hXFGTf+x30l89UPMkaE6s63EP4kFzIqQoxCT1V2Uja/XK
         owfcCGywOO3Rc5t5JDceoYIpgzjeOG42bSEtiq6UqgKTfqnCMc2bQGcUjYETMU1saZnR
         dA9oAJD4F0XeRfbNdH2n/9dXvhlERhRg7R3L0HTG7sTHdcQ0gObPSG0+zfwcNT0nX36P
         7nrN+wYUMnPXNaAZOlPoSbHSeamRqi+X6yUmBnig6KpVconDTB9KDFZakPh67U961/av
         oB4A==
X-Gm-Message-State: AOAM532S0UPr9P/NHUo+kJpabB/0RiH91GvHL/43Tjk07oEBL7hhnn3W
        mXvOUFnpAbyZi9M9rG1OWqI/MKw0eg==
X-Google-Smtp-Source: ABdhPJwkzVOV68Lv+LWfn57wnNkY5JjdeFSnWGYlqShq4Os8o0O24ewPmY4vT1CI/xQ/UIPr5naMbGHWZw==
X-Received: by 2002:a1c:6102:: with SMTP id v2mr37906503wmb.6.1593783647766;
 Fri, 03 Jul 2020 06:40:47 -0700 (PDT)
Date:   Fri,  3 Jul 2020 15:40:30 +0200
In-Reply-To: <20200703134031.3298135-1-elver@google.com>
Message-Id: <20200703134031.3298135-2-elver@google.com>
Mime-Version: 1.0
References: <20200703134031.3298135-1-elver@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 2/3] objtool: Add atomic builtin TSAN instrumentation to
 uaccess whitelist
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the new TSAN functions that may be emitted for atomic builtins to
objtool's uaccess whitelist.

Signed-off-by: Marco Elver <elver@google.com>
---
 tools/objtool/check.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5e0d70a89fb8..63d8b630c67a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -528,6 +528,56 @@ static const char *uaccess_safe_builtin[] = {
 	"__tsan_write4",
 	"__tsan_write8",
 	"__tsan_write16",
+	"__tsan_atomic8_load",
+	"__tsan_atomic16_load",
+	"__tsan_atomic32_load",
+	"__tsan_atomic64_load",
+	"__tsan_atomic8_store",
+	"__tsan_atomic16_store",
+	"__tsan_atomic32_store",
+	"__tsan_atomic64_store",
+	"__tsan_atomic8_exchange",
+	"__tsan_atomic16_exchange",
+	"__tsan_atomic32_exchange",
+	"__tsan_atomic64_exchange",
+	"__tsan_atomic8_fetch_add",
+	"__tsan_atomic16_fetch_add",
+	"__tsan_atomic32_fetch_add",
+	"__tsan_atomic64_fetch_add",
+	"__tsan_atomic8_fetch_sub",
+	"__tsan_atomic16_fetch_sub",
+	"__tsan_atomic32_fetch_sub",
+	"__tsan_atomic64_fetch_sub",
+	"__tsan_atomic8_fetch_and",
+	"__tsan_atomic16_fetch_and",
+	"__tsan_atomic32_fetch_and",
+	"__tsan_atomic64_fetch_and",
+	"__tsan_atomic8_fetch_or",
+	"__tsan_atomic16_fetch_or",
+	"__tsan_atomic32_fetch_or",
+	"__tsan_atomic64_fetch_or",
+	"__tsan_atomic8_fetch_xor",
+	"__tsan_atomic16_fetch_xor",
+	"__tsan_atomic32_fetch_xor",
+	"__tsan_atomic64_fetch_xor",
+	"__tsan_atomic8_fetch_nand",
+	"__tsan_atomic16_fetch_nand",
+	"__tsan_atomic32_fetch_nand",
+	"__tsan_atomic64_fetch_nand",
+	"__tsan_atomic8_compare_exchange_strong",
+	"__tsan_atomic16_compare_exchange_strong",
+	"__tsan_atomic32_compare_exchange_strong",
+	"__tsan_atomic64_compare_exchange_strong",
+	"__tsan_atomic8_compare_exchange_weak",
+	"__tsan_atomic16_compare_exchange_weak",
+	"__tsan_atomic32_compare_exchange_weak",
+	"__tsan_atomic64_compare_exchange_weak",
+	"__tsan_atomic8_compare_exchange_val",
+	"__tsan_atomic16_compare_exchange_val",
+	"__tsan_atomic32_compare_exchange_val",
+	"__tsan_atomic64_compare_exchange_val",
+	"__tsan_atomic_thread_fence",
+	"__tsan_atomic_signal_fence",
 	/* KCOV */
 	"write_comp_data",
 	"check_kcov_mode",
-- 
2.27.0.212.ge8ba1cc988-goog

