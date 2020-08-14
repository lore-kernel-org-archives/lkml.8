Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2394CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5DB420771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k8kEegPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgHNLjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNLjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:39:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD86C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:39:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k8so7668735wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dAFcbyfiLFxJ6YM+Uc6dODcjCd4qp0P9KJY2UNEh1zo=;
        b=k8kEegPS0quMxSTfE7dBkHWMmAbsOVdPpMm+2w3g7QaYRpMghCVXHHJQJamNkPf23T
         NppWzNwMEKB5c14BXvafBgOE4W6+0xY3S5+mTVCoP1dUkk3zIjc9qBTGWt0NkLRv36LD
         PaVPu6dWmwBiyJ00l5QgTxE21W2RR522LGo4/gnqx1ivQ+62Xx8IRpUnvDGXp0mCtxne
         JQioCT7UqvYv6rU3G0ZU5DseIwQ7FFWkXh6FLI/+xg+sjVjN8rDiHKtmDK5nQkcCz6Hf
         +aAhf6IUcDV7BUQNaS36OT9l+T99FKMCs/cW4i314ImOqOavpV5evntHwgf/e9TjFDIq
         tkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAFcbyfiLFxJ6YM+Uc6dODcjCd4qp0P9KJY2UNEh1zo=;
        b=Bak78lkIVKOB+194z3f3i+JdtwzR6H0aIML1DDKYZUty/1BjZTEgoWmin3wXwcmn5j
         kPcLg/VRQ86kpAF/9I4iCd6tNibVcDnWfp8fi9NWKCETtKTHwsl/lhUaoTolBpGz/waF
         EvZ4C1o/UNRZe2HChRhuXYIMCXlxAuQm4P1ZF9Gg7yVdTqNizu63X/iNC15HwAMcPp4b
         1th37D4TpRuGrRFgdy1fXR1ZbpmTnbk6u035SgFKQUD/oc59hlhJvpC7nKpV0DCsnIKF
         cFMZvxRlDARCtEmG/Bnj0KE9FHGdJBElNeqX4p5Q3uqzeMY49ylZLjgUZ+p2ggWcahUy
         nkiw==
X-Gm-Message-State: AOAM530d1u9ow02TgKn2DonwHhzCECNWezOrVeNs352CvBBM+eT5FCq2
        ZIhWRgLzZW0aPUht9/Bhn9qlEQ==
X-Google-Smtp-Source: ABdhPJw9sus+Q3MmWDBPU0OLoTXny8mT0azeyTIdFNVcBJoQywB68Y7udAa2oY3RYywYOE5jkM8p2g==
X-Received: by 2002:a1c:3c87:: with SMTP id j129mr2154154wma.176.1597405180892;
        Fri, 14 Aug 2020 04:39:40 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:39:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org
Subject: [PATCH 01/30] net: bonding: bond_3ad: Fix a bunch of kerneldoc parameter issues
Date:   Fri, 14 Aug 2020 12:39:04 +0100
Message-Id: <20200814113933.1903438-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renames and missing descriptions.

Fixes the following W=1 kernel build warning(s):

 drivers/net/bonding/bond_3ad.c:140: warning: Function parameter or member 'port' not described in '__get_first_agg'
 drivers/net/bonding/bond_3ad.c:140: warning: Excess function parameter 'bond' description in '__get_first_agg'
 drivers/net/bonding/bond_3ad.c:1655: warning: Function parameter or member 'agg' not described in 'ad_agg_selection_logic'
 drivers/net/bonding/bond_3ad.c:1655: warning: Excess function parameter 'aggregator' description in 'ad_agg_selection_logic'
 drivers/net/bonding/bond_3ad.c:1817: warning: Function parameter or member 'port' not described in 'ad_initialize_port'
 drivers/net/bonding/bond_3ad.c:1817: warning: Excess function parameter 'aggregator' description in 'ad_initialize_port'
 drivers/net/bonding/bond_3ad.c:1976: warning: Function parameter or member 'timeout' not described in 'bond_3ad_initiate_agg_selection'
 drivers/net/bonding/bond_3ad.c:2274: warning: Function parameter or member 'work' not described in 'bond_3ad_state_machine_handler'
 drivers/net/bonding/bond_3ad.c:2274: warning: Excess function parameter 'bond' description in 'bond_3ad_state_machine_handler'
 drivers/net/bonding/bond_3ad.c:2508: warning: Function parameter or member 'link' not described in 'bond_3ad_handle_link_change'
 drivers/net/bonding/bond_3ad.c:2508: warning: Excess function parameter 'status' description in 'bond_3ad_handle_link_change'
 drivers/net/bonding/bond_3ad.c:2566: warning: Function parameter or member 'bond' not described in 'bond_3ad_set_carrier'
 drivers/net/bonding/bond_3ad.c:2677: warning: Function parameter or member 'bond' not described in 'bond_3ad_update_lacp_rate'
 drivers/net/bonding/bond_3ad.c:1655: warning: Function parameter or member 'agg' not described in 'ad_agg_selection_logic'
 drivers/net/bonding/bond_3ad.c:1655: warning: Excess function parameter 'aggregator' description in 'ad_agg_selection_logic'
 drivers/net/bonding/bond_3ad.c:1817: warning: Function parameter or member 'port' not described in 'ad_initialize_port'
 drivers/net/bonding/bond_3ad.c:1817: warning: Excess function parameter 'aggregator' description in 'ad_initialize_port'
 drivers/net/bonding/bond_3ad.c:1976: warning: Function parameter or member 'timeout' not described in 'bond_3ad_initiate_agg_selection'
 drivers/net/bonding/bond_3ad.c:2274: warning: Function parameter or member 'work' not described in 'bond_3ad_state_machine_handler'
 drivers/net/bonding/bond_3ad.c:2274: warning: Excess function parameter 'bond' description in 'bond_3ad_state_machine_handler'
 drivers/net/bonding/bond_3ad.c:2508: warning: Function parameter or member 'link' not described in 'bond_3ad_handle_link_change'
 drivers/net/bonding/bond_3ad.c:2508: warning: Excess function parameter 'status' description in 'bond_3ad_handle_link_change'
 drivers/net/bonding/bond_3ad.c:2566: warning: Function parameter or member 'bond' not described in 'bond_3ad_set_carrier'
 drivers/net/bonding/bond_3ad.c:2677: warning: Function parameter or member 'bond' not described in 'bond_3ad_update_lacp_rate'

