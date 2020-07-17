Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4553EC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F77A20734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="fbixwv3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgGQOxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:53:24 -0400
Received: from smtp97.iad3b.emailsrvr.com ([146.20.161.97]:42092 "EHLO
        smtp97.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbgGQOxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1594997600;
        bh=Jb7u+DJ7y/hyn3SXGc4DxHLWLrr+Fe/OtaaINkhHAcA=;
        h=From:To:Subject:Date:From;
        b=fbixwv3ObUVmqTlZqe7UqPSjK72wjXNGPXlQXn/+CZ0EffnTdtykiZsYwgjcrBmxs
         bjce7X6ezRRxpOtUm9eGTUhocKxB36hgvK140XwLnIl8PdpVHy3a6CRtL7VZ0jHd/X
         B40nlD1/sTeLmsr9QoOWUrgnz6tExFN4UmVf9fXI=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp5.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 540F340167;
        Fri, 17 Jul 2020 10:53:19 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     devel@driverdev.osuosl.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 2/4] staging: comedi: addi_apci_1032: check INSN_CONFIG_DIGITAL_TRIG shift
Date:   Fri, 17 Jul 2020 15:52:55 +0100
Message-Id: <20200717145257.112660-3-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717145257.112660-1-abbotti@mev.co.uk>
References: <20200717145257.112660-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 3cd28aa4-5d40-4a0c-a681-8cbccbead0a1-3-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `INSN_CONFIG` comedi instruction with sub-instruction code
`INSN_CONFIG_DIGITAL_TRIG` includes a base channel in `data[3]`. This is
used as a right shift amount for other bitmask values without being
checked.  Shift amounts greater than or equal to 32 will result in
undefined behavior.  Add code to deal with this.

Fixes: 33cdce6293dcc ("staging: comedi: addi_apci_1032: conform to new INSN_CONFIG_DIGITAL_TRIG"
Cc: <stable@vger.kernel.org> #3.8+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 .../staging/comedi/drivers/addi_apci_1032.c   | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/comedi/drivers/addi_apci_1032.c b/drivers/staging/comedi/drivers/addi_apci_1032.c
index 560649be9d13..e035c9f757a1 100644
--- a/drivers/staging/comedi/drivers/addi_apci_1032.c
+++ b/drivers/staging/comedi/drivers/addi_apci_1032.c
@@ -106,14 +106,22 @@ static int apci1032_cos_insn_config(struct comedi_device *dev,
 				    unsigned int *data)
 {
 	struct apci1032_private *devpriv = dev->private;
-	unsigned int shift, oldmask;
+	unsigned int shift, oldmask, himask, lomask;
 
 	switch (data[0]) {
 	case INSN_CONFIG_DIGITAL_TRIG:
 		if (data[1] != 0)
 			return -EINVAL;
 		shift = data[3];
-		oldmask = (1U << shift) - 1;
+		if (shift < 32) {
+			oldmask = (1U << shift) - 1;
+			himask = data[4] << shift;
+			lomask = data[5] << shift;
+		} else {
+			oldmask = 0xffffffffu;
+			himask = 0;
+			lomask = 0;
+		}
 		switch (data[2]) {
 		case COMEDI_DIGITAL_TRIG_DISABLE:
 			devpriv->ctrl = 0;
@@ -136,8 +144,8 @@ static int apci1032_cos_insn_config(struct comedi_device *dev,
 				devpriv->mode2 &= oldmask;
 			}
 			/* configure specified channels */
-			devpriv->mode1 |= data[4] << shift;
-			devpriv->mode2 |= data[5] << shift;
+			devpriv->mode1 |= himask;
+			devpriv->mode2 |= lomask;
 			break;
 		case COMEDI_DIGITAL_TRIG_ENABLE_LEVELS:
 			if (devpriv->ctrl != (APCI1032_CTRL_INT_ENA |
@@ -154,8 +162,8 @@ static int apci1032_cos_insn_config(struct comedi_device *dev,
 				devpriv->mode2 &= oldmask;
 			}
 			/* configure specified channels */
-			devpriv->mode1 |= data[4] << shift;
-			devpriv->mode2 |= data[5] << shift;
+			devpriv->mode1 |= himask;
+			devpriv->mode2 |= lomask;
 			break;
 		default:
 			return -EINVAL;
-- 
2.27.0

