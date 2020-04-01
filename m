Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADECC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECC220784
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UX/9Uu0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732926AbgDASXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:23:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47263 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732910AbgDASXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585765427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8szS2/P4Z3/SR98iwz6z1Q9e8O85YRT99ZqA66Wzkvg=;
        b=UX/9Uu0B1Wb3seIp4nFDjdqxpkOaOkGb5Kbo33ipDceJP/Bsn3j3uYQupswS+5ggahC9Mj
        9QcXFyWEwk+WeUxriOCokQ/k3dv+awVXr40FN96UijteFmBaBmlLI8Ad4y1ZewBoo3TSLM
        GPjyad6pW4el6KJJCYowd4Pg5piccuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-SR-3u1lnPYadle6HyGLizQ-1; Wed, 01 Apr 2020 14:23:43 -0400
X-MC-Unique: SR-3u1lnPYadle6HyGLizQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 691CD18A8C82;
        Wed,  1 Apr 2020 18:23:41 +0000 (UTC)
Received: from treble.redhat.com (ovpn-118-135.phx2.redhat.com [10.3.118.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BADDE60BEC;
        Wed,  1 Apr 2020 18:23:40 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>
Subject: [PATCH 5/5] objtool: Make BP scratch register warning more robust
Date:   Wed,  1 Apr 2020 13:23:29 -0500
Message-Id: <afc628693a37acd287e843bcc5c0430263d93c74.1585761021.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1585761021.git.jpoimboe@redhat.com>
References: <cover.1585761021.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If func is NULL, a seg fault can result.

This is a theoretical issue which was found by Coverity.

Fixes: c705cecc8431 ("objtool: Track original function across branches")
Addresses-Coverity-ID: 1492002 ("Dereference after null check")
Reported-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c681a26c25ac..93fa7be67e9f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2023,8 +2023,8 @@ static int validate_return(struct symbol *func, str=
uct instruction *insn, struct
 	}
=20
 	if (state->bp_scratch) {
-		WARN("%s uses BP as a scratch register",
-		     func->name);
+		WARN_FUNC("BP used as a scratch register",
+			  insn->sec, insn->offset);
 		return 1;
 	}
=20
--=20
2.21.1

