Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8F1C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4921A208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqJjVjDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgD2PZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:25:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28660 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727855AbgD2PZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588173925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EBRv2/+FDr/lrTbtQJ9do2irFBLZgBPX8/+zXznQJVc=;
        b=GqJjVjDgOoS/5Z3CDDy3zwyclH4k5c6JmWv5AmjgREDCnmEEyMh8sH2pw0jil2l6oPd8E2
        z8TzE2dAvcFZnsjXSY/WIlS66RDLFTupDwmeypFW1Qs9Uw7B5n/5ZGQXLKhT3g8n7xDDeX
        HfYZ+eoUGvuvP8C89vAh80bPLkXeGKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-nQ9Y17OhP_SCQKoP7uXdJw-1; Wed, 29 Apr 2020 11:25:20 -0400
X-MC-Unique: nQ9Y17OhP_SCQKoP7uXdJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60C468054AE;
        Wed, 29 Apr 2020 15:25:11 +0000 (UTC)
Received: from treble.redhat.com (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A00E763F65;
        Wed, 29 Apr 2020 15:25:10 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     live-patching@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v4 08/11] livepatch: Remove module_disable_ro() usage
Date:   Wed, 29 Apr 2020 10:24:50 -0500
Message-Id: <100e5d6720353ee26acf0dd01511884d509f8cc5.1588173720.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1588173720.git.jpoimboe@redhat.com>
References: <cover.1588173720.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With arch_klp_init_object_loaded() gone, and apply_relocate_add() now
using text_poke(), livepatch no longer needs to use module_disable_ro().

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
---
 kernel/livepatch/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index f9ebb54affab..6b8b3c067be0 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -777,7 +777,6 @@ static int klp_init_object_loaded(struct klp_patch *p=
atch,
 	if (klp_is_module(obj)) {
=20
 		mutex_lock(&text_mutex);
-		module_disable_ro(patch->mod);
=20
 		/*
 		 * Only write module-specific relocations here
@@ -787,7 +786,6 @@ static int klp_init_object_loaded(struct klp_patch *p=
atch,
 		 */
 		ret =3D klp_apply_object_relocs(patch, obj);
=20
-		module_enable_ro(patch->mod, true);
 		mutex_unlock(&text_mutex);
=20
 		if (ret)
--=20
2.21.1

