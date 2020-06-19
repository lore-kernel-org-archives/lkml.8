Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BE7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC1421973
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580757;
	bh=7RDSSuE0x1CRJMtpeeSsfflH94SQLQHmYsHUUAk+q2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DV0Dzzt4RoBmB5KKVjpYOez8sHL80zOfDEGfHUrvYUlgdtUy5xkrP7O7Gv5Vijl/7
	 olDxsdn40AXJIVFMsX59fGVApIFIuDkghhHkTz2BnQirv8E/Yfg72oecslL7g30t8z
	 bTIev67Tf20eafHel6DXXKqyglgDiak6pw4R51S0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393898AbgFSPcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:32:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393679AbgFSPcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:32:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5301220786;
        Fri, 19 Jun 2020 15:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580736;
        bh=7RDSSuE0x1CRJMtpeeSsfflH94SQLQHmYsHUUAk+q2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E8PhRvU6nmKBvOx7oDGZ6D43h9i/OZq6LKxovPXAoJE0HdWM7nSarOKXT2tsR229S
         lS0R0WZSLoZvhPhI8qvURn++G/cFPabocPw3G4FOUz8RfNx06EswDN7QjvY5dcbD8t
         JN8bmN88SKgemD6KwlUkKIR0W6Ll7CNsXS9J5l80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.7 363/376] mtd: rawnand: plat_nand: Fix the probe error path
Date:   Fri, 19 Jun 2020 16:34:41 +0200
Message-Id: <20200619141727.497380992@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit 5284024b4dac5e94f7f374ca905c7580dbc455e9 upstream.

nand_release() is supposed be called after MTD device registration.
Here, only nand_scan() happened, so use nand_cleanup() instead.

There is no real Fixes tag applying here as the use of nand_release()
in this driver predates by far the introduction of nand_cleanup() in
commit d44154f969a4 ("mtd: nand: Provide nand_cleanup() function to free NAND related resources")
which makes this change possible, hence pointing it as the commit to
fix for backporting purposes, even if this commit is not introducing
any bug.

Fixes: d44154f969a4 ("mtd: nand: Provide nand_cleanup() function to free NAND related resources")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mtd/20200519130035.1883-43-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/plat_nand.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/plat_nand.c
+++ b/drivers/mtd/nand/raw/plat_nand.c
@@ -92,7 +92,7 @@ static int plat_nand_probe(struct platfo
 	if (!err)
 		return err;
 
-	nand_release(&data->chip);
+	nand_cleanup(&data->chip);
 out:
 	if (pdata->ctrl.remove)
 		pdata->ctrl.remove(pdev);


