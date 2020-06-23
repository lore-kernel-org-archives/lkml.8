Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB977C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B9221527
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943283;
	bh=R4gC8Std6+0cBF63AiYHIBg/fdvklqlY1l8m+PkvrKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2LrTFcyk6JBz/vE/D4PKxsMZ0dZL1Wat4sz47hFcPVbuDo8pdkh5uxzvAVXP+XMqb
	 FBxlU7KkrEpErR2F1qosabVtYyionMutI8eZymoGRzXXXt5hb4wuGankj7nuldhWpm
	 GWfREaeS8Md11RQ1SsUC9DXKKL3J5n6fANj17lr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389219AbgFWUOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:14:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389203AbgFWUOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:14:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C50920E65;
        Tue, 23 Jun 2020 20:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943270;
        bh=R4gC8Std6+0cBF63AiYHIBg/fdvklqlY1l8m+PkvrKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a4eP0hMjY3ussb3pK3hmAKOENkUIyBdu2I/pjpnPE0Xyp6BX6+GVxViHYkvN8Teev
         www2LMei4kC51j0HJD5b3WpVZuGysl070+y1MeOQj8B6OgxGEY6PC459ajXjJrjQDJ
         Eq5dKLlfm7+F2unJUS1BeiwWEMH+gE25xxZMJNMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 326/477] bpf: Fix an error code in check_btf_func()
Date:   Tue, 23 Jun 2020 21:55:23 +0200
Message-Id: <20200623195422.945688879@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit e7ed83d6fa1a00d0f2ad0327e73d3ea9e7ea8de1 ]

This code returns success if the "info_aux" allocation fails but it
should return -ENOMEM.

Fixes: 8c1b6e69dcc1 ("bpf: Compare BTF types of functions arguments with actual types")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Song Liu <songliubraving@fb.com>
Link: https://lore.kernel.org/bpf/20200604085436.GA943001@mwanda
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index efe14cf24bc65..739d9ba3ba6b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7366,7 +7366,7 @@ static int check_btf_func(struct bpf_verifier_env *env,
 	const struct btf *btf;
 	void __user *urecord;
 	u32 prev_offset = 0;
-	int ret = 0;
+	int ret = -ENOMEM;
 
 	nfuncs = attr->func_info_cnt;
 	if (!nfuncs)
-- 
2.25.1



