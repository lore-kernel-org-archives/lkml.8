Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D6CC33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 05:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED94C2067C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 05:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w2hVTTa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgAaF2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 00:28:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32857 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgAaF2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 00:28:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay11so2270635plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 21:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5O9dRwTmAfTdhR0RTimUtT1UQf2+T/KS73D+N+uxWxw=;
        b=w2hVTTa9jV41L9X8+VI9lgCG0sikVjC0VKQQhwZ45dJYTylRt1/bpb3Nn4MK8k1AuC
         lPF/7cBMG+d5Tg9APK4s1ooCILZdOtp5FEroxAyGalEcAICcKa8r6wZO2DWyhQa93lHx
         oF72ZGrpOpSbxrl8wYhq80uDxbDqjaEdxmrlX3XpSQu5JnhnsiAI+jM4GO//DStj6iOx
         Q/lyusherTK1Z80dgkNGgptdj4SufDpNTkmtoHaHnXCDJTyqs4rqfFja7fAv4bZVvF/6
         t7unsdJNEc57m5cQDFBuCMe+8Y9SUrtqIYI8eNFddXntxL5Ll1gB5WEAorHdXfQLRP2x
         Nl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5O9dRwTmAfTdhR0RTimUtT1UQf2+T/KS73D+N+uxWxw=;
        b=ttrNQ9LpI15xeggR9oAE8xrnT2UDP8lRsft8WhV5i8Jmnwo4V2Dz2yxaPZse5oXqU6
         vCG8wgIMHK8ym3GpB383s5UTEgUuh19pQAQXnM+U9PpD8YkyqkLN0R3zwT+m3DaFemFk
         gQLKIPEIsXefFn6eA9t02ND7ucMXzTwvVC61kJROr7n8GslELiWOFPUGviTou3VmQJ9U
         8/4nGjPmFEXmB9tPxNZ5k9Y4a7E5Fs+XHgHTZ/e1GW5LNgf+pMaRP6k2g/UuxVv0OCrB
         8N5qyK9hjJWofZXpilZaLAO9WqrS65Cf83RRaXhI88LV82eKHyOkeha0kSFcTGPZmsn3
         S3XQ==
X-Gm-Message-State: APjAAAVmeuSUcuWYeuW7sIq0m5CmcqJ4KCayLJ1lKJxPD91dmh3jAMo7
        i2TCqG/v3RyeUrGWvgdHbC4RLA==
X-Google-Smtp-Source: APXvYqxKJQkEsMprpBon3acfXN0/i9RqjCadeEkPMtXCEMGBgxYe7Qp0IMV/cARWwYTIPIDAh7lioA==
X-Received: by 2002:a17:90a:9f83:: with SMTP id o3mr10309975pjp.95.1580448502479;
        Thu, 30 Jan 2020 21:28:22 -0800 (PST)
Received: from localhost ([122.172.141.204])
        by smtp.gmail.com with ESMTPSA id b12sm8762269pfr.26.2020.01.30.21.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jan 2020 21:28:21 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     arnd@arndb.de, Sudeep Holla <sudeep.holla@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, jassisinghbrar@gmail.com,
        cristian.marussi@arm.com, peng.fan@nxp.com,
        peter.hilber@opensynergy.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 1/3] firmware: arm_scmi: Update doc style comments
Date:   Fri, 31 Jan 2020 10:58:11 +0530
Message-Id: <1bff7c0d1ad2c8b6eeff9660421f414f8c612eb2.1580448239.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1580448239.git.viresh.kumar@linaro.org>
References: <cover.1580448239.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix minor formatting issues with the doc style comments.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/firmware/arm_scmi/common.h | 4 ++--
 drivers/firmware/arm_scmi/driver.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index df35358ff324..227934871929 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -33,8 +33,8 @@ enum scmi_common_cmd {
 /**
  * struct scmi_msg_resp_prot_version - Response for a message
  *
- * @major_version: Major version of the ABI that firmware supports
  * @minor_version: Minor version of the ABI that firmware supports
+ * @major_version: Major version of the ABI that firmware supports
  *
  * In general, ABI version changes follow the rule that minor version increments
  * are backward compatible. Major revision changes in ABI may not be
@@ -88,7 +88,7 @@ struct scmi_msg {
  *	message. If request-ACK protocol is used, we can reuse the same
  *	buffer for the rx path as we use for the tx path.
  * @done: command message transmit completion event
- * @async: pointer to delayed response message received event completion
+ * @async_done: pointer to delayed response message received event completion
  */
 struct scmi_xfer {
 	int transfer_id;
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 2c96f6b5a7d8..978eafb53471 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -119,9 +119,9 @@ struct scmi_chan_info {
  *
  * @dev: Device pointer
  * @desc: SoC description for this instance
- * @handle: Instance of SCMI handle to send to clients
  * @version: SCMI revision information containing protocol version,
  *	implementation version and (sub-)vendor identification.
+ * @handle: Instance of SCMI handle to send to clients
  * @tx_minfo: Universal Transmit Message management info
  * @tx_idr: IDR object to map protocol id to Tx channel info pointer
  * @rx_idr: IDR object to map protocol id to Rx channel info pointer
-- 
2.21.0.rc0.269.g1a574e7a288b

