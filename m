Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D58C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A6C20575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588100131;
	bh=zh32gu6edzyBPgmvjXBu7eEBDvax85StJXrJqTDHdcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vzI8dLLnNd/FcL6anyLbgbB0aFGxpQYo8BTD3izwtIGFR2qTzqXIwHx55Gq52c9r9
	 RDYAm+enJNKUw3gE6f0TMpM9EIuvf5qCoHks7Ahh1xgdmG4Us5wi4YaULvTjWWlXLG
	 dLnDfO0FHxB6i4hXMqJ59Ygg7/UmwJLmP5+eXIZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgD1Sza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbgD1Scd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:32:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07EDF21707;
        Tue, 28 Apr 2020 18:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098753;
        bh=zh32gu6edzyBPgmvjXBu7eEBDvax85StJXrJqTDHdcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YGXDb7w5/7NsroINKJ3O44uYiYFi0HCB+StcUOcoIRRtHnKWeYm3V+/Pv+lg+Qt2P
         A1Y1/ktZdsMlyMV+WRRrEjSAXX/p3Y2sS733V4sOZ0pK6ua2YjOyNXBI8kqTWireTS
         Opi5z3SXeoV5GT9OR4nM//bLSmw8z8XTigE4QLmk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrey Ignatov <rdna@fb.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 080/167] libbpf: Only check mode flags in get_xdp_id
Date:   Tue, 28 Apr 2020 20:24:16 +0200
Message-Id: <20200428182235.076509927@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 257d7d4f0e69f5e8e3d38351bdcab896719dba04 ]

The commit in the Fixes tag changed get_xdp_id to only return prog_id
if flags is 0, but there are other XDP flags than the modes - e.g.,
XDP_FLAGS_UPDATE_IF_NOEXIST. Since the intention was only to look at
MODE flags, clear other ones before checking if flags is 0.

Fixes: f07cbad29741 ("libbpf: Fix bpf_get_link_xdp_id flags handling")
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrey Ignatov <rdna@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index 6d47345a310bd..c364e4be5e6eb 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -289,6 +289,8 @@ int bpf_get_link_xdp_info(int ifindex, struct xdp_link_info *info,
 
 static __u32 get_xdp_id(struct xdp_link_info *info, __u32 flags)
 {
+	flags &= XDP_FLAGS_MODES;
+
 	if (info->attach_mode != XDP_ATTACHED_MULTI && !flags)
 		return info->prog_id;
 	if (flags & XDP_FLAGS_DRV_MODE)
-- 
2.20.1



