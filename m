Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24142C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA56220702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943374;
	bh=bAgIU3lFh7NwZpBp8Zp4AYnfgGNpc/so8z+AZpG1vwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P3Oji3mOgEJLwHGceQDNvk4OXzqef4zI2BcTlsMakPb9CdwTwB7+A8W3kHODalXlj
	 92+PgOm38jnugLKr438e5G+A0NWsEuZhwQHds9k0PTGxOuWDs2ANQh4hliDl0MmlEA
	 qVF2KGN8KUV7XK4L1ZqA1NrnKagSYWbvOgStA3OU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389005AbgFWUQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388390AbgFWUQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:16:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89AEF20702;
        Tue, 23 Jun 2020 20:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943370;
        bh=bAgIU3lFh7NwZpBp8Zp4AYnfgGNpc/so8z+AZpG1vwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xdBDfPXuExNIgPDo3gF0rgwrjOAA3VXrTKTTg8FbtAdXGsPcRsgJoDpjb5Fziymie
         EAnNAyYYZlZGcI6prOOrYUxbABddDI7QxzCgTUEPOQuroiS5eAtOxllrP6j0LbqRex
         MoxID7od3CqKOXq7ErfJWkOE+cs3RwlDtrixBHjg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 364/477] scsi: acornscsi: Fix an error handling path in acornscsi_probe()
Date:   Tue, 23 Jun 2020 21:56:01 +0200
Message-Id: <20200623195424.735025270@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 42c76c9848e13dbe0538d7ae0147a269dfa859cb ]

'ret' is known to be 0 at this point.  Explicitly return -ENOMEM if one of
the 'ecardm_iomap()' calls fail.

Link: https://lore.kernel.org/r/20200530081622.577888-1-christophe.jaillet@wanadoo.fr
Fixes: e95a1b656a98 ("[ARM] rpc: acornscsi: update to new style ecard driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/arm/acornscsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/arm/acornscsi.c b/drivers/scsi/arm/acornscsi.c
index ddb52e7ba6226..9a912fd0f70b5 100644
--- a/drivers/scsi/arm/acornscsi.c
+++ b/drivers/scsi/arm/acornscsi.c
@@ -2911,8 +2911,10 @@ static int acornscsi_probe(struct expansion_card *ec, const struct ecard_id *id)
 
 	ashost->base = ecardm_iomap(ec, ECARD_RES_MEMC, 0, 0);
 	ashost->fast = ecardm_iomap(ec, ECARD_RES_IOCFAST, 0, 0);
-	if (!ashost->base || !ashost->fast)
+	if (!ashost->base || !ashost->fast) {
+		ret = -ENOMEM;
 		goto out_put;
+	}
 
 	host->irq = ec->irq;
 	ashost->host = host;
-- 
2.25.1



