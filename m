Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013D3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6A5204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457601;
	bh=LkmYfpO8CCHqVPPYGJEJrOUiJmWXY43q7bamRMNf8qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NqS+Cc6TesopWXa1JW+oUKq/hAdATUFflOp0THNyO4jrQD5xEf/wSesNjemI5R2Db
	 tLb54sBEhuNGvHHkDcfCzecncVHm0L471VhDCgBN+svFwkrQ7u2NGWuvt/sTUjaAwe
	 vFPczCyFZvSEvdiWNcIlKecfW5Z4MjxKeEbvkS2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgHCM0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgHCM0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:26:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC341207FB;
        Mon,  3 Aug 2020 12:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457592;
        bh=LkmYfpO8CCHqVPPYGJEJrOUiJmWXY43q7bamRMNf8qU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDajc0Z7NDs01zI2U/xMIjQFMIZqf0IG9mb0Aex8Bh71d8wf5BYIEiw7LP1FdBk+7
         p1xco8BZwS7stBrXqm2nGlMWqjRwTGQ+vsfv14CqO/AwdDzSHqIxmR7wpcecv+AdQI
         rKjDPWKKOp6mG9x+J2RzVGuCj/oqnjVspav/gwCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Pisati <paolo.pisati@canonical.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 097/120] selftests: fib_nexthop_multiprefix: fix cleanup() netns deletion
Date:   Mon,  3 Aug 2020 14:19:15 +0200
Message-Id: <20200803121907.638269762@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121902.860751811@linuxfoundation.org>
References: <20200803121902.860751811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Pisati <paolo.pisati@canonical.com>

[ Upstream commit 651149f60376758a4759f761767965040f9e4464 ]

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
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/fib_nexthop_multiprefix.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_nexthop_multiprefix.sh b/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
index 9dc35a16e4159..51df5e305855a 100755
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



