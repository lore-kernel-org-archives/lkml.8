Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F65C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE2D20776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXKO6M3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgDXMZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:25:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37293 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726942AbgDXMZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587731143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rAfkUZPwp0GSsvC6kXoI4ntMaM1pN62FyepDfYmHV0M=;
        b=FXKO6M3OSforWav8yoOCR2OvfMpO04KVxLAnpDosQxrUiJXNl1MGAbJ1cUpcX3raZteVRy
        771cAhNUGWRjyyikhPUA5f1mq5MrdRhrlrO7oJIU16xwOLGSzHMCdXTtlf4sI6qmlA8oc0
        tHmP+ES6n5Ki1TdhGzaWop/wjeOq+2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-suTRmxGPNZKGOB4m9NcuEg-1; Fri, 24 Apr 2020 08:25:41 -0400
X-MC-Unique: suTRmxGPNZKGOB4m9NcuEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A89081895A2A;
        Fri, 24 Apr 2020 12:25:40 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EDCF605CF;
        Fri, 24 Apr 2020 12:25:37 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/idt: Keep spurious entries unset in system_vectors
Date:   Fri, 24 Apr 2020 14:25:35 +0200
Message-Id: <20200424122535.1212732-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dc20b2d52653 ("x86/idt: Move interrupt gate initialization to IDT
code") had a side-effect of 'set_bit(i, used_vectors)' for unused entries
which are being mapped to spurious entries. (user_vectors were later
renamed to system_vectors).

Previously, we used to count on system_vectors in arch_show_interrupts()
to not print unexisting entries in /proc/interrupts. E.g. 'Hypervisor
callback interrupts' should not be printed on bare metal. This is
currently broken.

Setting bits in system_vectors for all unused entries also makes
alloc_intr_gate() fail in case someone decides to do it later. It seems
this is not currently an issue because all alloc_intr_gate() users are
calling it early, before we call idt_setup_apic_and_irq_gates() but
this also seems wrong.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kernel/idt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 87ef69a72c52..b62e9d080a3e 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -318,7 +318,13 @@ void __init idt_setup_apic_and_irq_gates(void)
=20
 #ifdef CONFIG_X86_LOCAL_APIC
 	for_each_clear_bit_from(i, system_vectors, NR_VECTORS) {
-		set_bit(i, system_vectors);
+		/*
+		 * Spurious entries are left unset in system_vectors so it can
+		 * be used to check which gates were really allocated. This also
+		 * allows using alloc_intr_gate() and not update_intr_gate() if
+		 * some of the currently-spurious entries are to be allocated
+		 * later.
+		 */
 		entry =3D spurious_entries_start + 8 * (i - FIRST_SYSTEM_VECTOR);
 		set_intr_gate(i, entry);
 	}
--=20
2.25.3

