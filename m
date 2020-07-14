Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C28C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA9B622370
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgGNMPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:15:54 -0400
Received: from 8bytes.org ([81.169.241.247]:52886 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbgGNMKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:10:51 -0400
Received: from cap.home.8bytes.org (p5b006776.dip0.t-ipconnect.de [91.0.103.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 9C076C07;
        Tue, 14 Jul 2020 14:10:48 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 29/75] x86/idt: Move two function from k/idt.c to i/a/desc.h
Date:   Tue, 14 Jul 2020 14:08:31 +0200
Message-Id: <20200714120917.11253-30-joro@8bytes.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714120917.11253-1-joro@8bytes.org>
References: <20200714120917.11253-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Move these two functions from kernel/idt.c to include/asm/desc.h:

	* init_idt_data()
	* idt_init_desc()

These functions are needed to setup IDT entries very early and need to
be called from head64.c. To be usable this early these functions need to
be compiled without instrumentation and the stack-protector feature.
These features need to be kept enabled for kernel/idt.c, so head64.c
must use its own versions.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/desc.h      | 27 +++++++++++++++++++++++++
 arch/x86/include/asm/desc_defs.h |  7 +++++++
 arch/x86/kernel/idt.c            | 34 --------------------------------
 3 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 1ced11d31932..476082a83d1c 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -383,6 +383,33 @@ static inline void set_desc_limit(struct desc_struct *desc, unsigned long limit)
 
 void alloc_intr_gate(unsigned int n, const void *addr);
 
+static inline void init_idt_data(struct idt_data *data, unsigned int n,
+				 const void *addr)
+{
+	BUG_ON(n > 0xFF);
+
+	memset(data, 0, sizeof(*data));
+	data->vector	= n;
+	data->addr	= addr;
+	data->segment	= __KERNEL_CS;
+	data->bits.type	= GATE_INTERRUPT;
+	data->bits.p	= 1;
+}
+
+static inline void idt_init_desc(gate_desc *gate, const struct idt_data *d)
+{
+	unsigned long addr = (unsigned long) d->addr;
+
+	gate->offset_low	= (u16) addr;
+	gate->segment		= (u16) d->segment;
+	gate->bits		= d->bits;
+	gate->offset_middle	= (u16) (addr >> 16);
+#ifdef CONFIG_X86_64
+	gate->offset_high	= (u32) (addr >> 32);
+	gate->reserved		= 0;
+#endif
+}
+
 extern unsigned long system_vectors[];
 
 extern void load_current_idt(void);
diff --git a/arch/x86/include/asm/desc_defs.h b/arch/x86/include/asm/desc_defs.h
index 5621fb3f2d1a..f7e7099af595 100644
--- a/arch/x86/include/asm/desc_defs.h
+++ b/arch/x86/include/asm/desc_defs.h
@@ -74,6 +74,13 @@ struct idt_bits {
 			p	: 1;
 } __attribute__((packed));
 
+struct idt_data {
+	unsigned int	vector;
+	unsigned int	segment;
+	struct idt_bits	bits;
+	const void	*addr;
+};
+
 struct gate_struct {
 	u16		offset_low;
 	u16		segment;
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 367eb6a593dd..d3f0c8133300 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -11,13 +11,6 @@
 #include <asm/desc.h>
 #include <asm/hw_irq.h>
 
-struct idt_data {
-	unsigned int	vector;
-	unsigned int	segment;
-	struct idt_bits	bits;
-	const void	*addr;
-};
-
 #define DPL0		0x0
 #define DPL3		0x3
 
@@ -178,20 +171,6 @@ bool idt_is_f00f_address(unsigned long address)
 }
 #endif
 
-static inline void idt_init_desc(gate_desc *gate, const struct idt_data *d)
-{
-	unsigned long addr = (unsigned long) d->addr;
-
-	gate->offset_low	= (u16) addr;
-	gate->segment		= (u16) d->segment;
-	gate->bits		= d->bits;
-	gate->offset_middle	= (u16) (addr >> 16);
-#ifdef CONFIG_X86_64
-	gate->offset_high	= (u32) (addr >> 32);
-	gate->reserved		= 0;
-#endif
-}
-
 static __init void
 idt_setup_from_table(gate_desc *idt, const struct idt_data *t, int size, bool sys)
 {
@@ -205,19 +184,6 @@ idt_setup_from_table(gate_desc *idt, const struct idt_data *t, int size, bool sy
 	}
 }
 
-static void init_idt_data(struct idt_data *data, unsigned int n,
-			  const void *addr)
-{
-	BUG_ON(n > 0xFF);
-
-	memset(data, 0, sizeof(*data));
-	data->vector	= n;
-	data->addr	= addr;
-	data->segment	= __KERNEL_CS;
-	data->bits.type	= GATE_INTERRUPT;
-	data->bits.p	= 1;
-}
-
 static __init void set_intr_gate(unsigned int n, const void *addr)
 {
 	struct idt_data data;
-- 
2.27.0

