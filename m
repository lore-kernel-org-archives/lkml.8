Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE99EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 713CF2173E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597680025;
	bh=sXtgcI/FlirC232oacrQyf899CGFW8M7zfPMnh/iWzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bfVY9Vuw0sbDhzdP8TXH7tEIWPfAtHDlOI/hyxISolZxew8PEVVqi4MAsIfvfteF1
	 yGpRUOra6Dnu59AmXIOtVvDo/Nc0coaFL9Amcd9YuxfbTaEA5Y40TQa6e0ss2ZHoFR
	 ByahW6OoG2xbJ1IfP6CYKruSMss4w+Nrhl8j9tHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbgHQQAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387520AbgHQPmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:42:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 712D220760;
        Mon, 17 Aug 2020 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678957;
        bh=sXtgcI/FlirC232oacrQyf899CGFW8M7zfPMnh/iWzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dhqCePTCJpL2aD/uubEbf3eq6CEXFTpYiV1f2Fq7AIMrc6P1zwVuo1uUWaIt9ENT/
         kmV2NvYroj3TPWD4bR9wpgXkLkUj1iOqgTI6ZGRwWDUpt610mOnDsG2P5O8RyCxlZ6
         ge0EKd8+jnBvBJYbgR+lufVj7Q8obJcv3nFMWgFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 047/393] soc: qcom: pdr: Reorder the PD state indication ack
Date:   Mon, 17 Aug 2020 17:11:37 +0200
Message-Id: <20200817143821.898364445@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

[ Upstream commit 72fe996f9643043c8f84e32c0610975b01aa555b ]

The Protection Domains (PD) have a mechanism to keep its resources
enabled until the PD down indication is acked. Reorder the PD state
indication ack so that clients get to release the relevant resources
before the PD goes down.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
Fixes: fbe639b44a82 ("soc: qcom: Introduce Protection Domain Restart helpers")
Reported-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Link: https://lore.kernel.org/r/20200701195954.9007-1-sibis@codeaurora.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/pdr_interface.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
index 17ad3b8698e16..cd8828c857234 100644
--- a/drivers/soc/qcom/pdr_interface.c
+++ b/drivers/soc/qcom/pdr_interface.c
@@ -282,13 +282,15 @@ static void pdr_indack_work(struct work_struct *work)
 
 	list_for_each_entry_safe(ind, tmp, &pdr->indack_list, node) {
 		pds = ind->pds;
-		pdr_send_indack_msg(pdr, pds, ind->transaction_id);
 
 		mutex_lock(&pdr->status_lock);
 		pds->state = ind->curr_state;
 		pdr->status(pds->state, pds->service_path, pdr->priv);
 		mutex_unlock(&pdr->status_lock);
 
+		/* Ack the indication after clients release the PD resources */
+		pdr_send_indack_msg(pdr, pds, ind->transaction_id);
+
 		mutex_lock(&pdr->list_lock);
 		list_del(&ind->node);
 		mutex_unlock(&pdr->list_lock);
-- 
2.25.1



