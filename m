Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E183C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 275AA2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458132;
	bh=68+LEuzRoR3ugStnHhsnfI6mCpaMtgKIP3ttLWOydd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QZevY3vtoJwTsqiW7XsQ89oBS+cam3AbpOPahez7IEkEUgEj4iQp+PpqaBJM/BUCj
	 Xvk3n1G+ai/gkGCD/3kWUqf0p6a2XTH8+hrmEUCcBB7eaubH19Lwg2Xj2jDxQbx9qI
	 fneGKEWXxtFwdNRM1RqnODFD3fPu6tunok9cQXiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgHCMfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729624AbgHCMfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:35:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 436372054F;
        Mon,  3 Aug 2020 12:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596458111;
        bh=68+LEuzRoR3ugStnHhsnfI6mCpaMtgKIP3ttLWOydd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FLFr7jXyhTaHIVrub38UxYq2rqb//aLTNyWN1N6uWhMBei4rVcADUue9zt2Tf8GTa
         WqBHN/aSrq2EZGyVjfQn3UMVnyMt0ILFp9SK+cyuRS3aEhVwZauM1ge52OH6tfB8wi
         DZvEgXG2oMFrppnqt8wIjuPSOE3hpCWqak+ns4Gc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurence Oberman <loberman@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 42/51] qed: Disable "MFW indication via attention" SPAM every 5 minutes
Date:   Mon,  3 Aug 2020 14:20:27 +0200
Message-Id: <20200803121851.619739433@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121849.488233135@linuxfoundation.org>
References: <20200803121849.488233135@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurence Oberman <loberman@redhat.com>

[ Upstream commit 1d61e21852d3161f234b9656797669fe185c251b ]

This is likely firmware causing this but its starting to annoy customers.
Change the message level to verbose to prevent the spam.
Note that this seems to only show up with ISCSI enabled on the HBA via the
qedi driver.

Signed-off-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_int.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_int.c b/drivers/net/ethernet/qlogic/qed/qed_int.c
index c5d9f290ec4c7..f8d1d02a3cd4a 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_int.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_int.c
@@ -1015,7 +1015,8 @@ static int qed_int_attentions(struct qed_hwfn *p_hwfn)
 			index, attn_bits, attn_acks, asserted_bits,
 			deasserted_bits, p_sb_attn_sw->known_attn);
 	} else if (asserted_bits == 0x100) {
-		DP_INFO(p_hwfn, "MFW indication via attention\n");
+		DP_VERBOSE(p_hwfn, NETIF_MSG_INTR,
+			   "MFW indication via attention\n");
 	} else {
 		DP_VERBOSE(p_hwfn, NETIF_MSG_INTR,
 			   "MFW indication [deassertion]\n");
-- 
2.25.1



