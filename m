Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00245C55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 11:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF170206EC
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 11:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKJHFN2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgDYLJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 07:09:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42685 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726053AbgDYLJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 07:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587812948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IxXwaITeFhkfWcto4jZfFgAdQs8wTFzjx9bORWuABjE=;
        b=jKJHFN2HPa8E0JXLYbf21DfXQmwczyhLujQlB+54hnfBpmg6+i/IO0DI1zkVF25eSXuYEv
        keJYlpnDRd8uvpCvXoANefSBk/0E2eOLtsDDgoT7WDI7S0VtsDe3mF3wXNlhpmytLLCJ7S
        xrthNinxWIazEA7QYhvuAU7xbBditBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-wPm5p_aIN5CZZZJh-Aq6Kg-1; Sat, 25 Apr 2020 07:08:56 -0400
X-MC-Unique: wPm5p_aIN5CZZZJh-Aq6Kg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66E981005510;
        Sat, 25 Apr 2020 11:08:55 +0000 (UTC)
Received: from treble.redhat.com (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6EE85C1D4;
        Sat, 25 Apr 2020 11:08:54 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     live-patching@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: [PATCH v3 10/10] x86/module: Use text_mutex in apply_relocate_add()
Date:   Sat, 25 Apr 2020 06:07:30 -0500
Message-Id: <9b8bd09ae5c255e2849a12b3b70085b327bdf9fd.1587812518.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1587812518.git.jpoimboe@redhat.com>
References: <cover.1587812518.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the livepatch code no longer needs the text_mutex for changing
module permissions, move its usage down to apply_relocate_add().

Note the s390 version of apply_relocate_add() doesn't need to use the
text_mutex because it already uses s390_kernel_write_lock, which
accomplishes the same task.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/module.c | 9 +++++++--
 kernel/livepatch/core.c  | 6 ------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 7614f478fd7a..23c95a53d20e 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -18,6 +18,7 @@
 #include <linux/gfp.h>
 #include <linux/jump_label.h>
 #include <linux/random.h>
+#include <linux/memory.h>
=20
 #include <asm/text-patching.h>
 #include <asm/page.h>
@@ -227,14 +228,18 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 	bool early =3D me->state =3D=3D MODULE_STATE_UNFORMED;
 	void *(*write)(void *, const void *, size_t) =3D memcpy;
=20
-	if (!early)
+	if (!early) {
 		write =3D text_poke;
+		mutex_lock(&text_mutex);
+	}
=20
 	ret =3D __apply_relocate_add(sechdrs, strtab, symindex, relsec, me,
 				   write);
=20
-	if (!early)
+	if (!early) {
 		text_poke_sync();
+		mutex_unlock(&text_mutex);
+	}
=20
 	return ret;
 }
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 6b8b3c067be0..96d2da14eb0d 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -775,9 +775,6 @@ static int klp_init_object_loaded(struct klp_patch *p=
atch,
 	int ret;
=20
 	if (klp_is_module(obj)) {
-
-		mutex_lock(&text_mutex);
-
 		/*
 		 * Only write module-specific relocations here
 		 * (.klp.rela.{module}.*).  vmlinux-specific relocations were
@@ -785,9 +782,6 @@ static int klp_init_object_loaded(struct klp_patch *p=
atch,
 		 * itself.
 		 */
 		ret =3D klp_apply_object_relocs(patch, obj);
-
-		mutex_unlock(&text_mutex);
-
 		if (ret)
 			return ret;
 	}
--=20
2.21.1

