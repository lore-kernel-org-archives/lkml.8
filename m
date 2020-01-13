Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2415C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF57214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578898198;
	bh=S1rP/fSqLEVdd3DZvFaqmO2ofd1WGEE6ZtTsPYB1sNk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=O52M2Jnx+wOV6n+TwdqJpreRRsGlZQ5djh4q+2xNkbN2Ok3SX8YWMkIEtdt8/bJDI
	 obsm6xtk34i/Q+w5pf5NfjyH/pYAQ7oxoaiOxS4Xtb4rvfw3mEKI+QULBWGv9MmVvt
	 eBX8QEdS9gF9QHV+QFqhWlfHTe+g3MRo3QrQHwDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgAMGt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:49:57 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:50763 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgAMGtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:49:41 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 00D6mj4u028522;
        Mon, 13 Jan 2020 15:48:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 00D6mj4u028522
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578898126;
        bh=b8gZiq2rbuCPPL1xVJ64NVCWfd5GpK5K9t6n1UkThYY=;
        h=From:To:Cc:Subject:Date:From;
        b=eoA6hhtQEJuHtfOqT5m9i7y3uM7sKEU+0toXw2yyqq0yW/wl484bTflmOnsikLRhI
         LlJYWI+CGVsXbde67SkeSGldNHUHEydWldLTuqnLzJ4EVnYjqayNeZlsT3W3t0BHm8
         xocWNayYum5F7VQLkte7XaRlEVmZlgh/PR4DjdVYMH+Rq+fQw6RqAeJx/r8zM98z9y
         dD37+f06thKqQPrcNxwwcV8byUAIoi8C3fItPVMnD0nrWc20vgAPLa22Y42YKRf6GQ
         dkqgngRCNceKDo9E54wPFnjtXm9oAXrDDr00FrzFm+s9J0HkpJANO1Yq5Vl6FAe2pw
         /e525U9l4L9dg==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] builddeb: remove unneeded files in hdrobjfiles for headers package
Date:   Mon, 13 Jan 2020 15:48:35 +0900
Message-Id: <20200113064841.3946-1-masahiroy@kernel.org>
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

