Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB97C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D46BB20767
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aht1gOhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgDWQqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:46:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46694 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbgDWQqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:46:08 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03NGjjUe113798;
        Thu, 23 Apr 2020 11:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587660345;
        bh=LL1d9fgDqVzc4YX8BrZ68MJrUQeQgp4yC0o6Tu+Le9w=;
        h=From:To:CC:Subject:Date;
        b=aht1gOhbWDqxzIYQhfRo/rl/tAUPFJnDTbv+AT35FJ+xGxhJmTfhXmBoCfwR5FuCU
         /ZZjW283DpkoxR0+T++EgUhDrAvZ9aHIOJ+7QxjojgM5tQV6IlPJbgJzlOjFnflfwp
         LRtbae7jfksl0E5ZfkqZ+hXzIDp6jNhpEPwzgNx4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03NGjjk5110349
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Apr 2020 11:45:45 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 23
 Apr 2020 11:45:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 23 Apr 2020 11:45:45 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03NGjidA104812;
        Thu, 23 Apr 2020 11:45:45 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>
CC:     <linux@armlinux.org.uk>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <afd@ti.com>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net 0/2] WoL fixes for DP83822 and DP83tc811
Date:   Thu, 23 Apr 2020 11:39:45 -0500
Message-ID: <20200423163947.18313-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The WoL feature for each device was enabled during boot or when the PHY was
brought up which may be undesired.  These patches disable the WoL in the
config_init.  The disabling and enabling of the WoL is now done though the
set_wol call.

Dan

Dan Murphy (2):
  net: phy: DP83822: Fix WoL in config init to be disabled
  net: phy: DP83TC811: Fix WoL in config init to be disabled

 drivers/net/phy/dp83822.c   | 30 ++++++++++++++++--------------
 drivers/net/phy/dp83tc811.c | 13 +++++++------
 2 files changed, 23 insertions(+), 20 deletions(-)

-- 
2.25.1

