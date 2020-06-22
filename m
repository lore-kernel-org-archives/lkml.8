Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184ECC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9C220716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="bsEelNyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgFVMd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:33:59 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:54294 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728226AbgFVMd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:33:57 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id D29E52E157C;
        Mon, 22 Jun 2020 15:33:54 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id tvXDMbdFDa-XriKD4Bn;
        Mon, 22 Jun 2020 15:33:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1592829234; bh=A9zAd0jKr1HJJKM0vzPcK7UnodFtieRjTMmElMPUxBU=;
        h=Message-ID:References:Date:To:From:Subject:In-Reply-To;
        b=bsEelNyo6pu+0UTIojw04wNkSSXzilBSqb+HOXjDxZEoDzE171u4gsLxUDkmvUaFf
         GEFo1kDGc8ZCSG3oHu1UfhXC1Sypd98uq4t5HgZdNAUTuOUJfQep/wE2of2G0Dkxzz
         QXgExn2gOPUOPYO+oG8g2sZnhLrzMAMQOAtsmPoc=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:14::1:13])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id hleZ2ieHdd-XrkOkvx2;
        Mon, 22 Jun 2020 15:33:53 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH 4/4] scripts/decode_stacktrace: guess path to vmlinux by
 release name
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Mon, 22 Jun 2020 15:33:53 +0300
Message-ID: <159282923334.248444.2399153100007347838.stgit@buzz>
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

Add option decode_stacktrace -r <release> to specify only release name.
This is enough to guess standard paths to vmlinux and modules:

$ echo -e 'schedule+0x0/0x0\ntap_open+0x0/0x0 [tap]' |
	./scripts/decode_stacktrace.sh -r 5.4.0-37-generic
schedule (kernel/sched/core.c:4138)
tap_open (drivers/net/tap.c:502) tap

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 scripts/decode_stacktrace.sh |   29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 7f18ac10af03..4bdcb6d8c605 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -5,14 +5,33 @@
 
 if [[ $# < 1 ]]; then
 	echo "Usage:"
-	echo "	$0 <vmlinux> [base path] [modules path]"
+	echo "	$0 -r <release> | <vmlinux> [base path] [modules path]"
 	exit 1
 fi
 
-vmlinux=$1
-basepath=${2-auto}
-modpath=$3
-release=""
+if [[ $1 == "-r" ]] ; then
+	vmlinux=""
+	basepath="auto"
+	modpath=""
+	release=$2
+
+	for fn in {,/usr/lib/debug}/boot/vmlinux-$release{,.debug} /lib/modules/$release{,/build}/vmlinux ; do
+		if [ -e "$fn" ] ; then
+			vmlinux=$fn
+			break
+		fi
+	done
+
+	if [[ $vmlinux == "" ]] ; then
+		echo "ERROR! vmlinux image for release $release is not found" >&2
+		exit 2
+	fi
+else
+	vmlinux=$1
+	basepath=${2-auto}
+	modpath=$3
+	release=""
+fi
 
 declare -A cache
 declare -A modcache

