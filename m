Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A49C35243
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 04:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593ED2075E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 04:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579925609;
	bh=tC/862s6NYIi6bv+76sQda0kXCCSCOq8TamINFzB0xc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VPAWpyzeWB0T4gVrVqaXGGl5Z6HKb6byyHrzXZ7BVXDEAXbGJJhWnRmOTpum6FhNO
	 5+ErPcvObUXP1ltPwpAR3X7AG1bNH1e7GwSVOI01qP7uop2zY4hnygLjji5ap7+ZT8
	 T+8oeoicKMAWWYrCrIuCRGSvKDBQHrZ0NpcAnM70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgAYEN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 23:13:28 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:28179 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgAYENM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 23:13:12 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 00P4CcjR032210;
        Sat, 25 Jan 2020 13:12:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 00P4CcjR032210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579925559;
        bh=3vvOuD9IzieNaW/plXSSiBRcrjm3RzM1ZdcZ0+Z2l48=;
        h=From:To:Cc:Subject:Date:From;
        b=Pf8V87+KzHTlWdbHpFggBOLCnT6DP0dC9yyZaHqVL/yn69CdToNPw4XhZa15tMWYy
         yUIqbEQZhWf2aHIcMD9qgyfSmDXTf3IA0DXzAOF7kirlkTYzcwubfbDl59CncSONjO
         WUzgufDocufbNl27Sdx2n3fVkFANWyY4a4F5Bn4stV8I2MimhwO27/UvhNOr8GfP7R
         I4xYEIRz0wtbFtK5TOfSNiPpYupPYwREKP+T4Ep/E/hzU7aCa2v9McfX22Fix9BRgD
         sGWsT9LYahTxvAOWuA3RJEClxXcweMleR6oC+PRugFuLkPKHAXirCODUe/z7gtQPXr
         40si5H3hUuWWQ==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v3 1/7] builddeb: remove unneeded files in hdrobjfiles for headers package
Date:   Sat, 25 Jan 2020 13:12:29 +0900
Message-Id: <20200125041235.8856-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - We do not need tools/objtool/fixdep or tools/objtool/sync-check.sh
   for building external modules. Including tools/objtool/objtool is
   enough.

 - gcc-common.h is a check-in file. I do not see any point to search
   for it in objtree.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v3: None
Changes in v2: None

 scripts/package/builddeb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index f903ba947daf..d4bb28fbd3de 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -170,11 +170,11 @@ done
 (cd $srctree; find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform) >> "$objtree/debian/hdrsrcfiles"
 (cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f) >> "$objtree/debian/hdrsrcfiles"
 if is_enabled CONFIG_STACK_VALIDATION; then
-	(cd $objtree; find tools/objtool -type f -executable) >> "$objtree/debian/hdrobjfiles"
+	echo tools/objtool/objtool >> "$objtree/debian/hdrobjfiles"
 fi
 (cd $objtree; find arch/$SRCARCH/include Module.symvers include scripts -type f) >> "$objtree/debian/hdrobjfiles"
 if is_enabled CONFIG_GCC_PLUGINS; then
-	(cd $objtree; find scripts/gcc-plugins -name \*.so -o -name gcc-common.h) >> "$objtree/debian/hdrobjfiles"
+	(cd $objtree; find scripts/gcc-plugins -name \*.so) >> "$objtree/debian/hdrobjfiles"
 fi
 destdir=$kernel_headers_dir/usr/src/linux-headers-$version
 mkdir -p "$destdir"
-- 
2.17.1

