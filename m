Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C63C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45BA206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048409;
	bh=g9v6h6SXtblq+7AJbJQ450xlCwd+w7sxbEg9I5Os8I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j6UcS9PTYvFKMqpGtw2Bi1EQbJOAH4PsIcuq3sOLQ+3RPZL729E6cWWTRg/HjXXgJ
	 +gHkTQeDi6Z+ye0Dvln9hdZ17e9ZZl2KjigmogjOiQNXmcd+Ezu+4QAyGtASswXwIz
	 iVxoodbsVFmc8Vlz5HVvqJxBnK6muRBlz5pSABpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbgDPOqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506796AbgDPN7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:59:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2EDC217D8;
        Thu, 16 Apr 2020 13:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045564;
        bh=g9v6h6SXtblq+7AJbJQ450xlCwd+w7sxbEg9I5Os8I4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=odWhlkk/ZOhOqxIjohKLtOmgDbCgJm46SDQayHHHsOMuwFhz3ld0EnQ73k2r/yI6J
         gvpGgliRDTysathC0EGh5kMBidWrPiehM7Piv+8QpBXh0OvpLxBiiZCYGyD1ZW7mAO
         kyhjKHRxWjsnsTSk5Eex9KDnXkTzABe2rRuplcmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Piotr Sroka <piotrs@cadence.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.6 145/254] mtd: rawnand: cadence: change bad block marker size
Date:   Thu, 16 Apr 2020 15:23:54 +0200
Message-Id: <20200416131344.667289483@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piotr Sroka <piotrs@cadence.com>

commit 9bf1903bed7a2e84f5a8deedb38f7e0ac5e8bfc6 upstream.

Increase bad block marker size from one byte to two bytes.
Bad block marker is handled by skip bytes feature of HPNFC.
Controller expects this value to be an even number.

Fixes: ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Piotr Sroka <piotrs@cadence.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/1581328530-29966-3-git-send-email-piotrs@cadence.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/cadence-nand-controller.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -2603,12 +2603,9 @@ int cadence_nand_attach_chip(struct nand
 	chip->options |= NAND_NO_SUBPAGE_WRITE;
 
 	cdns_chip->bbm_offs = chip->badblockpos;
-	if (chip->options & NAND_BUSWIDTH_16) {
-		cdns_chip->bbm_offs &= ~0x01;
-		cdns_chip->bbm_len = 2;
-	} else {
-		cdns_chip->bbm_len = 1;
-	}
+	cdns_chip->bbm_offs &= ~0x01;
+	/* this value should be even number */
+	cdns_chip->bbm_len = 2;
 
 	ret = nand_ecc_choose_conf(chip,
 				   &cdns_ctrl->ecc_caps,


