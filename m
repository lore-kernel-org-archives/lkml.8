Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D915BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF66F20663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593457012;
	bh=t1E3JVaFTVKNlVeXM74XVF6HIKEdKy9b6e4wFtTfKH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iDTw8suF02su1kepz9x9lZwYWmEn1fZ7OYwLCRZ8fMmFEeuYXY8T8kjcRlT56al3b
	 Yzpnv8yk87+7DXrngH+/8Y8Ma8dFU9WUOV9Qvo2/GypVVm3BmAoJ/j0l1UjTIN4CCZ
	 XX4Eb5StprAxDFuspXiIRls1XbsYa+2SCGB+oJO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgF2S4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729965AbgF2SzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:55:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BEB025562;
        Mon, 29 Jun 2020 15:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593446124;
        bh=t1E3JVaFTVKNlVeXM74XVF6HIKEdKy9b6e4wFtTfKH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SgY8p42PRpcYE8Tp0JZWg5NdWG3XG/y6e3Hbv54kk2NosfXF1Lk29ChhK8Tnq7BTA
         yL+2Pb/wXgeUR9+gub9eJU8ia6liANX/NDo+9UpasaplNzg2UMrYhbFVWidURtBbQ6
         6AKZJgbxqqadtvUNJMujye0eGQ+KzaVB2xcr1PkM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 115/135] netfilter: ipset: fix unaligned atomic access
Date:   Mon, 29 Jun 2020 11:52:49 -0400
Message-Id: <20200629155309.2495516-116-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
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
index 0583e2491770d..3231030a73edb 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -379,6 +379,8 @@ ip_set_elem_len(struct ip_set *set, struct nlattr *tb[], size_t len,
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

