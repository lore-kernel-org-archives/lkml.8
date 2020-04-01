Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106B2C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A9D20714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbgDAHrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:47:13 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54818 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731999AbgDAHrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 03:47:12 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 15E27200C90;
        Wed,  1 Apr 2020 09:47:11 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C0384200C8F;
        Wed,  1 Apr 2020 09:47:05 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 536D64030D;
        Wed,  1 Apr 2020 15:46:59 +0800 (SGT)
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, michal.simek@xilinx.com,
        manish.narani@xilinx.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        frank.li@nxp.com
Subject: [PATCH v2 0/4] Add edac driver for i.MX8MP based on synopsys edac driver
Date:   Wed,  1 Apr 2020 15:39:05 +0800
Message-Id: <1585726749-13039-1-git-send-email-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add edac driver support for i.MX8MP, since i.MX8MP use the same
synopsys memory controller with ZynqMP, so the driver is based on synopsys_edac
driver.

Considering that i.MX8MP dts file is still in kernel/git/shawnguo/linux.git and
isn't in mainline now, I will add EDAC node in i.MX8MP dts after this file is
pushed to mainline. 

And the edac driver for i.MX8MP has been tested in kernel/git/shawnguo/linux.git
where i.MX8MP is supported, it turns out that this driver works well to detect
corrected and uncorrected errors for LPDDR4 in i.MX8MP.

Changes since v1:
=================
- Reorganized the patchset, no content changes. 

Sherry Sun (4):
  dt-bindings: memory-controllers: Add i.MX8MP DDRC binding doc
  EDAC: Add synopsys edac driver support for i.MX8MP
  EDAC: synopsys: Add edac driver support for i.MX8MP
  EDAC: synopsys: Add useful debug and output information for 64bit
    systems

 .../bindings/memory-controllers/synopsys.txt  |   8 +-
 drivers/edac/Kconfig                          |   2 +-
 drivers/edac/synopsys_edac.c                  | 259 ++++++++++++------
 3 files changed, 185 insertions(+), 84 deletions(-)

-- 
2.17.1

