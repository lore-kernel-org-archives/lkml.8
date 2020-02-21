Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C109C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E292E24650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a9VfgXb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgBULuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:50:18 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50262 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgBULuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:50:18 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01LBoHdU063163;
        Fri, 21 Feb 2020 05:50:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582285817;
        bh=nUq1IfeWsIJTpACCU2tqDoDeARn2gFF9MxvXNJ+dBzU=;
        h=From:To:CC:Subject:Date;
        b=a9VfgXb/MdPSNhy8flXd7TUxxyvOxVl1nTSC30uBJAyc4WGLvXd9Oa1qyVGYkudzT
         lt1IFxmFRyGY9ihf1GKm+UXKFOnHjK1IxbuqwLmlWro1Ztoel0Q5xOqvXoM6fVWTtP
         XJAbpW+itRVim453pn9dg/T0+tezGZKUSoZrUwkI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01LBoGIu108761
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Feb 2020 05:50:16 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 21
 Feb 2020 05:50:16 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 21 Feb 2020 05:50:16 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01LBoEup059455;
        Fri, 21 Feb 2020 05:50:15 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PHY: For 5.6 -rc
Date:   Fri, 21 Feb 2020 17:23:56 +0530
Message-ID: <20200221115356.6587-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the pull request for 5.6 -rc cycle below.

It fixes an issue caused because of adding device_link_add() on platforms
which have cyclic dependency between PHY consumer and PHY provider.

It also includes misc fixes in Motorola, TI and Broadcom's PHY driver.
Please see the tag message for the complete list of changes and let me
know if I have to change something.

Thanks
Kishon

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.6-rc

for you to fetch changes up to 0ed41b33882c577e1d6582913163a2f5727765fe:

  phy: brcm-sata: Correct MDIO operations for 40nm platforms (2020-02-21 14:01:47 +0530)

----------------------------------------------------------------
phy: for 5.6-rc

*) Fix phy_get() from erroring out if device link creation failed
*) Fix write timeouts in Motorola Mapphone mdm6600 PHY
*) Fix Broadcom brcm-sata PHY driver to write to the correct MDIO register
*) Add GMII PHY mode in supported modes of TI AM335x/437x/5xx SoCs

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Florian Fainelli (1):
      phy: brcm-sata: Correct MDIO operations for 40nm platforms

Grygorii Strashko (2):
      phy: ti: gmii-sel: fix set of copy-paste errors
      phy: ti: gmii-sel: do not fail in case of gmii

Kishon Vijay Abraham I (1):
      phy: core: Fix phy_get() to not return error on link creation failure

Tony Lindgren (1):
      phy: mapphone-mdm6600: Fix write timeouts with shorter GPIO toggle interval

 drivers/phy/broadcom/phy-brcm-sata.c        | 148 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------------------------
 drivers/phy/motorola/phy-mapphone-mdm6600.c |   9 ++++++++-
 drivers/phy/phy-core.c                      |  18 ++++++------------
 drivers/phy/ti/phy-gmii-sel.c               |  10 +++++-----
 4 files changed, 84 insertions(+), 101 deletions(-)

-- 
2.17.1

