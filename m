Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7B0C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF93E206B9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=national.shitposting.agency header.i=@national.shitposting.agency header.b="L3R/XOhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgDVBAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 21:00:31 -0400
Received: from mail.cock.li ([37.120.193.124]:52764 "EHLO mail.cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgDVBAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 21:00:30 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Apr 2020 21:00:28 EDT
Date:   Wed, 22 Apr 2020 02:53:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=national.shitposting.agency; s=mail; t=1587516844;
        bh=p2IreHcoWDUmk7izJSdGsrX30OxvefkCnAAQ1gbHOYA=;
        h=Date:From:Cc:Subject:From;
        b=L3R/XOhczy0Eflp52Z/rcUwoG5+NRi3Kx5edmp4VGQtvyRDtjRX7Y804A/LcjYfLG
         KqSyKzX4FMKc5dgL3W0eXehX37kUrk1vybqWMHia8/EYjNBDyBwWY5jNwy7mpl0el4
         KM0tfZ/GkShoplvpfTPZIb1Oj6iXFgQtjWEJvetr8H8pNc1nSq+et8qUkE/3m7odxI
         SipDmUSd7DXOqdd9isMCE+rofLdYvK3ertZlGNpn+E2lu2EKCy/QPqA2sJ3doIBsv7
         vGBgrX3YRqMLUQaE3N6Xd3mpGhOnmdSduEy3X5O50SQvDHZgmK8m2OMckZgVytfuH4
         AIfkDgYA6JglQ==
From:   zsugabubus <zsugabubus@national.shitposting.agency>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: fix word quoting in shell scripts
Message-ID: <20200422005359.c6vh2jblrevznjml@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous implementation did not quote some variables that could be
potentially empty, for example due to a failed compilation. It made
test(1) failing but desired error action was not taken.

Cleaning of temporary files is also been made a bit more robust.
---
 arch/ia64/scripts/check-gas       | 25 ++++++++--------
 arch/ia64/scripts/toolchain-flags | 50 ++++++++++++++-----------------
 2 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/arch/ia64/scripts/check-gas b/arch/ia64/scripts/check-gas
index 787cf9b6b..7210522e6 100755
--- a/arch/ia64/scripts/check-gas
+++ b/arch/ia64/scripts/check-gas
@@ -1,16 +1,17 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-dir=$(dirname $0)
 CC=$1
 OBJDUMP=$2
-tmp=${TMPDIR:-/tmp}
-out=$tmp/out$$.o
-$CC -c $dir/check-gas-asm.S -o $out
-res=$($OBJDUMP -r --section .data $out | fgrep 00004 | tr -s ' ' |cut -f3 -d' ')
-rm -f $out
-if [ $res != ".text" ]; then
-	echo buggy
-else
-	echo good
-fi
-exit 0
+
+cd "$(dirname $0)"
+
+tmp=${TMPDIR:-/tmp}/check-gas-$$.o
+trap 'rm -f "$tmp"' INT TERM EXIT
+
+$CC -c check-gas-asm.S -o "$tmp" &&
+$OBJDUMP -r --section .data "$tmp" \
+| fgrep 00004 | tr -s ' ' | cut -f3 -d' ' \
+| {
+  read -r section
+  [ "$section" = .text ] && echo good
+} || echo buggy
diff --git a/arch/ia64/scripts/toolchain-flags b/arch/ia64/scripts/toolchain-flags
index 12dff5c98..4bfa4d6d6 100755
--- a/arch/ia64/scripts/toolchain-flags
+++ b/arch/ia64/scripts/toolchain-flags
@@ -7,48 +7,44 @@ CPPFLAGS=""
 CC=$1
 OBJDUMP=$2
 READELF=$3
-dir=$(dirname $0)
-tmp=${TMPDIR:-/tmp}
-out=$tmp/out$$
+
+cd "$(dirname $0)"
+
+tmp=${TMPDIR:-/tmp}/toolchain-flags-$$
+trap 'rm -f "$tmp"' INT TERM EXIT
 
 # Check whether cross-segment segment-relative relocs work fine.  We need
 # that for building the gate DSO:
-
-$CC -nostdlib -static -Wl,-T$dir/check-segrel.lds $dir/check-segrel.S -o $out
-res=$($OBJDUMP --full --section .rodata $out | fgrep 000 | cut -f3 -d' ')
-rm -f $out
-if [ $res != 00000a00 ]; then
-    CPPFLAGS="$CPPFLAGS -DHAVE_BUGGY_SEGREL"
-    cat >&2 <<EOF
+$CC -nostdlib -static -Wl,-Tcheck-segrel.lds check-segrel.S -o "$tmp" &&
+$OBJDUMP --full --section .rodata "$tmp" | fgrep 000 | cut -f3 -d' ' \
+| {
+  read -r addr
+  [ "$addr" = 00000a00 ]
+} || {
+  CPPFLAGS="$CPPFLAGS -DHAVE_BUGGY_SEGREL"
+  cat >&2 <<EOF
 warning: your linker cannot handle cross-segment segment-relative relocations.
          please upgrade to a newer version (it is safe to use this linker, but
          the kernel will be bigger than strictly necessary).
 EOF
-fi
+}
 
 # Check whether .align inside a function works as expected.
-
-$CC -c $dir/check-text-align.S -o $out
-$READELF -u $out | fgrep -q 'prologue(rlen=12)'
-res=$?
-rm -f $out
-if [ $res -eq 0 ]; then
-    CPPFLAGS="$CPPFLAGS -DHAVE_WORKING_TEXT_ALIGN"
+if $CC -c check-text-align.S -o "$tmp" && \
+   $READELF -u "$tmp" | fgrep -q 'prologue(rlen=12)'
+then
+  CPPFLAGS="$CPPFLAGS -DHAVE_WORKING_TEXT_ALIGN"
 fi
 
-if ! $CC -c $dir/check-model.c -o $out 2>&1 | grep  __model__ | grep -q attrib
+if ! $CC -c check-model.c -o "$tmp" 2>&1 | grep  __model__ | grep -q attrib
 then
-    CPPFLAGS="$CPPFLAGS -DHAVE_MODEL_SMALL_ATTRIBUTE"
+  CPPFLAGS="$CPPFLAGS -DHAVE_MODEL_SMALL_ATTRIBUTE"
 fi
-rm -f $out
 
 # Check whether assembler supports .serialize.{data,instruction} directive.
-
-$CC -c $dir/check-serialize.S -o $out 2>/dev/null
-res=$?
-rm -f $out
-if [ $res -eq 0 ]; then
-    CPPFLAGS="$CPPFLAGS -DHAVE_SERIALIZE_DIRECTIVE"
+if $CC -c check-serialize.S -o "$tmp" 2>/dev/null
+then
+  CPPFLAGS="$CPPFLAGS -DHAVE_SERIALIZE_DIRECTIVE"
 fi
 
 echo $CPPFLAGS
-- 
2.26.1

