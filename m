Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045A5C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D655320714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E96U6tNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgDYTTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 15:19:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21981 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726005AbgDYTTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 15:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587842379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KGEYiVi/N5jjAgrixEfeFIG/QsQOzD5jtvrhC/kRyL4=;
        b=E96U6tNO9DdCKAaE+lOcIojJq38h2BmFa/mXkKbUY35vB34zOkfdqnnShrWHDLr9q37b2N
        bGiBqJZ6D7E63ja+iCtyVmXPaWnf7/sk3PvpAjoDYEkPGOMcJcsybiraaXBWtDNEkdXWga
        ULCX+Hs6qv3iFz/7cy3ST3Ywx5hPc+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-TGwRrYgbOkq0dHhlg17iPQ-1; Sat, 25 Apr 2020 15:19:37 -0400
X-MC-Unique: TGwRrYgbOkq0dHhlg17iPQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1C28800D24;
        Sat, 25 Apr 2020 19:19:35 +0000 (UTC)
Received: from treble.redhat.com (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C2DE60300;
        Sat, 25 Apr 2020 19:19:34 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] objtool: Fix infinite loop in for_offset_range()
Date:   Sat, 25 Apr 2020 14:19:01 -0500
Message-Id: <02b719674b031800b61e33c30b2e823183627c19.1587842122.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy reported that objtool got stuck in an infinite loop when
processing drivers/i2c/busses/i2c-parport.o.  It was caused by the
following code:

  00000000000001fd <line_set>:
   1fd:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
   204:	00 00 00
  			1ff: R_X86_64_64	.rodata-0x8
   207:	41 55                	push   %r13
   209:	41 89 f5             	mov    %esi,%r13d
   20c:	41 54                	push   %r12
   20e:	49 89 fc             	mov    %rdi,%r12
   211:	55                   	push   %rbp
   212:	48 89 d5             	mov    %rdx,%rbp
   215:	53                   	push   %rbx
   216:	0f b6 5a 01          	movzbl 0x1(%rdx),%ebx
   21a:	48 8d 34 dd 00 00 00 	lea    0x0(,%rbx,8),%rsi
   221:	00
  			21e: R_X86_64_32S	.rodata
   222:	48 89 f1             	mov    %rsi,%rcx
   225:	48 29 c1             	sub    %rax,%rcx

find_jump_table() saw the .rodata reference and tried to find a jump
table associated with it (though there wasn't one).  The -0x8 rela
addend is unusual.  It caused find_jump_table() to send a negative
table_offset (unsigned 0xfffffffffffffff8) to find_rela_by_dest().

The negative offset should have been harmless, but it actually threw
for_offset_range() for a loop... literally.  When the mask value got
incremented past the end value, it also wrapped to zero, causing the
loop exit condition to remain true forever.

Prevent this scenario from happening by ensuring the incremented value
is always >=3D the starting value.

Fixes: 74b873e49d92 ("objtool: Optimize find_rela_by_dest_range()")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 5e76ac38cf99..f753148f5dac 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -89,9 +89,10 @@ struct elf {
 #define OFFSET_STRIDE		(1UL << OFFSET_STRIDE_BITS)
 #define OFFSET_STRIDE_MASK	(~(OFFSET_STRIDE - 1))
=20
-#define for_offset_range(_offset, _start, _end)		\
-	for (_offset =3D ((_start) & OFFSET_STRIDE_MASK);	\
-	     _offset <=3D ((_end) & OFFSET_STRIDE_MASK);	\
+#define for_offset_range(_offset, _start, _end)			\
+	for (_offset =3D ((_start) & OFFSET_STRIDE_MASK);		\
+	     _offset >=3D ((_start) & OFFSET_STRIDE_MASK) &&	\
+	     _offset <=3D ((_end) & OFFSET_STRIDE_MASK);		\
 	     _offset +=3D OFFSET_STRIDE)
=20
 static inline u32 sec_offset_hash(struct section *sec, unsigned long off=
set)
--=20
2.21.1

