Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E857C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E51472087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgH0Sql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:46:41 -0400
Received: from foss.arm.com ([217.140.110.172]:33274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgH0Sqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:46:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0519101E;
        Thu, 27 Aug 2020 11:46:39 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 579663F68F;
        Thu, 27 Aug 2020 11:46:38 -0700 (PDT)
Subject: Re: [PATCH 2/2] usb: dwc3: Add driver for Xilinx platforms
To:     Manish Narani <manish.narani@xilinx.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, balbi@kernel.org, p.zabel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        linux-arm-kernel@lists.infradead.org
References: <1598467441-124203-1-git-send-email-manish.narani@xilinx.com>
 <1598467441-124203-3-git-send-email-manish.narani@xilinx.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0927fb9f-1044-38b3-d6f3-76edffefd99c@arm.com>
Date:   Thu, 27 Aug 2020 19:46:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598467441-124203-3-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-26 19:44, Manish Narani wrote:
[...]
> +	/*
> +	 * This routes the usb dma traffic to go through CCI path instead
> +	 * of reaching DDR directly. This traffic routing is needed to
> +	 * make SMMU and CCI work with USB dma.
> +	 */
> +	if (of_dma_is_coherent(dev->of_node) || dev->iommu_group) {
> +		reg = readl(priv_data->regs + XLNX_USB_COHERENCY);
> +		reg |= XLNX_USB_COHERENCY_ENABLE;
> +		writel(reg, priv_data->regs + XLNX_USB_COHERENCY);
> +	}

This looks rather suspect - coherency should be based on coherency, not 
on whether an IOMMU group is present. If the device isn't described as 
coherent in the DT, then any SMMU mappings will end up using attributes 
that will downgrade traffic to be non-snooping anyway. And if the SMMU 
is enabled but not translating (e.g. "iommu.passthrough=1") then 
enabling hardware coherency when the DMA layer hasn't been told about it 
can potentially lead to nasty subtle problems and data loss.

Robin.
