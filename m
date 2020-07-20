Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A439EC433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759C322CBB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259528;
	bh=uT/bRBTIdkmSU5bvhXzruj9bPbkiXd8OXTikZIuokas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uC4Uj4vuIeBpOoJ++77264D4dTg/f+Exxt/eNsGxzjG+KglmMxY5RF+MT7ZrHh2kY
	 sWglYzz1weKM+Rz8CVxY/UNDQRJOWGrwZDr6dywJ9LvzGuXmsLtoLzMMSAqipo2iFo
	 k/K8I5xbrP4IRGtxWMuC/x2/FPJ10gl1hBOIrWIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgGTPir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729252AbgGTPik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:38:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B854922CBB;
        Mon, 20 Jul 2020 15:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259520;
        bh=uT/bRBTIdkmSU5bvhXzruj9bPbkiXd8OXTikZIuokas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jcNjwfKUbyAJ7w/xOlsObVAmhWlnrJk4bTBr6z68NjeZF4WON/8nxhzRufhupM3Bm
         /FYaX0KWGNLD0tPe/UG4YUk5FZiwWYCLdGeVIScRjJCaiIGyEar+XN4rfkqePQDFQn
         /U72bNVHxoWZmary1hLyZi0G2heJI+O6V1gpF1Y0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.4 36/58] mtd: rawnand: brcmnand: fix CS0 layout
Date:   Mon, 20 Jul 2020 17:36:52 +0200
Message-Id: <20200720152749.011706626@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152747.127988571@linuxfoundation.org>
References: <20200720152747.127988571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Álvaro Fernández Rojas <noltari@gmail.com>

commit 3d3fb3c5be9ce07fa85d8f67fb3922e4613b955b upstream.

Only v3.3-v5.0 have a different CS0 layout.
Controllers before v3.3 use the same layout for every CS.

Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for Broadcom STB NAND controller")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20200522121524.4161539-3-noltari@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/brcmnand/brcmnand.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -455,8 +455,9 @@ static int brcmnand_revision_init(struct
 	} else {
 		ctrl->cs_offsets = brcmnand_cs_offsets;
 
-		/* v5.0 and earlier has a different CS0 offset layout */
-		if (ctrl->nand_version <= 0x0500)
+		/* v3.3-5.0 have a different CS0 offset layout */
+		if (ctrl->nand_version >= 0x0303 &&
+		    ctrl->nand_version <= 0x0500)
 			ctrl->cs0_offsets = brcmnand_cs_offsets_cs0;
 	}
 


