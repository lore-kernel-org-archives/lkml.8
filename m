Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC7AC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61EA24699
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844551;
	bh=kFPwuE5ZqLxEVxKWnapOEi+Fe0RnV174k4NEdaYdxBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bb/jJOoDF57UoneK6kPTQSz/BRUUCNl2lbBPKy6WmhiBbERNkNX0PN2WB4FgSB6ty
	 zPWWbrF9VRbNUQqaPxwqp99xF9TL2K6M0BsACBTL/JGe8dgjj0XpSIQdbe3gh3yORF
	 8NixbjPv9Y4iE95jxScOPAkZVgTCjLikVQb0BexU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgCJMtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:49:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbgCJMtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:49:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B7572468E;
        Tue, 10 Mar 2020 12:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844543;
        bh=kFPwuE5ZqLxEVxKWnapOEi+Fe0RnV174k4NEdaYdxBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xv1Siim9gXC+jZm43+zFS3YAK60C1JsWO1vsueGUhUH5GNXxLlxee0QyB5FOeKY2V
         DDCrj35qKSV8T4cbQQF1HIB6I9+1hFDhwMzQ3+dc+2FsLHQ4vzNXUS9sQlD/M/ZRQX
         +9CQKB0ouNvxKxZWfH9c0gyliljrhaMI4+p78ZZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 009/168] RDMA/core: Fix use of logical OR in get_new_pps
Date:   Tue, 10 Mar 2020 13:37:35 +0100
Message-Id: <20200310123636.744134940@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 4ca501d6aaf21de31541deac35128bbea8427aa6 ]

Clang warns:

../drivers/infiniband/core/security.c:351:41: warning: converting the
enum constant to a boolean [-Wint-in-bool-context]
        if (!(qp_attr_mask & (IB_QP_PKEY_INDEX || IB_QP_PORT)) && qp_pps) {
                                               ^
1 warning generated.

A bitwise OR should have been used instead.

Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in get_pkey_idx_qp_list")
Link: https://lore.kernel.org/r/20200217204318.13609-1-natechancellor@gmail.com
Link: https://github.com/ClangBuiltLinux/linux/issues/889
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index 9e27ca18d3270..2d5608315dc80 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -352,7 +352,7 @@ static struct ib_ports_pkeys *get_new_pps(const struct ib_qp *qp,
 	if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask & IB_QP_PORT))
 		new_pps->main.state = IB_PORT_PKEY_VALID;
 
-	if (!(qp_attr_mask & (IB_QP_PKEY_INDEX || IB_QP_PORT)) && qp_pps) {
+	if (!(qp_attr_mask & (IB_QP_PKEY_INDEX | IB_QP_PORT)) && qp_pps) {
 		new_pps->main.port_num = qp_pps->main.port_num;
 		new_pps->main.pkey_index = qp_pps->main.pkey_index;
 		if (qp_pps->main.state != IB_PORT_PKEY_NOT_VALID)
-- 
2.20.1



