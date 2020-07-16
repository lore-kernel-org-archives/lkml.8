Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE312C433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 977C62075F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SP5OdA53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgGPDlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 23:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgGPDli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:41:38 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A4EC08C5DE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 20:41:37 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id x37so2638670qvf.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 20:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RqXiuX4xTk+c+m3/+/qauF2hZhj8i+Z6YtZCdH2Snc8=;
        b=SP5OdA53xpO2g879UlHzND9x16PSS2YeWd6k1DiG2SEtDMCq+XiIiaQv3lp4dwcxBb
         GZgChSNNBaBvlmpPwQqfqdSSp96ht7M2qACj2PWt47uaITvzqZ5Oxv5bYTIUR61DjsgF
         hPt+lTMLfRM2gkOb9M19KbD4CtWSnbj8QyBskUezCC0jRJxz1QbRR+I/HDHlQT2ZZOYx
         zfvf9eJK2R8FCYbGlmaLNoioILOyvAC8Ftk3NOORSLnIpsGjs2gE+e7DeE5xR3Z9s/oE
         xlDsQ/4UyKXy4/CAcNXQSHZUOrxmXleX8jXCxl4GDsrmAumGqsEFeGvgMVYaQDKeXwtr
         NjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RqXiuX4xTk+c+m3/+/qauF2hZhj8i+Z6YtZCdH2Snc8=;
        b=TitasjVj4Nr1eMF/WnvkcROcAOExm//IXIsT/Z2V+MnJzn+1M+1iTelxoF3Axm+84T
         q5gI1OfUOLLlJIIiwmQ2j4H7NkOQ4sZ5IYTAotuV8gJ+nr8Yc4C4zSPKQf53p5fpMPwH
         uCKQdIEpqvMW8RYyduWHrAR2Z2c/yLmtlS/XNHkj17wUHk4dNnKzDg7nk57NSxCTL87j
         drQ15rX5IqzRovJdLj1I8ljdRAE7bxn7NUWRUJ4FVlpViScwwu4M3c1M1Ld1B831CImD
         Y6fvM6PUDpx1EjYuH+7K0gHyd2UrswUuufD5wI7dWlZu/o6YuXUqPuKWOA2Y1OoHczyq
         1OZw==
X-Gm-Message-State: AOAM530LYFH2n0AJdhRLK6sJqM950zL8kh69bF9+c8xr5GBalU4Dd/Y9
        cYxNEB/n7xAmFq/zkd39W/ds1F3+mM0=
X-Google-Smtp-Source: ABdhPJx/tvtrXjaNurK8r8bUP20wV+jbDXYBvFLMca6IAOG3Qo3S+zosA7MaGPg5sAlbB3kfn0j70NYK6bI=
X-Received: by 2002:ad4:57c4:: with SMTP id y4mr2377290qvx.230.1594870897051;
 Wed, 15 Jul 2020 20:41:37 -0700 (PDT)
Date:   Wed, 15 Jul 2020 20:41:27 -0700
In-Reply-To: <20200716034128.1251728-1-badhri@google.com>
Message-Id: <20200716034128.1251728-2-badhri@google.com>
Mime-Version: 1.0
References: <20200716034128.1251728-1-badhri@google.com>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH 2/3 v3] usb: typec: tcpci: Support BIST test data mode for compliance.
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        reg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting from TCPCI spec:
"Setting this bit to 1 is intended to be used only when a USB compliance
tester is using USB BIST Test Data to test the PHY layer of the TCPC. The
TCPM should clear this bit when a disconnect is detected.
0: Normal Operation. Incoming messages enabled by RECEIVE_DETECT
passed to TCPM via Alert.
1: BIST Test Mode. Incoming messages enabled by RECEIVE_DETECT
result in GoodCRC response but may not be passed to the TCPM via
Alert."

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since V1:(Guenter's suggestions)
- Split the change into two: TCPM and TCPCI
- Move BIST log to TCPM log
- Alignment and column count changes

Changes since V2:(Guenter's suggestions)
- Re-ordered patchset
- Included Reviewed-by tag
---
 drivers/usb/typec/tcpm/tcpci.c | 9 +++++++++
 drivers/usb/typec/tcpm/tcpci.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 753645bb25273a..f57d91fd0e0924 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -227,6 +227,14 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
 				enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
 }
 
+static int tcpci_set_bist_data(struct tcpc_dev *tcpc, bool enable)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
+
+	return regmap_update_bits(tcpci->regmap, TCPC_TCPC_CTRL, TCPC_TCPC_CTRL_BIST_TM,
+				 enable ? TCPC_TCPC_CTRL_BIST_TM : 0);
+}
+
 static int tcpci_set_roles(struct tcpc_dev *tcpc, bool attached,
 			   enum typec_role role, enum typec_data_role data)
 {
@@ -530,6 +538,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.set_pd_rx = tcpci_set_pd_rx;
 	tcpci->tcpc.set_roles = tcpci_set_roles;
 	tcpci->tcpc.pd_transmit = tcpci_pd_transmit;
+	tcpci->tcpc.set_bist_data = tcpci_set_bist_data;
 
 	err = tcpci_parse_config(tcpci);
 	if (err < 0)
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index 303ebde265465c..11c36d086c8608 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -36,6 +36,7 @@
 
 #define TCPC_TCPC_CTRL			0x19
 #define TCPC_TCPC_CTRL_ORIENTATION	BIT(0)
+#define TCPC_TCPC_CTRL_BIST_TM		BIT(1)
 
 #define TCPC_ROLE_CTRL			0x1a
 #define TCPC_ROLE_CTRL_DRP		BIT(6)
-- 
2.27.0.389.gc38d7665816-goog

