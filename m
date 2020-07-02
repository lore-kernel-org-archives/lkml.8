Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05157C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2795207E8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpKvcG6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgGBE3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 00:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGBE3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 00:29:48 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72030C08C5C1;
        Wed,  1 Jul 2020 21:29:48 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id z5so12826590pgb.6;
        Wed, 01 Jul 2020 21:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUm6E77m5P4a+BM3+YaHgq+ITExt67rKXnpDKt5YS1I=;
        b=hpKvcG6qEqukV5QTmexCdK73ZvzYWQhPLrjrq49aep6EIMD29V8sTH1HaiHCcGqu34
         IYvdKcY+L/q3Lzn98WRrNiw5E6PQ+xgEl9yAwsqi/UQF4TqbMV60RFVSwd8XWUXJY2vX
         Eip7OyCMe/bBkxj+urccVQszHySlOWrTswx++Us0U9YUmMqIuPGiD9F08uCb2xv5zu+N
         8GnnpDrjqOOgUDvOIDxCAVkCoQJHRbDDA1/4wVA7ixRFToTdX7gyoZSTyUrGvCVwkH+w
         alDXe92xj/LPSebSrXGZLYz5euoIylKgwUr7VhMhoaTewuogFsfwA7k7RSIxGa7zejZ0
         3J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUm6E77m5P4a+BM3+YaHgq+ITExt67rKXnpDKt5YS1I=;
        b=TkaPG7SE1m+RUCyO9a3xzVfBO73qD4B9/EjGnEBZC9lz0msAm04PXSmlZ4XPjGXX2I
         flgbqpmrL9ZP/JZzbZODK6skyvak4rU6rJvs0/qCDZPo+4kG6MAefjSjBFfw4pdmItPi
         EzN2jrxsadtoKAJ5TSpSioaoqWwbqwH1ClHmB1xPlSC15uB+A2UhV5DBqeMdWJp7yHdE
         x9NCd9h+gqVvn5W3udW8WDmklb26QGExtoh0MiPOGHxWzZUQ738rrssSzj13jg5NbGI8
         19PJGAvnAhxs5aFiSL57GvZLuFnqCWF5QY+AdO/tbKjo2pabde41834Ix9f7z+hAKwbK
         L6/A==
X-Gm-Message-State: AOAM530e3Xrc+pCVdAhjyfGPfMbrjzHsbvE4PXWvEsNanG5H4VB0zfJ0
        VahKMBF+F0Vbo5P9TtXodjHs0hQH
X-Google-Smtp-Source: ABdhPJwvR7pOaepK24rQhaa+zvd3HSWeEKeskS1L5CvOvDra0LrUn9Mepu5J8jhPDy6AWat3EZowGQ==
X-Received: by 2002:a63:34c3:: with SMTP id b186mr22836965pga.173.1593664187530;
        Wed, 01 Jul 2020 21:29:47 -0700 (PDT)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id np5sm6806248pjb.43.2020.07.01.21.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 21:29:46 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Michal Kubecek <mkubecek@suse.cz>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 0/4] net: ethtool: Untangle PHYLIB dependency
Date:   Wed,  1 Jul 2020 21:29:38 -0700
Message-Id: <20200702042942.76674-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series untangles the ethtool netlink dependency with PHYLIB
which exists because the cable test feature calls directly into PHY
library functions. The approach taken here is to utilize a new set of
net_device_ops function pointers which are automatically set to the PHY
library variants when a network device driver attaches to a PHY device.

Florian Fainelli (4):
  net: Add cable test netdevice operations
  net: phy: Change cable test arguments to net_device
  net: phy: Automatically set-up cable test netdev_ops
  net: ethtool: Remove PHYLIB dependency

 drivers/net/phy/phy.c        | 18 ++++++++++++++----
 drivers/net/phy/phy_device.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/netdevice.h    | 14 ++++++++++++++
 include/linux/phy.h          | 10 ++++++----
 net/Kconfig                  |  1 -
 net/ethtool/cabletest.c      | 12 ++++++++----
 6 files changed, 74 insertions(+), 13 deletions(-)

-- 
2.25.1

