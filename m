Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A818BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7413E20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947498;
	bh=wscTOT490+jB0TIEzdIE6A8u5wLGa1vOApJtSWpdMdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lW4dikFRsNgpq8WT2Jgnqu0oAvOaIXgA6Bl7xynV4FQkEK8oagEk/BKCLCu06/ZRI
	 gRdM+Hs5D6fpmufRq0vffSWI6qreKuzuxqeRoA41PC7ozoyQAhvwdzaFqJpoNiDERv
	 DEClvyFN/YxHLGxZLsalZsDOBLKZxpBCausDAOtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393533AbgFWVYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389509AbgFWUTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:19:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A8C82073E;
        Tue, 23 Jun 2020 20:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943562;
        bh=wscTOT490+jB0TIEzdIE6A8u5wLGa1vOApJtSWpdMdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kty6+o1009vFM1Gm8h57i/MP8RwDQ2V0BoGlGTPGpWwoHs/tw7s92YXqf9z+heaIJ
         UR5Sv6tbzBHkMKm2HnC3YjbBhw+N4IbJzTlU+LmuyjKyPTgzSpnJRw3OEUnVnE9CrJ
         bzs9rPjVQcXr7dLkww6jBaNMaui2L/Py1jZM/wNQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 400/477] bnxt_en: Re-enable SRIOV during resume.
Date:   Tue, 23 Jun 2020 21:56:37 +0200
Message-Id: <20200623195426.437655764@linuxfoundation.org>
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

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 59ae210173ff86256fa0cdba4ea4d608c61e123d ]

If VFs are enabled, we need to re-configure them during resume because
firmware has been reset while resuming.  Otherwise, the VFs won't
work after resume.

Fixes: c16d4ee0e397 ("bnxt_en: Refactor logic to re-enable SRIOV after firmware reset detected.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index fbfb3e092e0dc..f8b26265cb86d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12115,6 +12115,8 @@ static int bnxt_resume(struct device *device)
 
 resume_exit:
 	bnxt_ulp_start(bp, rc);
+	if (!rc)
+		bnxt_reenable_sriov(bp);
 	rtnl_unlock();
 	return rc;
 }
-- 
2.25.1



