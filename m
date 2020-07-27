Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F48C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D902070A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859998;
	bh=JGHlMZQJ1xpEdottcTaPnLzS+nCY083XoLYz11gR/Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ENMt8CXeTwfp+/tzpxL+CAxBVbSqm1dHJVx6oHLeUdEmv5WQTtjDyHwNtGEQaYJ5s
	 v5b2YGy2GKT0k8JSl2+sVCFklPMxuCYV8EK95lg6+cCfGxyegc6uy2gDr+0WcrrEn/
	 YlzZEAcMrMRRYIEVSvKCgHywNb2k4iP6HFGoEU48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbgG0O0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:26:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732623AbgG0O0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:26:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DAD520663;
        Mon, 27 Jul 2020 14:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859993;
        bh=JGHlMZQJ1xpEdottcTaPnLzS+nCY083XoLYz11gR/Lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TsVCFZ6YISYvLsjE1s3UtosvQyoIGK2XNDw0C3t/7aKdVxN4uO7Ubnk23a53QDLbv
         /1E5RN8LkRHvNDD1CKhQVgJ7HonCzsDNv0eVkqA2uZAa6kHXiNJOyeWbW7Nvu3oNjJ
         yTS0ovtZ7bC5I2dJhYOBh9ywrXZe8GsQHChzYnLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 5.7 147/179] staging: comedi: addi_apci_1032: check INSN_CONFIG_DIGITAL_TRIG shift
Date:   Mon, 27 Jul 2020 16:05:22 +0200
Message-Id: <20200727134939.828869275@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Abbott <abbotti@mev.co.uk>

commit 0bd0db42a030b75c20028c7ba6e327b9cb554116 upstream.

The `INSN_CONFIG` comedi instruction with sub-instruction code
`INSN_CONFIG_DIGITAL_TRIG` includes a base channel in `data[3]`. This is
used as a right shift amount for other bitmask values without being
checked.  Shift amounts greater than or equal to 32 will result in
undefined behavior.  Add code to deal with this.

Fixes: 33cdce6293dcc ("staging: comedi: addi_apci_1032: conform to new INSN_CONFIG_DIGITAL_TRIG")
Cc: <stable@vger.kernel.org> #3.8+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20200717145257.112660-3-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/drivers/addi_apci_1032.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

--- a/drivers/staging/comedi/drivers/addi_apci_1032.c
+++ b/drivers/staging/comedi/drivers/addi_apci_1032.c
@@ -106,14 +106,22 @@ static int apci1032_cos_insn_config(stru
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
@@ -136,8 +144,8 @@ static int apci1032_cos_insn_config(stru
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
@@ -154,8 +162,8 @@ static int apci1032_cos_insn_config(stru
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


