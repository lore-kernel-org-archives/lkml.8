Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77491C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFD3207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597925562;
	bh=UtA49LqjWfOiF+UegpH3bqGT9EIXZNTUrGsjO15YjNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PdEzq9XluX5wTyk2TE+teMILds5s3hpE73SEqxrTtIqYiaAX54AuoBn4SDIls6JeQ
	 SiCxmQrYCveES3pdzHfpNXOitXcMAW+r+6wYNcNvU3HV3JdK1XAww6H6ALnKNUTxCK
	 xYv5wrplSoSmVYWAga9F3yEs23Ain9EpH0NUq5EQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgHTMMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:12:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730292AbgHTJ5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:57:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B25020855;
        Thu, 20 Aug 2020 09:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917453;
        bh=UtA49LqjWfOiF+UegpH3bqGT9EIXZNTUrGsjO15YjNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNn+I848lty8jEuWLo+CusSJyW4t4HFqjqrNsbjHKzYtITF2+3Tse2MAce3HIJjEq
         Z0j2EnZK1gGPbEkCtqs/va5EXrcpEe2KgwkB6x+yoqRPrDszzcWne/NzMoQHD6iEHN
         hH9F9CaQ2NdJEgHfzm9l/UKAoKUXNzuSrWguOIGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 007/212] ath9k_htc: release allocated buffer if timed out
Date:   Thu, 20 Aug 2020 11:19:40 +0200
Message-Id: <20200820091602.625662297@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 853acf7caf10b828102d92d05b5c101666a6142b ]

In htc_config_pipe_credits, htc_setup_complete, and htc_connect_service
if time out happens, the allocated buffer needs to be released.
Otherwise there will be memory leak.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/htc_hst.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index 257b6ee51e54b..1af216aa5adae 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -175,6 +175,7 @@ static int htc_config_pipe_credits(struct htc_target *target)
 	time_left = wait_for_completion_timeout(&target->cmd_wait, HZ);
 	if (!time_left) {
 		dev_err(target->dev, "HTC credit config timeout\n");
+		kfree_skb(skb);
 		return -ETIMEDOUT;
 	}
 
@@ -211,6 +212,7 @@ static int htc_setup_complete(struct htc_target *target)
 	time_left = wait_for_completion_timeout(&target->cmd_wait, HZ);
 	if (!time_left) {
 		dev_err(target->dev, "HTC start timeout\n");
+		kfree_skb(skb);
 		return -ETIMEDOUT;
 	}
 
@@ -284,6 +286,7 @@ int htc_connect_service(struct htc_target *target,
 	if (!time_left) {
 		dev_err(target->dev, "Service connection timeout for: %d\n",
 			service_connreq->service_id);
+		kfree_skb(skb);
 		return -ETIMEDOUT;
 	}
 
-- 
2.25.1



