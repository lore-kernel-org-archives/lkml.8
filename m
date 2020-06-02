Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7ECC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC2A20823
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pz2n9CXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgFBSDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgFBSDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:03:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46D9C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:03:10 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x207so3543194pfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0ff3kXbnY7mWoXT4ZLxtxnZ86nFn96gKFYgcZDXTiq4=;
        b=Pz2n9CXwBlKq8PW7Clg8W4f/AinwzKiB+1ZAHlMPryHhTCOrwPxRw4xVn3lGiwP8rO
         EcVeshytONp7z69W8S2CQ/9E/fSe+hmf2Z+RUjSkLQz7o7Je/OpRWCUiJFidLTEf/kI1
         HZ/ShoxY8TiY8m2yA9q9zGz+Cdquf+8PmU6BnRrc2isbe6OuPXiIXLqKTluopPjOB4at
         6c7Na0whmCZlO0YLC5QQgO3pGzF7cayFsq8ux4P796I2iaww5Xq+AnZdgzfmm7AOePfU
         UDkwsZ7Vn3XHjJ24T1QpIReFhzDhACVocPW5v4E39Dr4+3ynDwFfw5VGhylX6N9+y5zU
         UasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ff3kXbnY7mWoXT4ZLxtxnZ86nFn96gKFYgcZDXTiq4=;
        b=ZbcLXyOlcivkbThq70h/J8jrhSp3acJ7jRi4Td7Op6GBk/x0LlSnXDunX87NFq3cuD
         5IQlqzByeaRz+avpeheSBQJiIbJaJO9QvnfGWzf/Co06unCxoM//ccRBf20KVwb7MWWh
         86RfTmRSVI/aL+wNJ1B+BtVNJzmCfaVOqQrBAJy+6EcXl3F4Lo/rBoEVBiZcgq0uwNsL
         nQjID6MCYplu5s7Z/Qa+zNSUueY9JewmGkPO5M+CUEZ/4wkPOW01LLsobMC45LFgbmAo
         y8JqMajfHvohuzx0e6Dcizgbq+2nhMhSCrjyTEzMVvb2sIr5yXKnnlRmT/KzU0z0LsQO
         Y0MA==
X-Gm-Message-State: AOAM533BIFtUeN/UK5+b2LxwLtcgHK5CLe1HVj14VxT2TBQ0kdO7DyRy
        JpPKhw9KIrrcBPS5KgjI/9Q=
X-Google-Smtp-Source: ABdhPJyeJEHpH4P3opkCS6VQefDLqAL7wW0kPJHO1aE4Rm6Ng+v9CzZH4XZaXxORa/Ol5Hh9sA0z3Q==
X-Received: by 2002:a63:9319:: with SMTP id b25mr26017714pge.374.1591120990153;
        Tue, 02 Jun 2020 11:03:10 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id p8sm2740053pgs.29.2020.06.02.11.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 11:03:09 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 5/6] arm64/vdso: Restrict splitting VVAR VMA
Date:   Tue,  2 Jun 2020 11:02:58 -0700
Message-Id: <20200602180259.76361-6-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200602180259.76361-1-avagin@gmail.com>
References: <20200602180259.76361-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forbid splitting VVAR VMA resulting in a stricter ABI and reducing the
amount of corner-cases to consider while working further on VDSO time
namespace support.

As the offset from timens to VVAR page is computed compile-time, the pages
in VVAR should stay together and not being partically mremap()'ed.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/kernel/vdso.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index f3baecd8edfb..8b17d7d10729 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -235,6 +235,17 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 	return vmf_insert_pfn(vma, vmf->address, pfn);
 }
 
+static int vvar_mremap(const struct vm_special_mapping *sm,
+		       struct vm_area_struct *new_vma)
+{
+	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
+
+	if (new_size != VVAR_NR_PAGES * PAGE_SIZE)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int __setup_additional_pages(enum arch_vdso_type arch_index,
 				    struct mm_struct *mm,
 				    struct linux_binprm *bprm,
@@ -317,6 +328,7 @@ static struct vm_special_mapping aarch32_vdso_spec[C_PAGES] = {
 	{
 		.name = "[vvar]",
 		.fault = vvar_fault,
+		.mremap = vvar_mremap,
 	},
 	{
 		.name = "[vdso]",
@@ -488,6 +500,7 @@ static struct vm_special_mapping vdso_spec[A_PAGES] __ro_after_init = {
 	{
 		.name	= "[vvar]",
 		.fault = vvar_fault,
+		.mremap = vvar_mremap,
 	},
 	{
 		.name	= "[vdso]",
-- 
2.24.1

