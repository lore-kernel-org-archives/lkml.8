Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C760C55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 11:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B928206EC
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 11:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dhd1vVNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgDYLJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 07:09:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29968 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726306AbgDYLJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 07:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587812939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HVnDGeFkqHxYb6JYfvKvmBLlLrCl0RNnUymEdkvh3L4=;
        b=Dhd1vVNxVOK8oRWubgWV3GZFPakVd8vcxxcwFgExS7Js5RlQFINYIzvnd5k9WNun2sTotG
        kHs6eB5mo/PXnHPzSgmWzaZ2KNAlEda+sxStMpNZypXiYV7+2RHXJ5IqKkYjzlPgR+5mM4
        IsI9Kk3ad2p1VEEK9UjsC5Z986FO+3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-UdyXikkFMSWe8aotxXWkXQ-1; Sat, 25 Apr 2020 07:08:55 -0400
X-MC-Unique: UdyXikkFMSWe8aotxXWkXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A7D9462;
        Sat, 25 Apr 2020 11:08:54 +0000 (UTC)
Received: from treble.redhat.com (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 950ED5C1D4;
        Sat, 25 Apr 2020 11:08:51 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     live-patching@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: [PATCH v3 09/10] module: Remove module_disable_ro()
Date:   Sat, 25 Apr 2020 06:07:29 -0500
Message-Id: <33089a8ffb2e724cecfa51d72887ae9bf70354f9.1587812518.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1587812518.git.jpoimboe@redhat.com>
References: <cover.1587812518.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module_disable_ro() has no more users.  Remove it.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/module.h |  2 --
 kernel/module.c        | 13 -------------
 2 files changed, 15 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 1ad393e62bef..e4ef7b36feda 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -860,10 +860,8 @@ extern int module_sysfs_initialized;
=20
 #ifdef CONFIG_STRICT_MODULE_RWX
 extern void module_enable_ro(const struct module *mod, bool after_init);
-extern void module_disable_ro(const struct module *mod);
 #else
 static inline void module_enable_ro(const struct module *mod, bool after=
_init) { }
-static inline void module_disable_ro(const struct module *mod) { }
 #endif
=20
 #ifdef CONFIG_GENERIC_BUG
diff --git a/kernel/module.c b/kernel/module.c
index 96b2575329f4..f0e414a01d91 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2016,19 +2016,6 @@ static void frob_writable_data(const struct module=
_layout *layout,
 		   (layout->size - layout->ro_after_init_size) >> PAGE_SHIFT);
 }
=20
-/* livepatching wants to disable read-only so it can frob module. */
-void module_disable_ro(const struct module *mod)
-{
-	if (!rodata_enabled)
-		return;
-
-	frob_text(&mod->core_layout, set_memory_rw);
-	frob_rodata(&mod->core_layout, set_memory_rw);
-	frob_ro_after_init(&mod->core_layout, set_memory_rw);
-	frob_text(&mod->init_layout, set_memory_rw);
-	frob_rodata(&mod->init_layout, set_memory_rw);
-}
-
 void module_enable_ro(const struct module *mod, bool after_init)
 {
 	if (!rodata_enabled)
--=20
2.21.1

