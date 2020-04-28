Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0529EC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C752B208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099194;
	bh=bfMmx3fYjly39Pex01XfPoaA0tBtUA1c8xYcYUBstT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZxRge9ghJuyGEVkSQrfE5mc32kmtxYjaLNyqfc4xflZ7QN74gfMhfFxRxVdSX5TP8
	 Jin3pZbK2PfmQ0Zfc5J44cDpdtBQ8czGH9VahCBpSKuTV5yNtTxyf9r7O5owcYIW+H
	 8VnT6DrLggCbdnqPSyC6TSQyrr8ZRsfmG3lxP9+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbgD1Sjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730806AbgD1Sjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:39:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA22B20575;
        Tue, 28 Apr 2020 18:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099190;
        bh=bfMmx3fYjly39Pex01XfPoaA0tBtUA1c8xYcYUBstT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yt+7Sk6F9BzqsZEy+5ontDYeJ+Xnf5kXGRs5Wf95ROwFDCD8stLM8M+mW6KV4f4vw
         8ETGOgoUlyk0D5UEk5kvvH995sRUywhEMGOOya/k4vFV6lIEZC4KWRsTqAYJugobzb
         DB7JSw6dsnCkzE+kuKWh24ed2sBBi9c39OQZnRfQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 070/168] selftests: Fix suppress test in fib_tests.sh
Date:   Tue, 28 Apr 2020 20:24:04 +0200
Message-Id: <20200428182240.825189111@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 2c1dd4c110627c2a4f006643f074119205cfcff4 ]

fib_tests is spewing errors:
    ...
    Cannot open network namespace "ns1": No such file or directory
    Cannot open network namespace "ns1": No such file or directory
    Cannot open network namespace "ns1": No such file or directory
    Cannot open network namespace "ns1": No such file or directory
    ping: connect: Network is unreachable
    Cannot open network namespace "ns1": No such file or directory
    Cannot open network namespace "ns1": No such file or directory
    ...

Each test entry in fib_tests is supposed to do its own setup and
cleanup. Right now the $IP commands in fib_suppress_test are
failing because there is no ns1. Add the setup/cleanup and logging
expected for each test.

Fixes: ca7a03c41753 ("ipv6: do not free rt if FIB_LOOKUP_NOREF is set on suppress rule")
Signed-off-by: David Ahern <dsahern@gmail.com>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/fib_tests.sh |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -618,16 +618,22 @@ fib_nexthop_test()
 
 fib_suppress_test()
 {
+	echo
+	echo "FIB rule with suppress_prefixlength"
+	setup
+
 	$IP link add dummy1 type dummy
 	$IP link set dummy1 up
 	$IP -6 route add default dev dummy1
 	$IP -6 rule add table main suppress_prefixlength 0
-	ping -f -c 1000 -W 1 1234::1 || true
+	ping -f -c 1000 -W 1 1234::1 >/dev/null 2>&1
 	$IP -6 rule del table main suppress_prefixlength 0
 	$IP link del dummy1
 
 	# If we got here without crashing, we're good.
-	return 0
+	log_test 0 0 "FIB rule suppress test"
+
+	cleanup
 }
 
 ################################################################################


