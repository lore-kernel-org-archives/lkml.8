Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1B5C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188AC207EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgICJTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 05:19:09 -0400
Received: from foss.arm.com ([217.140.110.172]:57284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgICJTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 05:19:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C6CC101E;
        Thu,  3 Sep 2020 02:19:07 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BA943F68F;
        Thu,  3 Sep 2020 02:19:06 -0700 (PDT)
Date:   Thu, 3 Sep 2020 10:19:01 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc:     Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Boot failure on gru-scarlet-inx with 5.9-rc2
Message-ID: <20200903091901.GA9386@e121166-lin.cambridge.arm.com>
References: <20200829164920.7d28e01a@DUFFMAN>
 <65d88bdd0888a69849327501a2aad186@kernel.org>
 <20200831031838.2d6d76d9@DUFFMAN>
 <90731ebb54fe03003dce03bc7ec4872e@kernel.org>
 <20200831234542.295b1275@DUFFMAN>
 <5db50a8e5b251714cebe0a719ee9dc73@kernel.org>
 <20200901164249.GA15045@e121166-lin.cambridge.arm.com>
 <20200901143356.0425d9ba@DUFFMAN>
 <20200902160110.GA30014@e121166-lin.cambridge.arm.com>
 <20200902234756.60e4c4f6@DUFFMAN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902234756.60e4c4f6@DUFFMAN>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 11:47:56PM -0400, Samuel Dionne-Riel wrote:
> On Wed, 2 Sep 2020 17:01:19 +0100
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> 
> > On Tue, Sep 01, 2020 at 02:33:56PM -0400, Samuel Dionne-Riel wrote:
> > 
> > Please print a pointer as a pointer and print both bus and
> > bus->parent.
> 
> Hopefully pointer as a pointer is %px. Not sure what else, if that's
> wrong please tell.
> 
> ---
> @@ -79,6 +79,8 @@ static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
>          * do not read more than one device on the bus directly attached
>          * to RC's downstream side.
>          */
> +       printk("[!!] // bus (%px) bus->parent (%px)\n", bus, bus->parent);
> +       printk("[!!] bus->primary (%d) == rockchip->root_bus_nr (%d) && dev (%d) > 0\n", bus->primary, rockchip->root_bus_nr, dev);
>         if (bus->primary == rockchip->root_bus_nr && dev > 0)
>                 return 0;
>  
> --
> 
> Again, two values, verified with a bit of set and `sort -u`.
> 
> [    1.691266] [!!] // bus (ffff0000ef9ab800) bus->parent (0000000000000000)
> [    1.691271] [!!] bus->primary (0) == rockchip->root_bus_nr (0) && dev (0) > 0
> 
> and
> 
> [    1.697156] [!!] // bus (ffff0000ef9ac000) bus->parent (ffff0000ef9ab800)
> [    1.697160] [!!] bus->primary (0) == rockchip->root_bus_nr (0) && dev (0) > 0
> 
> First instance of each shown here. Last time I don't think it was.

Ok I think I understand what the problem is.

Can you give this patch a shot please ? I think we are dereferencing
a NULL pointer if bus is the root bus and dev == 0, we can rewrite
the check if this patch fixes the issue.

-- >8 --
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 0bb2fb3e8a0b..72beda87b47f 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -79,7 +79,7 @@ static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
 	 * do not read more than one device on the bus directly attached
 	 * to RC's downstream side.
 	 */
-	if (pci_is_root_bus(bus->parent) && dev > 0)
+	if (bus->parent && pci_is_root_bus(bus->parent) && dev > 0)
 		return 0;
 
 	return 1;
