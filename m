Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1F3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9A9207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgE0Dcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:32:39 -0400
Received: from m17616.mail.qiye.163.com ([59.111.176.16]:19320 "EHLO
        m17616.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgE0Dci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:32:38 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17616.mail.qiye.163.com (Hmail) with ESMTPA id AB9831086E6;
        Wed, 27 May 2020 11:32:34 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     davem@davemloft.net, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, trivial@kernel.org,
        Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH] drivers: ipa: remove discription of nonexistent element
Date:   Tue, 26 May 2020 20:32:22 -0700
Message-Id: <20200527033222.34410-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTVVITU9LS0tISUtPSE9OTFlXWShZQU
        hPN1dZLVlBSVdZDwkaFQgSH1lBWRJOKzI4HD8VChITKEhDSh4pSRg6OjpWVlVITyhJWVdZCQ4XHg
        hZQVk1NCk2OjckKS43PllXWRYaDxIVHRRZQVk0MFkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTo6Azo5STgzLyMjT0IfHQJR
        LB0KFD1VSlVKTkJLTk5LSE5MSkxOVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUpPQ0I3Bg++
X-HM-Tid: 0a7254305c6b9374kuwsab9831086e6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No element named "client" exists within "struct ipa_endpoint".
It might be a heritage forgotten to be removed. Delete it now.

Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
 drivers/net/ipa/ipa_endpoint.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_endpoint.h b/drivers/net/ipa/ipa_endpoint.h
index 4b336a1f759d..bbee9535d4b2 100644
--- a/drivers/net/ipa/ipa_endpoint.h
+++ b/drivers/net/ipa/ipa_endpoint.h
@@ -41,7 +41,6 @@ enum ipa_endpoint_name {
 
 /**
  * struct ipa_endpoint - IPA endpoint information
- * @client:	Client associated with the endpoint
  * @channel_id:	EP's GSI channel
  * @evt_ring_id: EP's GSI channel event ring
  */
-- 
2.17.1

