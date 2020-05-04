Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E15C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 21:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E940E20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 21:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jaPlGZnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgEDV6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 17:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727809AbgEDV6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 17:58:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46264C061A10
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 14:58:33 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h11so323564plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 14:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=orFzK+6AOl9Sz0N2w3p5SSg3SPmMkMh0jb6dZXjNAFs=;
        b=jaPlGZnfWYrtPVx1maSVT3ArUEpaiEnh3c5ZYrfq6i/L+ifNSf6JbnomP03mqRSMlK
         f6euoaI0SsW6zum8kWp1BwzoyyU4+Rtk8PuOXa6bK1D+feYt40M45ssIJw7l1Rv9TP11
         i3rEpDQKvKAqkXO4usqwzOmXuBrbD3OJUmNpE5K0dE949Jv5XBxA4ds/5xWq/0LgfyEV
         Oryrwp3mDWT5j4mxQUWqg9ZykXAU9ti2XWi7Ck6lXcXr8btQAt77sqGm2e0VUMybPOTx
         EXmnSJpcI3MzUz7/olOQC1I2nzSN4HHH3eGTuukCMtgAOlnj4oM7BeP/4IPLLtp1StWS
         vmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=orFzK+6AOl9Sz0N2w3p5SSg3SPmMkMh0jb6dZXjNAFs=;
        b=GOXHp0oR+Yw1weiu2R47gJgWeRy9qOnR3esOnw4SE/pzN9AkUS0jEXcl9HHtepXt3s
         hzX6tK9cEiVuhVBfuzuwReL/k35y2bwkf7x5ZPFoT8kpR4Hq1XnJAbXvmX2tMu4aX401
         7vndtzBUH29gWPRdBt8e1Ec4fjyqaC6bFTdBPCS1UbI+bhhfQRRqxyADKm+iRNQ9DW7U
         HozqxdmXkBwIZrCyupUH6iD4UcoeWofY+q9S/uKniHdIFXJp/abOFMezdCHEgqk9Qicp
         bYo+U3TPgZhHzBHmNDYHTEC4FlAS1gLHNO2Jvg1R8BWDWRC2fUyO/bvuKOOEol0qj70X
         sN4w==
X-Gm-Message-State: AGi0Pub5IKSyNk4MrOZQkL91gi1p465td5V4gLUmCsGOu3LSNrGxfW9V
        0GcpzTU1Gr8bm8JWxBf0EJJ/xw==
X-Google-Smtp-Source: APiQypL2uSjObUfnCx6WaMS/6lC8/Rl10vfxTuETATlgRxuCgRXqZQTNSsEMYetk9Sm/POFvW5sndw==
X-Received: by 2002:a17:90a:e28c:: with SMTP id d12mr3714pjz.19.1588629512778;
        Mon, 04 May 2020 14:58:32 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g10sm60185pfk.103.2020.05.04.14.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 14:58:32 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] rpmsg: core: Add wildcard match for name service
Date:   Mon,  4 May 2020 15:58:29 -0600
Message-Id: <20200504215830.31394-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504215830.31394-1-mathieu.poirier@linaro.org>
References: <20200504215830.31394-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the capability to supplement the base definition published
by an rpmsg_driver with a postfix description so that it is possible
for several entity to use the same service.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/rpmsg/rpmsg_core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index a6361cad608b..5e01e8dede6b 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -399,7 +399,25 @@ ATTRIBUTE_GROUPS(rpmsg_dev);
 static inline int rpmsg_id_match(const struct rpmsg_device *rpdev,
 				  const struct rpmsg_device_id *id)
 {
-	return strncmp(id->name, rpdev->id.name, RPMSG_NAME_SIZE) == 0;
+	size_t len = min_t(size_t, strlen(id->name), RPMSG_NAME_SIZE);
+
+	/*
+	 * Allow for wildcard matches.  For example if rpmsg_driver::id_table
+	 * is:
+	 *
+	 * static struct rpmsg_device_id rpmsg_driver_sample_id_table[] = {
+	 *      { .name = "rpmsg-client-sample" },
+	 *      { },
+	 * }
+	 *
+	 * Then it is possible to support "rpmsg-client-sample*", i.e:
+	 *	rpmsg-client-sample
+	 *	rpmsg-client-sample_instance0
+	 *	rpmsg-client-sample_instance1
+	 *	...
+	 *	rpmsg-client-sample_instanceX
+	 */
+	return strncmp(id->name, rpdev->id.name, len) == 0;
 }
 
 /* match rpmsg channel and rpmsg driver */
-- 
2.20.1

