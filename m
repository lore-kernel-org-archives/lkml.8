Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D509C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B7D207C4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824564;
	bh=oiO+oGYe2TO77I0bRdx6WRJGyV4o5hYZ87yzWZ/FEvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eCarjVEQ9gRWUQvQbuNkh/c6MDthkO5QcUsPtqPXOHM7Rr9zW3GoIra1xZa2HPFbF
	 P+Fck2gCiCWQjLXXW0ncwJQ3DM6VUf0xSVzR0KK/Y4YnJNXzaN0JJqU5sRByb53qRy
	 TQLlU2FdTr9H9QzQSw9G1J6BJdbss1Nj9UKsGz5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbgERR4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731571AbgERR4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:56:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AC8620715;
        Mon, 18 May 2020 17:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824559;
        bh=oiO+oGYe2TO77I0bRdx6WRJGyV4o5hYZ87yzWZ/FEvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rbobwBJkni2iyna+ZK64Gp+x4W3bZYao2sSItBEyPeVq4YqJ7mVsM7fdByf7/Flui
         3ECBz4/KWuA09i8vp2XtYicKjhTnrlMv8kRBdodKRIjde0Va9LU8nsBROPlccJjaqp
         LcLh4qYhxU4hXvebbHaHzSKQxxztvFk+J+U+w7SY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 060/147] bpf: Fix error return code in map_lookup_and_delete_elem()
Date:   Mon, 18 May 2020 19:36:23 +0200
Message-Id: <20200518173521.476624061@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173513.009514388@linuxfoundation.org>
References: <20200518173513.009514388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 7f645462ca01d01abb94d75e6768c8b3ed3a188b ]

Fix to return negative error code -EFAULT from the copy_to_user() error
handling case instead of 0, as done elsewhere in this function.

Fixes: bd513cd08f10 ("bpf: add MAP_LOOKUP_AND_DELETE_ELEM syscall")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20200430081851.166996-1-weiyongjun1@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 14f4a76b44d5f..946cfdd3b2cc2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1146,8 +1146,10 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 	if (err)
 		goto free_value;
 
-	if (copy_to_user(uvalue, value, value_size) != 0)
+	if (copy_to_user(uvalue, value, value_size) != 0) {
+		err = -EFAULT;
 		goto free_value;
+	}
 
 	err = 0;
 
-- 
2.20.1



