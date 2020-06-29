Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC36C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B431207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461160;
	bh=nLNVnUkhRI/NJ1/56ogLVmoCKmOrnZaaRd6qx79OxKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xvY/BJc45EyAw6pj2xbpeqiceQZl7j8xX1io8Tz84IIzX5lLjlH9dG3UX7GzoUaSc
	 PXt0a+4qgAHIru6jkQ3le499H7xXtMjlRrYvTMl+ihcqQlwjKXFyb/o7HKHgORcUXL
	 eV51tVJixBopXK5pWGKMaaap6uJBPl+uWhtwM+E4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbgF2UF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732962AbgF2Ta2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 347C02531B;
        Mon, 29 Jun 2020 15:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445148;
        bh=nLNVnUkhRI/NJ1/56ogLVmoCKmOrnZaaRd6qx79OxKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NFU/HkvSvv5Fr3+W0fMMw9pRK6gyek6rpVpPu47k2iNfrQ/ScN7xq4Zpjr1XXBwGK
         t+QrAOdIEQv3k6D431B7NRb3McKe2MBHEAT9Yzx8jh/5Ifv/FPUtOOd766IqJ4Xco6
         XKdf2ZsIshUa8CGQiHlxymAWBs6wcov4+Qaoqp6c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 51/78] netfilter: ipset: fix unaligned atomic access
Date:   Mon, 29 Jun 2020 11:37:39 -0400
Message-Id: <20200629153806.2494953-52-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153806.2494953-1-sashal@kernel.org>
References: <20200629153806.2494953-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.186-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.186-rc1
X-KernelTest-Deadline: 2020-07-01T15:38+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 715028460082d07a7ec6fcd87b14b46784346a72 ]

When using ip_set with counters and comment, traffic causes the kernel
to panic on 32-bit ARM:

Alignment trap: not handling instruction e1b82f9f at [<bf01b0dc>]
Unhandled fault: alignment exception (0x221) at 0xea08133c
PC is at ip_set_match_extensions+0xe0/0x224 [ip_set]

The problem occurs when we try to update the 64-bit counters - the
faulting address above is not 64-bit aligned.  The problem occurs
due to the way elements are allocated, for example:

	set->dsize = ip_set_elem_len(set, tb, 0, 0);
	map = ip_set_alloc(sizeof(*map) + elements * set->dsize);

If the element has a requirement for a member to be 64-bit aligned,
and set->dsize is not a multiple of 8, but is a multiple of four,
then every odd numbered elements will be misaligned - and hitting
an atomic64_add() on that element will cause the kernel to panic.

ip_set_elem_len() must return a size that is rounded to the maximum
alignment of any extension field stored in the element.  This change
ensures that is the case.

Fixes: 95ad1f4a9358 ("netfilter: ipset: Fix extension alignment")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipset/ip_set_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index c2b21c9c12295..5c59bbad8d193 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -381,6 +381,8 @@ ip_set_elem_len(struct ip_set *set, struct nlattr *tb[], size_t len,
 	for (id = 0; id < IPSET_EXT_ID_MAX; id++) {
 		if (!add_extension(id, cadt_flags, tb))
 			continue;
+		if (align < ip_set_extensions[id].align)
+			align = ip_set_extensions[id].align;
 		len = ALIGN(len, ip_set_extensions[id].align);
 		set->offset[id] = len;
 		set->extensions |= ip_set_extensions[id].type;
-- 
2.25.1

