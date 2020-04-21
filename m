Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C370C55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E1E2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgDUHMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:12:44 -0400
Received: from hfcrelay.icp-osb-irony-out1.external.iinet.net.au ([203.59.1.81]:1566
        "EHLO hfcrelay.icp-osb-irony-out1.external.iinet.net.au"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgDUHMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:12:44 -0400
X-SMTP-MATCH: 0
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BOAQAhnJ5e/xsiIRsNWRwBAQEBAQc?=
 =?us-ascii?q?BAREBBAQBAYF7hEeEHo9QAQEGgQotigCRTgoBAQEBAQEBAQE3BAEBhEQCgjQ?=
 =?us-ascii?q?4EwIQAQEBBQEBAQEBBQMBhXeGSgEBAQMjFUEQCxgCAiYCAlcGAQwGAgEBgyK?=
 =?us-ascii?q?CTAMJsC11gTKFT4J+IU6BQIEOKoxTeYEHgTiCOy4+hBWDS4JfBJhkmSMIgka?=
 =?us-ascii?q?XayOcV49wnn+BeDMaCCgIgyRQJZFkF443YoxsgkUBAQ?=
X-IPAS-Result: =?us-ascii?q?A2BOAQAhnJ5e/xsiIRsNWRwBAQEBAQcBAREBBAQBAYF7h?=
 =?us-ascii?q?EeEHo9QAQEGgQotigCRTgoBAQEBAQEBAQE3BAEBhEQCgjQ4EwIQAQEBBQEBA?=
 =?us-ascii?q?QEBBQMBhXeGSgEBAQMjFUEQCxgCAiYCAlcGAQwGAgEBgyKCTAMJsC11gTKFT?=
 =?us-ascii?q?4J+IU6BQIEOKoxTeYEHgTiCOy4+hBWDS4JfBJhkmSMIgkaXayOcV49wnn+Be?=
 =?us-ascii?q?DMaCCgIgyRQJZFkF443YoxsgkUBAQ?=
X-IronPort-AV: E=Sophos;i="5.72,409,1580745600"; 
   d="scan'208";a="288535545"
Received: from 27-33-34-27.tpgi.com.au (HELO [192.168.0.106]) ([27.33.34.27])
  by icp-osb-irony-out1.iinet.net.au with ESMTP; 21 Apr 2020 15:12:37 +0800
Subject: Re: [PATCH] m68k/PCI: Fix a memory leak in an error handling path
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        geert@linux-m68k.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200418070751.25420-1-christophe.jaillet@wanadoo.fr>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <3a465332-532b-00f1-bca0-4ead5228ebd9@linux-m68k.org>
Date:   Tue, 21 Apr 2020 17:12:34 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418070751.25420-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 18/4/20 5:07 pm, Christophe JAILLET wrote:
> If 'ioremap' fails, we must free 'bridge', as done in other error handling
> path bellow.
> 
> Fixes: 19cc4c843f40 ("m68k/PCI: Replace pci_fixup_irqs() call with host bridge IRQ mapping hooks")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Looks good, thanks.
I will queue this in the for-next branch of the m68knommu tree.

Regards
Greg


> ---
>   arch/m68k/coldfire/pci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/coldfire/pci.c b/arch/m68k/coldfire/pci.c
> index 62b0eb6cf69a..84eab0f5e00a 100644
> --- a/arch/m68k/coldfire/pci.c
> +++ b/arch/m68k/coldfire/pci.c
> @@ -216,8 +216,10 @@ static int __init mcf_pci_init(void)
>   
>   	/* Keep a virtual mapping to IO/config space active */
>   	iospace = (unsigned long) ioremap(PCI_IO_PA, PCI_IO_SIZE);
> -	if (iospace == 0)
> +	if (iospace == 0) {
> +		pci_free_host_bridge(bridge);
>   		return -ENODEV;
> +	}
>   	pr_info("Coldfire: PCI IO/config window mapped to 0x%x\n",
>   		(u32) iospace);
>   
> 
