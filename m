Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025CEC2BA12
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACB720784
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qg1rdaZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbgDASXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:23:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56825 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732943AbgDASXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585765430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g2n0Iw5Dd9JFbjZc1yj3P1KSOEihDnom0Nq536oA/X4=;
        b=Qg1rdaZg9wBooeKpTT+DTEROnEjo1SKCtBuFQQy3CRo3u3ngsuAR7NwKGrL0ptZEibxK0u
        h7q/2jV+5zdDOqOJtQK5WTThEC1wgz8tT5kwj+kUPCpDVIjsaHAvebM7X9cwvCnxh5rpIh
        37/8O/HEGK1ZlyNqoj2SLS+CvCXF2no=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-OgpYwYQqMSOkgM56PmohSg-1; Wed, 01 Apr 2020 14:23:41 -0400
X-MC-Unique: OgpYwYQqMSOkgM56PmohSg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BA7F477;
        Wed,  1 Apr 2020 18:23:40 +0000 (UTC)
Received: from treble.redhat.com (ovpn-118-135.phx2.redhat.com [10.3.118.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1537160BEC;
        Wed,  1 Apr 2020 18:23:40 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 4/5] objtool: Fix switch table detection in .text.unlikely
Date:   Wed,  1 Apr 2020 13:23:28 -0500
Message-Id: <157c35d42ca9b6354bbb1604fe9ad7d1153ccb21.1585761021.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1585761021.git.jpoimboe@redhat.com>
References: <cover.1585761021.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a switch jump table's indirect branch is in a ".cold" subfunction in
.text.unlikely, objtool doesn't detect it, and instead prints a false
warning:

  drivers/media/v4l2-core/v4l2-ioctl.o: warning: objtool: v4l_print_forma=
t.cold()+0xd6: sibling call from callable instruction with modified stack=
 frame
  drivers/hwmon/max6650.o: warning: objtool: max6650_probe.cold()+0xa5: s=
ibling call from callable instruction with modified stack frame
  drivers/media/dvb-frontends/drxk_hard.o: warning: objtool: init_drxk.co=
ld()+0x16f: sibling call from callable instruction with modified stack fr=
ame

Fix it by comparing the function, instead of the section and offset.

Fixes: 13810435b9a7 ("objtool: Support GCC 8's cold subfunctions")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index aaec5e1277ea..c681a26c25ac 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1068,10 +1068,7 @@ static struct rela *find_jump_table(struct objtool=
_file *file,
 	 * it.
 	 */
 	for (;
-	     &insn->list !=3D &file->insn_list &&
-	     insn->sec =3D=3D func->sec &&
-	     insn->offset >=3D func->offset;
-
+	     &insn->list !=3D &file->insn_list && insn->func && insn->func->pfu=
nc =3D=3D func;
 	     insn =3D insn->first_jump_src ?: list_prev_entry(insn, list)) {
=20
 		if (insn !=3D orig_insn && insn->type =3D=3D INSN_JUMP_DYNAMIC)
--=20
2.21.1

