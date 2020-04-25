Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175D9C55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7F920714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQT1yJIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgDYKD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:03:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60806 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726022AbgDYKD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587809005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hzFlafVbguPCTGsWYTBA2MqvtcW1IOj7wGDJ/qclM6c=;
        b=SQT1yJIW9W7+LA+LBxMLwgktf8K6BGpl3E1Uxdl3fouBBmF+ikLEjbsNiSb0sV4X4paN2p
        3fmI1nIPFgPIO6RCJFN0J7f3c9bpwSM3OhlPrFRe3iwDXD9VGd+sYkNcXt3l+Hxpnw3z+p
        SpSgy0TheNkOxQRrU8QTYKXdfm8v5Zk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-Vn_BDqwSOXSKzUoVY-oMwQ-1; Sat, 25 Apr 2020 06:03:23 -0400
X-MC-Unique: Vn_BDqwSOXSKzUoVY-oMwQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15FED180F125;
        Sat, 25 Apr 2020 10:03:21 +0000 (UTC)
Received: from treble.redhat.com (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B1146061E;
        Sat, 25 Apr 2020 10:03:19 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Joe Mario <jmario@redhat.com>
Subject: [PATCH v2 01/11] objtool: Fix stack offset tracking for indirect CFAs
Date:   Sat, 25 Apr 2020 05:03:00 -0500
Message-Id: <853d5d691b29e250333332f09b8e27410b2d9924.1587808742.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1587808742.git.jpoimboe@redhat.com>
References: <cover.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0d500767009b..0c732d586924 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1550,7 +1550,7 @@ static int update_cfi_state_regs(struct instruction=
 *insn,
 {
 	struct cfi_reg *cfa =3D &cfi->cfa;
=20
-	if (cfa->base !=3D CFI_SP)
+	if (cfa->base !=3D CFI_SP && cfa->base !=3D CFI_SP_INDIRECT)
 		return 0;
=20
 	/* push */
--=20
2.21.1

