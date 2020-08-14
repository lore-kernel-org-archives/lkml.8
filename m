Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821EDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589DE20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+111kqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgHNLjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgHNLjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:39:44 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D34C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:39:43 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k8so7668770wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MUV+yz+bHDDxU9QUealM8/lB5IQK1oTN3Rz5yVKFYm4=;
        b=l+111kqHdNB0lIDK3r++LA2g+EZA//8R6aznyiwvdp+j0MKetNqHwbb7cuk9RrKa2E
         8JEl3bytLKvZNB/Kxrxwcx0aPjN7M2y+bOQJkVsEiBcXovmpYZgNBqtD6uN8FUb9juC4
         ejvTWSUKwvqTKg/RZkPj8akPf09yu4PUEvPnRRoVS4e5LN87uJ5aMmSjKUKFY9bkIP+I
         mSSQkwqKtAL2BuvfF57rSKTwc30gSoz3RwUrZHckDSPhZpBbmMAtNleFt3ViyH/499aK
         3sVD5bU402VDJaCJNhhN0gQnHRlothsgZqgQA7s3EBeQu5SpL3otQ7BRPB+1QHx7p2qW
         2Dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MUV+yz+bHDDxU9QUealM8/lB5IQK1oTN3Rz5yVKFYm4=;
        b=OUvTii6oA9RV+4ubljVVtnD6kQdl6x3edi2MPieJbPjwMy79QgQTTMU6Oi3D8JPu9u
         GIdLoqG96PRcbqVlmQRrizSQNh9OlKwWMQlnik3gLmPpzKGBwEK8TtbVItfM93A19yLK
         9XfkcP6Vb4HNaVzE32BxSOPxZayy0lYnxM/iBUEF42qEcRO00q2p7/sIuZWWuoFnHChe
         I2mS2O0bc6QUxBaPlvXOEwENZiEe/JxxSloKifTIInUIpVc2iV5jIIVP8bvv+6uCVFh1
         vWmtTo6tL/0bgEUXSwMkm2FLgf3sEZhy2/N1pZKgM+C/Ov90JBDdhgMC43pSZT/LfeGs
         w4SQ==
X-Gm-Message-State: AOAM532cZpnd84sk+R7gZefSKtryK9550/XRJZlF7Pkk2ZzayyS8pGm2
        h/1IsC55bEAi4FJJbG9ZgLNhNg==
X-Google-Smtp-Source: ABdhPJzL3xmyXx+1jDTkp7IuUawasCOHs8oE9JoXge8m6lDvNsUquUCvs2Sem2m06iG2L4QTo3QEZQ==
X-Received: by 2002:a1c:7405:: with SMTP id p5mr2151480wmc.130.1597405182109;
        Fri, 14 Aug 2020 04:39:42 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:39:41 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Thomas Davis <tadavis@lbl.gov>, netdev@vger.kernel.org
Subject: [PATCH 02/30] net: bonding: bond_main: Document 'proto' and rename 'new_active' parameters
Date:   Fri, 14 Aug 2020 12:39:05 +0100
Message-Id: <20200814113933.1903438-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/bonding/bond_main.c:329: warning: Function parameter or member 'proto' not described in 'bond_vlan_rx_add_vid'
 drivers/net/bonding/bond_main.c:362: warning: Function parameter or member 'proto' not described in 'bond_vlan_rx_kill_vid'
 drivers/net/bonding/bond_main.c:964: warning: Function parameter or member 'new_active' not described in 'bond_change_active_slave'
 drivers/net/bonding/bond_main.c:964: warning: Excess function parameter 'new' description in 'bond_change_active_slave'

Cc: Jay Vosburgh <j.vosburgh@gmail.com>
Cc: Veaceslav Falico <vfalico@gmail.com>
Cc: Andy Gospodarek <andy@greyhouse.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Davis <tadavis@lbl.gov>
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/bonding/bond_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 5ad43aaf76e56..a448467d8789a 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -322,6 +322,7 @@ netdev_tx_t bond_dev_queue_xmit(struct bonding *bond, struct sk_buff *skb,
 /**
  * bond_vlan_rx_add_vid - Propagates adding an id to slaves
  * @bond_dev: bonding net device that got called
+ * @proto: network protocol ID
  * @vid: vlan id being added
  */
 static int bond_vlan_rx_add_vid(struct net_device *bond_dev,
@@ -355,6 +356,7 @@ static int bond_vlan_rx_add_vid(struct net_device *bond_dev,
 /**
  * bond_vlan_rx_kill_vid - Propagates deleting an id to slaves
  * @bond_dev: bonding net device that got called
+ * @proto: network protocol ID
  * @vid: vlan id being removed
  */
 static int bond_vlan_rx_kill_vid(struct net_device *bond_dev,
@@ -948,7 +950,7 @@ static bool bond_should_notify_peers(struct bonding *bond)
 /**
  * change_active_interface - change the active slave into the specified one
  * @bond: our bonding struct
- * @new: the new slave to make the active one
+ * @new_active: the new slave to make the active one
  *
  * Set the new slave to the bond's settings and unset them on the old
  * curr_active_slave.
-- 
2.25.1

