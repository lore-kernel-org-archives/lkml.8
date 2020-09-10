Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908BBC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50DF8214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k52S/3xv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgIJXkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIJXj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:39:56 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65054C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:39:56 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l126so5788860pfd.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V7hSJYPLUCOtHHvd64Ozpw8tkzTrrz5bb+74FUJ2a40=;
        b=k52S/3xv/KKfN7vYTMe1vCAOcShgd9nF/l2ZCY7NdmH4EbTMSNFk5Wz5WXpWVivmn+
         UoiC4BsdSVyJl2SnkSmVsIXgQn7BBBhxZrcb67RjiAyxI5GgfLQhCThQmcZ8HADVyxPw
         7RU6r9vOhBseBTYpCYqxHu77z3tWCdjfxUy5p5npu2Pxfk1aeJQNeveHZyoFl8ywWkK3
         qoSNRn78WT6efJTS7DKQ6egpFq5SNDIK5mNLxOd1v2sUxSJ2uWgvTXVTgCac71hgA5IN
         kl3/qjduOmKraYlwnlZmDO2m5NTq7HhXzUT2dPZuHGdUREj6su7fwiCQnVjQgh5+c9xz
         lYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V7hSJYPLUCOtHHvd64Ozpw8tkzTrrz5bb+74FUJ2a40=;
        b=HCilp8ZxyVQGTtyWJ+NEJM5imishEa6fVyxwTlADBpK7X5qjzSgxmCHdTYusSqWejV
         6fcdVHrOlHGb3y4E7eMbcUIbQIpEtOa5u6WefQl3Z4wTrhX0OxxEnMoQYr/+jo+OXSGX
         dZJVwbhsx0uiwHiMDyvogOIdtdyL8+NfPNXEq667+AEcC4Ds3Ac+S2BabtkwUzQJNtJ3
         o+5zWAkhtt3V4VzA4NKVMiih0W+IVKVysB0E3AHahxNDxJlWwjvYgX8oZ8smOdLI9XLe
         u/lVlrrts5MIU6g2RbG8COJ1COb46HcIF6sAqWbHugbIr4Sdxn5QrBzYcYZf1cm/EfZf
         EvKw==
X-Gm-Message-State: AOAM533TTj8QMoEnUN0Ku7nNlF968vWltyCpoKMZGWIu/A+QQTHj6fRa
        1HBzJ3ZYMxfsl/bZGqzPvfdfwcqtALDu7A==
X-Google-Smtp-Source: ABdhPJwxQOMbNrAwl0ZI8QAfxOi/eX3wo5m1enZWETRIbSDvBbK2Pmykk7rpssTjKhnRabGSXA4a3w==
X-Received: by 2002:a62:ab06:: with SMTP id p6mr7726622pff.131.1599781195637;
        Thu, 10 Sep 2020 16:39:55 -0700 (PDT)
Received: from localhost (g168.115-65-169.ppp.wakwak.ne.jp. [115.65.169.168])
        by smtp.gmail.com with ESMTPSA id h9sm191767pfc.28.2020.09.10.16.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 16:39:55 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Mike Rapoport <rppt@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openrisc@lists.librecores.org
Subject: [PATCH v3 1/3] openrisc: Reserve memblock for initrd
Date:   Fri, 11 Sep 2020 08:39:38 +0900
Message-Id: <20200910233940.2132107-2-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910233940.2132107-1-shorne@gmail.com>
References: <20200910233940.2132107-1-shorne@gmail.com>
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
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
---
Changes since v2:
 - None

Changes since v1:
 - Updated to use separate variables as suggested by Mike.

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

