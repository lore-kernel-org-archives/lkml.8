Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA60C433E4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A21208B3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457789;
	bh=I2dTzUq/9wZciNDjDhbRp5+H1zAaUup4cSjPwG9P8DI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d2JYwJOfA6c7SBTbkKGj8ou0VDQF98DTgUwsvduGn053veZ8Vtw18vKo2zOtY17wc
	 tk8s0iNrs79JoXREwkWAOH75hTgGdDk1mdMyamHL0SykMKJjZBPPe4B/8fMjLBPpAF
	 AXKO4FMn3HnhWf2UmKcPbYr7yppccLOB6QifpLdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgHCM3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728965AbgHCM3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:29:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C23B3204EC;
        Mon,  3 Aug 2020 12:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457784;
        bh=I2dTzUq/9wZciNDjDhbRp5+H1zAaUup4cSjPwG9P8DI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/MexlLfoQNbB8RxoXfu/YAxjYaThGWVOU7GdKUh4cDaN8X9UNsuF0o2D96Ut0WUE
         lEHr7px6vzHslEq8rAqQCnxJy2T0Q5iGQS/0fjFIcEKvbvA/tQ4VXKJIr8wfRMFrSS
         wkf9gOQWWr/4+Dkl35fM4eaW+vc7ApD9os9hxJBc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Pisati <paolo.pisati@canonical.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 73/90] selftests: net: ip_defrag: modprobe missing nf_defrag_ipv6 support
Date:   Mon,  3 Aug 2020 14:19:35 +0200
Message-Id: <20200803121901.147778151@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Pisati <paolo.pisati@canonical.com>

[ Upstream commit aba69d49fb49c9166596dd78926514173b7f9ab5 ]

Fix ip_defrag.sh when CONFIG_NF_DEFRAG_IPV6=m:

$ sudo ./ip_defrag.sh
+ set -e
+ mktemp -u XXXXXX
+ readonly NETNS=ns-rGlXcw
+ trap cleanup EXIT
+ setup
+ ip netns add ns-rGlXcw
+ ip -netns ns-rGlXcw link set lo up
+ ip netns exec ns-rGlXcw sysctl -w net.ipv4.ipfrag_high_thresh=9000000
+ ip netns exec ns-rGlXcw sysctl -w net.ipv4.ipfrag_low_thresh=7000000
+ ip netns exec ns-rGlXcw sysctl -w net.ipv4.ipfrag_time=1
+ ip netns exec ns-rGlXcw sysctl -w net.ipv6.ip6frag_high_thresh=9000000
+ ip netns exec ns-rGlXcw sysctl -w net.ipv6.ip6frag_low_thresh=7000000
+ ip netns exec ns-rGlXcw sysctl -w net.ipv6.ip6frag_time=1
+ ip netns exec ns-rGlXcw sysctl -w net.netfilter.nf_conntrack_frag6_high_thresh=9000000
+ cleanup
+ ip netns del ns-rGlXcw

$ ls -la /proc/sys/net/netfilter/nf_conntrack_frag6_high_thresh
ls: cannot access '/proc/sys/net/netfilter/nf_conntrack_frag6_high_thresh': No such file or directory

$ sudo modprobe nf_defrag_ipv6
$ ls -la /proc/sys/net/netfilter/nf_conntrack_frag6_high_thresh
-rw-r--r-- 1 root root 0 Jul 14 12:34 /proc/sys/net/netfilter/nf_conntrack_frag6_high_thresh

Signed-off-by: Paolo Pisati <paolo.pisati@canonical.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/ip_defrag.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/ip_defrag.sh b/tools/testing/selftests/net/ip_defrag.sh
index 15d3489ecd9ce..ceb7ad4dbd945 100755
--- a/tools/testing/selftests/net/ip_defrag.sh
+++ b/tools/testing/selftests/net/ip_defrag.sh
@@ -6,6 +6,8 @@
 set +x
 set -e
 
+modprobe -q nf_defrag_ipv6
+
 readonly NETNS="ns-$(mktemp -u XXXXXX)"
 
 setup() {
-- 
2.25.1



