Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80817C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C962073A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20150623.gappssmtp.com header.i=@dionne-riel-com.20150623.gappssmtp.com header.b="p+DLtz7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgIADpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIADps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 23:45:48 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3733C0612FE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 20:45:46 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 92so6448790qtb.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 20:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sb15qLWva7b5eccs+rAtHW207dq5g5GxXtdLjsQxg3E=;
        b=p+DLtz7WvZ7g/1FEoh9amfFpz7eFYZxiSbjhiDaOyDTkIowmmAKSmS4KeP9Z+9hxTo
         ROWSFXHQgVaVpnjkJXvwngQ9y35iINpSi6zTbx0lORgmnBlPMYh2pyEidc2tsX9m0tME
         RXB5+GRrqz5uVE3ZpDX2uC242n2ycolauL/vA1HqDsFfwwgvB5RP39jj15E9K0l2dlYi
         3Lle9LoWLxdXrNRrgl/aUEBIgdvpmfwnUH1+KiEokL7pMR1yzJ82wmuOtc7mqtShLVRM
         wvRKH0JiBw02cynF9aPycAVhonAaTK2OrlttLMUY/eRYRS+tazmzR+KSWsGG74gMcWtg
         wJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sb15qLWva7b5eccs+rAtHW207dq5g5GxXtdLjsQxg3E=;
        b=Tke+stG8RlpNvqlrZajMBNrrG4sXCFEjoY5xGUdDbL2ADrJF8eXaYUNwDsrYpEMYZH
         iT1/M5/xywh2DuULGuLTaht7trdJssokkMIqLWN0Y24j9EPSXFbPjnqTY4gNhGyz+nz7
         73ltXvuZQG21/maFfyge04b4DrAS45/U/9B8KZ7aFZXa+nh8NUdp3KjOvo0VaYvZ09Py
         fZrXUElk8Sojj8Iem2ynqwrS8mapZGr0qiL9kzgajUwn7npAx09vZDN4eNbTJCDiLyBG
         f3Zz8pV7YEKzMdS+aNbfScplAnIUFdIrdFPKIFSCageCAQAa07drJYuz8cMC2gdO6PR0
         L44A==
X-Gm-Message-State: AOAM5321gLYBQvtPgs8x9JMY0sdgLWGCrX/osUFd0JZ9YuyrIzfMk22y
        GfT7DN6rWXd+SHAibRTEv/CPzQ==
X-Google-Smtp-Source: ABdhPJytKLui/iELEzCyDiiipRYaftb3La6isv90YSp0yFSiuo20xYRbxtdXV+Nd4vBPGaXncxF/dA==
X-Received: by 2002:ac8:ec7:: with SMTP id w7mr4676763qti.118.1598931945770;
        Mon, 31 Aug 2020 20:45:45 -0700 (PDT)
Received: from DUFFMAN (135-23-195-85.cpe.pppoe.ca. [135.23.195.85])
        by smtp.gmail.com with ESMTPSA id s17sm13489048qte.50.2020.08.31.20.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 20:45:45 -0700 (PDT)
Date:   Mon, 31 Aug 2020 23:45:42 -0400
From:   Samuel Dionne-Riel <samuel@dionne-riel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Boot failure on gru-scarlet-inx with 5.9-rc2
Message-ID: <20200831234542.295b1275@DUFFMAN>
In-Reply-To: <90731ebb54fe03003dce03bc7ec4872e@kernel.org>
References: <20200829164920.7d28e01a@DUFFMAN>
        <65d88bdd0888a69849327501a2aad186@kernel.org>
        <20200831031838.2d6d76d9@DUFFMAN>
        <90731ebb54fe03003dce03bc7ec4872e@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 10:27:37 +0100
Marc Zyngier <maz@kernel.org> wrote:
> 
> Ah, so actually anything that *enables pcie* kills your system.
> Great investigative work!
> 
> > 
> > And backed by a further bisection with this that points to
> > d84c572de1a360501d2e439ac632126f5facf59d being the actual change
> > that causes the tablet to fail to boot, as long as the pcie0 node is
> > identified as pci properly.
> > 
> > I am unsure if I should add as a Cc everyone involved in that change
> > set, though the author (coincidentally) is already in the original
> > list of recipients.
> 
> I've deliberately moved Rob from Cc to To... ;-)

Thanks, I don't actually know who to write to exactly.

> > Any additional thoughts from this additional information?  
> 
> What you could do is to start looking at which of the
> pci_is_root_bus() changes breaks PCIe on this system.  The fact that
> it breaks on your system and not on mine is a bit puzzling.

Let me show you, on top of v5.9-rc3 I can successfully boot using this
partial revert / adaptation of d84c572d. In addition, it also allows
the Wi-Fi to work again, compared to how it didn't in 5.9-rc1 or
5.9-rc[23] with the dumb revert of your fix.

So, if we number each pci_is_root_bus by order appearance, it is only
the second use, in rockchip_pcie_valid_device, which seem to cause
scarlet not to boot.

The patch (not actually a patch submission) reverts only that instance
of pci_is_root_bus, while also doing some leg work to put back some
functionally equivalent code that was refactored away since.

If there's anything else you want me to try, don't hesitate.

---
 drivers/pci/controller/pcie-rockchip-host.c | 8 +++++++-
 drivers/pci/controller/pcie-rockchip.h      | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 0bb2fb3e8a0b..5a27fa833fbd 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -79,7 +79,7 @@ static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
 	 * do not read more than one device on the bus directly attached
 	 * to RC's downstream side.
 	 */
-	if (pci_is_root_bus(bus->parent) && dev > 0)
+	if (bus->primary == rockchip->root_bus_nr && dev > 0)
 		return 0;
 
 	return 1;
@@ -944,6 +944,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	struct rockchip_pcie *rockchip;
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
+	struct resource *bus_res;
 	int err;
 
 	if (!dev->of_node)
@@ -983,6 +984,11 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto err_deinit_port;
 
+	/* HACK; ~equiv to last param of pci_parse_request_of_pci_ranges */
+	bus_res = (resource_list_first_type(&bridge->windows, IORESOURCE_MEM))->res;
+
+	rockchip->root_bus_nr = bus_res->start;
+
 	err = rockchip_pcie_cfg_atu(rockchip);
 	if (err)
 		goto err_remove_irq_domain;
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index c7d0178fc8c2..0952fec7e34d 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -298,6 +298,7 @@ struct rockchip_pcie {
 	struct	gpio_desc *ep_gpio;
 	u32	lanes;
 	u8      lanes_map;
+	u8      root_bus_nr;
 	int	link_gen;
 	struct	device *dev;
 	struct	irq_domain *irq_domain;
-- 
2.25.4


Thanks again!

-- 
Samuel Dionne-Riel
