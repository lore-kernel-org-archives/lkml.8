Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877B7C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C0952076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="trOhVudw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgD3NHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:07:46 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48114 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgD3NHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:07:46 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03UD7ir6027536;
        Thu, 30 Apr 2020 08:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588252064;
        bh=CCBvsCnbnKVyCy8qZajezdDs+LtdF+rrN8tIlu5hi+4=;
        h=From:To:CC:Subject:Date;
        b=trOhVudwBohlx2hlVlj735Z/efjQ1eEeqtV2lU/Ap6VwlDh4oOitLOpHyRpjy/eHG
         OnpN9Yoq+H2PCmCVMMGYlvXpRxGrmgFWNKFkpGuLvzBk2SX8/D8o64p6b87iWEoZI+
         9vt2/IGBAqGuf54hp0eSSRCxjfBbFmbihoF3cseo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03UD7iNN070882;
        Thu, 30 Apr 2020 08:07:44 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 30
 Apr 2020 08:07:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 30 Apr 2020 08:07:44 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03UD7ffY036041;
        Thu, 30 Apr 2020 08:07:42 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: [GIT PULL] PHY: For 5.7 -rc
Date:   Thu, 30 Apr 2020 18:37:41 +0530
Message-ID: <20200430130741.2396-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the PHY pull request for 5.7 -rc below.

Vinod Koul has kindly agreed to co-maintain PHY subsystem. So we are
also moving linux-phy to a shared repository. I've included a patch
to update MAINTAINER file to reflect both these changes in the pull
request.

Other than that it includes couple of Qualcomm driver fixes and Kconfig
depenecy fix in Tegra PHY. For the full list of changes see tag message
below.

Consider merging this for the upcoming -rc cycle and let me know if
I have to make any changes.

Thanks
Kishon

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.7-rc

for you to fetch changes up to 820eeb9de62f1f479c04fc6575d874611b1e2095:

  phy: qualcomm: usb-hs-28nm: Prepare clocks in init (2020-04-30 12:10:49 +0530)

----------------------------------------------------------------
phy: for 5.7 -rc

*) Update MAINTAINER to include Vinod Koul as co-maintainer of PHY
*) Fix Kconfig dependencies in seen with PHY_TEGRA_XUSB
*) Re-add "qcom,sdm845-qusb2-phy" compatible in phy-qcom-qusb2.c to
   make it work with existing dtbs
*) Move clock enable from ->poweron() to ->init() in Qualcomm
   usb-hs-28nm driver to initialize HW in ->init()

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Bjorn Andersson (1):
      phy: qualcomm: usb-hs-28nm: Prepare clocks in init

John Stultz (1):
      phy: qcom-qusb2: Re add "qcom,sdm845-qusb2-phy" compat string

Kishon Vijay Abraham I (1):
      MAINTAINERS: Add Vinod Koul as Generic PHY co-maintainer

Thierry Reding (1):
      phy: tegra: Select USB_COMMON for usb_get_maximum_speed()

 MAINTAINERS                                 |  3 ++-
 drivers/phy/qualcomm/phy-qcom-qusb2.c       |  7 +++++++
 drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c | 32 +++++++++++++++++++++-----------
 drivers/phy/tegra/Kconfig                   |  3 ++-
 4 files changed, 32 insertions(+), 13 deletions(-)
-- 
2.17.1

