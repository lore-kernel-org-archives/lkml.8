Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A60C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3FB32067B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yE5Cbr/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgFEOBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:01:36 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60174 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgFEOBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:01:35 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 055E1EwF099487;
        Fri, 5 Jun 2020 09:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591365674;
        bh=2GHscl+SeAzWHZi2XdmGONEbgK2VVOmLwo6jNaj1WXA=;
        h=From:To:CC:Subject:Date;
        b=yE5Cbr/vLuyigzbdFaZfepph1xyeJh6CjOjgR9TNcPqOXnVgL3By5HViwidZ+zWkv
         DvBdkfzjA5g33+iswHB5UUvAkWUpkLuqIB6ja/Uk1uDYRVlnUG7/fF3Xueb8awJSaf
         wobX7xQ2GqU6p5mcMKbYSBjZXlgZqBhXCpthxWQg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 055E1EQm025952
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Jun 2020 09:01:14 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 5 Jun
 2020 09:01:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 5 Jun 2020 09:01:14 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 055E1DtW113753;
        Fri, 5 Jun 2020 09:01:14 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>, <kuba@kernel.org>
CC:     <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michael@walle.cc>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net 0/4] Fixes for OF_MDIO flag
Date:   Fri, 5 Jun 2020 09:01:03 -0500
Message-ID: <20200605140107.31275-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

There are some residual drivers that check the CONFIG_OF_MDIO flag using the
if defs. Using this check does not work when the OF_MDIO is configured as a
module. Using the IS_ENABLED macro checks if the flag is declared as built-in
or as a module.

Dan

Dan Murphy (4):
  net: dp83869: Fix OF_MDIO config check
  net: dp83867: Fix OF_MDIO config check
  net: marvell: Fix OF_MDIO config check
  net: mscc: Fix OF_MDIO config check

 drivers/net/phy/dp83867.c        | 2 +-
 drivers/net/phy/dp83869.c        | 2 +-
 drivers/net/phy/marvell.c        | 2 +-
 drivers/net/phy/mscc/mscc.h      | 2 +-
 drivers/net/phy/mscc/mscc_main.c | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.26.2

