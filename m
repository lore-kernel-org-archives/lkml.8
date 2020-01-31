Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8919C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A0F20705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgAaOsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:48:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:50390 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729090AbgAaOsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:48:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2020 06:47:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,386,1574150400"; 
   d="scan'208";a="310020734"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2020 06:47:56 -0800
Subject: Re: [PATCH] xhci-mtk: Fix NULL pointer dereference with xhci_irq()
 for shared_hcd
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Sriharsha Allenki <sallenki@codeaurora.org>
References: <1579246910-22736-1-git-send-email-macpaul.lin@mediatek.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <08f69bab-2ada-d6ab-7bf7-d960e9f148a0@linux.intel.com>
Date:   Fri, 31 Jan 2020 16:50:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1579246910-22736-1-git-send-email-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.1.2020 9.41, Macpaul Lin wrote:
> According to NULL pointer fix: https://tinyurl.com/uqft5ra
> xhci: Fix NULL pointer dereference with xhci_irq() for shared_hcd
> The similar issue has also been found in QC activities in Mediatek.
> 
> Here quote the description from the referenced patch as follows.
> "Commit ("f068090426ea xhci: Fix leaking USB3 shared_hcd
> at xhci removal") sets xhci_shared_hcd to NULL without
> stopping xhci host. This results into a race condition
> where shared_hcd (super speed roothub) related interrupts
> are being handled with xhci_irq happens when the
> xhci_plat_remove is called and shared_hcd is set to NULL.
> Fix this by setting the shared_hcd to NULL only after the
> controller is halted and no interrupts are generated."
> 
> Signed-off-by: Sriharsha Allenki <sallenki@codeaurora.org>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>   drivers/usb/host/xhci-mtk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> index b18a6baef204..c227c67f5dc5 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -593,11 +593,11 @@ static int xhci_mtk_remove(struct platform_device *dev)
>   	struct usb_hcd  *shared_hcd = xhci->shared_hcd;
>   
>   	usb_remove_hcd(shared_hcd);
> -	xhci->shared_hcd = NULL;
>   	device_init_wakeup(&dev->dev, false);
>   
>   	usb_remove_hcd(hcd);
>   	usb_put_hcd(shared_hcd);
> +	xhci->shared_hcd = NULL;
>   	usb_put_hcd(hcd);
>   	xhci_mtk_sch_exit(mtk);
>   	xhci_mtk_clks_disable(mtk);
> 

Could you share details of the NULL pointer dereference, (backtrace).

The USB3 hcd is already removed when xhci->shared_hcd is set to NULL.
We might want to add some checks to make sure we are not using the removed
hcd anymore in that codepath anymore.

-Mathias
