Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B049C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C77221556
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577933;
	bh=afey/RecsirKQAD3ec+xHIOS+5OO1hTmH62iLsK7Xk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZoejvdzJQ4aMLDXxjw9hyCqpnloab8nnbgPWWpQ+y6gWY3Xnorx+M0xKzNFP2r8iJ
	 8tC+6eOUkNXwnol++e9Tv7lIGlcbg+rlINtCk1pkljefs2xtVJxpwM/u+0AtAam1Bn
	 ERMi7MGQUY0e39B34xKDHJg9fSwzybWDkidRU8OE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388710AbgFSOpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388682AbgFSOpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:45:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B75420A8B;
        Fri, 19 Jun 2020 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577917;
        bh=afey/RecsirKQAD3ec+xHIOS+5OO1hTmH62iLsK7Xk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzJjvtghmIISWZqF8XLNy6rtUY1OkAmBUUcmmMglDEwZ0Adp2wLW0iXplE/HQYHNg
         R/mZKYaJjRrxwm7xvu4YmJ+EkcWK80yn3cDlbhYnBBcgPcqhbfNBUrGSpIMOWv0tcV
         MjdL/hQ5kdbsH2X6OjTscBstyqFjXV9oc9nIlvnE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 013/190] drivers/net/ibmvnic: Update VNIC protocol version reporting
Date:   Fri, 19 Jun 2020 16:30:58 +0200
Message-Id: <20200619141634.133139918@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



