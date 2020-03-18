Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2D3C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E02420768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgCRHmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 03:42:38 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:57377 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCRHmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 03:42:38 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id 02I7gTO9041137;
        Wed, 18 Mar 2020 15:42:29 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        bbrezillon@kernel.org
Cc:     frieder.schrempf@kontron.de, tglx@linutronix.de, stefan@agner.ch,
        juliensu@mxic.com.tw, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, allison@lohutok.net,
        linux-mtd@lists.infradead.org, yuehaibing@huawei.com,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v4 0/2] mtd: rawnand: Add support for manufacturer specific suspend/resume operation
Date:   Wed, 18 Mar 2020 15:42:26 +0800
Message-Id: <1584517348-14486-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG4.macronix.com 02I7gTO9041137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changelog

v4:
Patch nand_suspend() return error code to the upper layer,
removed _ prefix of suspend/resme hooks and kbuildtest robot tag.

v3:
patch nand_lock_area/nand_unlock_area.
fixed kbuidtest robot warnings and reviewer's comments as below:
- Patched the Kdoc for both lock_area/unlock_area and _suspend/_resume
- Created a helper to read default protected value (after device power on)
  for protection function detection.
- patched the prefix for Macronix deep power down command, 0xB9
- Patched the description of mxic_nand_resume() and add a small sleeping 
  delay.
- Created a helper for deep power down device part number detection.

v2:
Patch nand_lock() & nand_unlock() for MTD->_lock/_unlock default call-back
function replacement. 
Patch nand_suspend() & nand_resume() with manufacturer specific operation.

v1:
Patch manufacturer post_init for MTD->_lock/_unlock & MTD->_suspend/_resume
replacement.

thanks for your time & review.
Mason

Mason Yang (2):
  mtd: rawnand: Add support for manufacturer specific suspend/resume
    operation
  mtd: rawnand: macronix: Add support for deep power down mode

 drivers/mtd/nand/raw/nand_base.c     | 17 +++++++--
 drivers/mtd/nand/raw/nand_macronix.c | 74 ++++++++++++++++++++++++++++++++++++
 include/linux/mtd/rawnand.h          |  4 ++
 3 files changed, 91 insertions(+), 4 deletions(-)

-- 
1.9.1

