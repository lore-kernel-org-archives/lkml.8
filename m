Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B804CC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACD020738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442775;
	bh=J9F1PGeWIaH35qjWCvix8nTwa5Ul93QdffcfLkZwmJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sRZ5P0b5S/GjSupBUoedpd/FHwOq1Wx21nptUoDxEL5LrUq7mwTHgo/yCs4vnIOmg
	 pewfqz9pQ50Td70wu4LMaTsTTBR1Tygj5W3aloj8Kbxyrd7p/OvOVaIt3g/oNvPTEZ
	 5eqeNX9y2ItpqMpbCQfUpd5qIGMrWh3BpGBfhKfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgCQK7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbgCQK72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:59:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32A7220738;
        Tue, 17 Mar 2020 10:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442767;
        bh=J9F1PGeWIaH35qjWCvix8nTwa5Ul93QdffcfLkZwmJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c7ytL4NWRiVJM74KFgLDPxlydaT4EuJ7X2Wm2lYi89Nbk3PCpvJEHF7qPDTYY138G
         da7DhlNIwuhJ4CfHPSyIa6mUeZ3GkWfsPOFfu1EzLOA7lA+NL0N6aH1+xVx6MWgtOd
         coXhp9W8/Qa4/qHpXB//wjYVIX+AKx8I2Sb/ipPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 37/89] selftests/net/fib_tests: update addr_metric_test for peer route testing
Date:   Tue, 17 Mar 2020 11:54:46 +0100
Message-Id: <20200317103304.276030730@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 0d29169a708bf730ede287248e429d579f432d1d ]

This patch update {ipv4, ipv6}_addr_metric_test with
1. Set metric of address with peer route and see if the route added
correctly.
2. Modify metric and peer address for peer route and see if the route
changed correctly.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/fib_tests.sh |   34 ++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -979,6 +979,27 @@ ipv6_addr_metric_test()
 	fi
 	log_test $rc 0 "Prefix route with metric on link up"
 
+	# verify peer metric added correctly
+	set -e
+	run_cmd "$IP -6 addr flush dev dummy2"
+	run_cmd "$IP -6 addr add dev dummy2 2001:db8:104::1 peer 2001:db8:104::2 metric 260"
+	set +e
+
+	check_route6 "2001:db8:104::1 dev dummy2 proto kernel metric 260"
+	log_test $? 0 "Set metric with peer route on local side"
+	log_test $? 0 "User specified metric on local address"
+	check_route6 "2001:db8:104::2 dev dummy2 proto kernel metric 260"
+	log_test $? 0 "Set metric with peer route on peer side"
+
+	set -e
+	run_cmd "$IP -6 addr change dev dummy2 2001:db8:104::1 peer 2001:db8:104::3 metric 261"
+	set +e
+
+	check_route6 "2001:db8:104::1 dev dummy2 proto kernel metric 261"
+	log_test $? 0 "Modify metric and peer address on local side"
+	check_route6 "2001:db8:104::3 dev dummy2 proto kernel metric 261"
+	log_test $? 0 "Modify metric and peer address on peer side"
+
 	$IP li del dummy1
 	$IP li del dummy2
 	cleanup
@@ -1320,13 +1341,20 @@ ipv4_addr_metric_test()
 
 	run_cmd "$IP addr flush dev dummy2"
 	run_cmd "$IP addr add dev dummy2 172.16.104.1/32 peer 172.16.104.2 metric 260"
-	run_cmd "$IP addr change dev dummy2 172.16.104.1/32 peer 172.16.104.2 metric 261"
 	rc=$?
 	if [ $rc -eq 0 ]; then
-		check_route "172.16.104.2 dev dummy2 proto kernel scope link src 172.16.104.1 metric 261"
+		check_route "172.16.104.2 dev dummy2 proto kernel scope link src 172.16.104.1 metric 260"
+		rc=$?
+	fi
+	log_test $rc 0 "Set metric of address with peer route"
+
+	run_cmd "$IP addr change dev dummy2 172.16.104.1/32 peer 172.16.104.3 metric 261"
+	rc=$?
+	if [ $rc -eq 0 ]; then
+		check_route "172.16.104.3 dev dummy2 proto kernel scope link src 172.16.104.1 metric 261"
 		rc=$?
 	fi
-	log_test $rc 0 "Modify metric of address with peer route"
+	log_test $rc 0 "Modify metric and peer address for peer route"
 
 	$IP li del dummy1
 	$IP li del dummy2


