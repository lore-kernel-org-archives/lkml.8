Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20CBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CD92468A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699509;
	bh=+CqEos7/aIv8ITK1vvdTOwiWRvGqm2psdhrENFvh4is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xrlMaaS7cin4gPWsP8lrBfr+fNGh4EcrNJtKKnaD/fxJFTyz6MSw5FrTHhv2pYu4j
	 6R3fdnhWFAIRm2oS7aXD3JqRFpuPniRmLEYCnCOEW0reBr09SfTnfy6snkBL8bIzYP
	 Cvk2xCtHdGuCHWI5OSjzWr3qPfBbobWokj8s6ns8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731184AbgAVNZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:25:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731151AbgAVNZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:25:07 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2611A24688;
        Wed, 22 Jan 2020 13:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699506;
        bh=+CqEos7/aIv8ITK1vvdTOwiWRvGqm2psdhrENFvh4is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OccRh5e7KV3MQj7BS5yI5SLATt0T1wI5wGtv8tmhBqSSsqoGz+EJkk/LKr4y2LM6G
         xE4Kngbx7MhgFdoRtCUP74UB+kfS96zDfxLexK8H0J00aEcsas+L+eUFtYljp7FtTS
         qdM2A9FfnCPMEZ15DhFeZZKGYC9uOilp7018tm0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 149/222] bnxt_en: Fix NTUPLE firmware command failures.
Date:   Wed, 22 Jan 2020 10:28:55 +0100
Message-Id: <20200122092844.394182716@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit ceb3284c588eee5ea256c70e4d8d7cf399b8134e ]

The NTUPLE related firmware commands are sent to the wrong firmware
channel, causing all these commands to fail on new firmware that
supports the new firmware channel.  Fix it by excluding the 3
NTUPLE firmware commands from the list for the new firmware channel.

Fixes: 760b6d33410c ("bnxt_en: Add support for 2nd firmware message channel.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1904,9 +1904,6 @@ static inline bool bnxt_cfa_hwrm_message
 	case HWRM_CFA_ENCAP_RECORD_FREE:
 	case HWRM_CFA_DECAP_FILTER_ALLOC:
 	case HWRM_CFA_DECAP_FILTER_FREE:
-	case HWRM_CFA_NTUPLE_FILTER_ALLOC:
-	case HWRM_CFA_NTUPLE_FILTER_FREE:
-	case HWRM_CFA_NTUPLE_FILTER_CFG:
 	case HWRM_CFA_EM_FLOW_ALLOC:
 	case HWRM_CFA_EM_FLOW_FREE:
 	case HWRM_CFA_EM_FLOW_CFG:


