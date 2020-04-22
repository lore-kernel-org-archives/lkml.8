Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9791C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B615E2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551288;
	bh=w8ay4hs0GJbRR1//Q+FusngJfVtuAxS6jSP+LQOxm0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X3hi3GG4gErSMJD00Oy8BD2F8v+P+ichAkcaqHv8dq1lsoMZPMhRqraO7TS6RbZ7/
	 UmZrBMh3l4zC/kgQ7Gzu1DVWvKnNLK+fjFCbUAoDShuIXpF3De2Pbh2Y5nR7xpP2eL
	 eV15HLNPFKar18wv80y8Z+eZIi0fj5/OnFe9I070=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbgDVK2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730979AbgDVK2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:28:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9B19208E4;
        Wed, 22 Apr 2020 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551281;
        bh=w8ay4hs0GJbRR1//Q+FusngJfVtuAxS6jSP+LQOxm0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IH78PKN3TeUEZUnJAOl0GAhi7b5KtlTux+ccfPzCl6uc2Xkmx76AVS7kc0cBp4CVl
         KSgiwri1SHLeGGUg0l0Ivr6trYBNAk8BgBE6QFoCiep5PwG+2aUQwhFOtAbavzFY3E
         Md3mIg+eu9+cqWv6YhESHxoRlYje5t1zG5dndCfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe Kerello <christophe.kerello@st.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.6 157/166] mtd: rawnand: free the nand_device object
Date:   Wed, 22 Apr 2020 11:58:04 +0200
Message-Id: <20200422095105.310981182@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Kerello <christophe.kerello@st.com>

commit 009264605cdf1b12962c3a46f75818d05452e890 upstream.

This patch releases the resources allocated in nanddev_init function.

Fixes: a7ab085d7c16 ("mtd: rawnand: Initialize the nand_device object")
Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/1579767768-32295-1-git-send-email-christophe.kerello@st.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/nand_base.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5907,6 +5907,8 @@ void nand_cleanup(struct nand_chip *chip
 	    chip->ecc.algo == NAND_ECC_BCH)
 		nand_bch_free((struct nand_bch_control *)chip->ecc.priv);
 
+	nanddev_cleanup(&chip->base);
+
 	/* Free bad block table memory */
 	kfree(chip->bbt);
 	kfree(chip->data_buf);


