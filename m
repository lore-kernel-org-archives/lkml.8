Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AFAC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F83206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579105573;
	bh=EO+lbnTl8JD9KU9HVqHVfPTrZrSDTWy4iAB8c1tG5vA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kTGg+VDbftDpH4VELYQrZ7fJo4XVrp1o57tYhkxRejMGGb93HCM/JegWKiAwL1Tu5
	 0wRCUUVEpOBPMZqULXGiYPtNfs/BETXFh5sfRKSyxlhwCQC/E3iGUApW5FUjPFwYZC
	 3Ci9tt2GnCpraFLRm8g8e/dCh34ne6o48WUHbzbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgAOQ0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:26:13 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:58429 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgAOQ0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:26:11 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 00FGPX3A015075;
        Thu, 16 Jan 2020 01:25:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 00FGPX3A015075
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579105534;
        bh=fouf2erZu2zlCkdO4KBDKaCsNgyUUXqd28gkzb62sDQ=;
        h=From:To:Cc:Subject:Date:From;
        b=2jYDSnqaNaNLiGKL9a3+LeixR2nydWYpWyaOzexh5Fl4No7EzQEPBW6thW7SaE74S
         IWAKY3tIhP9MXAbLlX7jJc6COJrQeRCXcSL40kztlR8Q2dIfzTtadrlPRNk4mQJJmc
         dJZUO0CNVzs5qHlBOuvgPeBIzbV6WnWHq1xcp+HEyRv4EtHMaLQ7Qk2wpcwtvIBcIu
         Dwv+t5ctbsFQexwnjpIJIOb4YEid8YCbB49h0jr7tjRPII9WXy0Yipp6zdsXXoBNKE
         9tpo3NStFusR8Q+HoYlsLt/pwRPjB+kJdeqvQSe9qKseFY5xXR7KBUvmHLhN3aGWdk
         hErpZcH+i5DlA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] builddeb: remove unneeded files in hdrobjfiles for headers package
Date:   Thu, 16 Jan 2020 01:25:23 +0900
Message-Id: <20200115162529.11089-1-masahiroy@kernel.org>
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

Changes in v2: None

 scripts/package/builddeb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index b60388051c7f..eb067d6f1370 100755
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

