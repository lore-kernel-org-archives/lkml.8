Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F509C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BAC9206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmrazZgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgD1Jio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:38:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58609 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727791AbgD1Jik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588066719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pb+AfvnqByh3aIbGh7ARWNKo95Vgwbukq+rHYtogLC0=;
        b=UmrazZgoCzdwUmqVkq8ZAUD8nR1MI31FgkYLyk3ygDOOFLJ99cSux1JRuMPTm/xpBztkAp
        0cJjBWxYmPg0hHaHqb8lKHLpA8OMOiaHhTFFrNbYpjBT5n0+Wjj49g15ct8pxdUH1ZsKdM
        tW7Ij8DvlkF6yINKgOFLd5t6a7nDwAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-iSZhVUcmOv6DI8k31eJqjQ-1; Tue, 28 Apr 2020 05:38:37 -0400
X-MC-Unique: iSZhVUcmOv6DI8k31eJqjQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39BA218B6426;
        Tue, 28 Apr 2020 09:38:36 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3185F5D715;
        Tue, 28 Apr 2020 09:38:33 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2 3/3] x86/idt: Keep spurious entries unset in system_vectors
Date:   Tue, 28 Apr 2020 11:38:24 +0200
Message-Id: <20200428093824.1451532-4-vkuznets@redhat.com>
In-Reply-To: <20200428093824.1451532-1-vkuznets@redhat.com>
References: <20200428093824.1451532-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit dc20b2d52653 ("x86/idt: Move interrupt gate initialization to
IDT code") non assigned system vectors are also marked as used in
'used_vectors' (now 'system_vectors') bitmap. This makes checks in
arch_show_interrupts() whether a particular system vector is allocated to
always pass and e.g. 'Hyper-V reenlightenment interrupts' entry always
shows up in /proc/interrupts.

Another side effect of having all unassigned system vectors marked as use=
d
is that irq_matrix_debug_show() will wrongly count them among 'System'
vectors.

As we now make sure alloc_intr_gate() is not called after init, it is
possible to leave unused entries in 'system_vectors' unset to fix the
issues.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kernel/idt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index f95c3be00e5a..28500ccb835c 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -321,7 +321,11 @@ void __init idt_setup_apic_and_irq_gates(void)
=20
 #ifdef CONFIG_X86_LOCAL_APIC
 	for_each_clear_bit_from(i, system_vectors, NR_VECTORS) {
-		set_bit(i, system_vectors);
+		/*
+		 * Don't set the non assigned system vectors in the
+		 * system_vectors bitmap. Otherwise they show up in
+		 * /proc/interrupts.
+		 */
 		entry =3D spurious_entries_start + 8 * (i - FIRST_SYSTEM_VECTOR);
 		set_intr_gate(i, entry);
 	}
--=20
2.25.3

