Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21119C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A8B208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faz10b4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgD2PZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:25:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57455 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727872AbgD2PZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588173925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CgzAwtsyZTU68WwvLxr2IdSTNi5xOjDVczwYslxfyiw=;
        b=faz10b4whaDoa5ezd8Hr//EBbFhF4BukAufvauhGAtnjkse2bKz6D/FOojm6vvTIgeIYuy
        q1AxUlGmxFlZqLlIf+tNLI5kUboGqN53PiKAbzTVUrbK2ZhoNE67Vkb37ZrHh3ZJtOgFtC
        frBDg40aZdwIKpuLaY4npdvgirUt0KE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-iNzzhXowOq2o9svufc09qw-1; Wed, 29 Apr 2020 11:25:22 -0400
X-MC-Unique: iNzzhXowOq2o9svufc09qw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FBCF800C78;
        Wed, 29 Apr 2020 15:25:13 +0000 (UTC)
Received: from treble.redhat.com (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C671605CB;
        Wed, 29 Apr 2020 15:25:12 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     live-patching@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v4 10/11] x86/module: Use text_mutex in apply_relocate_add()
Date:   Wed, 29 Apr 2020 10:24:52 -0500
Message-Id: <506017e7d3e0d86a1c6409418c87516d8baeaa5e.1588173720.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1588173720.git.jpoimboe@redhat.com>
References: <cover.1588173720.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
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

