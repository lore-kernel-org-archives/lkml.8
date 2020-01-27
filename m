Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353CAC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051DA206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJWVurVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgA0Xyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:54:46 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:52781 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgA0Xyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:54:45 -0500
Received: by mail-pg1-f201.google.com with SMTP id w21so7496480pgf.19
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 15:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LtaIREjg0GbBNJyJVnqCp3W9hRUEU+wNigeViXWJb/o=;
        b=QJWVurVz83htEHzzAukWZOjRvkslLJAt6RkcCPRQgUwcrrqnp2W42ISvpNSlJqhLYI
         HDzfPU81B/8MhLW3/BOHOTSm3GJr/tMW4jJ1uZjzTbJHZI7r00deF2uuiZE1jDlE3Ujn
         MIMSuULUgAiE5dl8Nrbk0b8EeQoezOApOBHVkrgqe0dU+IightjL6OUCro+mwIxTLbFb
         t2pFhrqSSkm11dR+u1q94/yUiey4cwHOn48bYfK20V0lZ9Glrn/woVo38KYoMyo6/pXm
         Ki9LI1z6JOEkTJvqF9Ngr3gnj3PxZwspaCM9AexVBTeEbEa6NoLses4XF2PhfQahE7g1
         UGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LtaIREjg0GbBNJyJVnqCp3W9hRUEU+wNigeViXWJb/o=;
        b=RF8YO1e1srQFRdxA4pa95PwUeaq/DPHAO3ohyMR76fyrVybWqit8ChhwJEhR8VIp+j
         IJVsjnBF/QAgd1BGjKfGtfiCgCGlBOGWzs+WnoyACEQPW2Rta2LElJuWjERlBg9OxDRy
         qOgqgKuvS3INkUkPYLVW82lr3l4aO8cMgaTtgpaKGqTJ4A39OcqbeO3rAHuuGoSfz+iX
         cBVDynUygoYnHyDwOx3YYXwi/ArPtzAovxdJsX5V+Zaj0DwO30ddh+Gd3agzNfoxtW53
         45iphsF2i/0CwcLYxj6+UDx1RCtoZg9j2pK8h/cPkuVNwvvu54MgDx1pOeuzJl77tQJG
         kLEw==
X-Gm-Message-State: APjAAAUaxGi37ioOaLBam7q883vOdvtJKorB5VKRd01xLLOnHJwpK8gG
        xRl3gj4xLy8aWyI5YPAs7cMlI4NjrDxP3G6D2LNYYg==
X-Google-Smtp-Source: APXvYqweRQ8m5hhu1HXuRMedVPc2bAFe5tdPFCvhiapDMmB+s6KJgSZdl7ge+tHS5zEbJYelkAeAJQhRjXaIFteOOxWnoQ==
X-Received: by 2002:a63:234f:: with SMTP id u15mr21895366pgm.88.1580169284558;
 Mon, 27 Jan 2020 15:54:44 -0800 (PST)
Date:   Mon, 27 Jan 2020 15:53:52 -0800
In-Reply-To: <20200127235356.122031-1-brendanhiggins@google.com>
Message-Id: <20200127235356.122031-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200127235356.122031-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v1 1/5] net: axienet: add unspecified HAS_IOMEM dependency
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        "David S . Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Robert Hancock <hancock@sedsystems.ca>,
        Esben Haabendal <esben@geanix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, heidifahim@google.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CONFIG_XILINX_AXI_EMAC=y implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

/usr/bin/ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.o: in function `axienet_probe':
drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1680: undefined reference to `devm_ioremap_resource'
/usr/bin/ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1779: undefined reference to `devm_ioremap_resource'
/usr/bin/ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1789: undefined reference to `devm_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/net/ethernet/xilinx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
index 6304ebd8b5c69..b1a285e693756 100644
--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -25,6 +25,7 @@ config XILINX_EMACLITE
 
 config XILINX_AXI_EMAC
 	tristate "Xilinx 10/100/1000 AXI Ethernet support"
+	depends on HAS_IOMEM
 	select PHYLINK
 	---help---
 	  This driver supports the 10/100/1000 Ethernet from Xilinx for the
-- 
2.25.0.341.g760bfbb309-goog

