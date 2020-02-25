Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA368C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7D724650
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDEi1gYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgBYHh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:37:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45680 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbgBYHhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:37:48 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so6701559pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 23:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ug72A/vgrdmHIVdpr3zMNCL3H56NFZ8NAXeJKxd5VIo=;
        b=pDEi1gYlasNmPGrqygmBasm60r/FtjxKJbgu4k+fU01Lpbbws9FwI+l0FyggrMrfw8
         0TywUcVUcE6eDH/x1tLCESNAOLg5GflR/tj1V62c4ij6I0lqgBQCuSOB0ZEO4LteZdlj
         lCamjaH8M6JaLgIu50NR1uYkqcxu/vEJNkUeYLwHCKUrGVYrDjEdUg4CJBiLgwgRV8EM
         21cz3AhcL/QT09ImUvOvYnfvW7gSxFXeQJ9BePtmuJbMsKdK4I9GO55KmKdzYFu6Gxr8
         E8/GMCSYYqKE5Z0UJJP3Tp2X+lv0AcZo20RDJwsgdK3zNUZEv7fyreYvwuC5JS86DFxJ
         Y6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ug72A/vgrdmHIVdpr3zMNCL3H56NFZ8NAXeJKxd5VIo=;
        b=dUdxV7Swsq/CeJd2YqvTVnnMYA+Ee9Ut6+WlkQzesx6uKmJkU5XNvJkOTWxK3CvxjM
         5b4B/H7IrifzVZhDT/3TSQADQd+6Cad4hQ2fzj64RMmJGqckCEEwFcfUU+OdZiuTK/lH
         nXDqD3tzMZ+8m5kjrP2BpKq3yv4znWum4PgRQPPDUgKO6UPX1Azck5SiSHd4PxNqPaVn
         h6XcGYcBhdmwjNMmY98kx9pAVO60+dBq5bnuPdFivL1WCpHdYPtLONj5Nn4bCGHrdcyI
         yP5PDbeTjd4dIPDV3gGS3i8PKkD6mGanzALGy4QXf7bHcvxQWQaQP/BYBsVfi/tjej41
         gwqQ==
X-Gm-Message-State: APjAAAXw9AL5fJ2wKAJ4lrSk7JGazh5XKXq98CioRL4pkc9oRdhFWvrM
        j/Enbsa7BbT+pQBtdHpCymE0DaBF
X-Google-Smtp-Source: APXvYqwBnc/F3BTx7cSSKx9yuCG9NgaaS6u4J8P5NdiroM5iqOC7DIhqEjPmkP0xhbxHaeNsEvHanw==
X-Received: by 2002:a63:d845:: with SMTP id k5mr54501802pgj.183.1582616265720;
        Mon, 24 Feb 2020 23:37:45 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id m128sm15979390pfm.183.2020.02.24.23.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 23:37:45 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH v2 5/6] arm64/vdso: Restrict splitting VVAR VMA
Date:   Mon, 24 Feb 2020 23:37:30 -0800
Message-Id: <20200225073731.465270-6-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200225073731.465270-1-avagin@gmail.com>
References: <20200225073731.465270-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forbid splitting VVAR VMA resulting in a stricter ABI and reducing the
amount of corner-cases to consider while working further on VDSO time
namespace support.

As the offset from timens to VVAR page is computed compile-time, the pages
in VVAR should stay together and not being partically mremap()'ed.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/kernel/vdso.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index fb32c6f76078..c003f7ee383a 100644
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
@@ -315,6 +326,7 @@ static struct vm_special_mapping aarch32_vdso_spec[C_PAGES] = {
 	{
 		.name = "[vvar]",
 		.fault = vvar_fault,
+		.mremap = vvar_mremap,
 	},
 	{
 		.name = "[vdso]",
@@ -497,6 +509,7 @@ static struct vm_special_mapping vdso_spec[A_PAGES] __ro_after_init = {
 	{
 		.name	= "[vvar]",
 		.fault = vvar_fault,
+		.mremap = vvar_mremap,
 	},
 	{
 		.name	= "[vdso]",
-- 
2.24.1

