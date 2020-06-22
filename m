Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE63C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285C420716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ouAAR+rF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgFVMdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:33:50 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:50712 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728044AbgFVMdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:33:49 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id BED762E15E0;
        Mon, 22 Jun 2020 15:33:46 +0300 (MSK)
Received: from sas2-32987e004045.qloud-c.yandex.net (sas2-32987e004045.qloud-c.yandex.net [2a02:6b8:c08:b889:0:640:3298:7e00])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id HW0XVSmIOX-XjXq6q2p;
        Mon, 22 Jun 2020 15:33:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1592829226; bh=fvyycw4re93HVkcugbpWZ1oaVNue5Odc1T1ODvb5EyM=;
        h=Message-ID:Date:To:From:Subject;
        b=ouAAR+rF5wdOu1HwL6djC2b7CCeeKodAkhQm+wq4N7Uyt0RiG5RASQ7OXrcAzXaRR
         En5DsLTDc7iQfTO20jg9ZkB3ABcIQlmwt8olPhoc1NJg0QLunk+mR+yTtkIYh9w87G
         IS8TSNNyWvn9wJ1ovBxcpV8mmx4DPIYBqnz6KY1Q=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:14::1:13])
        by sas2-32987e004045.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id CkFvV9sfDr-Xjl8SaSZ;
        Mon, 22 Jun 2020 15:33:45 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH 1/4] scripts/decode_stacktrace: skip missing symbols
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Mon, 22 Jun 2020 15:33:45 +0300
Message-ID: <159282922499.248444.4883465570858385250.stgit@buzz>
User-Agent: StGit/0.22-39-gd257
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now script turns missing symbols into '0' and make bogus decode.
Skip them instead. Also simplify parsing output of 'nm'.

Before:

$ echo 'xxx+0x0/0x0' | ./scripts/decode_stacktrace.sh vmlinux ""
xxx (home/khlebnikov/src/linux/./arch/x86/include/asm/processor.h:398)

After:

$ echo 'xxx+0x0/0x0' | ./scripts/decode_stacktrace.sh vmlinux ""
xxx+0x0/0x0

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 scripts/decode_stacktrace.sh |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 66a6d511b524..6ec8d6dff86c 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -56,7 +56,11 @@ parse_symbol() {
 	if [[ "${cache[$module,$name]+isset}" == "isset" ]]; then
 		local base_addr=${cache[$module,$name]}
 	else
-		local base_addr=$(nm "$objfile" | grep -i ' t ' | awk "/ $name\$/ {print \$1}" | head -n1)
+		local base_addr=$(nm "$objfile" | awk '$3 == "'$name'" && ($2 == "t" || $2 == "T") {print $1; exit}')
+		if [[ $base_addr == "" ]] ; then
+			# address not found
+			return
+		fi
 		cache[$module,$name]="$base_addr"
 	fi
 	# Let's start doing the math to get the exact address into the

