Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CBDC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FFE2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9khVOvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCLRa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:30:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59765 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726514AbgCLRa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584034256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m84iy5pqfsfUSttVpmAAxAY2oS4vc4hPjzrw134P0do=;
        b=h9khVOvEcDqz+BMG6Oxl3bUvlL5/qeP9IRckjO9n+aTuhFxiIMWBU2sKW+zoFagEbuqFME
        vJ1bPjEUhq3R38ExCMCFFoo2ecpKXb7/z6ON4eQjUsjyo3K36XwBwfG7DiJXg6WaIFEpHL
        0W378ML8AaX6TzSZIDhmDjY2I6QnfkY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-jHFreawOOaSQs3APWjw45w-1; Thu, 12 Mar 2020 13:30:55 -0400
X-MC-Unique: jHFreawOOaSQs3APWjw45w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44877801FB3;
        Thu, 12 Mar 2020 17:30:53 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-137.rdu2.redhat.com [10.10.122.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE19960BEC;
        Thu, 12 Mar 2020 17:30:51 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Joe Mario <jmario@redhat.com>
Subject: [PATCH 02/14] objtool: Fix stack offset tracking for indirect CFAs
Date:   Thu, 12 Mar 2020 12:30:21 -0500
Message-Id: <5622250dee750c8eff46cd2de97788a649fe212b.1584033751.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1584033751.git.jpoimboe@redhat.com>
References: <cover.1584033751.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the current frame address (CFA) is stored on the stack (i.e.,
cfa->base =3D=3D CFI_SP_INDIRECT), objtool neglects to adjust the stack
offset when there are subsequent pushes or pops.  This results in bad
ORC data at the end of the ENTER_IRQ_STACK macro, when it puts the
previous stack pointer on the stack and does a subsequent push.

This fixes the following unwinder warning:

  WARNING: can't dereference registers at 00000000f0a6bdba for ip interru=
pt_entry+0x9f/0xa0

Fixes: 627fce14809b ("objtool: Add ORC unwind table generation")
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Reported-by: Dave Jones <dsj@fb.com>
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Reported-by: Joe Mario <jmario@redhat.com>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e637a4a38d2a..fe906864e1c1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1464,7 +1464,7 @@ static int update_insn_state_regs(struct instructio=
n *insn, struct insn_state *s
 	struct cfi_reg *cfa =3D &state->cfa;
 	struct stack_op *op =3D &insn->stack_op;
=20
-	if (cfa->base !=3D CFI_SP)
+	if (cfa->base !=3D CFI_SP && cfa->base !=3D CFI_SP_INDIRECT)
 		return 0;
=20
 	/* push */
--=20
2.21.1

