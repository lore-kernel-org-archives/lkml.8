Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB794C35241
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 04:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFC92072C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 04:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579925599;
	bh=SYeTX+PqU+P+ZCKuAYOp98NXw6qAemwsQeMBd6kxEO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YFBPWRmvf/CKSGvhRhnIHkaKmTSfEZrtT5DaUHTP6VaMs3LrQPmHIP9ZFZAYzp4B7
	 dXRZA+f87eKM3fG0AALujQsKu/oT9+smouvZbBJH4HbH/XoexEkhsL8P4U0JQIZ4Q1
	 83mDTXBkUBbUx3nmNiDxNjmUd48iuDdb6uOOlon4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgAYENS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 23:13:18 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:28283 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAYENO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 23:13:14 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 00P4CcjU032210;
        Sat, 25 Jan 2020 13:12:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 00P4CcjU032210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579925561;
        bh=HYAKUp6qSuTf3zs3jQ3kzK92dAW45rJ8WzZQ2aLc2co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MwyuSZU+2Nnb2GFmp3L+6xjFm5z95hUsk5KemWOzetJbNx8Lwn/T5ouoI2/i7dHTT
         g0clURqojp9Mxf/nwoqQloI6pkr3Y9OuoJaJ4Xn67KiW6f4p1Gy8rZcmy+0PDC8fau
         wlZbVLJSMq060ylgzTgFka5oTqquvzgFwBQ4JsT+rs3QXkzy3RkFpBOqkOpJjgD8Q5
         qrCLkO6o1ZCmGw68hc4TJBLo5WwuSX2dBPjS6YrbkSYoVCaHlrnpuwP4XwDPUw9czJ
         o26odSB/TUuv5NYYG7UxbkL7PisC580n76GpGkNlV7dlCejtav/ULtFUbnqUsahl+E
         Za5ZtecZ/u8SQ==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v3 4/7] builddeb: avoid invoking sub-shells where possible
Date:   Sat, 25 Jan 2020 13:12:32 +0900
Message-Id: <20200125041235.8856-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200125041235.8856-1-masahiroy@kernel.org>
References: <20200125041235.8856-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commands surrounded by ( ... ) is run in a sub-shell, but you do
not have to spawn a sub-shell for every single line.

Use just one ( ... ) for creating debian/hdrsrcfiles.

For tar, use -C option instead.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v3:
 - fix more misconversion

Changes in v2:
 - fix misconversion pointed out by Ben

 scripts/package/builddeb | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 15a76817e4ac..a73e0d5377e9 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -165,21 +165,30 @@ EOF
 done
 
 # Build kernel header package
-(cd $srctree; find . arch/$SRCARCH -maxdepth 1 -name Makefile\*) > debian/hdrsrcfiles
-(cd $srctree; find include scripts -type f -o -type l) >> debian/hdrsrcfiles
-(cd $srctree; find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform) >> debian/hdrsrcfiles
-(cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f) >> debian/hdrsrcfiles
-if is_enabled CONFIG_STACK_VALIDATION; then
-	echo tools/objtool/objtool >> debian/hdrobjfiles
-fi
-find arch/$SRCARCH/include Module.symvers include scripts -type f >> debian/hdrobjfiles
-if is_enabled CONFIG_GCC_PLUGINS; then
-	find scripts/gcc-plugins -name \*.so >> debian/hdrobjfiles
-fi
+(
+	cd $srctree
+	find . arch/$SRCARCH -maxdepth 1 -name Makefile\*
+	find include scripts -type f -o -type l
+	find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform
+	find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f
+) > debian/hdrsrcfiles
+
+{
+	if is_enabled CONFIG_STACK_VALIDATION; then
+		echo tools/objtool/objtool
+	fi
+
+	find arch/$SRCARCH/include Module.symvers include scripts -type f
+
+	if is_enabled CONFIG_GCC_PLUGINS; then
+		find scripts/gcc-plugins -name \*.so
+	fi
+} > debian/hdrobjfiles
+
 destdir=$kernel_headers_dir/usr/src/linux-headers-$version
 mkdir -p "$destdir"
-(cd $srctree; tar -c -f - -T -) < debian/hdrsrcfiles | (cd $destdir; tar -xf -)
-tar -c -f - -T - < debian/hdrobjfiles | (cd $destdir; tar -xf -)
+tar -c -f - -C $srctree -T debian/hdrsrcfiles | tar -xf - -C $destdir
+tar -c -f - -T debian/hdrobjfiles | tar -xf - -C $destdir
 cp $KCONFIG_CONFIG $destdir/.config # copy .config manually to be where it's expected to be
 ln -sf "/usr/src/linux-headers-$version" "$kernel_headers_dir/lib/modules/$version/build"
 rm -f debian/hdrsrcfiles debian/hdrobjfiles
-- 
2.17.1

