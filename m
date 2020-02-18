Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F754C34033
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093322072C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oj1LPJZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgBRDmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 22:42:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27984 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726166AbgBRDmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 22:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581997328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XrWyoh+EKpwDUgbqCfs/qtzTlVcIIymdke9iyPrdemU=;
        b=Oj1LPJZ+hzyRBticZpoO119H3DEe06XLBrJRPNxoz7z3qb8o/jukOLc4neDNaXHeh4zsPq
        MDFkt819/cmaRblZDPHFGGogNWFSkQpuJt9vyPFfaq2GAewVK/7Vi8sDTPYioDvk/NzqXQ
        JKwvI4xlz7WKSpkX43svqZTGazKK3FQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-KDspin5DOyqO6wgb8sezbg-1; Mon, 17 Feb 2020 22:42:04 -0500
X-MC-Unique: KDspin5DOyqO6wgb8sezbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFEF48014D0;
        Tue, 18 Feb 2020 03:42:03 +0000 (UTC)
Received: from treble.redhat.com (ovpn-121-12.rdu2.redhat.com [10.10.121.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 102F010027BA;
        Tue, 18 Feb 2020 03:42:02 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 1/2] objtool: Fix clang switch table edge case
Date:   Mon, 17 Feb 2020 21:41:53 -0600
Message-Id: <263f6aae46d33da0b86d7030ced878cb5cab1788.1581997059.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1581997059.git.jpoimboe@redhat.com>
References: <cover.1581997059.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang has the ability to create a switch table which is not a jump
table, but is rather a table of string pointers.  This confuses objtool,
because it sees the relocations for the string pointers and assumes
they're part of a jump table:

  drivers/ata/sata_dwc_460ex.o: warning: objtool: sata_dwc_bmdma_start_by=
_tag()+0x3a2: can't find switch jump table
  net/ceph/messenger.o: warning: objtool: ceph_con_workfn()+0x47c: can't =
find switch jump table

Make objtool's find_jump_table() smart enough to distinguish between a
switch jump table (which has relocations to text addresses in the same
function as the original instruction) and other anonymous rodata (which
may have relocations to elsewhere).

Link: https://github.com/ClangBuiltLinux/linux/issues/485
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b6da413bcbd6..e7227649bac7 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1019,7 +1019,7 @@ static struct rela *find_jump_table(struct objtool_=
file *file,
 				      struct instruction *insn)
 {
 	struct rela *text_rela, *table_rela;
-	struct instruction *orig_insn =3D insn;
+	struct instruction *dest_insn, *orig_insn =3D insn;
 	struct section *table_sec;
 	unsigned long table_offset;
=20
@@ -1071,10 +1071,17 @@ static struct rela *find_jump_table(struct objtoo=
l_file *file,
 		    strcmp(table_sec->name, C_JUMP_TABLE_SECTION))
 			continue;
=20
-		/* Each table entry has a rela associated with it. */
+		/*
+		 * Each table entry has a rela associated with it.  The rela
+		 * should reference text in the same function as the original
+		 * instruction.
+		 */
 		table_rela =3D find_rela_by_dest(table_sec, table_offset);
 		if (!table_rela)
 			continue;
+		dest_insn =3D find_insn(file, table_rela->sym->sec, table_rela->addend=
);
+		if (!dest_insn || !dest_insn->func || dest_insn->func->pfunc !=3D func=
)
+			continue;
=20
 		/*
 		 * Use of RIP-relative switch jumps is quite rare, and
--=20
2.21.1

