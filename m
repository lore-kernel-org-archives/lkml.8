Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE5CC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E14720727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589482753;
	bh=GiW5jJVTAQv8wgCT0GNmmSwq7wuYgS+rkA7XRNs5qCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r4KF0wnERGVWXM9m60eSsAknF7rQF6/dte8Zhc3VYa+ZQmtgDRogSmYZu3M1JUail
	 F6o82JxSBo0MdeZP91uHBgct578JvrR/b17MhXuXY/1wlrkO8eYL9lhLdKPq79aQKH
	 X4s4c3LOyLBkzIq2PVDwwBz2+3kH16KxuGUKOKEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgENS4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:56:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729536AbgENSz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:55:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB78D2076A;
        Thu, 14 May 2020 18:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482556;
        bh=GiW5jJVTAQv8wgCT0GNmmSwq7wuYgS+rkA7XRNs5qCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h0kLCR/GOyVH4F++9DtbyjwpyATpdpMY/eP943uLI+/5KkRFczogYG2cMLolnzDZz
         SzZ8OoOStYYmql/Cctm3cZXrMMHrTGKZiWKTgrMQDbWZ8D++YFc+68Yrq3Dh7BIKiS
         UbqBiiVdB0V4fc5LyIhmDDHYj+DXFne/715Hodqk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>,
        b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 05/27] batman-adv: Fix refcnt leak in batadv_show_throughput_override
Date:   Thu, 14 May 2020 14:55:28 -0400
Message-Id: <20200514185550.21462-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185550.21462-1-sashal@kernel.org>
References: <20200514185550.21462-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

[ Upstream commit f872de8185acf1b48b954ba5bd8f9bc0a0d14016 ]

batadv_show_throughput_override() invokes batadv_hardif_get_by_netdev(),
which gets a batadv_hard_iface object from net_dev with increased refcnt
and its reference is assigned to a local pointer 'hard_iface'.

When batadv_show_throughput_override() returns, "hard_iface" becomes
invalid, so the refcount should be decreased to keep refcount balanced.

The issue happens in the normal path of
batadv_show_throughput_override(), which forgets to decrease the refcnt
increased by batadv_hardif_get_by_netdev() before the function returns,
causing a refcnt leak.

Fix this issue by calling batadv_hardif_put() before the
batadv_show_throughput_override() returns in the normal path.

Fixes: 0b5ecc6811bd ("batman-adv: add throughput override attribute to hard_ifaces")
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 31d7e239a1fd6..d3fb5396f9473 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -1120,6 +1120,7 @@ static ssize_t batadv_show_throughput_override(struct kobject *kobj,
 
 	tp_override = atomic_read(&hard_iface->bat_v.throughput_override);
 
+	batadv_hardif_put(hard_iface);
 	return sprintf(buff, "%u.%u MBit\n", tp_override / 10,
 		       tp_override % 10);
 }
-- 
2.20.1

