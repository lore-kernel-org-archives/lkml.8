Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6A9C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E70DB2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551273;
	bh=+xra3vEo1yIYNzhtiqLFGvu0By+bBWk/4gp6Caqkb1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m1XGEUlVBa+lMlFD5FWSjmj7nj/Jz2sKlTq8MK6+umFWuEMNZoKFixjTrlx1PXYWx
	 dedoWx2qbL/G0pgfW9RdvU11Wd8Bo1eP6O4m4BZQEJIwEFZOhsfU45Vf3SF24MZ7c2
	 CfxIAq1nK/fFSbrKrHDhhyS1+Iat/62t5qerCAtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbgDVK1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730927AbgDVK1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:27:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C9AB2071E;
        Wed, 22 Apr 2020 10:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551264;
        bh=+xra3vEo1yIYNzhtiqLFGvu0By+bBWk/4gp6Caqkb1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AK2dPaey4Yy0u2nv4JQQsZM+NFugQsDTe4mlnIqM6B+Ny6BzftMGssPNJok4JYRez
         T1bn+NmUxPcfK1gqjOFkleU8WyCTqbp8QQARtyxjkEWp0V0b5G39lMXDZIeWyTqMmO
         CzxZmdJurLyBkbdQL8G04BFCQ5bOeIOvKBu9B/i4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.6 160/166] mtd: lpddr: Fix a double free in probe()
Date:   Wed, 22 Apr 2020 11:58:07 +0200
Message-Id: <20200422095105.588737539@linuxfoundation.org>
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


