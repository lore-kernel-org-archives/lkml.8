Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42766C55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F28520714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QR+JOTpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgDYKDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:03:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51839 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726159AbgDYKDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587809018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=98wxm4LxWtuh6/aQQPAtxpzRp5BkuEHL2r32GVcm3CA=;
        b=QR+JOTpeu4HaFq9GPdIKIqnW3DEIxue98TitbU5oBqlJ5WbeqO57ulCv9oNPNLmB4rhCn0
        3KgABjkA3msYtfkN4cds9doaNP5xNk2OG1cPlUPbQtqw3bhu1in8qUkbWumdRS2i2OOnvS
        Bfb/Lb1xrq3IjlyB40xC16U16HCrXiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-xGBhV-sTPt-C629FmLqGtg-1; Sat, 25 Apr 2020 06:03:33 -0400
X-MC-Unique: xGBhV-sTPt-C629FmLqGtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E6A08015CF;
        Sat, 25 Apr 2020 10:03:32 +0000 (UTC)
Received: from treble.redhat.com (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4A5D60623;
        Sat, 25 Apr 2020 10:03:30 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 09/11] x86/unwind/orc: Prevent unwinding before ORC initialization
Date:   Sat, 25 Apr 2020 05:03:08 -0500
Message-Id: <069d1499ad606d85532eb32ce39b2441679667d5.1587808742.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1587808742.git.jpoimboe@redhat.com>
References: <cover.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the unwinder is called before the ORC data has been initialized,
orc_find() returns NULL, and it tries to fall back to using frame
pointers.  This can cause some unexpected warnings during boot.

Move the 'orc_init' check from orc_find() to __unwind_init(), so that it
doesn't even try to unwind from an uninitialized state.

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
---
 arch/x86/kernel/unwind_orc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index e9f5a20c69c6..cb11567361cc 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -148,9 +148,6 @@ static struct orc_entry *orc_find(unsigned long ip)
 {
 	static struct orc_entry *orc;
=20
-	if (!orc_init)
-		return NULL;
-
 	if (ip =3D=3D 0)
 		return &null_orc_entry;
=20
@@ -591,6 +588,9 @@ EXPORT_SYMBOL_GPL(unwind_next_frame);
 void __unwind_start(struct unwind_state *state, struct task_struct *task=
,
 		    struct pt_regs *regs, unsigned long *first_frame)
 {
+	if (!orc_init)
+		goto done;
+
 	memset(state, 0, sizeof(*state));
 	state->task =3D task;
=20
--=20
2.21.1

