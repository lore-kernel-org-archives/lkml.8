Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D89C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D750620656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261982;
	bh=BCseF6yIY3Ulzlh+XSpynom55BCuEJ7b8LcoqTRukrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jPMzuLfQva0k2pv8dojU5ej4CeRrwaqenukaA7uaO9f/vDU7h2V6qQSw46iPdh6af
	 t7QWpYXp94LiTaRfnV3DtZd7om7NBJnrMyWeFT0JurTA2X/cZZeZhjC6EpFsQnNlOb
	 bB7Kgsgk5ZfK8mqPW4E4h6fIQaojXkqKvJU17s6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388376AbgGTQTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387821AbgGTQLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:11:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48A222065E;
        Mon, 20 Jul 2020 16:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261494;
        bh=BCseF6yIY3Ulzlh+XSpynom55BCuEJ7b8LcoqTRukrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWst2nKprIRSkcNt/lDmx1nVIRv9OvbMaqgn7s1Gs40AXuT6e4r47S/D29PKQgkIw
         DJHTZQ8bQu5kwV60BCX7sax/Kmuo4eNixufvUGVnVp74M+tm7f25otS8Y/AQFxVUk2
         u5oocfc49kP7K+m3u3UKjx/wrkzxRWT+/Psd60/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 5.7 135/244] mtd: rawnand: marvell: Use nand_cleanup() when the device is not yet registered
Date:   Mon, 20 Jul 2020 17:36:46 +0200
Message-Id: <20200720152832.268573955@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
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
 


