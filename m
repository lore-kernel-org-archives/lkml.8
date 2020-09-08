Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56B9C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0B120C09
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599592442;
	bh=hsRI/DQtIhUQiWlHw6qbEK4v7Tt/BNhJxhJm/I7Jm4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qvBEJuEGNwfuWCB22CNdzaWIDTnGYvYNWncIw7NNPr/LvIuz4MbfCi/nZqUfnkifH
	 S9RcZAYjq8b85NcXkV6eeRbmUFCQx0Mrhxf9PFDVynufQa/n3Z2cTfnut6TyQRykbw
	 tQwX0UplbPskb/+YCeFM7sJbQR6AXV4kibNpoQEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbgIHTOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731202AbgIHQEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:04:53 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE11B23BEE;
        Tue,  8 Sep 2020 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579396;
        bh=hsRI/DQtIhUQiWlHw6qbEK4v7Tt/BNhJxhJm/I7Jm4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qztjcuWZnGZP+OMsOe2shrXYbR9+4/+/AG6sLZtDU/5f6BFPkYQMCqetI6CMGEiXY
         RWnf+JFZuV/dwy8z42QjsAs/NBvx8duQyp3WSu9ci9QUx3L+sNgqq8igak++u81Cg0
         HsmQiFAH6H3CxPcFu99/H37oXnlCuaQ1vLih+ogM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 061/186] bpf: Fix a buffer out-of-bound access when filling raw_tp link_info
Date:   Tue,  8 Sep 2020 17:23:23 +0200
Message-Id: <20200908152244.620746578@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

[ Upstream commit b474959d5afda6e341a02c85f9595d85d39189ae ]

Commit f2e10bff16a0 ("bpf: Add support for BPF_OBJ_GET_INFO_BY_FD for bpf_link")
added link query for raw_tp. One of fields in link_info is to
fill a user buffer with tp_name. The Scurrent checking only
declares "ulen && !ubuf" as invalid. So "!ulen && ubuf" will be
valid. Later on, we do "copy_to_user(ubuf, tp_name, ulen - 1)" which
may overwrite user memory incorrectly.

This patch fixed the problem by disallowing "!ulen && ubuf" case as well.

Fixes: f2e10bff16a0 ("bpf: Add support for BPF_OBJ_GET_INFO_BY_FD for bpf_link")
Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/20200821191054.714731-1-yhs@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0fd80ac81f705..72e943b3bd656 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2629,7 +2629,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
 	u32 ulen = info->raw_tracepoint.tp_name_len;
 	size_t tp_len = strlen(tp_name);
 
-	if (ulen && !ubuf)
+	if (!ulen ^ !ubuf)
 		return -EINVAL;
 
 	info->raw_tracepoint.tp_name_len = tp_len + 1;
-- 
2.25.1



