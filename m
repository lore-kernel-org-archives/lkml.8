Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE51C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE0C22C9F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597678658;
	bh=qZCuGZZreY0kD5kUbaQ6CJlNK25aU5S6PjzyCntTlDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WbYd5OEQUBLLu9ki6Y/S7fv7Wq3b7tH4+k2B/XnonexTzNjzX6i3jvQQoPbjJtWCT
	 38LT8CIg6W7/2GzY+TkdicLC1Z9z3WeGV7+/oTJOPLqymxrfrpxburVFcaoEhBN3aB
	 aKk3DmXktiMntgMmkJp4upFE9klqaoYg8U4kTTD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbgHQPhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:37:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730273AbgHQPbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:31:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4406922B4E;
        Mon, 17 Aug 2020 15:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678274;
        bh=qZCuGZZreY0kD5kUbaQ6CJlNK25aU5S6PjzyCntTlDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZKawQYJh5rDXKUASLME32xn3KkKsHO6Nu4K0vcpJpHyUkv2jfTPxvIAqZiHH8/MhX
         VpMjNC0NCY0m2hcW9FMW9ABYtyByd8Zp+L23F5FvvKVL1Po4bzSoEMZ0Zlu4JRdewe
         KBBHRh9iYzKUKo0FqH2uqVGzWzJt4Ac2M6hA3rqY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 277/464] tools/bpftool: Fix error handing in do_skeleton()
Date:   Mon, 17 Aug 2020 17:13:50 +0200
Message-Id: <20200817143847.036709454@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 956fcfcd359512f15b19bcd157fa8206ed26605b ]

Fix pass 0 to PTR_ERR, also dump more err info using
libbpf_strerror.

Fixes: 5dc7a8b21144 ("bpftool, selftests/bpf: Embed object file inside skeleton")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Link: https://lore.kernel.org/bpf/20200717123059.29624-1-yuehaibing@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/gen.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 10de76b296ba1..540ffde0b03a3 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -305,8 +305,11 @@ static int do_skeleton(int argc, char **argv)
 	opts.object_name = obj_name;
 	obj = bpf_object__open_mem(obj_data, file_sz, &opts);
 	if (IS_ERR(obj)) {
+		char err_buf[256];
+
+		libbpf_strerror(PTR_ERR(obj), err_buf, sizeof(err_buf));
+		p_err("failed to open BPF object file: %s", err_buf);
 		obj = NULL;
-		p_err("failed to open BPF object file: %ld", PTR_ERR(obj));
 		goto out;
 	}
 
-- 
2.25.1



