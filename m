Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ABCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC078206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581363;
	bh=U+JU3pulcrPnDSUFMUHuppeZgdml6VTYsuEf4BfNm28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IENlLn1CxOX2qxMHWPUx5UZcnAxhto/o/co0WuHJDEP/Tis35ZH//f0KbDvguth8+
	 R3M85D6EcBf13XzojrRJ+ljGQUB1jScOF6yrjP/wDnjD26PlIYucOc6Zw1CX8S+MmX
	 akRzJ6QI0OwCczaq46akzMQdaH0nhrreijkM6M3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392093AbgFSPml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:42:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393633AbgFSP2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:28:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4112821919;
        Fri, 19 Jun 2020 15:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580513;
        bh=U+JU3pulcrPnDSUFMUHuppeZgdml6VTYsuEf4BfNm28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5h4+87wGtENue0bBu6lzsTZl9CiW1yewL0XLTvTNFPF1q9xIxMbWift8Sm5qduYa
         uKBRiJEZD0DqDuZSJ563RCCeorAdQA0vMQfkN/xMf/jcixGHrxgGOahdgDVOpQuKr7
         2H7cLvtITBv26JmOsFOIOxoMdfQkejBfVNCZTM9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anton Protopopov <a.s.protopopov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 248/376] bpf: Fix map permissions check
Date:   Fri, 19 Jun 2020 16:32:46 +0200
Message-Id: <20200619141722.065296471@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Protopopov <a.s.protopopov@gmail.com>

[ Upstream commit 1ea0f9120c8ce105ca181b070561df5cbd6bc049 ]

The map_lookup_and_delete_elem() function should check for both FMODE_CAN_WRITE
and FMODE_CAN_READ permissions because it returns a map element to user space.

Fixes: bd513cd08f10 ("bpf: add MAP_LOOKUP_AND_DELETE_ELEM syscall")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20200527185700.14658-5-a.s.protopopov@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e6dee19a668..5e52765161f9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1468,7 +1468,8 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-	if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ) ||
+	    !(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
 		err = -EPERM;
 		goto err_put;
 	}
-- 
2.25.1



