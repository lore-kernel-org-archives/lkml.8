Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0091DC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D108720773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260970;
	bh=BCseF6yIY3Ulzlh+XSpynom55BCuEJ7b8LcoqTRukrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h1If6e8FOAkAF+iGEEtZzmAicnAvDIh5g1ZNWriMT6Ih8cNFkRkSofWXEdVaPrt1N
	 7QesVEGkVBrJfOMfACH4EYlX/oyqath5SiEP6rDfsyXzz5vRoCNLKfyMjNCdkfkEpU
	 psikf9S1PPeT9MHsS9cUuR5YSGwqDxP+GtxFNQL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgGTQCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732708AbgGTQCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:02:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 829BE22CBB;
        Mon, 20 Jul 2020 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260963;
        bh=BCseF6yIY3Ulzlh+XSpynom55BCuEJ7b8LcoqTRukrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W0kSeEetKmrSsuC+a1Ge859ExOt6wRswbFzvpUu6GW/msDjSGsrCc87+XxlSXrxlW
         yft/7VMTLUlgcMfWEVfsOEvDH1z0LR8TxMO/jv6CB2ewKHTf3y4Y+Q7WG2XpyWiWo7
         5aYWGCMN7b74vzY/SzPoVEmmtPOFOZn7cnV7sjzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 5.4 132/215] mtd: rawnand: marvell: Use nand_cleanup() when the device is not yet registered
Date:   Mon, 20 Jul 2020 17:36:54 +0200
Message-Id: <20200720152826.469148390@linuxfoundation.org>
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

commit 7a0c18fb5c71c6ac7d4662a145e4227dcd4a36a3 upstream.

Do not call nand_release() while the MTD device has not been
registered, use nand_cleanup() instead.

Fixes: 02f26ecf8c77 ("mtd: nand: add reworked Marvell NAND controller driver")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://lore.kernel.org/linux-mtd/20200424164501.26719-4-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/marvell_nand.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2664,7 +2664,7 @@ static int marvell_nand_chip_init(struct
 		ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
 		dev_err(dev, "failed to register mtd device: %d\n", ret);
-		nand_release(chip);
+		nand_cleanup(chip);
 		return ret;
 	}
 


