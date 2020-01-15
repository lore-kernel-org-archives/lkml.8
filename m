Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7576C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF7324656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579105578;
	bh=fiQN7tX4lhgGkCMVarWJ5EYMl9/zE0hefm2D1qE3Af0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nzqdj7Mwo/ymonexqCMvhnenZlXnjedk9lZID+R+B+DGNP6DJjugKinE53sLyhAMv
	 BqMXyn5yU1GCOOQEEHkVqFOGVc/SrGQf3m0WccMIU50pRGDz1hCI3Nc6i+nszoY8Gl
	 xQztMylsiIIY6oKSrjUKRMfABnxJ5NE/IPG4ounE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgAOQ0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:26:17 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:58519 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgAOQ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:26:16 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 00FGPX3C015075;
        Thu, 16 Jan 2020 01:25:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 00FGPX3C015075
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579105535;
        bh=gFAgJ6b5Jn67RGEgm344mvWSA0S1s/Vavy96BOU0mH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYH+M0POPw02E+6JkkezXpT1uApI8FkcSricQC1Xp4gL/2Nr4MNpPE1QdXxuLKdaW
         4XYtOP/e8peEG5I48W1+/eEvabkkzSf+yKlGYVdYMwXgenjJx+u/Fq9Jz/cNKua9yH
         hmjZGz0d7x9ICJKdGQ+RceRlpPkdEh/a/VGYALjL5sCJ0t5UarILiFuhb4hAMnMpgL
         a1gi/JGjzGS/DuvfgCLfTptHB2WDD8zCLeQxCmY6ZURFgD+z7BYsLuA+d68L2JlKkP
         xv/Yds72o1z8qazNa2H+ltERz257abdJN5lSyAGactPK9Pl3+gL8eohoWN94r3R9hL
         pkg/cj6ZCOlpA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] builddeb: remove redundant $objtree/
Date:   Thu, 16 Jan 2020 01:25:25 +0900
Message-Id: <20200115162529.11089-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115162529.11089-1-masahiroy@kernel.org>
References: <20200115162529.11089-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This script works only when it is invoked in the $objtree, that is,
it is already relying on $objtree is '.'

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 scripts/package/builddeb | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 0a0a7c1447f4..9b92745bf13a 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -47,10 +47,10 @@ create_package() {
 }
 
 version=$KERNELRELEASE
-tmpdir="$objtree/debian/linux-image"
-kernel_headers_dir="$objtree/debian/linux-headers"
-libc_headers_dir="$objtree/debian/linux-libc-dev"
-dbg_dir="$objtree/debian/linux-image-dbg"
+tmpdir=debian/linux-image
+kernel_headers_dir=debian/linux-headers
+libc_headers_dir=debian/linux-libc-dev
+dbg_dir=debian/linux-image-dbg
 packagename=linux-image-$version
 kernel_headers_packagename=linux-headers-$version
 libc_headers_packagename=linux-libc-dev
@@ -77,7 +77,7 @@ esac
 BUILD_DEBUG=$(if_enabled_echo CONFIG_DEBUG_INFO Yes)
 
 # Setup the directory structure
-rm -rf "$tmpdir" "$kernel_headers_dir" "$libc_headers_dir" "$dbg_dir" $objtree/debian/files
+rm -rf "$tmpdir" "$kernel_headers_dir" "$libc_headers_dir" "$dbg_dir" debian/files
 mkdir -m 755 -p "$tmpdir/DEBIAN"
 mkdir -p "$tmpdir/lib" "$tmpdir/boot"
 mkdir -p "$kernel_headers_dir/lib/modules/$version/"
@@ -165,24 +165,24 @@ EOF
 done
 
 # Build kernel header package
-(cd $srctree; find . arch/$SRCARCH -maxdepth 1 -name Makefile\*) > "$objtree/debian/hdrsrcfiles"
-(cd $srctree; find include scripts -type f -o -type l) >> "$objtree/debian/hdrsrcfiles"
-(cd $srctree; find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform) >> "$objtree/debian/hdrsrcfiles"
-(cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f) >> "$objtree/debian/hdrsrcfiles"
+(cd $srctree; find . arch/$SRCARCH -maxdepth 1 -name Makefile\*) > debian/hdrsrcfiles
+(cd $srctree; find include scripts -type f -o -type l) >> debian/hdrsrcfiles
+(cd $srctree; find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform) >> debian/hdrsrcfiles
+(cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f) >> debian/hdrsrcfiles
 if is_enabled CONFIG_STACK_VALIDATION; then
-	echo tools/objtool/objtool >> "$objtree/debian/hdrobjfiles"
+	echo tools/objtool/objtool >> debian/hdrobjfiles
 fi
-(cd $objtree; find arch/$SRCARCH/include Module.symvers include scripts -type f) >> "$objtree/debian/hdrobjfiles"
+find arch/$SRCARCH/include Module.symvers include scripts -type f >> debian/hdrobjfiles
 if is_enabled CONFIG_GCC_PLUGINS; then
-	(cd $objtree; find scripts/gcc-plugins -name \*.so) >> "$objtree/debian/hdrobjfiles"
+	find scripts/gcc-plugins -name \*.so >> debian/hdrobjfiles
 fi
 destdir=$kernel_headers_dir/usr/src/linux-headers-$version
 mkdir -p "$destdir"
-(cd $srctree; tar -c -f - -T -) < "$objtree/debian/hdrsrcfiles" | (cd $destdir; tar -xf -)
-(cd $objtree; tar -c -f - -T -) < "$objtree/debian/hdrobjfiles" | (cd $destdir; tar -xf -)
-(cd $objtree; cp $KCONFIG_CONFIG $destdir/.config) # copy .config manually to be where it's expected to be
+(cd $srctree; tar -c -f - -T -) < debian/hdrsrcfiles | (cd $destdir; tar -xf -)
+tar -c -f - -T - < debian/hdrobjfiles | (cd $destdir; tar -xf -)
+cp $KCONFIG_CONFIG $destdir/.config # copy .config manually to be where it's expected to be
 ln -sf "/usr/src/linux-headers-$version" "$kernel_headers_dir/lib/modules/$version/build"
-rm -f "$objtree/debian/hdrsrcfiles" "$objtree/debian/hdrobjfiles"
+rm -f debian/hdrsrcfiles debian/hdrobjfiles
 
 if [ "$ARCH" != "um" ]; then
 	create_package "$kernel_headers_packagename" "$kernel_headers_dir"
-- 
2.17.1

