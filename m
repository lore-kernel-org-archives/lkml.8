Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA218C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8092146E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RjexQymL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbgCDLuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:50:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33684 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgCDLuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:50:22 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 024BoKr2000813;
        Wed, 4 Mar 2020 05:50:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583322621;
        bh=I1LvhXp8lDPeOMH6UKe4C7/GztRumHt7wXjhQP2BUuI=;
        h=From:To:CC:Subject:Date;
        b=RjexQymLssiCTHHxYriW7IAAs39o/2H/inKqg61EuL2liVYl8XmvMJO9zY6H3ppr4
         UsbPi76CG9RLqoYG2SP7HW30qZ+XFj2lYuj5lf9wiaM37CYuYoCoWHm/mLi5aNBEdo
         +0+Z9NaCgm6rRgD+MdTB/sRbFcUZZVbyjo7xaWbA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 024BoKQH120199
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Mar 2020 05:50:20 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 4 Mar
 2020 05:50:20 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 4 Mar 2020 05:50:20 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 024BoI9e104827;
        Wed, 4 Mar 2020 05:50:19 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL v2] PHY: For 5.6 -rc
Date:   Wed, 4 Mar 2020 17:24:54 +0530
Message-ID: <20200304115454.14921-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the updated pull request for 5.6 -rc cycle below. It only
adds an additional patch over my previous pull request (I added a new
patch since my initial pull request is not merged).

It fixes an issue caused because of adding device_link_add() on platforms
which have cyclic dependency between PHY consumer and PHY provider.

It also includes couple of timeout fixes in Motorola and other misc
fixes in TI and Broadcom's PHY driver.
Please see the tag message for the complete list of changes and let me
know if I have to change something.

Thanks
Kishon

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.6-rc_v2

for you to fetch changes up to be4e3c737eebd75815633f4b8fd766defaf0f1fc:

  phy: mapphone-mdm6600: Fix timeouts by adding wake-up handling (2020-02-27 10:20:40 +0530)

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

Tony Lindgren (2):
      phy: mapphone-mdm6600: Fix write timeouts with shorter GPIO toggle interval
      phy: mapphone-mdm6600: Fix timeouts by adding wake-up handling

 drivers/phy/broadcom/phy-brcm-sata.c        | 148 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------------------------
 drivers/phy/motorola/phy-mapphone-mdm6600.c |  27 ++++++++++++++++++++++++---
 drivers/phy/phy-core.c                      |  18 ++++++------------
 drivers/phy/ti/phy-gmii-sel.c               |  10 +++++-----
 4 files changed, 100 insertions(+), 103 deletions(-)
-- 
2.17.1

