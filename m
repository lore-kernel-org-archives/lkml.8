Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CB8C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141C32085B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581361164;
	bh=dV/9pypPR+5LSujojchvrgFxxYVcyddDIPtQmTd6EPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=seAW2+asXDPq0oKqM/KKgENRWyd7QqQ9IT99lRpjwMCAnNc3fr8DMEKEoJ+gZQFIp
	 9wMjiIe/Z4lmsjpGYqCpL1M1KT5eJq2yuhNvdnMdjYJU2l98mnGvL2kFKSPwfQc0CA
	 VohC+VcncjejA49EFAAktZXoI3/dR7OBU4sAfMI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgBJS7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:59:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbgBJS7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:59:23 -0500
Received: from localhost (unknown [104.132.1.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED63E2085B;
        Mon, 10 Feb 2020 18:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581361162;
        bh=dV/9pypPR+5LSujojchvrgFxxYVcyddDIPtQmTd6EPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q9QOfyJW/DgVkDJQKfWyyLP9n5gkpS18hB2rZtUPWUvVhuHJZEqkHWEyFkKnFcYcN
         14BhDANDwaxllNUjwFiHBl3y0OgKngSv82tCYLGXoxEiyLS4/zUJS6eVnPPj7XjUHS
         3wDbtqT2pn0Sc1NNUaZoMg+OtGhJ1YvwDJjuZzUU=
Date:   Mon, 10 Feb 2020 10:59:21 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: Enable LPM for VIA LABS VL805
Message-ID: <20200210185921.GA1058087@kroah.com>
References: <20200120142422.3907-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120142422.3907-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 03:24:22PM +0100, Nicolas Saenz Julienne wrote:
> This PCIe controller chip is used on the Raspberry Pi 4 and multiple
> adapter cards. There is no publicly available documentation for the
> chip, yet both the downstream RPi4 kernel and the controller cards
> support/advertise LPM support.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/usb/host/xhci-pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 4917c5b033fa..c1976e98992b 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -241,6 +241,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  			pdev->device == 0x3432)
>  		xhci->quirks |= XHCI_BROKEN_STREAMS;
>  
> +	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483)
> +		xhci->quirks |= XHCI_LPM_SUPPORT;
> +
>  	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
>  			pdev->device == 0x1042)
>  		xhci->quirks |= XHCI_BROKEN_STREAMS;

Mathias, is this in your review queue?

thanks,

greg k-h
