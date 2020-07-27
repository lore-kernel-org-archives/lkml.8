Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB3AC433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D670206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860646;
	bh=wgQ+dqjWde6gj5sHLIy3LyLTb5h2Ed0FJyVL+Tfcgec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aGYCDKgI1i1nAwUM5EkSoPyLYU1r4UcY7AHuJgFJ19Kk8B9SkOYKTfCRfBhXirjSP
	 sI4pyFj0gsnFxXOQEgAZpIrLLA04jP66DyvF89MQiFu4zE7tqesL5wSZEp3mg1n1kW
	 VuAAOOnpOgcu/OJ5PiPYn0nOdFxjefDp3AIsM04Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgG0OhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729643AbgG0OMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:12:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7B562073E;
        Mon, 27 Jul 2020 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859160;
        bh=wgQ+dqjWde6gj5sHLIy3LyLTb5h2Ed0FJyVL+Tfcgec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AFD8zuYifIJmC24ZTkvxmzxqxcsmjeZS7rVm3cQ94gMAz0HdnOT0USSPUb2NHPVQ+
         /Msaxlk9mUdCVToqoFlViHYijkPhMOUOFQt+j7OOj5Xmnv1nSBdKTDWe/CRGCaGaR2
         gbheZkJ12ruy7ho1cqJ2esPj8PJ3FQmfK8fJMZv4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.19 69/86] staging: comedi: addi_apci_1564: check INSN_CONFIG_DIGITAL_TRIG shift
Date:   Mon, 27 Jul 2020 16:04:43 +0200
Message-Id: <20200727134917.880081083@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134914.312934924@linuxfoundation.org>
References: <20200727134914.312934924@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Abbott <abbotti@mev.co.uk>

commit 926234f1b8434c4409aa4c53637aa3362ca07cea upstream.

The `INSN_CONFIG` comedi instruction with sub-instruction code
`INSN_CONFIG_DIGITAL_TRIG` includes a base channel in `data[3]`. This is
used as a right shift amount for other bitmask values without being
checked.  Shift amounts greater than or equal to 32 will result in
undefined behavior.  Add code to deal with this.

Fixes: 1e15687ea472 ("staging: comedi: addi_apci_1564: add Change-of-State interrupt subdevice and required functions")
Cc: <stable@vger.kernel.org> #3.17+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20200717145257.112660-4-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/drivers/addi_apci_1564.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

--- a/drivers/staging/comedi/drivers/addi_apci_1564.c
+++ b/drivers/staging/comedi/drivers/addi_apci_1564.c
@@ -331,14 +331,22 @@ static int apci1564_cos_insn_config(stru
 				    unsigned int *data)
 {
 	struct apci1564_private *devpriv = dev->private;
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
@@ -362,8 +370,8 @@ static int apci1564_cos_insn_config(stru
 				devpriv->mode2 &= oldmask;
 			}
 			/* configure specified channels */
-			devpriv->mode1 |= data[4] << shift;
-			devpriv->mode2 |= data[5] << shift;
+			devpriv->mode1 |= himask;
+			devpriv->mode2 |= lomask;
 			break;
 		case COMEDI_DIGITAL_TRIG_ENABLE_LEVELS:
 			if (devpriv->ctrl != (APCI1564_DI_IRQ_ENA |
@@ -380,8 +388,8 @@ static int apci1564_cos_insn_config(stru
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


