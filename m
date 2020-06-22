Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93E6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D2220716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="upRPggFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgFVMd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgFVMdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:33:55 -0400
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C542C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 05:33:55 -0700 (PDT)
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 386402E1570;
        Mon, 22 Jun 2020 15:33:52 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id GGoBXLwOKV-Xpii0A77;
        Mon, 22 Jun 2020 15:33:52 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1592829232; bh=qYRn0I4QZHkgYpMxlwruar2vZfIbydT7OY976zSCbPQ=;
        h=Message-ID:References:Date:To:From:Subject:In-Reply-To;
        b=upRPggFPnr5+EjWgCv12VpHCCo6e9ltWYvpkLyj/N0JIX3L0GXtFY4ArR2pDoKChz
         /A39l4scTpywsyz0/Gx5+W0a/ockhn7dONB2i2vqEbt2/Lhqlrt4BCZWpNL4thCcZb
         oMthcBvFNUS8mS69SZz6eU37ElICAjrJhEzkc0uE=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:14::1:13])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id lTGM00DLDB-Xoka2Bjn;
        Mon, 22 Jun 2020 15:33:50 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH 3/4] scripts/decode_stacktrace: guess path to modules
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Mon, 22 Jun 2020 15:33:50 +0300
Message-ID: <159282923068.248444.5461337458421616083.stgit@buzz>
In-Reply-To: <159282922499.248444.4883465570858385250.stgit@buzz>
References: <159282922499.248444.4883465570858385250.stgit@buzz>
User-Agent: StGit/0.22-39-gd257
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to find module in directory with vmlinux (for fresh build).
Then try standard paths where debuginfo are usually placed.
Pick first file which have elf section '.debug_line'.

Before:

$ echo 'tap_open+0x0/0x0 [tap]' |
  ./scripts/decode_stacktrace.sh /usr/lib/debug/boot/vmlinux-5.4.0-37-generic
WARNING! Modules path isn't set, but is needed to parse this symbol
tap_open+0x0/0x0 tap

After:

$ echo 'tap_open+0x0/0x0 [tap]' |
  ./scripts/decode_stacktrace.sh /usr/lib/debug/boot/vmlinux-5.4.0-37-generic
tap_open (drivers/net/tap.c:502) tap

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 scripts/decode_stacktrace.sh |   36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index b1b85a7b2115..7f18ac10af03 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -12,9 +12,40 @@ fi
 vmlinux=$1
 basepath=${2-auto}
 modpath=$3
+release=""
+
 declare -A cache
 declare -A modcache
 
+find_module() {
+	if [[ "$modpath" != "" ]] ; then
+		for fn in $(find "$modpath" -name "${module//_/[-_]}.ko*") ; do
+			if readelf -WS "$fn" | grep -qwF .debug_line ; then
+				echo $fn
+				return
+			fi
+		done
+		return 1
+	fi
+
+	modpath=$(dirname "$vmlinux")
+	find_module && return
+
+	if [[ $release == "" ]] ; then
+		release=$(gdb -ex 'print init_uts_ns.name.release' -ex 'quit' -quiet -batch "$vmlinux" | sed -n 's/\$1 = "\(.*\)".*/\1/p')
+	fi
+
+	for dn in {/usr/lib/debug,}/lib/modules/$release ; do
+		if [ -e "$dn" ] ; then
+			modpath="$dn"
+			find_module && return
+		fi
+	done
+
+	modpath=""
+	return 1
+}
+
 parse_symbol() {
 	# The structure of symbol at this point is:
 	#   ([name]+[offset]/[total length])
@@ -27,12 +58,11 @@ parse_symbol() {
 	elif [[ "${modcache[$module]+isset}" == "isset" ]]; then
 		local objfile=${modcache[$module]}
 	else
-		if [[ $modpath == "" ]]; then
+		local objfile=$(find_module)
+		if [[ $objfile == "" ]] ; then
 			echo "WARNING! Modules path isn't set, but is needed to parse this symbol" >&2
 			return
 		fi
-		local objfile=$(find "$modpath" -name "${module//_/[-_]}.ko*" -print -quit)
-		[[ $objfile == "" ]] && return
 		modcache[$module]=$objfile
 	fi
 

