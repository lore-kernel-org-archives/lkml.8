Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21695C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D9120726
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgCCHVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:21:38 -0500
Received: from twhmllg3.macronix.com ([211.75.127.131]:31728 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgCCHVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:21:37 -0500
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id 0237LRL9023026;
        Tue, 3 Mar 2020 15:21:27 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     frieder.schrempf@kontron.de, tglx@linutronix.de, stefan@agner.ch,
        juliensu@mxic.com.tw, allison@lohutok.net,
        linux-kernel@vger.kernel.org, bbrezillon@kernel.org,
        rfontana@redhat.com, linux-mtd@lists.infradead.org,
        yuehaibing@huawei.com, s.hauer@pengutronix.de,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v3 0/4] mtd: rawnand: Add support Macronix Block Portection & Deep Power Down mode 
Date:   Tue,  3 Mar 2020 15:21:20 +0800
Message-Id: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG3.macronix.com 0237LRL9023026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changelog

v3:
patch nand_lock_area/nand_unlock_area.
fixed kbuidtest robot warnings and reviewer's comments.

v2:
Patch nand_lock() & nand_unlock() for MTD->_lock/_unlock default call-back
function replacement. 
Patch nand_suspend() & nand_resume() with manufacturer specific operation.

v1:
Patch manufacturer post_init for MTD->_lock/_unlock & MTD->_suspend/_resume
replacement.

thanks for your time & review.
Mason


Mason Yang (4):
  mtd: rawnand: Add support manufacturer specific lock/unlock operation
  mtd: rawnand: Add support Macronix Block Protection function
  mtd: rawnand: Add support manufacturer specific suspend/resume
    operation
  mtd: rawnand: Add support Macronix deep power down mode

 drivers/mtd/nand/raw/nand_base.c     |  47 +++++++++--
 drivers/mtd/nand/raw/nand_macronix.c | 146 +++++++++++++++++++++++++++++++++++
 include/linux/mtd/rawnand.h          |   9 +++
 3 files changed, 197 insertions(+), 5 deletions(-)

-- 
1.9.1

