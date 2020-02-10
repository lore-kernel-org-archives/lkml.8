Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FA9C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFEB20661
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581365218;
	bh=EI73JsHkyAETxCqIdwxlUf793jd3DNtIID++vA19oiY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=V4TsiJqGJfSEVVj3zYLRHsQOD+2ojjz+CvmKOSZmkdw0wiVM5nUtmmWf9QohasJGj
	 YzBO8NlQ8JaESnlLDLKNK3F/4RdjArOEdNiHz2/HH7aRWBb2rjUJ8+ywYj9DYiNwUH
	 GAn27Uzk/+fVOrlpbcjlxAFvOXA62NdxJcqvqZFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBJUG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 15:06:57 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:54337 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgBJUG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 15:06:56 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 01AK6d7s027300;
        Tue, 11 Feb 2020 05:06:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 01AK6d7s027300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581365200;
        bh=QbvMFMrDwsuvJuynkwyzbwUz09Fk9Jq4y53z3DitBDg=;
        h=From:To:Cc:Subject:Date:From;
        b=wxx9dvjU0O+XKJ5RRwa+0xQ5828+8k4JZem9qCMVNzOhgGXkgP0GBd1R8Nb1Ua6n3
         ihMEp8xtKlFuq5E0JZFivbnWxkDtVKexw009/ohswuGT6t1oLBd1WJvzgPKFTFr+Mu
         hc+qZ3Jk2BgUAaczNSvfOX7JldiLTmn4THl5TqVxqspl21A+BHRAYDkWE9MFt4/kBg
         yE0HnYVX8shtaa/9Hh98xjkxFeBhUhwcQ7kMAryvVCrlH59HeYVLtLghu6msEJ4Jh+
         PbZEJdCJ7vfpxQxfy3UxvTHL17RdekjxcfObkb2hZE+5HhVGf7G79RygADOSh2levC
         0JVhWrNOwXgvg==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH] kbuild: fix mismatch between .version and include/generated/compile.h
Date:   Tue, 11 Feb 2020 05:06:34 +0900
Message-Id: <20200210200634.950-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 56d589361572 ("kbuild: do not create orphan built-in.a or
obj-y objects"), scripts/link-vmlinux.sh does nothing when descending
into init/.

Once the version number becomes out of sync between .version and
include/generated/compile.h, it is not self-healing.

[How to reproduce]

 $ echo 100 > .version
 $ make

You will see the number in the .version is always bigger than that in
compile.h by one. After this, every time you run 'make', the vmlinux is
re-linked even when none of source files is updated.

Fixes: 56d589361572 ("kbuild: do not create orphan built-in.a or obj-y objects")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/link-vmlinux.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 1919c311c149..dd484e92752e 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -239,7 +239,7 @@ else
 fi;
 
 # final build of init/
-${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init
+${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init need-builtin=1
 
 #link vmlinux.o
 info LD vmlinux.o
-- 
2.17.1

