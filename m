Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6AEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3606207D3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591359996;
	bh=afey/RecsirKQAD3ec+xHIOS+5OO1hTmH62iLsK7Xk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rQbn89JMCaFvYG2MZ3ijjF6lL5qgUBIF07bVbmsAFSI0+j/gjNPLBfYGKuZvV7jzj
	 vSN7Jl4liE8sxTUzcdaFb1iPQVqZCwbthMAWJjI69KPSjwKamAZjHOO31YzNs6pho2
	 aJIRsLFUgzzj275akEUPHaW76xQmeC5WXEybS46M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgFEM0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgFEM0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:26:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EFE6208B8;
        Fri,  5 Jun 2020 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591359978;
        bh=afey/RecsirKQAD3ec+xHIOS+5OO1hTmH62iLsK7Xk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=16V9sTOyabTzvy1/MddhE9IsEG5eNsi0nwAQHWU3BVAzdaJMrhhsMbFeuTBqjtaxm
         W3dxyaqzLtvyyvML6GVogN/BL8sfcL17CZ6TrCfWKspycgmyHWUYdSwbJmN6AQvVE1
         tctXUdaKs9c43YeHHh7Nc4/2q37DnCQWK3L7TSRM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 7/8] drivers/net/ibmvnic: Update VNIC protocol version reporting
Date:   Fri,  5 Jun 2020 08:26:08 -0400
Message-Id: <20200605122609.2882841-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605122609.2882841-1-sashal@kernel.org>
References: <20200605122609.2882841-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Falcon <tlfalcon@linux.ibm.com>

[ Upstream commit 784688993ebac34dffe44a9f2fabbe126ebfd4db ]

VNIC protocol version is reported in big-endian format, but it
is not byteswapped before logging. Fix that, and remove version
comparison as only one protocol version exists at this time.

Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 956fbb164e6f..85c11dafb4cd 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3560,12 +3560,10 @@ static void ibmvnic_handle_crq(union ibmvnic_crq *crq,
 			dev_err(dev, "Error %ld in VERSION_EXCHG_RSP\n", rc);
 			break;
 		}
-		dev_info(dev, "Partner protocol version is %d\n",
-			 crq->version_exchange_rsp.version);
-		if (be16_to_cpu(crq->version_exchange_rsp.version) <
-		    ibmvnic_version)
-			ibmvnic_version =
+		ibmvnic_version =
 			    be16_to_cpu(crq->version_exchange_rsp.version);
+		dev_info(dev, "Partner protocol version is %d\n",
+			 ibmvnic_version);
 		send_cap_queries(adapter);
 		break;
 	case QUERY_CAPABILITY_RSP:
-- 
2.25.1

