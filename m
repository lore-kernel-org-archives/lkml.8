Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7CAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615E520709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860021;
	bh=BRYwBjzqPeNcYdjfaXF3xkVJMjvsS/my2E02IvspKh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CK+JREq3iZkg2jc1NBBJM7WuZsUEIC3myfVwIu5YTt2UmRvZkNYebm3xLkBBfSP5M
	 4EqhFFuAK0ONXXM5HaAMdsyiHup5t3ZQCUkMdrY8KyjHbDGHd0qGMr8Y/Y0uPhVl05
	 Nf8U7LNEUIQfpI1HpJq4SGG3CBicTGijQT2eyhu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbgAXKAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:00:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730996AbgAXKAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:00:18 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C82E20709;
        Fri, 24 Jan 2020 10:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860018;
        bh=BRYwBjzqPeNcYdjfaXF3xkVJMjvsS/my2E02IvspKh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qirtO+t7J/1nmVAD0Pp1HLdEgGWNBNpkbCM+d8UqZcUs7yOErwYdrrYP/NZSM/sdm
         a2JduIptt5Qf5g3tLOLuxNK03dfJFkNgtuajEC88DFuUVxhseBCR2PTJ1XGxeeMRnE
         CkCwELLdovjeX6rGqf1XsWNn97FEqIKae7Rmb4gs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gary R Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 217/343] crypto: ccp - Fix 3DES complaint from ccp-crypto module
Date:   Fri, 24 Jan 2020 10:30:35 +0100
Message-Id: <20200124092948.594690149@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hook, Gary <Gary.Hook@amd.com>

[ Upstream commit 89646fdda4cae203185444ac7988835f36a21ee1 ]

Crypto self-tests reveal an error:

alg: skcipher: cbc-des3-ccp encryption test failed (wrong output IV) on test vector 0, cfg="in-place"

The offset value should not be recomputed when retrieving the context.
Also, a code path exists which makes decisions based on older (version 3)
hardware; a v3 device deosn't support 3DES so remove this check.

Fixes: 990672d48515 ('crypto: ccp - Enable 3DES function on v5 CCPs')

Signed-off-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/ccp-ops.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-ops.c b/drivers/crypto/ccp/ccp-ops.c
index 1e2e42106dee0..4b48b8523a40c 100644
--- a/drivers/crypto/ccp/ccp-ops.c
+++ b/drivers/crypto/ccp/ccp-ops.c
@@ -1293,6 +1293,9 @@ static int ccp_run_des3_cmd(struct ccp_cmd_queue *cmd_q, struct ccp_cmd *cmd)
 	int ret;
 
 	/* Error checks */
+	if (cmd_q->ccp->vdata->version < CCP_VERSION(5, 0))
+		return -EINVAL;
+
 	if (!cmd_q->ccp->vdata->perform->des3)
 		return -EINVAL;
 
@@ -1375,8 +1378,6 @@ static int ccp_run_des3_cmd(struct ccp_cmd_queue *cmd_q, struct ccp_cmd *cmd)
 	 * passthru option to convert from big endian to little endian.
 	 */
 	if (des3->mode != CCP_DES3_MODE_ECB) {
-		u32 load_mode;
-
 		op.sb_ctx = cmd_q->sb_ctx;
 
 		ret = ccp_init_dm_workarea(&ctx, cmd_q,
@@ -1392,12 +1393,8 @@ static int ccp_run_des3_cmd(struct ccp_cmd_queue *cmd_q, struct ccp_cmd *cmd)
 		if (ret)
 			goto e_ctx;
 
-		if (cmd_q->ccp->vdata->version == CCP_VERSION(3, 0))
-			load_mode = CCP_PASSTHRU_BYTESWAP_NOOP;
-		else
-			load_mode = CCP_PASSTHRU_BYTESWAP_256BIT;
 		ret = ccp_copy_to_sb(cmd_q, &ctx, op.jobid, op.sb_ctx,
-				     load_mode);
+				     CCP_PASSTHRU_BYTESWAP_256BIT);
 		if (ret) {
 			cmd->engine_error = cmd_q->cmd_error;
 			goto e_ctx;
@@ -1459,10 +1456,6 @@ static int ccp_run_des3_cmd(struct ccp_cmd_queue *cmd_q, struct ccp_cmd *cmd)
 		}
 
 		/* ...but we only need the last DES3_EDE_BLOCK_SIZE bytes */
-		if (cmd_q->ccp->vdata->version == CCP_VERSION(3, 0))
-			dm_offset = CCP_SB_BYTES - des3->iv_len;
-		else
-			dm_offset = 0;
 		ccp_get_dm_area(&ctx, dm_offset, des3->iv, 0,
 				DES3_EDE_BLOCK_SIZE);
 	}
-- 
2.20.1



