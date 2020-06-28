Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A59C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BB720757
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzDgpAan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgF1Sjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 14:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgF1Sjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 14:39:39 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F276BC03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 11:39:38 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b15so11039885edy.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 11:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lm0EvFj5SQqQjjPPBO8iNtNM6ecOSgXLk09O7mbVMlw=;
        b=AzDgpAan7U2t78PhMuTnRQwakm9/ua25ia2AGWFY6rYOUeUUiNEy9HDehVBbNLiPmU
         wADNS+4eA9YrFDVIydHVvI3SCEU7HRYxR7+g58LfvzAlk9JGjy9G/44lWo+/b51GoLxZ
         AsNcgQdQcDtiXscmmxcqEBgN0jQXl8Re6yuIFhifWqLONr1T9fPCEMZD+tBnjCJ4iAc5
         ciNdDZPVUOYLny0Bhbk4tuFhdJApxf2Cr2TRGZbXMqLBcmhFQybpuNvDnWXhLSw2mXBD
         F7jgBCFE61B9FDNbJVopmADEuubNvwfCLV80MQZunRcpyAMlHeCSYq7/aZTs/RgGPhpV
         wq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lm0EvFj5SQqQjjPPBO8iNtNM6ecOSgXLk09O7mbVMlw=;
        b=D+PwNp0/P9WRYoCnjHgV+aeyQAeOTKhvEJ1hMCkkBNZQKlqtoPqrgCCGYvHbwLzx7c
         YklCgenL2zJeObH1T8Wf/llltPH3CMNDqepFIhkHdueUP+A63FX2LqlQn2sSxiLCrluH
         v/JEqkRN6GK7LEcu7owcWy4C2lS/hD5D+awD3yzFkIMd1H6v3zjM7Au21tU66TVRpWW4
         XWuudzTV3ypaoEm+uWlnOImgrkOanwQhVK7uzIiRH4OD7RVValxtihSbF1+1ECmC5otY
         G5hv8BfyJsz6KD/oMwoRvRYQEzNfbZDJQJCogwUVXW1RsDVWbk/l3Q26LB6CKmccFH6t
         P7IQ==
X-Gm-Message-State: AOAM531bLgEFycZcR+HZCq3FvhfNCUn4kyoENzqMv5F6BFE5mEW2FpHh
        EaAemxJCTQa5q49fmRKuNeE=
X-Google-Smtp-Source: ABdhPJzkAToo93OpIPSXT3A97figlkjnzzRq/XOS6rmjm9XAFRSpYUlX+ZbyEr7BGtc3IuK4QptnAA==
X-Received: by 2002:aa7:d297:: with SMTP id w23mr13400049edq.49.1593369577818;
        Sun, 28 Jun 2020 11:39:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:f145:9a83:6418:5a5c])
        by smtp.gmail.com with ESMTPSA id d20sm1016070edy.9.2020.06.28.11.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 11:39:37 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] staging: ks7010: fix ks_wlan_start_xmit()'s return type
Date:   Sun, 28 Jun 2020 20:39:26 +0200
Message-Id: <20200628183926.74908-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too and
usind 'NETDEV_TX_OK' instead of 0 accordingly.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/staging/ks7010/ks_wlan_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 211dd4a11cac..334ae1ded684 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -46,7 +46,7 @@ struct wep_key {
  */
 static int ks_wlan_open(struct net_device *dev);
 static void ks_wlan_tx_timeout(struct net_device *dev, unsigned int txqueue);
-static int ks_wlan_start_xmit(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t ks_wlan_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static int ks_wlan_close(struct net_device *dev);
 static void ks_wlan_set_rx_mode(struct net_device *dev);
 static struct net_device_stats *ks_wlan_get_stats(struct net_device *dev);
@@ -2511,7 +2511,7 @@ void ks_wlan_tx_timeout(struct net_device *dev, unsigned int txqueue)
 }
 
 static
-int ks_wlan_start_xmit(struct sk_buff *skb, struct net_device *dev)
+netdev_tx_t ks_wlan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 	int ret;
-- 
2.27.0

