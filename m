Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B9AC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A01206B1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezLWnqqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgCLRb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:31:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23774 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726666AbgCLRbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584034277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2CM3e15i+9DpcFFaDwqs3PZDJ1aP3WweoWF55vw0+y8=;
        b=ezLWnqqBJYcA5QNWyltWpb/MCrvp0hNvqWX9FMukgfrGDygnr0Tnq8puV921+ZBa83WBJN
        Cs6ReIiqbsZTsr9AV8YlK133i0Qx6ubi0GiV4NdCtd+wXrK9ddPyEw0M2wTjFiX0IQplpu
        zOlZc7rbIKia8dVh1zLTvtPD+vbIBu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409--n20pf4PMRWvhtzNWV0afA-1; Thu, 12 Mar 2020 13:31:13 -0400
X-MC-Unique: -n20pf4PMRWvhtzNWV0afA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8862C10BEC35;
        Thu, 12 Mar 2020 17:31:11 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-137.rdu2.redhat.com [10.10.122.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A8D260BEC;
        Thu, 12 Mar 2020 17:31:10 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 14/14] x86/unwind/orc: Add 'unwind_debug' cmdline option
Date:   Thu, 12 Mar 2020 12:30:33 -0500
Message-Id: <749b30b074b4acbca8c5af9e787b78c8e670a374.1584033751.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1584033751.git.jpoimboe@redhat.com>
References: <cover.1584033751.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes the one-line ORC unwinder warnings aren't very helpful.  Add a
new 'unwind_debug' cmdline option which will dump the full stack
contents of the current task when an error condition is encountered.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++
 arch/x86/kernel/unwind_orc.c                  | 49 ++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
index a1b7d3ad2a35..fd7d71b908b2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5098,6 +5098,12 @@
 	unknown_nmi_panic
 			[X86] Cause panic on unknown NMI.
=20
+	unwind_debug	[X86-64]
+			Enable unwinder debug output.  This can be
+			useful for debugging certain unwinder error
+			conditions, including corrupt stacks and
+			bad/missing unwinder metadata.
+
 	usbcore.authorized_default=3D
 			[USB] Default USB device authorization:
 			(default -1 =3D authorized except for wireless USB,
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 4118013a574a..139b476f848a 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -12,8 +12,13 @@
=20
 #define orc_warn_current(args...)					\
 ({									\
-	if (state->task =3D=3D current)					\
+	static bool dumped_before;					\
+	if (state->task =3D=3D current) {					\
 		orc_warn(args);						\
+		if (unwind_debug && !dumped_before)			\
+			unwind_dump(state);				\
+		dumped_before =3D true;					\
+	}								\
 })
=20
 extern int __start_orc_unwind_ip[];
@@ -22,11 +27,53 @@ extern struct orc_entry __start_orc_unwind[];
 extern struct orc_entry __stop_orc_unwind[];
=20
 static bool orc_init __ro_after_init;
+static bool unwind_debug __ro_after_init;
 static unsigned int lookup_num_blocks __ro_after_init;
=20
 static DEFINE_MUTEX(sort_mutex);
 static int *cur_orc_ip_table =3D __start_orc_unwind_ip;
 static struct orc_entry *cur_orc_table =3D __start_orc_unwind;
+static unsigned int lookup_num_blocks __ro_after_init;
+
+static int __init unwind_debug_cmdline(char *str)
+{
+	unwind_debug =3D true;
+
+	return 0;
+}
+early_param("unwind_debug", unwind_debug_cmdline);
+
+static void unwind_dump(struct unwind_state *state)
+{
+	static bool dumped_before;
+	unsigned long word, *sp;
+	struct stack_info stack_info =3D {0};
+	unsigned long visit_mask =3D 0;
+
+	if (dumped_before)
+		return;
+
+	dumped_before =3D true;
+
+	printk_deferred("unwind stack type:%d next_sp:%p mask:0x%lx graph_idx:%=
d\n",
+			state->stack_info.type, state->stack_info.next_sp,
+			state->stack_mask, state->graph_idx);
+
+	for (sp =3D __builtin_frame_address(0); sp;
+	     sp =3D PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
+		if (get_stack_info(sp, state->task, &stack_info, &visit_mask))
+			break;
+
+		for (; sp < stack_info.end; sp++) {
+
+			word =3D READ_ONCE_NOCHECK(*sp);
+
+			printk_deferred("%0*lx: %0*lx (%pB)\n", BITS_PER_LONG/4,
+					(unsigned long)sp, BITS_PER_LONG/4,
+					word, (void *)word);
+		}
+	}
+}
=20
 static inline unsigned long orc_ip(const int *ip)
 {
--=20
2.21.1

