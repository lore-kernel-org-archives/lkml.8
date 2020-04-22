Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A436C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37FC12075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552057;
	bh=+xra3vEo1yIYNzhtiqLFGvu0By+bBWk/4gp6Caqkb1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V8uOvPL7WNp1ZKd0IpCjBg26tp7BklP1Rl4ivii9i8RrAUV5Rl5QGg8Zf4DlyB5z2
	 KUFKjZaYsnDH/mbSTqEm43HcODpUH547MnrsL3gKxDxn/6mxaGpwu59Ml6FCHN2JrG
	 3QiiPVnniCyhk2LJ7+4cYsMtgwUVCJZ4TzkwcM7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbgDVKkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:40:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730118AbgDVKUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:20:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA1CC2076B;
        Wed, 22 Apr 2020 10:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550837;
        bh=+xra3vEo1yIYNzhtiqLFGvu0By+bBWk/4gp6Caqkb1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P6c3kO1Dv9vZhCzfPZEqsD/Ikdc4KfjRnCCu9tZovR10dIfGL+Asvx14dvfFT+EQR
         aWWY9btIQvMDUhb5VWzZZMsiR8vQHf5s6q/t9Z5JT//1G3L2l2PFCFQmrdu6r6rXKx
         kyakWy6n9QqCWiukqfyBCam9brRtb0QUzaRWfbWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.4 112/118] mtd: lpddr: Fix a double free in probe()
Date:   Wed, 22 Apr 2020 11:57:53 +0200
Message-Id: <20200422095049.257744225@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 4da0ea71ea934af18db4c63396ba2af1a679ef02 upstream.

This function is only called from lpddr_probe().  We free "lpddr" both
here and in the caller, so it's a double free.  The best place to free
"lpddr" is in lpddr_probe() so let's delete this one.

Fixes: 8dc004395d5e ("[MTD] LPDDR qinfo probing.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20200228092554.o57igp3nqhyvf66t@kili.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/lpddr/lpddr_cmds.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/mtd/lpddr/lpddr_cmds.c
+++ b/drivers/mtd/lpddr/lpddr_cmds.c
@@ -68,7 +68,6 @@ struct mtd_info *lpddr_cmdset(struct map
 	shared = kmalloc_array(lpddr->numchips, sizeof(struct flchip_shared),
 						GFP_KERNEL);
 	if (!shared) {
-		kfree(lpddr);
 		kfree(mtd);
 		return NULL;
 	}


