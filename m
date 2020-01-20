Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F45C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE9024655
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bD4T/EpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgATSOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 13:14:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22869 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726942AbgATSO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 13:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579544067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MQMUqUHJYS04Smnn75usLp5F19GbW9z9n9b5RBM0XBA=;
        b=bD4T/EpY4Nhk4Qh3gTYBD+akb9Ds3CNlEF13tcelaPr7vaOUHNMF/dB8AhnM1sPVgy2nOT
        GuLcvgwMNOq88dMQ/qtUXTiFmuCBAn2O6P60bRF4i6epAHRZqZS5B1ZW62UvJsfehwJx7e
        Bz6jZG3kmIQTRDwBc6hpjwocqv6xKuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-i7eAo9-DNauzCbtId7qEuw-1; Mon, 20 Jan 2020 13:14:23 -0500
X-MC-Unique: i7eAo9-DNauzCbtId7qEuw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B4C418A8C82;
        Mon, 20 Jan 2020 18:14:22 +0000 (UTC)
Received: from treble.redhat.com (ovpn-125-19.rdu2.redhat.com [10.10.125.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60D151001B30;
        Mon, 20 Jan 2020 18:14:21 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 1/3] objtool: Silence build output
Date:   Mon, 20 Jan 2020 12:14:07 -0600
Message-Id: <cb002857fafa8186cfb9c3e43fb62e4108a1bab9.1579543924.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1579543924.git.jpoimboe@redhat.com>
References: <cover.1579543924.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olof Johansson <olof@lixom.net>

The sync-check.sh script prints out the path due to a "cd -" at the end
of the script, even on silent builds. This isn't even needed, since the
script is executed in our build instead of sourced (so it won't change
the working directory of the surrounding build anyway).

Just remove the cd to make the build silent.

Fixes: 2ffd84ae973b ("objtool: Update sync-check.sh from perf's check-hea=
ders.sh")
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/sync-check.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 9bd04bbed01e..2a1261bfbb62 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -48,5 +48,3 @@ check arch/x86/include/asm/inat.h     '-I "^#include [\=
"<]\(asm/\)*inat_types.h[
 check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.=
h[\">]"'
 check arch/x86/lib/inat.c             '-I "^#include [\"<]\(../include/\=
)*asm/insn.h[\">]"'
 check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\=
)*asm/in\(at\|sn\).h[\">]" -I "^#include [\"<]\(../include/\)*asm/emulate=
_prefix.h[\">]"'
-
-cd -
--=20
2.21.1

