Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18A8C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E07206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262299;
	bh=xm9UZW9zAD+VA4H6R+EB34yC3IghtWXpFJKcdYMmkao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RE2rqUaS4dRFIZAIBlomaVmUsvYM1zArG/a5zee7ml2Vnw043ViTRGVOZ1wKVsv3o
	 +ZP6eAi75uDTWH5sgM+0qar83brDVEZnzUxw17ZYztQSqMOMimlQdNhoBNzFq0QTqt
	 HAVYDFRoCti/+4YUDf1d2JB37z5EB1gjwytVqT08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbgGTQY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732617AbgGTQCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:02:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51B092176B;
        Mon, 20 Jul 2020 16:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260932;
        bh=xm9UZW9zAD+VA4H6R+EB34yC3IghtWXpFJKcdYMmkao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zLXMIAGTMo4EN4z3+6dRzeiwC+A3YhqiLYrHVAzicfNJQapShUx6yFdbKqO1bWp9f
         IPeCq1ETWGd4XsKnlu4Y+jclB0eBl2a3hoQdCRp/LfLRVImUCJxBI8wnGpxT5EQ8+1
         ZwNOOafUyUBgSBRSHuXQ+okw+jzRLcTwdddjoiIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 5.4 131/215] mtd: rawnand: marvell: Fix the condition on a return code
Date:   Mon, 20 Jul 2020 17:36:53 +0200
Message-Id: <20200720152826.423586799@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit c27075772d1f1c8aaf276db9943b35adda8a8b65 upstream.

In a previous fix, I changed the condition on which the timeout of an
IRQ is reached from:

    if (!ret)

into:

    if (ret && !pending)

While having a non-zero return code is usual in the Linux kernel, here
ret comes from a wait_for_completion_timeout() which returns 0 when
the waiting period is too long.

Hence, the revised condition should be:

    if (!ret && !pending)

The faulty patch did not produce any error because of the !pending
condition so this change is finally purely cosmetic and does not
change the actual driver behavior.

Fixes: cafb56dd741e ("mtd: rawnand: marvell: prevent timeouts on a loaded machine")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://lore.kernel.org/linux-mtd/20200424164501.26719-2-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/marvell_nand.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -707,7 +707,7 @@ static int marvell_nfc_wait_op(struct na
 	 * In case the interrupt was not served in the required time frame,
 	 * check if the ISR was not served or if something went actually wrong.
 	 */
-	if (ret && !pending) {
+	if (!ret && !pending) {
 		dev_err(nfc->dev, "Timeout waiting for RB signal\n");
 		return -ETIMEDOUT;
 	}


