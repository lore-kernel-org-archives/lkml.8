Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E07C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4862206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0C0uDVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgD1Jik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:38:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46972 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727789AbgD1Jih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588066716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QnVF6RVPfBlqkS/v3YnkEFynSRhZFtgRvjVkUDT1EM=;
        b=U0C0uDVSffWGombOR3CrnpPemRyy7Gku1jwSnzJVEOolXpFvYPhChqgAFqeU2GUJFHPcs4
        gbmM5BCyoVtpp39dvyrBC7kyKqlr4unrYX15u+MwdyqSbwmE184rAaydZ0pMfMK4fTIk3x
        WtM3Zz+udenJdkfWbCVwWAuf+SoxoiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-JkPl61w1OkG3OcigZJs3_Q-1; Tue, 28 Apr 2020 05:38:35 -0400
X-MC-Unique: JkPl61w1OkG3OcigZJs3_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B73A8464;
        Tue, 28 Apr 2020 09:38:33 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38AF35D715;
        Tue, 28 Apr 2020 09:38:31 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2 2/3] x86/idt: Annotate alloc_intr_gate() with __init
Date:   Tue, 28 Apr 2020 11:38:23 +0200
Message-Id: <20200428093824.1451532-3-vkuznets@redhat.com>
In-Reply-To: <20200428093824.1451532-1-vkuznets@redhat.com>
References: <20200428093824.1451532-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be no reason to allocate interrupt gates after init. Mark
alloc_intr_gate() as __init and add WARN_ON() checks making sure it is
only used before idt_setup_apic_and_irq_gates() finalizes IDT setup and
maps all un-allocated entries to spurious entries.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kernel/idt.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 87ef69a72c52..f95c3be00e5a 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -51,6 +51,9 @@ struct idt_data {
 #define TSKG(_vector, _gdt)				\
 	G(_vector, NULL, DEFAULT_STACK, GATE_TASK, DPL0, _gdt << 3)
=20
+
+static bool idt_setup_done __initdata;
+
 /*
  * Early traps running on the DEFAULT_STACK because the other interrupt
  * stacks work only after cpu_init().
@@ -323,6 +326,7 @@ void __init idt_setup_apic_and_irq_gates(void)
 		set_intr_gate(i, entry);
 	}
 #endif
+	idt_setup_done =3D true;
 }
=20
 /**
@@ -352,6 +356,7 @@ void idt_invalidate(void *addr)
 	load_idt(&idt);
 }
=20
+/* This goes away once ASYNC_PF is sanitized */
 void __init update_intr_gate(unsigned int n, const void *addr)
 {
 	if (WARN_ON_ONCE(!test_bit(n, system_vectors)))
@@ -359,9 +364,14 @@ void __init update_intr_gate(unsigned int n, const v=
oid *addr)
 	set_intr_gate(n, addr);
 }
=20
-void alloc_intr_gate(unsigned int n, const void *addr)
+void __init alloc_intr_gate(unsigned int n, const void *addr)
 {
-	BUG_ON(n < FIRST_SYSTEM_VECTOR);
-	if (!test_and_set_bit(n, system_vectors))
+	if (WARN_ON(n < FIRST_SYSTEM_VECTOR))
+		return;
+
+	if (WARN_ON(idt_setup_done))
+		return;
+
+	if (!WARN_ON(test_and_set_bit(n, system_vectors)))
 		set_intr_gate(n, addr);
 }
--=20
2.25.3

