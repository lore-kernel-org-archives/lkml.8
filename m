Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F43C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72B25208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598977450;
	bh=iwwrjsRIAJUQyuCjybCmNKWMiu/9B3HjaHena9EblRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z078HFlaFXBJ3rjVslp1NwrwEKBbBaqX10vgwbjtc9r7ZHf6CFdpm+6wX5Z0syZOA
	 TpHB2KVwsWDSqD+2u0xDobq87Orj61W368o4sp9Myi2HXlav04kHwZT2zgHil2kt6w
	 QM0kZZoNVfseonfyVa+6rHNgno0/TBuBkE64P6tc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbgIAPcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730605AbgIAPaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:30:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AC0220767;
        Tue,  1 Sep 2020 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974230;
        bh=iwwrjsRIAJUQyuCjybCmNKWMiu/9B3HjaHena9EblRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jBGEnSKUqxwNHyUa/acC/dXYvCv+3I5kchd5ITXt8pwTy0ih360zrYTMFi4pqzyj7
         YMeplzCBusSuFASwxosJPwLpQOfdG4mu/JMsiv/glPTM0+PuRui6eF42aKVmh3eeVL
         ww2bvmbZWb4MoDFYk8A4v5veuIclqgBTIqdrccTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 065/214] efi: provide empty efi_enter_virtual_mode implementation
Date:   Tue,  1 Sep 2020 17:09:05 +0200
Message-Id: <20200901150956.091585597@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

[ Upstream commit 2c547f9da0539ad1f7ef7f08c8c82036d61b011a ]

When CONFIG_EFI is not enabled, we might get an undefined reference to
efi_enter_virtual_mode() error, if this efi_enabled() call isn't inlined
into start_kernel().  This happens in particular, if start_kernel() is
annodated with __no_sanitize_address.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Elena Petrova <lenaptr@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Walter Wu <walter-zh.wu@mediatek.com>
Link: http://lkml.kernel.org/r/6514652d3a32d3ed33d6eb5c91d0af63bf0d1a0c.1596544734.git.andreyknvl@google.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/efi.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index d87acf62958e2..13ed2c6b13f8b 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1039,7 +1039,11 @@ extern void *efi_get_pal_addr (void);
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
2.25.1



