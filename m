Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDC5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419D12083B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgGNPlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:41:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39814 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgGNPlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:41:02 -0400
Received: from 1.general.ppisati.uk.vpn ([10.172.193.134] helo=canonical.com)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <paolo.pisati@canonical.com>)
        id 1jvN39-0003Lt-JJ; Tue, 14 Jul 2020 15:40:55 +0000
From:   Paolo Pisati <paolo.pisati@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: fib_nexthop_multiprefix: fix cleanup() netns deletion
Date:   Tue, 14 Jul 2020 17:40:55 +0200
Message-Id: <20200714154055.68167-1-paolo.pisati@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During setup():
...
        for ns in h0 r1 h1 h2 h3
        do
                create_ns ${ns}
        done
...

while in cleanup():
...
        for n in h1 r1 h2 h3 h4
        do
                ip netns del ${n} 2>/dev/null
        done
...

and after removing the stderr redirection in cleanup():

$ sudo ./fib_nexthop_multiprefix.sh
...
TEST: IPv4: host 0 to host 3, mtu 1400                              [ OK ]
TEST: IPv6: host 0 to host 3, mtu 1400                              [ OK ]
Cannot remove namespace file "/run/netns/h4": No such file or directory
$ echo $?
1

and a non-zero return code, make kselftests fail (even if the test
itself is fine):

...
not ok 34 selftests: net: fib_nexthop_multiprefix.sh # exit=1
...

Signed-off-by: Paolo Pisati <paolo.pisati@canonical.com>
---
 tools/testing/selftests/net/fib_nexthop_multiprefix.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_nexthop_multiprefix.sh b/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
index 9dc35a16e415..51df5e305855 100755
--- a/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
+++ b/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
@@ -144,7 +144,7 @@ setup()
 
 cleanup()
 {
-	for n in h1 r1 h2 h3 h4
+	for n in h0 r1 h1 h2 h3
 	do
 		ip netns del ${n} 2>/dev/null
 	done
-- 
2.25.1

