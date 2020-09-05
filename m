Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A239C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15932072D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQIR8dUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgIENUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 09:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbgIENUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 09:20:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5704CC061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 06:20:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u3so1065000pjr.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 06:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=djsLOAj49I3V2rEQOLHM4U+3AfJWXtqzZzZwC5xLBeA=;
        b=nQIR8dUFvevjZjwwDnA9GNxfMR0FcpxmEwiHHELuOnjDpHhFzg9q12KR8ID7CMxl4R
         z5UtyjDoZ+4hkT5Ux8Qs/fh/3XaqcPWszHLjb+KTobb6rcSb2/hWi9DaJSeIyVRctOPL
         dcVxYVWcnfjhvDtPzLHk89rYs7Cs5ZscUV49nu16nBcUCztHnGzc7xPiOm29zfgnTkFI
         vroFIjRRVnDs2rdhQSRk943rVPHsSeTZ0lNLLEM/KFhgY4aY/rshETTEPp6PYr3NSxTa
         PiPTe0D3JTN+AQBSuge4af3CbfsvTHr+0x44h11kutmOyXxB4nKach/ahLJ1QVEgSEPb
         ighw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=djsLOAj49I3V2rEQOLHM4U+3AfJWXtqzZzZwC5xLBeA=;
        b=T2nJdM90PIs8OY/soxN+5T5p0A0/c2tFLqIvKyzPzz2EUnl/MEjX8Ev7kIxQ7yClpA
         t8CIxeMM0D/mNXfykuSKVrbgCDvUdAGmK0K8Tnya9WdiY6pMr4bgp/jAeRbeLZRZMEcW
         nNlz3SrhWt6rneVZmHm9ek9hOZqFLHiSF57pqZC1Rlgm/xMFYMInsWGuhNUUZdJ7xWx4
         tMv/ZjUyRBZAjU49A3q9O6Oy8p2pgqm8frOeI1zpq1lb3csID/H7fJr6yzh1dVDCqgRf
         RgGp7F/ZdzAUuudCPkpYjZ1warB3F9hfmiMh+Pk7KYkIqx+IkI3On0B00yd83lGmddhX
         7eCQ==
X-Gm-Message-State: AOAM530NeBKHEHD9SZ07RwKil5fFkrQyaethxST4Y70UtM+ZuYmoJXga
        9Wv3nzjrDvLoyXbrNC4S8ckzynJfUFQ=
X-Google-Smtp-Source: ABdhPJxdbchpxF4VNi6l4PJPZ13DplwdNunYtZocl7Debwv1KvQfsC61gpYcC4p7wj9hNkRN2Gt5vQ==
X-Received: by 2002:a17:902:e789:: with SMTP id cp9mr12639308plb.215.1599312008821;
        Sat, 05 Sep 2020 06:20:08 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id q193sm10093224pfq.127.2020.09.05.06.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 06:20:07 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Mike Rapoport <rppt@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        openrisc@lists.librecores.org
Subject: [PATCH v2 1/3] openrisc: Reserve memblock for initrd
Date:   Sat,  5 Sep 2020 22:19:33 +0900
Message-Id: <20200905131935.972386-2-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200905131935.972386-1-shorne@gmail.com>
References: <20200905131935.972386-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently OpenRISC added support for external initrd images, but I found
some instability when using larger buildroot initrd images. It turned
out that I forgot to reserve the memblock space for the initrd image.

This patch fixes the instability issue by reserving memblock space.

Fixes: ff6c923dbec3 ("openrisc: Add support for external initrd images")
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/setup.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index b18e775f8be3..13c87f1f872b 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -80,6 +80,16 @@ static void __init setup_memory(void)
 	 */
 	memblock_reserve(__pa(_stext), _end - _stext);
 
+#ifdef CONFIG_BLK_DEV_INITRD
+	/* Then reserve the initrd, if any */
+	if (initrd_start && (initrd_end > initrd_start)) {
+		unsigned long aligned_start = ALIGN_DOWN(initrd_start, PAGE_SIZE);
+		unsigned long aligned_end = ALIGN(initrd_end, PAGE_SIZE);
+
+		memblock_reserve(__pa(aligned_start), aligned_end - aligned_start);
+	}
+#endif /* CONFIG_BLK_DEV_INITRD */
+
 	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
 
-- 
2.26.2

