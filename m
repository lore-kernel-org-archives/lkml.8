Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53B4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB782067D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="El9eCMgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgHDMmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgHDMlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:41:39 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E654AC061757
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 05:41:38 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id r12so4402579qvx.20
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 05:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MkWKUi7xJlcxy+e8OWBoJNl1OXW3h1d9K35k1It603c=;
        b=El9eCMgZto7hrv7PDOK8sz2wSLBcDVP89TfYWUHfgVCBju0bnGiOsMLl6XBn8jPSjh
         qrgdXGRXN4HlmL1fOGf8voLbPZt1X18PEjYdDjjXTh3PKpwhCwvxfdH77PmSuIH6bHjH
         IzHWS/61LABdVG/cl9nv7tSaT02sva1I2t9kU4CCxKn2Fuq5zAhsavQCtRi26JwEs+Dl
         9fQdx9ceg+7jPTrfJr2H/RPbendmsnMPAjmTuZXHQ5z0+weqjI1akX4ATVsuIjOK4K4K
         9i8R5X/OYsJ9UZwUQgh+6iCBRktsvnPbggGzIRvclgIctl5ElMdM+aNZB9sDbsroXJJs
         M9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MkWKUi7xJlcxy+e8OWBoJNl1OXW3h1d9K35k1It603c=;
        b=R8ejtpRmwRcusdbAA4WsosOsje2x+Yt1M3ivlIyNfXyygRbWJBihnstj1dSfZZPJ/4
         FRKSu/2dYPSOCiaUSDyW+a8l9k/3Y9WmpgqtJVzwjdDSPiewfx9BBcDGsdlQNuBFDLjY
         pdnngqcs5T1eTatP3SGuqWOiBjdyfHiVN2rGH0hPuAYpRF9UJWqc68zJnv0sa1r3WzO8
         t2v0oO2wESDc+dpPWpmrlps0gfw8JebHXy2ew/eo7x+0s/+W5oFrip77U8JZsWbHeguU
         r3rvLLCYnlHWW5Lq2C0e8kP9qQAgmqaldZDKW3Kd3MyKXWdE0FX8y+W04jcYMr9YZ+yx
         iP6Q==
X-Gm-Message-State: AOAM532zcJE4cvfVaMm/YZjQbvn23tkXO2clMhiK0l80312Pl4ibO3cB
        JvW6pQK0ZD8w8Ir37WsnYmxeB8oEu86MVR63
X-Google-Smtp-Source: ABdhPJwC+zlXBovbZ5yMemFd6n1F3dx7E2v/1/0xLypGVzYOL4r1AHzTFwqN6hvHO5BmR1xUzcpuB+Tj4Xl/elq0
X-Received: by 2002:ad4:4152:: with SMTP id z18mr22181844qvp.42.1596544898043;
 Tue, 04 Aug 2020 05:41:38 -0700 (PDT)
Date:   Tue,  4 Aug 2020 14:41:25 +0200
In-Reply-To: <cover.1596544734.git.andreyknvl@google.com>
Message-Id: <6514652d3a32d3ed33d6eb5c91d0af63bf0d1a0c.1596544734.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1596544734.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 2/5] efi: provide empty efi_enter_virtual_mode implementation
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Elena Petrova <lenaptr@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_EFI is not enabled, we might get an undefined reference
to efi_enter_virtual_mode() error, if this efi_enabled() call isn't
inlined into start_kernel(). This happens in particular, if start_kernel()
is annodated with __no_sanitize_address.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/efi.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 05c47f857383..73db1ae04cef 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -606,7 +606,11 @@ extern void *efi_get_pal_addr (void);
 extern void efi_map_pal_code (void);
 extern void efi_memmap_walk (efi_freemem_callback_t callback, void *arg);
 extern void efi_gettimeofday (struct timespec64 *ts);
+#ifdef CONFIG_EFI
 extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if possible */
+#else
+static inline void efi_enter_virtual_mode (void) {}
+#endif
 #ifdef CONFIG_X86
 extern efi_status_t efi_query_variable_store(u32 attributes,
 					     unsigned long size,
-- 
2.28.0.163.g6104cc2f0b6-goog

