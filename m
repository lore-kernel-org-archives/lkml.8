Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBEBC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B58C20675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="m7BI9M5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgCJNiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:38:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40082 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgCJNiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:38:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id m2so12664043qka.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KLpE8ve97oAPJLQLYYx8zGcQlVMaeFiUkBk5Iqbenl8=;
        b=m7BI9M5RrSAdY9gQkOpFG49o2OVYRUpkhH5uPzs18vsyS6dGIxm5s7iy5NuIjVGJzY
         9vZLRtNmR4ZeKnF8/Ev178kvbaneUUaPBN8fExwioTwYzLO8BHYMGBPGQthQADnPfaD4
         qV1AIlIkINGm2asemPKT1jIGsK7D65xVBhMUxRY9pgNfThrpLCLcQUxg4mj2eBguU5MZ
         ljFhCUIQUF9wwbQOtN0XtlHLX39W7/Kb2CPNBl6dOJFT3Gyq8CW8O7COTMjFc2vK/YS9
         kOObfhDYXgduzoYwXrQKBG7F/QrlrFI0erXY3tKTa7Z+0MF5CKI47BKQDh2whXED8BlE
         24jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KLpE8ve97oAPJLQLYYx8zGcQlVMaeFiUkBk5Iqbenl8=;
        b=Kuvg7RMQYNhpz0jPuoU/HVkaAffR3lBoY2UmvlleTHTZ6U68HHlY1x6CXvf0lLIyOX
         H0Ko67C9Fp/SmW2BFLsKJNwPZAgw2H9L1gHT3J6rG3v9jUutVwXp60j6wLkKU84M1GU/
         OLiA6jBKtFGMf5pn5Lr2vvUMsQdCYaS4KsmDzDLfHR6ofE/eFs/0PFB4f9cTEXw86N7v
         l4SzMAtjXy13Bblfp2g2Ei/F4FVqiil2OBq+TNpV29Z65hyyivCblY1+pEf6xuZm2VE9
         iVZAFkzyZgX0miEZkQKcmJy00q8n5WKVqyDoUBdGxnG3vm+jxWN5bXZUBKYzr/eurCuF
         A2pw==
X-Gm-Message-State: ANhLgQ0DtAQoBy7nw6sazy4sBPFWxGxl030N5wJVZcLhTvOSwhJAyJJg
        KqrUeEXcqN9xlkgTpl+kUOdJIg==
X-Google-Smtp-Source: ADFU+vumpRvFLLiIHtsP+ekHyITbCWW7vsarNvrGDMzw+/UrDznI0a70pXFrab+iJaNLKVMgkWxF6w==
X-Received: by 2002:a37:4986:: with SMTP id w128mr20381557qka.189.1583847483739;
        Tue, 10 Mar 2020 06:38:03 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v59sm3576687qte.19.2020.03.10.06.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 06:38:03 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] lib/test_kasan: silence a -Warray-bounds warning
Date:   Tue, 10 Mar 2020 09:37:49 -0400
Message-Id: <1583847469-4354-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit "kasan: add test for invalid size in memmove" introduced a
compilation warning where it used a negative size on purpose. Silence it
by disabling "array-bounds" checking for this file only for testing
purpose.

In file included from ./include/linux/bitmap.h:9,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
                 from ./arch/x86/include/asm/processor.h:22,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:38,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/rcupdate.h:27,
                 from ./include/linux/rculist.h:11,
                 from ./include/linux/pid.h:5,
                 from ./include/linux/sched.h:14,
                 from ./include/linux/uaccess.h:6,
                 from ./arch/x86/include/asm/fpu/xstate.h:5,
                 from ./arch/x86/include/asm/pgtable.h:26,
                 from ./include/linux/kasan.h:15,
                 from lib/test_kasan.c:12:
In function 'memmove',
    inlined from 'kmalloc_memmove_invalid_size' at
lib/test_kasan.c:301:2:
./include/linux/string.h:441:9: warning: '__builtin_memmove' pointer
overflow between offset 0 and size [-2, 9223372036854775807]
[-Warray-bounds]
  return __builtin_memmove(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Qian Cai <cai@lca.pw>
---
 lib/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Makefile b/lib/Makefile
index ab68a8674360..24d519a0741d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -297,6 +297,8 @@ UBSAN_SANITIZE_ubsan.o := n
 KASAN_SANITIZE_ubsan.o := n
 KCSAN_SANITIZE_ubsan.o := n
 CFLAGS_ubsan.o := $(call cc-option, -fno-stack-protector) $(DISABLE_STACKLEAK_PLUGIN)
+# kmalloc_memmove_invalid_size() does this on purpose.
+CFLAGS_test_kasan.o += $(call cc-disable-warning, array-bounds)
 
 obj-$(CONFIG_SBITMAP) += sbitmap.o
 
-- 
1.8.3.1

