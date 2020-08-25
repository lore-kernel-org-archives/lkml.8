Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F286C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 05:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E209A20738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 05:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="UqUmObp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgHYFJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 01:09:06 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:58230 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgHYFJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 01:09:05 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F18A88011F;
        Tue, 25 Aug 2020 17:09:02 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1598332142;
        bh=pPfKgtF59ePZsZgDCVDwLyVKrhSykY3VP/ASYTxiIPM=;
        h=From:To:Cc:Subject:Date;
        b=UqUmObp7Igs79ivOqutvMR2WGBaDu/idBjaRV1GcjnO9VYCaMzWVD9pXIEVt45HIO
         FzLcP0SKhWCXfB+HBB+wE2/KYigazhZX2INLN9+HmBKFaQcSJlVhxCyVROp8x1eKp8
         84lAoobOmyUhVyhT1nkELtSOfLuB0t1HxhmNkG6g3jdU0/xe5TXh7Z3n9IrJlLXxlw
         FGPnzHUqdSxV+Cpw06bNVnfKOH5TnkW/9DJXgoYNpxDBjwUYZpWS0GQSKi9aYr2Pkk
         10VF169AXYVnMfatH8wlGt0sLROPyO/qWUTKf1fJyF0UN2U0Gay/nEJpBH5MHtt6Tm
         ysBWlWWx8SJfQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f449ced0000>; Tue, 25 Aug 2020 17:09:03 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 7301013ED33;
        Tue, 25 Aug 2020 17:08:59 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 7D83828004E; Tue, 25 Aug 2020 17:09:00 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] spi: spi-fsl-espi: Remove use of %p
Date:   Tue, 25 Aug 2020 17:08:56 +1200
Message-Id: <20200825050856.29616-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register offset is already included in the device name so even prior
%p values being hashed printing the base was redundant. Remove the %p
from the dev_info() output.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/spi/spi-fsl-espi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index e60581283a24..7e9b6f8d6243 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -730,7 +730,7 @@ static int fsl_espi_probe(struct device *dev, struct =
resource *mem,
 	if (ret < 0)
 		goto err_pm;
=20
-	dev_info(dev, "at 0x%p (irq =3D %u)\n", espi->reg_base, irq);
+	dev_info(dev, "irq =3D %u\n", irq);
=20
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
--=20
2.28.0

