Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B42CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 22:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E93924905
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 22:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="W2N41+5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbgFUW5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 18:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgFUW5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 18:57:16 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E71C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 15:57:15 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 27EE88066C;
        Mon, 22 Jun 2020 10:57:10 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1592780230;
        bh=YCsbe4EpQ2HQPtwpZQRB0Vn4aud+zoi8XPglVswF6LQ=;
        h=From:To:Cc:Subject:Date;
        b=W2N41+5Wfe0dFv15oUj3+vt7pc1SPbXC2zK50GFEnMjTR/3ge0zFX1uVO0b1FK2wq
         ayozR9dUZogcGhAdkvKSs3H8GpYx9OajdRiwmDg8a21ZlksA845tuKoJ+asJFYBFcu
         yW5CoQSNzcw9uPdtsJBcdO1ltC3d5LH3YXmOjRHWW36N8+P+26mVP4678EPgR/i8mZ
         jXOB+6CfmCXQyk7JIP5WjhPKYrn+EUGKo3ssCSU1SR88lfKQWpwSI8n8DWe+gXlAUz
         xOo5CUPunQkF92ZQx+CUFM83pWEaPWLJssUwPQOc0j+lnB7a66SVxLUH6vVJC6x5GG
         zZumFcCuksH9w==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5eefe5c40000>; Mon, 22 Jun 2020 10:57:08 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id DE9F513EEA8;
        Mon, 22 Jun 2020 10:57:08 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id E23ED28005D; Mon, 22 Jun 2020 10:57:09 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     wsa@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] i2c: algo-pca: Add 0x78 as SCL stuck low status
Date:   Mon, 22 Jun 2020 10:57:05 +1200
Message-Id: <20200621225705.21666-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCA9665 datasheet says that I2CSTA =3D 78h indicates that SCL is stuc=
k
low, this differs to the PCA9564 which uses 90h for this indication.
Treat either 0x78 or 0x90 as an indication that the SCL line is stuck.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Based on looking through the PCA9564 and PCA9665 datasheets this should b=
e
safe. The PCA9564 should not return 0x78 for any valid state and the PCA9=
665
should not return 0x90.

 drivers/i2c/algos/i2c-algo-pca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-alg=
o-pca.c
index 7f10312d1b88..e3017329cea8 100644
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -314,6 +314,7 @@ static int pca_xfer(struct i2c_adapter *i2c_adap,
 			DEB2("BUS ERROR - SDA Stuck low\n");
 			pca_reset(adap);
 			goto out;
+		case 0x78: /* Bus error - SCL stuck low */
 		case 0x90: /* Bus error - SCL stuck low */
 			DEB2("BUS ERROR - SCL Stuck low\n");
 			pca_reset(adap);
--=20
2.27.0

