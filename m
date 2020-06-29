Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310E4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06786206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466475;
	bh=2wW1ZablLRZ2EYClWlZMOab5AEpw4UtTQ2CXvTCt/20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DlYkCJJ5JtQy7baU2qtQobVI7ulMNLWYnCK4GcEyep4gCBrbP+rWRkQPRB3G2rXqN
	 OLeIFps5YoC80JpFAgJXxFr773Lv5slFZUOsp2AVJLeXhCjyN8xlotyNpdtYi4LmKA
	 H2cqWKwYl4Dh54X/4wpW3eXG34OnhDJi8pDjZj5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390798AbgF2Vee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbgF2Sk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 015DA23ED0;
        Mon, 29 Jun 2020 15:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593443904;
        bh=2wW1ZablLRZ2EYClWlZMOab5AEpw4UtTQ2CXvTCt/20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bH6ZZnqZiAxhAmTEsCdTDc+7aZrLQJtvGI/OtaK0wVEUkyJO5mLfJeVMPRzdCYM4Q
         hbDa0cn9mic0ZsQjo7xxZ82xLEeyqIeZaV8ChMzeB/L0xShCmi2r1dVaLfOxPqKpe5
         VoohpH3uuLRrTPHU/CBj2uhABMnigOKsyt6cJyqQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gaurav Singh <gaurav1086@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.7 004/265] ethtool: Fix check in ethtool_rx_flow_rule_create
Date:   Mon, 29 Jun 2020 11:13:57 -0400
Message-Id: <20200629151818.2493727-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaurav Singh <gaurav1086@gmail.com>

[ Upstream commit 21a739c64d3e9871186483a0cc3e7b52638c3d59 ]

Fix check in ethtool_rx_flow_rule_create

Fixes: eca4205f9ec3 ("ethtool: add ethtool_rx_flow_spec to flow_rule structure translator")
Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ethtool/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 89d0b1827aaff..d3eeeb26396cd 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2957,7 +2957,7 @@ ethtool_rx_flow_rule_create(const struct ethtool_rx_flow_spec_input *input)
 			       sizeof(match->mask.ipv6.dst));
 		}
 		if (memcmp(v6_m_spec->ip6src, &zero_addr, sizeof(zero_addr)) ||
-		    memcmp(v6_m_spec->ip6src, &zero_addr, sizeof(zero_addr))) {
+		    memcmp(v6_m_spec->ip6dst, &zero_addr, sizeof(zero_addr))) {
 			match->dissector.used_keys |=
 				BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS);
 			match->dissector.offset[FLOW_DISSECTOR_KEY_IPV6_ADDRS] =
-- 
2.25.1

