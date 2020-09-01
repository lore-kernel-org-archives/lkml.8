Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCC4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E6720767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598977493;
	bh=suhF0qwwSU0yECNHcaKgTLO11nlKyMh0NmEMGkWs6+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gne1k9nZNoMzoJwVPoyAjUMVyUoE+ZoJcM6IRUtHXv7X0rMNe3F5lQ+4cmLQmgt42
	 xsUn9Pt2A+DCQCrs5s3o7qbsCIJo6TN/zQRuMZgHcFjtfcMd9dYyipCDs9Hz39Pu/i
	 afosHfdN8xtCTosUseBUkIrgZpyUrhxnTQMHfsEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbgIAQYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730572AbgIAPcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:32:11 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF12205F4;
        Tue,  1 Sep 2020 15:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974330;
        bh=suhF0qwwSU0yECNHcaKgTLO11nlKyMh0NmEMGkWs6+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ozNcCFvKLC05OAO1m3F4dnyhAMqYtDjp6QJXO4Kqf+AWSb0PsfpTvy2e7zYftENem
         W6IA0iNkqLnZmyGdbiW4RsG67g2hyL9QhsoSAOKlI/gK2oYY/28GsfjkQ11DDtuA4R
         M6KJ8k6ZDIu/tOW/8HjJvrCGJUi+y5ClLgFW0Iiw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 135/214] selftests: disable rp_filter for icmp_redirect.sh
Date:   Tue,  1 Sep 2020 17:10:15 +0200
Message-Id: <20200901150959.448195977@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@kernel.org>

[ Upstream commit bcf7ddb0186d366f761f86196b480ea6dd2dc18c ]

h1 is initially configured to reach h2 via r1 rather than the
more direct path through r2. If rp_filter is set and inherited
for r2, forwarding fails since the source address of h1 is
reachable from eth0 vs the packet coming to it via r1 and eth1.
Since rp_filter setting affects the test, explicitly reset it.

Signed-off-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/icmp_redirect.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/icmp_redirect.sh b/tools/testing/selftests/net/icmp_redirect.sh
index 18c5de53558af..bf361f30d6ef9 100755
--- a/tools/testing/selftests/net/icmp_redirect.sh
+++ b/tools/testing/selftests/net/icmp_redirect.sh
@@ -180,6 +180,8 @@ setup()
 			;;
 		r[12]) ip netns exec $ns sysctl -q -w net.ipv4.ip_forward=1
 		       ip netns exec $ns sysctl -q -w net.ipv4.conf.all.send_redirects=1
+		       ip netns exec $ns sysctl -q -w net.ipv4.conf.default.rp_filter=0
+		       ip netns exec $ns sysctl -q -w net.ipv4.conf.all.rp_filter=0
 
 		       ip netns exec $ns sysctl -q -w net.ipv6.conf.all.forwarding=1
 		       ip netns exec $ns sysctl -q -w net.ipv6.route.mtu_expires=10
-- 
2.25.1



