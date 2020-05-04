Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6167AC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 352EA20675
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cZue72a3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgEDXx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgEDXxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:53:54 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F40FC061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 16:53:54 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id i7so570382qkl.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 16:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9e/vSBZuwDiq8/b0nws+itk9WL5dzY00wM0U6fmP48U=;
        b=cZue72a32pclfHpfB6ezr17gZGoOVWHOFdTNrMgh5YMPUcwIBXtFp3+XfkafkA/dQS
         R+r2zdv98+R9IfxU7IVMhkmZkUS/A8O6eOXhcN7ESIqvsBcrOkOBMSzAfmKJaZvec+dS
         /W+0PEFoH8+t2YJvNLCJaAJYKeDAMyCvv8KN+vhn26ACPoqA+O74L3wZL1qpkpriwRIy
         8fMarpe7768rbfTDQZrlWwWhG8uOXemNYr3hhdaDjU1tTEegMBURx28M+1xIBATdnjD2
         X56wUEAS0vRa5eIYUTGpKS+GZmn6+y3r9in4boSdcQL5qOWkFGirOMnLMYcnubCNqCAy
         hHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9e/vSBZuwDiq8/b0nws+itk9WL5dzY00wM0U6fmP48U=;
        b=m4Ex3khoiQy+YtrE7Gi1yNngveJO9lzayENT7Q/xdNqmiuUpYODOJW2ftgpxvPeC1L
         LavieO0gKVu4I9+Dv71sWSO5ng42LiKDtWDsNJEsoMm1CWPaFQ4f0DKoVjXnpuu3w6oD
         ub4Uzz89WuxOEJOtrzj1PDrWItG3oleV+Z5F9kfzDxkS3QQsYFUK6z/9jfyx25o9MQ5d
         vrBvWY47enFVdcyWrm8n+yzpyICWrrWzDADCNOY1WaTAkDO/RKILsEyEMa1VVl0tZmGo
         Z+HAopBhNnA95988ehWPgF2ImWAqa8Ska7zjTl0OhmsAWECeYVxBPNI7WOp80sJmWas3
         zCOQ==
X-Gm-Message-State: AGi0PuYjrc/LxzudviDj3VQzsQTnfFdGYSMX8+6DSldZGX4tfk4/KNfN
        6iqWdhZShNyHYyeCqhr2lS6DXg==
X-Google-Smtp-Source: APiQypJwIH0y5YEgziQGpZMep0whQGrFG6xdz4SF/k+HuofPrLIay0wZ3KqCCsN8QifgioflFWYyYA==
X-Received: by 2002:a37:d0a:: with SMTP id 10mr936221qkn.288.1588636433490;
        Mon, 04 May 2020 16:53:53 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id z18sm296004qti.47.2020.05.04.16.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:53:52 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/5] net: ipa: get rid of workaround in ipa_endpoint_stop()
Date:   Mon,  4 May 2020 18:53:42 -0500
Message-Id: <20200504235345.17118-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504235345.17118-1-elder@linaro.org>
References: <20200504235345.17118-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ipa_endpoint_stop(), a workaround is used for IPA version 3.5.1
where a 1-byte DMA request is issued between GSI channel stop
retries.

It turns out that this workaround is only required for IPA versions
3.1 and 3.2, and we don't support those.  So remove the call to
ipa_endpoint_stop_rx_dma() in that function.  That leaves that
function unused, so get rid of it.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 39 +---------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index a21534f1462f..c20a5a32fbaa 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -33,13 +33,10 @@
 #define IPA_RX_BUFFER_OVERHEAD	(PAGE_SIZE - SKB_MAX_ORDER(NET_SKB_PAD, 0))
 
 #define IPA_ENDPOINT_STOP_RX_RETRIES		10
-#define IPA_ENDPOINT_STOP_RX_SIZE		1	/* bytes */
 
 #define IPA_ENDPOINT_RESET_AGGR_RETRY_MAX	3
 #define IPA_AGGR_TIME_LIMIT_DEFAULT		1000	/* microseconds */
 
-#define ENDPOINT_STOP_DMA_TIMEOUT		15	/* milliseconds */
-
 /** enum ipa_status_opcode - status element opcode hardware values */
 enum ipa_status_opcode {
 	IPA_STATUS_OPCODE_PACKET		= 0x01,
@@ -1246,32 +1243,6 @@ static void ipa_endpoint_reset(struct ipa_endpoint *endpoint)
 			ret, endpoint->channel_id, endpoint->endpoint_id);
 }
 
-static int ipa_endpoint_stop_rx_dma(struct ipa *ipa)
-{
-	u16 size = IPA_ENDPOINT_STOP_RX_SIZE;
-	struct gsi_trans *trans;
-	dma_addr_t addr;
-	int ret;
-
-	trans = ipa_cmd_trans_alloc(ipa, 1);
-	if (!trans) {
-		dev_err(&ipa->pdev->dev,
-			"no transaction for RX endpoint STOP workaround\n");
-		return -EBUSY;
-	}
-
-	/* Read into the highest part of the zero memory area */
-	addr = ipa->zero_addr + ipa->zero_size - size;
-
-	ipa_cmd_dma_task_32b_addr_add(trans, size, addr, false);
-
-	ret = gsi_trans_commit_wait_timeout(trans, ENDPOINT_STOP_DMA_TIMEOUT);
-	if (ret)
-		gsi_trans_free(trans);
-
-	return ret;
-}
-
 /**
  * ipa_endpoint_stop() - Stops a GSI channel in IPA
  * @client:	Client whose endpoint should be stopped
@@ -1287,20 +1258,12 @@ int ipa_endpoint_stop(struct ipa_endpoint *endpoint)
 	int ret;
 
 	do {
-		struct ipa *ipa = endpoint->ipa;
-		struct gsi *gsi = &ipa->gsi;
+		struct gsi *gsi = &endpoint->ipa->gsi;
 
 		ret = gsi_channel_stop(gsi, endpoint->channel_id);
 		if (ret != -EAGAIN || endpoint->toward_ipa)
 			break;
 
-		/* For IPA v3.5.1, send a DMA read task and check again */
-		if (ipa->version == IPA_VERSION_3_5_1) {
-			ret = ipa_endpoint_stop_rx_dma(ipa);
-			if (ret)
-				break;
-		}
-
 		msleep(1);
 	} while (retries--);
 
-- 
2.20.1

