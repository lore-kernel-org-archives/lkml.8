Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFB2C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5DC2467E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996306;
	bh=QOtqjUFCOKYM8zRv5UdVdn1GxVGQCrtHBIh9QLZ5b9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MEoTj4vqqgQ85Q1+queNFZ7RuPL2LmrpRCYtJXCrLh++VzTH/uwViDIJpeibUTmNW
	 89RNTV64+IuWusXaa/Aj2JS9Puoa+8q5G8n0kYQaXYq9zual+yNZTdJN8whJKCMilx
	 +tZ6pldpwtsbWVnagpLPVBKSVOS10HPNi09kIPto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbgANKFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:32854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729605AbgANKFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:05:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 569E12467E;
        Tue, 14 Jan 2020 10:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996300;
        bh=QOtqjUFCOKYM8zRv5UdVdn1GxVGQCrtHBIh9QLZ5b9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xWRuhyH2MF4WYg0SQfR0jKFpasGXVCFrSDQxINf2z4UYpyw6VOO1QhjJSA+s4xaos
         gCiHPyaFWuCEjK2jM27q6MCJ4pNLQ/HVW7H2wFWZ5Xk5nwJtSP/gqkaX5Xug0Za4aP
         QV1Q21USNNrMfjMxXwyU/o0xrXp+g2RoJQj7Jyok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmytro Fil <monkdaf@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 5.4 49/78] staging: comedi: adv_pci1710: fix AI channels 16-31 for PCI-1713
Date:   Tue, 14 Jan 2020 11:01:23 +0100
Message-Id: <20200114094400.082859298@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094352.428808181@linuxfoundation.org>
References: <20200114094352.428808181@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Abbott <abbotti@mev.co.uk>

commit a9d3a9cedc1330c720e0ddde1978a8e7771da5ab upstream.

The Advantech PCI-1713 has 32 analog input channels, but an incorrect
bit-mask in the definition of the `PCI171X_MUX_CHANH(x)` and
PCI171X_MUX_CHANL(x)` macros is causing channels 16 to 31 to be aliases
of channels 0 to 15.  Change the bit-mask value from 0xf to 0xff to fix
it.  Note that the channel numbers will have been range checked already,
so the bit-mask isn't really needed.

Fixes: 92c65e5553ed ("staging: comedi: adv_pci1710: define the mux control register bits")
Reported-by: Dmytro Fil <monkdaf@gmail.com>
Cc: <stable@vger.kernel.org> # v4.5+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20191227170054.32051-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/drivers/adv_pci1710.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/comedi/drivers/adv_pci1710.c
+++ b/drivers/staging/comedi/drivers/adv_pci1710.c
@@ -46,8 +46,8 @@
 #define PCI171X_RANGE_UNI	BIT(4)
 #define PCI171X_RANGE_GAIN(x)	(((x) & 0x7) << 0)
 #define PCI171X_MUX_REG		0x04	/* W:   A/D multiplexor control */
-#define PCI171X_MUX_CHANH(x)	(((x) & 0xf) << 8)
-#define PCI171X_MUX_CHANL(x)	(((x) & 0xf) << 0)
+#define PCI171X_MUX_CHANH(x)	(((x) & 0xff) << 8)
+#define PCI171X_MUX_CHANL(x)	(((x) & 0xff) << 0)
 #define PCI171X_MUX_CHAN(x)	(PCI171X_MUX_CHANH(x) | PCI171X_MUX_CHANL(x))
 #define PCI171X_STATUS_REG	0x06	/* R:   status register */
 #define PCI171X_STATUS_IRQ	BIT(11)	/* 1=IRQ occurred */