Cc: Jay Vosburgh <j.vosburgh@gmail.com>
Cc: Veaceslav Falico <vfalico@gmail.com>
Cc: Andy Gospodarek <andy@greyhouse.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/bonding/bond_3ad.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 31e43a2197a30..cddaa43a9d527 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -130,7 +130,7 @@ static inline struct bonding *__get_bond_by_port(struct port *port)
 
 /**
  * __get_first_agg - get the first aggregator in the bond
- * @bond: the bond we're looking at
+ * @port: the port we're looking at
  *
  * Return the aggregator of the first slave in @bond, or %NULL if it can't be
  * found.
@@ -1626,7 +1626,7 @@ static int agg_device_up(const struct aggregator *agg)
 
 /**
  * ad_agg_selection_logic - select an aggregation group for a team
- * @aggregator: the aggregator we're looking at
+ * @agg: the aggregator we're looking at
  * @update_slave_arr: Does slave array need update?
  *
  * It is assumed that only one aggregator may be selected for a team.
@@ -1810,7 +1810,7 @@ static void ad_initialize_agg(struct aggregator *aggregator)
 
 /**
  * ad_initialize_port - initialize a given port's parameters
- * @aggregator: the aggregator we're looking at
+ * @port: the port we're looking at
  * @lacp_fast: boolean. whether fast periodic should be used
  */
 static void ad_initialize_port(struct port *port, int lacp_fast)
@@ -1967,6 +1967,7 @@ static void ad_marker_response_received(struct bond_marker *marker,
 /**
  * bond_3ad_initiate_agg_selection - initate aggregator selection
  * @bond: bonding struct
+ * @timeout: timeout value to set
  *
  * Set the aggregation selection timer, to initiate an agg selection in
  * the very near future.  Called during first initialization, and during
@@ -2259,7 +2260,7 @@ void bond_3ad_update_ad_actor_settings(struct bonding *bond)
 
 /**
  * bond_3ad_state_machine_handler - handle state machines timeout
- * @bond: bonding struct to work on
+ * @work: work context to fetch bonding struct to work on from
  *
  * The state machine handling concept in this module is to check every tick
  * which state machine should operate any function. The execution order is
@@ -2500,7 +2501,7 @@ void bond_3ad_adapter_speed_duplex_changed(struct slave *slave)
 /**
  * bond_3ad_handle_link_change - handle a slave's link status change indication
  * @slave: slave struct to work on
- * @status: whether the link is now up or down
+ * @link: whether the link is now up or down
  *
  * Handle reselection of aggregator (if needed) for this port.
  */
@@ -2551,7 +2552,7 @@ void bond_3ad_handle_link_change(struct slave *slave, char link)
 
 /**
  * bond_3ad_set_carrier - set link state for bonding master
- * @bond - bonding structure
+ * @bond: bonding structure
  *
  * if we have an active aggregator, we're up, if not, we're down.
  * Presumes that we cannot have an active aggregator if there are
@@ -2664,7 +2665,7 @@ int bond_3ad_lacpdu_recv(const struct sk_buff *skb, struct bonding *bond,
 
 /**
  * bond_3ad_update_lacp_rate - change the lacp rate
- * @bond - bonding struct
+ * @bond: bonding struct
  *
  * When modify lacp_rate parameter via sysfs,
  * update actor_oper_port_state of each port.
-- 
2.25.1

