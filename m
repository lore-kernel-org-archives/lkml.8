Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53628C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EDD6206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918274;
	bh=10+zJNWlRoM66xwFf3KVQNglej270cZB0fTcSdq6LUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yHUh6IW1rSUtsTjm5Fs2EAw1smZePp3qEOQvcb4gyjoLRvZs3DCF1P5/VYV6Z09HY
	 YsE7q/q8JzRgxdEPugyH/a71wbkw3IEe4FsClGyUBLmwJiTs0YVuNwayP3P09wNVPy
	 a2LJfAZOQTgroVnVU018v+IFRSVW+B/FK/WlQZow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbgHTKLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730931AbgHTKKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:10:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD0EC2067C;
        Thu, 20 Aug 2020 10:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918253;
        bh=10+zJNWlRoM66xwFf3KVQNglej270cZB0fTcSdq6LUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJQvY+Ai0WBZvV+qe1m7qhmMrzApH9S8/qJ0c/WYvFkTwsiJXeuA/1kim2KXRi0N8
         8IBnXHz7uNxF/FvLo2cQCd8fyvpjwp21IRGxZo7682jv5bfCg4JMHSjM9Xz8IrvTZk
         yZo3FYYeB7u4j0Xyh7OJd8VtgA+/02jaMOv+8d4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 105/228] mwifiex: Prevent memory corruption handling keys
Date:   Thu, 20 Aug 2020 11:21:20 +0200
Message-Id: <20200820091612.848621514@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit e18696786548244914f36ec3c46ac99c53df99c3 ]

The length of the key comes from the network and it's a 16 bit number.  It
needs to be capped to prevent a buffer overflow.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200708115857.GA13729@mwanda
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../wireless/marvell/mwifiex/sta_cmdresp.c    | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
index 0fba5b10ef2d7..19ce279df24d9 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
@@ -585,6 +585,11 @@ static int mwifiex_ret_802_11_key_material_v1(struct mwifiex_private *priv,
 {
 	struct host_cmd_ds_802_11_key_material *key =
 						&resp->params.key_material;
+	int len;
+
+	len = le16_to_cpu(key->key_param_set.key_len);
+	if (len > sizeof(key->key_param_set.key))
+		return -EINVAL;
 
 	if (le16_to_cpu(key->action) == HostCmd_ACT_GEN_SET) {
 		if ((le16_to_cpu(key->key_param_set.key_info) & KEY_MCAST)) {
@@ -598,9 +603,8 @@ static int mwifiex_ret_802_11_key_material_v1(struct mwifiex_private *priv,
 
 	memset(priv->aes_key.key_param_set.key, 0,
 	       sizeof(key->key_param_set.key));
-	priv->aes_key.key_param_set.key_len = key->key_param_set.key_len;
-	memcpy(priv->aes_key.key_param_set.key, key->key_param_set.key,
-	       le16_to_cpu(priv->aes_key.key_param_set.key_len));
+	priv->aes_key.key_param_set.key_len = cpu_to_le16(len);
+	memcpy(priv->aes_key.key_param_set.key, key->key_param_set.key, len);
 
 	return 0;
 }
@@ -615,9 +619,14 @@ static int mwifiex_ret_802_11_key_material_v2(struct mwifiex_private *priv,
 					      struct host_cmd_ds_command *resp)
 {
 	struct host_cmd_ds_802_11_key_material_v2 *key_v2;
-	__le16 len;
+	int len;
 
 	key_v2 = &resp->params.key_material_v2;
+
+	len = le16_to_cpu(key_v2->key_param_set.key_params.aes.key_len);
+	if (len > WLAN_KEY_LEN_CCMP)
+		return -EINVAL;
+
 	if (le16_to_cpu(key_v2->action) == HostCmd_ACT_GEN_SET) {
 		if ((le16_to_cpu(key_v2->key_param_set.key_info) & KEY_MCAST)) {
 			mwifiex_dbg(priv->adapter, INFO, "info: key: GTK is set\n");
@@ -633,10 +642,9 @@ static int mwifiex_ret_802_11_key_material_v2(struct mwifiex_private *priv,
 	memset(priv->aes_key_v2.key_param_set.key_params.aes.key, 0,
 	       WLAN_KEY_LEN_CCMP);
 	priv->aes_key_v2.key_param_set.key_params.aes.key_len =
-				key_v2->key_param_set.key_params.aes.key_len;
-	len = priv->aes_key_v2.key_param_set.key_params.aes.key_len;
+				cpu_to_le16(len);
 	memcpy(priv->aes_key_v2.key_param_set.key_params.aes.key,
-	       key_v2->key_param_set.key_params.aes.key, le16_to_cpu(len));
+	       key_v2->key_param_set.key_params.aes.key, len);
 
 	return 0;
 }
-- 
2.25.1



