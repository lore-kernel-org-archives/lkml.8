Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F77C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09E1522518
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgGNNfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:35:19 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48214 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgGNNfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:35:17 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 23B4B2001C4;
        Tue, 14 Jul 2020 15:35:15 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 17D902001B2;
        Tue, 14 Jul 2020 15:35:15 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id CD9C8205A4;
        Tue, 14 Jul 2020 15:35:14 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/6] staging: dpaa2-ethsw: cleanup of link state and MAC addresses
Date:   Tue, 14 Jul 2020 16:34:25 +0300
Message-Id: <20200714133431.17532-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is cleaning up the link state handling of the switch
ports in patches 1-4. The last two patches are setting up the MAC
addresses of the switch ports automatically so that the user is not
forced to manually add them before adding them to a bridge.

Ioana Ciornei (6):
  staging: dpaa2-ethsw: fix reported link state
  staging: dpaa2-ethsw: ignore state interrupts when the interface is
    not running
  staging: dpaa2-ethsw: use netif_running when checking for port up
  staging: dpaa2-ethsw: disable switch ports are probe time
  staging: dpaa2-ethsw: store version information of the DPSW object
  staging: dpaa2-ethsw: setup MAC address of switch netdevices

 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h |  14 +++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c     | 106 +++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h     |   9 ++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c    | 102 +++++++++++++++++---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h    |   4 +
 5 files changed, 221 insertions(+), 14 deletions(-)

-- 
2.25.1

