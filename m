Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F28C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CD620675
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/fdp3Ur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgBJSd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:33:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49402 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727669AbgBJSdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581359603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/GXPd2YWBJrZzDlO3gX8t/00XYvRj8m5L7xKKx+UXkw=;
        b=g/fdp3Ur0yp5SU5XOch99BS3D8gZXGxoamb0d+pdxWL9cEzsJhPWmKC2dJQidFnhPZga26
        LoG7RXUQGhvahYp9OZscGLZf0T+mmcyexCEXnpfxOFHkYMlMv+6TGfQr3IwNy+Zs1mrI8M
        HpEKoN/Dr3FjvnKQ2q5taLavjQwdgs8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-MJbc5WepOlqXZG9zSBn10Q-1; Mon, 10 Feb 2020 13:33:19 -0500
X-MC-Unique: MJbc5WepOlqXZG9zSBn10Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9E51100550E;
        Mon, 10 Feb 2020 18:33:18 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-45.rdu2.redhat.com [10.10.122.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E70A10013A7;
        Mon, 10 Feb 2020 18:33:17 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/3] objtool: Fail the kernel build on fatal errors
Date:   Mon, 10 Feb 2020 12:32:38 -0600
Message-Id: <f18c3743de0fef673d49dd35760f26bdef7f6fc3.1581359535.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1581359535.git.jpoimboe@redhat.com>
References: <cover.1581359535.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When objtool encounters a fatal error, it usually means the binary is
corrupt or otherwise broken in some way.  Up until now, such errors were
just treated as warnings which didn't fail the kernel build.

However, objtool is now stable enough that if a fatal error is
discovered, it most likely means something is seriously wrong and it
should fail the kernel build.

Note that this doesn't apply to "normal" objtool warnings; only fatal
ones.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b6da413bcbd6..61d2d1877fd2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2509,8 +2509,14 @@ int check(const char *_objname, bool orc)
 out:
 	cleanup(&file);
=20
-	/* ignore warnings for now until we get all the code cleaned up */
-	if (ret || warnings)
-		return 0;
+	if (ret < 0) {
+		/*
+		 *  Fatal error.  The binary is corrupt or otherwise broken in
+		 *  some way, or objtool itself is broken.  Fail the kernel
+		 *  build.
+		 */
+		return ret;
+	}
+
 	return 0;
 }
--=20
2.21.1

