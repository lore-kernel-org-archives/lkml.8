Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CFCC433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 03:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E3C2073E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 03:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyQgXwWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgGRDFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 23:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGRDFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 23:05:49 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF58AC0619D2;
        Fri, 17 Jul 2020 20:05:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q17so6262124pfu.8;
        Fri, 17 Jul 2020 20:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s0bPXMdX/gLeZJkA8kYL9ZRzdQQF5fbDlom5NC+jb10=;
        b=LyQgXwWeMz66AYtzZPLQN7XJ8zJJ7GIpcEuVShlLxAy10Ovh2OKkzQyq3iE0HcYmFR
         pArR97N3ZWU2dQDJTd3+LAvkCO7VmsK0QkfQkGQkH7szDiz9nycdZXDBLsRu/MYNtxnu
         c8uXaYmwVaSj+6+SN66vmBi51raoFnTg3OBezOa2XBPQyappXarOcgnkkL3EI9aDotxk
         VXXSTO1sBPXqCSiBC5Dndi1h3jfX7tcdPUwVYUvV+qRYwdhLhunNefQ4GrD6DrwnQYG5
         ua3W03pYYyRawCWfMwWVc3zINk+z03iq6G/U/2hjxjfbda5xaf5sIFQaWYo4thcYGF3E
         lBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s0bPXMdX/gLeZJkA8kYL9ZRzdQQF5fbDlom5NC+jb10=;
        b=pTtKbnNMCfnpQM3zYe7OrAj1wSLSJGLzZ6v7YmTxsJ7wYTvJp8UsrTNazfBRVxshgx
         LSTFmP/yJzwZ19q1kLvjV2kYz7vXN06No05p2VRKde5W0P8jYNjcD3XMgNqAa5OSDdev
         7VH1ldEnJnnsU+ASN7VPBRDXdBGXD4NlIbEUOZ82zep7jKusg54vLTip64RSOYA6yYCW
         dvhgJs1Vpb/13awpRyjBneOKn7lMV41cc39I5I1dVptu3AkU4DHc+eS4/rGBdp9d7hCI
         zl3v4WhLCqRvaxn6ysNTedsdrGIOwjHYP/7Me6oSdE3vW9SlX5BhOndy0aCiBFIgpAwq
         b7hQ==
X-Gm-Message-State: AOAM530N/r+TmKcqVXX1fTUXf9hvCqgMqnZX4vigh0GdW/lF9CeWBXf/
        UnWWzJsruUDqyxQNVgIkCGtWk4jf
X-Google-Smtp-Source: ABdhPJxb13oZtxiCIm6ZTbuuVOzEZAb1CZyNjdVipyblB6s1d4r3UsQcVirfl3YtRzRC7mCB7pwcyQ==
X-Received: by 2002:a62:7e51:: with SMTP id z78mr10587547pfc.3.1595041548972;
        Fri, 17 Jul 2020 20:05:48 -0700 (PDT)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id c9sm617331pjr.35.2020.07.17.20.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 20:05:48 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Eric Dumazet <edumazet@google.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 3/4] net: Call into DSA netdevice_ops wrappers
Date:   Fri, 17 Jul 2020 20:05:32 -0700
Message-Id: <20200718030533.171556-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200718030533.171556-1-f.fainelli@gmail.com>
References: <20200718030533.171556-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the core net_device code call into our ndo_do_ioctl() and
ndo_get_phys_port_name() functions via the wrappers defined previously

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/core/dev.c       | 5 +++++
 net/core/dev_ioctl.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 062a00fdca9b..19f1abc26fcd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -98,6 +98,7 @@
 #include <net/busy_poll.h>
 #include <linux/rtnetlink.h>
 #include <linux/stat.h>
+#include <net/dsa.h>
 #include <net/dst.h>
 #include <net/dst_metadata.h>
 #include <net/pkt_sched.h>
@@ -8602,6 +8603,10 @@ int dev_get_phys_port_name(struct net_device *dev,
 	const struct net_device_ops *ops = dev->netdev_ops;
 	int err;
 
+	err  = dsa_ndo_get_phys_port_name(dev, name, len);
+	if (err == 0 || err != -EOPNOTSUPP)
+		return err;
+
 	if (ops->ndo_get_phys_port_name) {
 		err = ops->ndo_get_phys_port_name(dev, name, len);
 		if (err != -EOPNOTSUPP)
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index a213c703c90a..b2cf9b7bb7b8 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -5,6 +5,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/net_tstamp.h>
 #include <linux/wireless.h>
+#include <net/dsa.h>
 #include <net/wext.h>
 
 /*
@@ -231,6 +232,10 @@ static int dev_do_ioctl(struct net_device *dev,
 	const struct net_device_ops *ops = dev->netdev_ops;
 	int err = -EOPNOTSUPP;
 
+	err = dsa_ndo_do_ioctl(dev, ifr, cmd);
+	if (err == 0 || err != -EOPNOTSUPP)
+		return err;
+
 	if (ops->ndo_do_ioctl) {
 		if (netif_device_present(dev))
 			err = ops->ndo_do_ioctl(dev, ifr, cmd);
-- 
2.25.1

