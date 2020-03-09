Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856FEC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEA020828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lS9XfaG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgCIRiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:38:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33649 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgCIRiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:38:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so8530610wrd.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 10:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrRaa2oLGASoVUcKPYHBNJIYaKUXkZG1vLWKS/FETTM=;
        b=lS9XfaG7i9K70Uz52uiZGAJLSYBH0BwEbvNfFeQPbZAYCDFVg/xbQB9QBhNNzCmUyu
         DSQtXZF5lXClDT+BykDCQ2AGOlo462xlHcjCAYxutGzmYVVxvY818q8mgVTL0c3xe9jd
         nHq2G1WLeBJcFdqMJGKQoqGRS+nlOJRam4fIRajkKbQSsWSgEsQ3fDmFNr1jza1SUgXK
         0jlAlAvCH3dDmuuOLqZ9nOw144R77rwiOEgB5X9fyhumtQT8mEqQwci9ICaPRF1IcE97
         j+No9luh0JXOFwjkH4uzLsGXk5GHgIcUbVZUmc9/uVIaPjq31qJzhZmQK0A8hB7wSBuB
         rz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrRaa2oLGASoVUcKPYHBNJIYaKUXkZG1vLWKS/FETTM=;
        b=VEryOYRBLPy8UxSAX+hZ39oUtyBvdUF28/c2LJ7bbW22/42wCSUYUGShC3w94dtuNH
         rD+ccO57kg6ysT3TEunjMHuUI8NdUXjG43uLiCg5fuFFtOFP3iu7VsCOT4JR32NcyBR5
         4YR+8USxogenFBIy7Gt1pbOd99lv2kqm8knHI9f4nkJKl1VFxlnvzuY+aAxtWbfzkAVO
         WwyIUEB9TUc/qfkCjX0eCF+Ve9NNv81J/tnwbNO9XpbnmYreuyv3wvrOv81jRiNokMzP
         wRAEB+Qt2jjyBOnejGONabHMabL5iPC8nOgEG+fz2XbRUJYwCG6JH5OIpuoQ3uSThBZQ
         UdQg==
X-Gm-Message-State: ANhLgQ1J/zJbdGNczGxxVi52POiNzCrp/eSUwlgDbNWDm/UxLfRq3R07
        fGLYsgVPeV3yYInL7O3mZ1DPJA==
X-Google-Smtp-Source: ADFU+vvLfd/MwARBYr7I+uIlvy/rGZiD/jQkUZifoVZVosaPYiFgIKPRqE2d04DkNXkKUpUoZ7WeAQ==
X-Received: by 2002:a5d:514a:: with SMTP id u10mr2144282wrt.360.1583775485460;
        Mon, 09 Mar 2020 10:38:05 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id w81sm321838wmg.19.2020.03.09.10.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 10:38:04 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH] soundwire: bus: Add flag to mark DPN_BlockCtrl1 as readonly
Date:   Mon,  9 Mar 2020 17:37:55 +0000
Message-Id: <20200309173755.955-1-srinivas.kandagatla@linaro.org>
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

I will send patch for WSA881x to include this change once this patch
is accepted.

 drivers/soundwire/bus.h    |  2 ++
 drivers/soundwire/stream.c | 17 ++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

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
-- 
2.21.0

