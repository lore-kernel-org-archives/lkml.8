Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E9FC10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD909208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgCKFGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:06:44 -0400
Received: from smtprelay0099.hostedemail.com ([216.40.44.99]:33780 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725813AbgCKFGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:06:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 17F48182CED2A;
        Wed, 11 Mar 2020 05:06:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: skate15_1d63d46acf10d
X-Filterd-Recvd-Size: 1923
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:06:41 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH -next 002/491] MARVELL OCTEONTX2 RVU ADMIN FUNCTION DRIVER: Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:16 -0700
Message-Id: <a110b54f4e04b43b866c9348a280c02c566769cd.1583896347.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 36953d4..01a7931 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -737,7 +737,7 @@ static int rvu_nix_aq_enq_inst(struct rvu *rvu, struct nix_aq_enq_req *req,
 		else if (req->ctype == NIX_AQ_CTYPE_MCE)
 			memcpy(mask, &req->mce_mask,
 			       sizeof(struct nix_rx_mce_s));
-		/* Fall through */
+		fallthrough;
 	case NIX_AQ_INSTOP_INIT:
 		if (req->ctype == NIX_AQ_CTYPE_RQ)
 			memcpy(ctx, &req->rq, sizeof(struct nix_rq_ctx_s));
-- 
2.24.0

