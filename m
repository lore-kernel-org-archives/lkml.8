Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A240CC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EE0222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbgBMNYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:24:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:44559 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730000AbgBMNYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:24:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 05:24:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,436,1574150400"; 
   d="scan'208";a="347728491"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2020 05:24:33 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 2/9] usb: typec: mux: Add helpers for setting the mux state
Date:   Thu, 13 Feb 2020 16:24:21 +0300
Message-Id: <20200213132428.53374-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213132428.53374-1-heikki.krogerus@linux.intel.com>
References: <20200213132428.53374-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding helpers typec_switch_set() and typec_mux_set() that
simply call the ->set callback function of the mux. These
functions make it possible to set the mux states also from
outside the class code.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/class.c     | 10 ++++------
 drivers/usb/typec/mux.c       | 19 +++++++++++++++++++
 include/linux/usb/typec_mux.h |  5 +++++
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 7c44e930602f..57ef8b91864b 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1495,11 +1495,9 @@ int typec_set_orientation(struct typec_port *port,
 {
 	int ret;
 
-	if (port->sw) {
-		ret = port->sw->set(port->sw, orientation);
-		if (ret)
-			return ret;
-	}
+	ret = typec_switch_set(port->sw, orientation);
+	if (ret)
+		return ret;
 
 	port->orientation = orientation;
 
@@ -1533,7 +1531,7 @@ int typec_set_mode(struct typec_port *port, int mode)
 
 	state.mode = mode;
 
-	return port->mux ? port->mux->set(port->mux, &state) : 0;
+	return typec_mux_set(port->mux, &state);
 }
 EXPORT_SYMBOL_GPL(typec_set_mode);
 
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 3a9970d1d1c0..2b10869f0abd 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -151,6 +151,16 @@ typec_switch_register(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(typec_switch_register);
 
+int typec_switch_set(struct typec_switch *sw,
+		     enum typec_orientation orientation)
+{
+	if (IS_ERR_OR_NULL(sw))
+		return 0;
+
+	return sw->set(sw, orientation);
+}
+EXPORT_SYMBOL_GPL(typec_switch_set);
+
 /**
  * typec_switch_unregister - Unregister USB Type-C orientation switch
  * @sw: USB Type-C orientation switch
@@ -286,6 +296,15 @@ void typec_mux_put(struct typec_mux *mux)
 }
 EXPORT_SYMBOL_GPL(typec_mux_put);
 
+int typec_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
+{
+	if (IS_ERR_OR_NULL(mux))
+		return 0;
+
+	return mux->set(mux, state);
+}
+EXPORT_SYMBOL_GPL(typec_mux_set);
+
 static void typec_mux_release(struct device *dev)
 {
 	kfree(to_typec_mux(dev));
diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
index 47ab5a828b07..4991c93df5d0 100644
--- a/include/linux/usb/typec_mux.h
+++ b/include/linux/usb/typec_mux.h
@@ -23,6 +23,9 @@ struct typec_switch_desc {
 
 struct typec_switch *typec_switch_get(struct device *dev);
 void typec_switch_put(struct typec_switch *sw);
+int typec_switch_set(struct typec_switch *sw,
+		     enum typec_orientation orientation);
+
 struct typec_switch *
 typec_switch_register(struct device *parent,
 		      const struct typec_switch_desc *desc);
@@ -50,6 +53,8 @@ struct typec_mux_desc {
 struct typec_mux *
 typec_mux_get(struct device *dev, const struct typec_altmode_desc *desc);
 void typec_mux_put(struct typec_mux *mux);
+int typec_mux_set(struct typec_mux *mux, struct typec_mux_state *state);
+
 struct typec_mux *
 typec_mux_register(struct device *parent, const struct typec_mux_desc *desc);
 void typec_mux_unregister(struct typec_mux *mux);
-- 
2.25.0

