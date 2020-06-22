Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2FAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3797120716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="U6DfDEq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgFVMdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgFVMdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:33:52 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E269C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 05:33:52 -0700 (PDT)
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 775B02E155D;
        Mon, 22 Jun 2020 15:33:49 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id ECjH23KgHz-XmaWJMGG;
        Mon, 22 Jun 2020 15:33:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1592829229; bh=mK+g03fVwj0jzU22S9yPTNGpUpPC10EpoJBdwk9JdEc=;
        h=Message-ID:References:Date:To:From:Subject:In-Reply-To;
        b=U6DfDEq2cscfPN2gk6XxwElUWQuwEWyQC/pPGZT2tfdmTFH1w/QdOB5NnpKw+4cnc
         SnulZ0MTM8vNqQ8OFePhqlD3GdPsJlt8xZefTuSGwV0w1zi+AKJm447Te/FFhb0Xji
         lOcgZRES+mftKo9dM94qujqBupPZpKdcte5KYEiU=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:14::1:13])
        by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id bm7jXTbos2-XmkWwdd1;
        Mon, 22 Jun 2020 15:33:48 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH 2/4] scripts/decode_stacktrace: guess basepath if not
 specified
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Mon, 22 Jun 2020 15:33:48 +0300
Message-ID: <159282922803.248444.2379229451667913634.stgit@buzz>
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

Guess path to kernel sources using known location of symbol "kernel_init".
Make basepath argument optional.

Before:

$ echo 'vfs_open+0x0/0x0' | ./scripts/decode_stacktrace.sh vmlinux ""
vfs_open (home/khlebnikov/src/linux/fs/open.c:912)

After:

$ echo 'vfs_open+0x0/0x0' | ./scripts/decode_stacktrace.sh vmlinux
vfs_open (fs/open.c:912)

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 scripts/decode_stacktrace.sh |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 6ec8d6dff86c..b1b85a7b2115 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -3,14 +3,14 @@
 # (c) 2014, Sasha Levin <sasha.levin@oracle.com>
 #set -x
 
-if [[ $# < 2 ]]; then
+if [[ $# < 1 ]]; then
 	echo "Usage:"
-	echo "	$0 [vmlinux] [base path] [modules path]"
+	echo "	$0 <vmlinux> [base path] [modules path]"
 	exit 1
 fi
 
 vmlinux=$1
-basepath=$2
+basepath=${2-auto}
 modpath=$3
 declare -A cache
 declare -A modcache
@@ -152,6 +152,14 @@ handle_line() {
 	echo "${words[@]}" "$symbol $module"
 }
 
+if [[ $basepath == "auto" ]] ; then
+	module=""
+	symbol="kernel_init+0x0/0x0"
+	parse_symbol
+	basepath=${symbol#kernel_init (}
+	basepath=${basepath%/init/main.c:*)}
+fi
+
 while read line; do
 	# Let's see if we have an address in the line
 	if [[ $line =~ \[\<([^]]+)\>\] ]] ||

