Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8024EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BDE20888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HhMcEpIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388456AbgE1Lgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388326AbgE1Lgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:36:52 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BD8C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:36:52 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f21so10362636pgg.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SPlSNhEoMy4GFhlZbMQB+IG1g/7jJz5UAQwhfKQZkc0=;
        b=HhMcEpIht9SY74kN2eKZY+4AIad8N9YEflvLVjOmgNDuhnFtYjKbe81JGHw+6BulzK
         N3wFaZdKCJ3jzwxuM+pG1z2zWrRjWZl48HZIiaZgRJD3H+oiX2kYrlwu3C9os+bwag74
         0WSwB1Q3wFUuzH+h9PhpX0pq6lcmxFj42icqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SPlSNhEoMy4GFhlZbMQB+IG1g/7jJz5UAQwhfKQZkc0=;
        b=AzFqQMkf/vO8Rhayel1sd6H4VYCcAs6mNMRr+hS23TA0fWpA+4LTOm/lE9MdBWoXaM
         tThkCNYk8Gq1ARbIkGqytugOFbtNgUd5Mg+BUvMZh8xCEilEq0pMiEqcrdCUn9pJldBX
         2QreEU/1TTlJq2e6lfSlKteWpgr15MZsOg73LzN8pJ4TAq35OSc4gIYM5dC/uuMTx0Te
         TPsPA3AC8jhDYJ3ljhy6OiKE6xoyVwkfroN6c9DGocBBGFZhgOjUJapJFLkgy1X41waz
         btA0wAj7ZI4d+wsVUc2oTyTymLs8fj0pTtzCHj9+lF7Gl3u26Fcv7hJEMwOMq7n20cgO
         rLhQ==
X-Gm-Message-State: AOAM531sCiluzxMibkDDPeABpe51UgmrZ+vbK8Z6k4S/Z/NNLJMS+5IX
        Q2UHxyT+RXr68qT/cgNJIYoIcSRR8FY=
X-Google-Smtp-Source: ABdhPJyoG0S/eS58uuLYRarclfaRb7AfmwcNXlQk61kt+RhLkhZQGjYPNcDSjL4ydGHbeptZAT4M3Q==
X-Received: by 2002:a63:6605:: with SMTP id a5mr2483594pgc.50.1590665812048;
        Thu, 28 May 2020 04:36:52 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id g7sm4519961pjs.48.2020.05.28.04.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 04:36:51 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH 2/4] platform/chrome: typec: Register PD CTRL cmd v2
Date:   Thu, 28 May 2020 04:36:05 -0700
Message-Id: <20200528113607.120841-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
In-Reply-To: <20200528113607.120841-1-pmalani@chromium.org>
References: <20200528113607.120841-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recognize EC_CMD_USB_PD_CONTROL command version 2. This is necessary in
order to process Type C mux information (like DP alt mode pin
configuration), which is needed by the Type C Connector class API to
configure the Type C muxes correctly

While we are here, rename the struct member storing this version number
from cmd_ver to pd_ctrl_ver, which more accurately reflects what is
being stored.

Also, slightly change the logic for calling
cros_typec_set_port_params_*(). Now, v0 is called when pd_ctrl_ver is 0,
and v1 is called otherwise.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 6e79f917314b..d69a88464cef 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -37,7 +37,7 @@ struct cros_typec_data {
 	struct device *dev;
 	struct cros_ec_device *ec;
 	int num_ports;
-	unsigned int cmd_ver;
+	unsigned int pd_ctrl_ver;
 	/* Array of ports, indexed by port number. */
 	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
 	struct notifier_block nb;
@@ -340,7 +340,7 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 	req.mux = USB_PD_CTRL_MUX_NO_CHANGE;
 	req.swap = USB_PD_CTRL_SWAP_NONE;
 
-	ret = cros_typec_ec_command(typec, typec->cmd_ver,
+	ret = cros_typec_ec_command(typec, typec->pd_ctrl_ver,
 				    EC_CMD_USB_PD_CONTROL, &req, sizeof(req),
 				    &resp, sizeof(resp));
 	if (ret < 0)
@@ -351,7 +351,7 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 	dev_dbg(typec->dev, "Polarity %d: 0x%hhx\n", port_num, resp.polarity);
 	dev_dbg(typec->dev, "State %d: %s\n", port_num, resp.state);
 
-	if (typec->cmd_ver == 1)
+	if (typec->pd_ctrl_ver != 0)
 		cros_typec_set_port_params_v1(typec, port_num, &resp);
 	else
 		cros_typec_set_port_params_v0(typec, port_num,
@@ -374,13 +374,15 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
 	if (ret < 0)
 		return ret;
 
-	if (resp.version_mask & EC_VER_MASK(1))
-		typec->cmd_ver = 1;
+	if (resp.version_mask & EC_VER_MASK(2))
+		typec->pd_ctrl_ver = 2;
+	else if (resp.version_mask & EC_VER_MASK(1))
+		typec->pd_ctrl_ver = 1;
 	else
-		typec->cmd_ver = 0;
+		typec->pd_ctrl_ver = 0;
 
 	dev_dbg(typec->dev, "PD Control has version mask 0x%hhx\n",
-		typec->cmd_ver);
+		typec->pd_ctrl_ver);
 
 	return 0;
 }
-- 
2.27.0.rc0.183.gde8f92d652-goog

