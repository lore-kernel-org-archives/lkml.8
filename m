Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABD5C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A00206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274585;
	bh=+0812Eg5+LNOtMVydZcCyoOxN83vHjF8PnFw8dcCjhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XT9DKItnwYUDS26tkNBXPoFVLbC0tWrnq9Tb5VR389+aGh/NnJ6j5VyN4R47fz53Y
	 QOuhmDzkHlFUg0/rIixIlIJHDsg/8bGxY7jGNcjKiLlQKgDN9dqFg/64ZpU/ng4Aum
	 C34SsxjtY8xV2PbJyrocF9qZhp55QOgvbBx+IhTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbgBUInE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:43:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730005AbgBUHyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:54:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 322E220578;
        Fri, 21 Feb 2020 07:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271649;
        bh=+0812Eg5+LNOtMVydZcCyoOxN83vHjF8PnFw8dcCjhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7j86t5LnsKrVbdUsBm0HndEtH3Ko0hvJPqAMWHW/Qp/NOM4u1ZOABTph1bbFBDzt
         GCc2LRwfmhvw8bybV5ckXtBBlRofi9qj5b/On1shNfifFnIcTFC4FkRCUtyfkl8PHp
         F4CoiFBHd6P1w9NWzIIHVB/9KHsuz/dUtTSzs/JA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 247/399] bus: fsl-mc: properly empty-initialize structure
Date:   Fri, 21 Feb 2020 08:39:32 +0100
Message-Id: <20200221072426.464236212@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

[ Upstream commit cff081ea9d0962defd733daf6778f62b1dac3daa ]

Use the proper form of the empty initializer when working with
structures that contain an array. Otherwise, older gcc versions (eg gcc
4.9) will complain about this.

Fixes: 1ac210d128ef ("bus: fsl-mc: add the fsl_mc_get_endpoint function")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Acked-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Link: https://lore.kernel.org/r/20191204142950.30206-1-ioana.ciornei@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index a07cc19becdba..c78d10ea641fb 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -715,9 +715,9 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_remove);
 struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev)
 {
 	struct fsl_mc_device *mc_bus_dev, *endpoint;
-	struct fsl_mc_obj_desc endpoint_desc = { 0 };
-	struct dprc_endpoint endpoint1 = { 0 };
-	struct dprc_endpoint endpoint2 = { 0 };
+	struct fsl_mc_obj_desc endpoint_desc = {{ 0 }};
+	struct dprc_endpoint endpoint1 = {{ 0 }};
+	struct dprc_endpoint endpoint2 = {{ 0 }};
 	int state, err;
 
 	mc_bus_dev = to_fsl_mc_device(mc_dev->dev.parent);
-- 
2.20.1



