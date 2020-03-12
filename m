Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0C7C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7E8206B1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtLUHbc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgCLRbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:31:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41585 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726740AbgCLRbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584034273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LJbrYB7EGQI8APHbNBkrdPBHWXpYZec9DyNjgcrdQ5U=;
        b=HtLUHbc9cC4GTJxf2I1Dj+kZ48zBe4q5h1YVY0pAf+TREvxr+9xiMgNNh1mDmRbpTupAJ9
        5tnM4U74LepMrxSm4QzemBJt0m+a9LW2STmvu1vinAerWOOGa+a3c0MTztN5DO9D/+8K3e
        XLRIHVDJ60y09VDcKCq6NO+jh+9Je/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-2ZLqWi1BPQy0AzQp_PEftw-1; Thu, 12 Mar 2020 13:31:12 -0400
X-MC-Unique: 2ZLqWi1BPQy0AzQp_PEftw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31A5D800D4E;
        Thu, 12 Mar 2020 17:31:10 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-137.rdu2.redhat.com [10.10.122.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F266360BEC;
        Thu, 12 Mar 2020 17:31:08 +0000 (UTC)
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
Subject: [PATCH 13/14] x86/unwind/orc: Add more unwinder warnings
Date:   Thu, 12 Mar 2020 12:30:32 -0500
Message-Id: <45505e1a05d93f0b80a50868dc8d2c1570f92241.1584033751.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1584033751.git.jpoimboe@redhat.com>
References: <cover.1584033751.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure warnings are displayed for all error scenarios (except when
encountering an empty unwind hint).

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/unwind_orc.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 0ebc11a8bb45..4118013a574a 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -450,8 +450,15 @@ bool unwind_next_frame(struct unwind_state *state)
=20
 	/* End-of-stack check for kernel threads: */
 	if (orc->sp_reg =3D=3D ORC_REG_UNDEFINED) {
-		if (!orc->end)
+		if (!orc->end) {
+			/*
+			 * This is reported as an error for the caller, but
+			 * otherwise it isn't worth warning about.  In theory
+			 * it can only happen when hitting UNWIND_HINT_EMPTY in
+			 * entry code, close to a kernel exit point.
+			 */
 			goto err;
+		}
=20
 		goto the_end;
 	}
@@ -515,8 +522,11 @@ bool unwind_next_frame(struct unwind_state *state)
 	}
=20
 	if (indirect) {
-		if (!deref_stack_reg(state, sp, &sp))
+		if (!deref_stack_reg(state, sp, &sp)) {
+			orc_warn_current("can't access indirect SP at %pB\n",
+					 (void *)state->ip);
 			goto err;
+		}
 	}
=20
 	/* Find IP, SP and possibly regs: */
@@ -524,8 +534,11 @@ bool unwind_next_frame(struct unwind_state *state)
 	case ORC_TYPE_CALL:
 		ip_p =3D sp - sizeof(long);
=20
-		if (!deref_stack_reg(state, ip_p, &state->ip))
+		if (!deref_stack_reg(state, ip_p, &state->ip)) {
+			orc_warn_current("can't access call return IP (0x%lx) at %pB\n",
+					 ip_p, (void *)orig_ip);
 			goto err;
+		}
=20
 		state->ip =3D ftrace_graph_ret_addr(state->task, &state->graph_idx,
 						  state->ip, (void *)ip_p);
@@ -577,13 +590,19 @@ bool unwind_next_frame(struct unwind_state *state)
 		break;
=20
 	case ORC_REG_PREV_SP:
-		if (!deref_stack_reg(state, sp + orc->bp_offset, &state->bp))
+		if (!deref_stack_reg(state, sp + orc->bp_offset, &state->bp)) {
+			orc_warn_current("can't access BP (from SP) at %pB\n",
+					 (void *)orig_ip);
 			goto err;
+		}
 		break;
=20
 	case ORC_REG_BP:
-		if (!deref_stack_reg(state, state->bp + orc->bp_offset, &state->bp))
+		if (!deref_stack_reg(state, state->bp + orc->bp_offset, &state->bp)) {
+			orc_warn_current("can't access BP at %pB\n",
+					 (void *)orig_ip);
 			goto err;
+		}
 		break;
=20
 	default:
--=20
2.21.1

