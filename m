Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12322C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B59206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048399;
	bh=W1TFNcL6d7PTuFQZwdR3ie9JKMjHoYNZuPHRwD0bY2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mPtC7SVzcF/Lh3R87ihtyzSnlN0ytwrAc9T3Rmu+uU7+Z4VZG+1zUTBXTVBEWsmsS
	 7/5niOG2Z7fSWpG5rH2TUbT0BydHf9fvdaM6mno2YeJycRkRes7leseYPnnIx0erME
	 BFSVGjqViPvLj9i8XGmxHtc53E7YDxEulmzoXUAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394658AbgDPOqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:46:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506797AbgDPN71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:59:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D2B922203;
        Thu, 16 Apr 2020 13:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045566;
        bh=W1TFNcL6d7PTuFQZwdR3ie9JKMjHoYNZuPHRwD0bY2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yhsGDobPb8TlPbGN2dKuZspQlGsb8kp4Omjft0LRdLYOwI0EXEt0nagqDMiKR3ex0
         Ac12JaooHktqudy0Rx1yZElVYEoWzwMedpo3jl6TnHsfzvb8424k6SVgEDE0ftw8iL
         poXlrP9i4SDA2S1llpqr/bOvE+s/DeKlXXqRs564=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Piotr Sroka <piotrs@cadence.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.6 146/254] mtd: rawnand: cadence: reinit completion before executing a new command
Date:   Thu, 16 Apr 2020 15:23:55 +0200
Message-Id: <20200416131344.795701960@linuxfoundation.org>
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

commit 0d7d6c8183aadb1dcc13f415941404a7913b46b3 upstream.

Reing the completion object before executing CDMA command to make sure
the 'done' flag is OK.

Fixes: ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Piotr Sroka <piotrs@cadence.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/1581328530-29966-4-git-send-email-piotrs@cadence.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/cadence-nand-controller.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -997,6 +997,7 @@ static int cadence_nand_cdma_send(struct
 		return status;
 
 	cadence_nand_reset_irq(cdns_ctrl);
+	reinit_completion(&cdns_ctrl->complete);
 
 	writel_relaxed((u32)cdns_ctrl->dma_cdma_desc,
 		       cdns_ctrl->reg + CMD_REG2);


