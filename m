Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB52C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A58BD2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="meuU0Zkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHYRCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgHYRB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:01:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4C3C0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:01:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q14so2368557wrn.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNXnwR9p0uhARPXD5IdPdhRimuwkBpCRHZXkkYzIxeQ=;
        b=meuU0Zkwwy7TRrTbdm6LUcRa5e3YU5RgQBubXJ47ZT+Lsi5779G+F1X6eYeme2O5ZK
         p2YXUVA6EPBOQJ8xCp+iAq2xzLrx7ZKTIVrya5CPfG16nKyhpqBoYZgvIxvm/5K6Z2r+
         78/DCncRswMvj1HScNrlpYXIKlojHDrvV4lbdROLjNgQmsOqTzU7CCGF1OeJzpJauMJw
         dyqSZ/VXsQS0r5Nd4I+aB01EtTbUVdKSOe9ikHjB4+c1fu583F6SwzIn8WMgR0rZ95Hl
         QJdygPc1CUeEDPE9zxO72ecB2l+o4UkJTKXeXJT1vAMzMMn/x/zn5KC51P70XrXvFdPP
         r45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNXnwR9p0uhARPXD5IdPdhRimuwkBpCRHZXkkYzIxeQ=;
        b=f9fJGkWoihtb915ZkmNMGDV/8xPp7F8WmVwLfFduz21qtSAiFfIbCN5rrWtXZynX+T
         RD7t4mMdPkvohxXmV5P0Z3r8G1cftnJROf/xmC4bymUsJ7Y1QIch3Q5/uIzOiKa5N9KY
         DKZshRZF/t/q6U3wvadYgjSTLkCy5hAPWJDfOVE4hnaE05G1J5wsm9RQMLSlaJrbyQEw
         Q5nrIXHSOpSB5slwRWNP5TeH65tbQWb1qU/negB1qfWDdV+sp9bRMVt3FQ2nT5RxKe9U
         q3zZFhKof12taxkHl662u67wpONReLL6Jzz+/lhhYS0YtgRsRz9NqKUJ8eyI6xdLePoC
         nNsg==
X-Gm-Message-State: AOAM532FgB0BCdwAu7miydcfrujNHlf3gINBzkyauW+kV0T3wDVSJldK
        J6SC+P84WrV6xiG4Fq3ORdfOoQ==
X-Google-Smtp-Source: ABdhPJygtIjUoGytXl0pS2x7kihR5qpo/+T9Ab3cspeev/uMhVEEZfjD6nvOU54rZeDnoPpVpNhnRA==
X-Received: by 2002:adf:e78e:: with SMTP id n14mr10900629wrm.357.1598374915151;
        Tue, 25 Aug 2020 10:01:55 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y17sm6669008wma.17.2020.08.25.10.01.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 10:01:54 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     saravanak@google.com, mdtipton@codeaurora.org,
        okukatla@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, akashast@codeaurora.org,
        georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] interconnect: Add get_bw() callback
Date:   Tue, 25 Aug 2020 20:01:50 +0300
Message-Id: <20200825170152.6434-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200825170152.6434-1-georgi.djakov@linaro.org>
References: <20200825170152.6434-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interconnect controller hardware may support querying the current
bandwidth settings, so add a callback for providers to implement this
functionality if supported.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 include/linux/interconnect-provider.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 4735518de515..520f70fe5a31 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -38,6 +38,7 @@ struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
  * @aggregate: pointer to device specific aggregate operation function
  * @pre_aggregate: pointer to device specific function that is called
  *		   before the aggregation begins (optional)
+ * @get_bw: pointer to device specific function to get current bandwidth
  * @xlate: provider-specific callback for mapping nodes from phandle arguments
  * @dev: the device this interconnect provider belongs to
  * @users: count of active users
@@ -51,6 +52,7 @@ struct icc_provider {
 	int (*aggregate)(struct icc_node *node, u32 tag, u32 avg_bw,
 			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 	void (*pre_aggregate)(struct icc_node *node);
+	int (*get_bw)(struct icc_node *node, u32 *avg, u32 *peak);
 	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
 	struct device		*dev;
 	int			users;
