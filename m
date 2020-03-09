Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E434CC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99F320578
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDZuaPba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgCISHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:07:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56036 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgCISHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:07:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id 6so519523wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBA+lZ954g7jKtpw1/B41PQ19wyi8PM6OpdNZu9C37U=;
        b=NDZuaPbahD6tbwTSLsUoK6vFEr3myBlaK8x58xuAm1YAI3IdhxHCNkh6nd43S8a8R7
         OKWSf/G7BtmTl6J4NgeR55mAh9i6TBontjXNbG8fqVhEdlPQUnWNYlYdHzt2naNCxDHH
         tFN1lcR4LDqm9bsQiTqNWC1ex8RVuIzjVloyg6XGh7o24/+ROkTag5hXR7EcH2CNKhW7
         j1zz3iztybXvaFYuwzf+SxwnkLxrvBV/aRZqLCzVze0w4UMrS5jiW/mE5ubk/coYGraN
         7OBSgDlIza0pwekqoDCLhv2618fwzCUMCn2oLKxqcuOvKp6juHm1n43oGDLILmDpO5LK
         BClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBA+lZ954g7jKtpw1/B41PQ19wyi8PM6OpdNZu9C37U=;
        b=Xatat211Jv/NmDDDasEe2rIs1t9O9t/jAJyYGHQ8gdOpe+zdkwcpAcSlI1HainXOSN
         QAF14w+tP9aayVyznU6u/+8soTUR+PrGbdCQP82GmoHS7IwObfhLWKGMKaMEYnyYQOZ4
         VAvtKQS/8aEgwBMXvYuZphI4lrUZP6sHSJ45q6fSA2Jzh8sNcvZWeMUqTK9ENN0nZhHG
         WD/DP/GYaG7JPRiIuGNGYOJN8t1ieMIxXAzaJZa8UCMCKX/8+E4FLL32k+VEXJqluhIl
         EFH4stIAQCVMVcwzvjNyL8YSp8FSOagSEOKywcw4y/B+ONxb5MB3HgR0qxhSvf/4ykzC
         4MpA==
X-Gm-Message-State: ANhLgQ0VUTHToz8n9lcr2d+OBR1vY8kZ64bS+gE+cAu9Be3fyLfBWxk7
        IZvXoJe21LuvfVNqTl8eTIyj2Q==
X-Google-Smtp-Source: ADFU+vtlH9GTgZeMk3lm/2bspK2xoqdgsbmzqg66MrkWYbiXkiMArhwcCth7YJqArpzCjiwH/5ghOw==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr16607wmg.136.1583777250248;
        Mon, 09 Mar 2020 11:07:30 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id g127sm474817wmf.10.2020.03.09.11.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 11:07:29 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND RFC PATCH] soundwire: bus: Add flag to mark DPN_BlockCtrl1 as readonly
Date:   Mon,  9 Mar 2020 18:07:25 +0000
Message-Id: <20200309180726.15792-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to SoundWire Specification Version 1.2.
"A Data Port number X (in the range 0-14) which supports only one
value of WordLength may implement the WordLength field in the
DPX_BlockCtrl1 Register as Read-Only, returning the fixed value of
WordLength in response to reads."

As WSA881x interfaces in PDM mode making the only field "WordLength"
in DPX_BlockCtrl1" fixed and read-only. Behaviour of writing to this
register on WSA881x soundwire slave with Qualcomm Soundwire Controller
is throwing up an error. Not sure how other controllers deal with
writing to readonly registers, but this patch provides a way to avoid
writes to DPN_BlockCtrl1 register by providing a ro_blockctrl1_reg
flag in struct sdw_port_runtime.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Sorry resending this one as I missed header file changes in my previous patch.

I will send patch for WSA881x to include this change once this patch
is accepted.

 drivers/soundwire/bus.h       |  2 ++
 drivers/soundwire/stream.c    | 17 ++++++++++-------
 include/linux/soundwire/sdw.h |  1 +
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 204204a26db8..791e8d14093e 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -79,6 +79,7 @@ int sdw_find_col_index(int col);
  * @num: Port number. For audio streams, valid port number ranges from
  * [1,14]
  * @ch_mask: Channel mask
+ * @ro_blockctrl1_reg: Read Only flag for DPN_BlockCtrl1 register
  * @transport_params: Transport parameters
  * @port_params: Port parameters
  * @port_node: List node for Master or Slave port_list
@@ -89,6 +90,7 @@ int sdw_find_col_index(int col);
 struct sdw_port_runtime {
 	int num;
 	int ch_mask;
+	bool ro_blockctrl1_reg;
 	struct sdw_transport_params transport_params;
 	struct sdw_port_params port_params;
 	struct list_head port_node;
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 00348d1fc606..4491643aeb4a 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -167,13 +167,15 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
 		return ret;
 	}
 
-	/* Program DPN_BlockCtrl1 register */
-	ret = sdw_write(s_rt->slave, addr2, (p_params->bps - 1));
-	if (ret < 0) {
-		dev_err(&s_rt->slave->dev,
-			"DPN_BlockCtrl1 register write failed for port %d\n",
-			t_params->port_num);
-		return ret;
+	if (!p_rt->ro_blockctrl1_reg) {
+		/* Program DPN_BlockCtrl1 register */
+		ret = sdw_write(s_rt->slave, addr2, (p_params->bps - 1));
+		if (ret < 0) {
+			dev_err(&s_rt->slave->dev,
+				"DPN_BlockCtrl1 register write failed for port %d\n",
+				t_params->port_num);
+			return ret;
+		}
 	}
 
 	/* Program DPN_SampleCtrl1 register */
@@ -1195,6 +1197,7 @@ static struct sdw_port_runtime
 
 	p_rt->ch_mask = port_config[port_index].ch_mask;
 	p_rt->num = port_config[port_index].num;
+	p_rt->ro_blockctrl1_reg = port_config[port_index].ro_blockctrl1_reg;
 
 	return p_rt;
 }
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index ee349a4c5349..8b130855acd1 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -842,6 +842,7 @@ void sdw_delete_bus_master(struct sdw_bus *bus);
 struct sdw_port_config {
 	unsigned int num;
 	unsigned int ch_mask;
+	bool ro_blockctrl1_reg;
 };
 
 /**
-- 
2.21.0

