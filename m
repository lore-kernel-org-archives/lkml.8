Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F04C2BA13
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77E120BED
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqLd52KQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732946AbgDASXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:23:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37440 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732579AbgDASXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585765425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ed86f8mBs636MCN5s8u0lJs9+rF7ja9CVlRZvAQrmco=;
        b=eqLd52KQvWsNYywZyf0LeeUwzKkwk9N+sm2rE2F0qHm6HKIkd+5/6/bHr53mRaJvckW//1
        dlmQNgbiFjiduFMnJokNZmJVYCNzBAeMMALfc6ln2bHtfRzh63T+mGboVqHUJ5TQgTKT+T
        mvKRHxNvPYbUBRHeJlKAB1HC4IB1jwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-Xyq8AVtaPfmN7ONLCbH9cQ-1; Wed, 01 Apr 2020 14:23:41 -0400
X-MC-Unique: Xyq8AVtaPfmN7ONLCbH9cQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9BD018A8C80;
        Wed,  1 Apr 2020 18:23:39 +0000 (UTC)
Received: from treble.redhat.com (ovpn-118-135.phx2.redhat.com [10.3.118.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C185A60BEC;
        Wed,  1 Apr 2020 18:23:38 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 3/5] objtool: Support Clang non-section symbols in ORC generation
Date:   Wed,  1 Apr 2020 13:23:27 -0500
Message-Id: <9a9cae7fcf628843aabe5a086b1a3c5bf50f42e8.1585761021.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1585761021.git.jpoimboe@redhat.com>
References: <cover.1585761021.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling the kernel with AS=3Dclang, objtool produces a lot of
warnings:

  warning: objtool: missing symbol for section .text
  warning: objtool: missing symbol for section .init.text
  warning: objtool: missing symbol for section .ref.text

It then fails to generate the ORC table.

The problem is that objtool assumes text section symbols always exist.
But the Clang assembler is aggressive about removing them.

When generating relocations for the ORC table, objtool always tries to
reference instructions by their section symbol offset.  If the section
symbol doesn't exist, it bails.

Do a fallback: when a section symbol isn't available, reference a
function symbol instead.

Link: https://github.com/ClangBuiltLinux/linux/issues/669
Cc: Nick Desaulniers <ndesaulniers@google.com>
Reported-by: Dmitry Golovin <dima@golovin.in>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/orc_gen.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 41e4a2754da4..4c0dabd28000 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -88,11 +88,6 @@ static int create_orc_entry(struct elf *elf, struct se=
ction *u_sec, struct secti
 	struct orc_entry *orc;
 	struct rela *rela;
=20
-	if (!insn_sec->sym) {
-		WARN("missing symbol for section %s", insn_sec->name);
-		return -1;
-	}
-
 	/* populate ORC data */
 	orc =3D (struct orc_entry *)u_sec->data->d_buf + idx;
 	memcpy(orc, o, sizeof(*orc));
@@ -105,8 +100,32 @@ static int create_orc_entry(struct elf *elf, struct =
section *u_sec, struct secti
 	}
 	memset(rela, 0, sizeof(*rela));
=20
-	rela->sym =3D insn_sec->sym;
-	rela->addend =3D insn_off;
+	if (insn_sec->sym) {
+		rela->sym =3D insn_sec->sym;
+		rela->addend =3D insn_off;
+	} else {
+		/*
+		 * The Clang assembler doesn't produce section symbols, so we
+		 * have to reference the function symbol instead:
+		 */
+		rela->sym =3D find_symbol_containing(insn_sec, insn_off);
+		if (!rela->sym) {
+			/*
+			 * Hack alert.  This happens when we need to reference
+			 * the NOP pad insn immediately after the function.
+			 */
+			rela->sym =3D find_symbol_containing(insn_sec,
+							   insn_off - 1);
+		}
+		if (!rela->sym) {
+			WARN("missing symbol for insn at offset 0x%lx\n",
+			     insn_off);
+			return -1;
+		}
+
+		rela->addend =3D insn_off - rela->sym->offset;
+	}
+
 	rela->type =3D R_X86_64_PC32;
 	rela->offset =3D idx * sizeof(int);
 	rela->sec =3D ip_relasec;
--=20
2.21.1

