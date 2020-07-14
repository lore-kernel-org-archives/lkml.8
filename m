Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98435C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D8B122314
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgGNNfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:35:25 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48278 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728417AbgGNNfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:35:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A39ED201027;
        Tue, 14 Jul 2020 15:35:16 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 97BB22015E6;
        Tue, 14 Jul 2020 15:35:16 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 618DA205A4;
        Tue, 14 Jul 2020 15:35:16 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 5/6] staging: dpaa2-ethsw: store version information of the DPSW object
Date:   Tue, 14 Jul 2020 16:34:30 +0300
Message-Id: <20200714133431.17532-6-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714133431.17532-1-ioana.ciornei@nxp.com>
References: <20200714133431.17532-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the major and minor versions of the DPSW object in the ethsw
structure. This will be used in a subsequent patch to make sure some
commands are only called on the appropriate version of object.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 16 ++++++++--------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h |  1 +
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index f283ce195c1e..a8fc9bcf3b8a 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1368,9 +1368,9 @@ static int ethsw_init(struct fsl_mc_device *sw_dev)
 {
 	struct device *dev = &sw_dev->dev;
 	struct ethsw_core *ethsw = dev_get_drvdata(dev);
-	u16 version_major, version_minor, i;
 	struct dpsw_stp_cfg stp_cfg;
 	int err;
+	u16 i;
 
 	ethsw->dev_id = sw_dev->obj_desc.id;
 
@@ -1388,20 +1388,20 @@ static int ethsw_init(struct fsl_mc_device *sw_dev)
 	}
 
 	err = dpsw_get_api_version(ethsw->mc_io, 0,
-				   &version_major,
-				   &version_minor);
+				   &ethsw->major,
+				   &ethsw->minor);
 	if (err) {
 		dev_err(dev, "dpsw_get_api_version err %d\n", err);
 		goto err_close;
 	}
 
 	/* Minimum supported DPSW version check */
-	if (version_major < DPSW_MIN_VER_MAJOR ||
-	    (version_major == DPSW_MIN_VER_MAJOR &&
-	     version_minor < DPSW_MIN_VER_MINOR)) {
+	if (ethsw->major < DPSW_MIN_VER_MAJOR ||
+	    (ethsw->major == DPSW_MIN_VER_MAJOR &&
+	     ethsw->minor < DPSW_MIN_VER_MINOR)) {
 		dev_err(dev, "DPSW version %d:%d not supported. Use %d.%d or greater.\n",
-			version_major,
-			version_minor,
+			ethsw->major,
+			ethsw->minor,
 			DPSW_MIN_VER_MAJOR, DPSW_MIN_VER_MINOR);
 		err = -ENOTSUPP;
 		goto err_close;
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index a0244f7d5003..0e520fd94dbc 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -61,6 +61,7 @@ struct ethsw_core {
 	struct fsl_mc_io		*mc_io;
 	u16				dpsw_handle;
 	struct dpsw_attr		sw_attr;
+	u16				major, minor;
 	int				dev_id;
 	struct ethsw_port_priv		**ports;
 
-- 
2.25.1

