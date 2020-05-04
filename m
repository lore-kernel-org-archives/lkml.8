Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E350CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C022B20721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgEDOR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 10:17:58 -0400
Received: from netrider.rowland.org ([192.131.102.5]:44283 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728075AbgEDOR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:17:57 -0400
Received: (qmail 13977 invoked by uid 500); 4 May 2020 10:17:56 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 May 2020 10:17:56 -0400
Date:   Mon, 4 May 2020 10:17:56 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     mathias.nyman@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] xhci: Prevent runtime suspend on Etron EJ168
In-Reply-To: <20200504113622.20361-1-kai.heng.feng@canonical.com>
Message-ID: <Pine.LNX.4.44L0.2005041015570.11213-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 May 2020, Kai-Heng Feng wrote:

> Etron EJ168 USB 3.0 Host Controller stops working after S3, if it was
> runtime suspended previously:
> [  370.080359] pci 0000:02:00.0: can't change power state from D3cold to D0 (config space inaccessible)
> [  370.080477] xhci_hcd 0000:04:00.0: can't change power state from D3cold to D0 (config space inaccessible)
> [  370.080532] pcieport 0000:00:1c.0: DPC: containment event, status:0x1f05 source:0x0200
> [  370.080533] pcieport 0000:00:1c.0: DPC: ERR_FATAL detected
> [  370.080536] xhci_hcd 0000:04:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> [  370.080552] xhci_hcd 0000:04:00.0: AER: can't recover (no error_detected callback)
> [  370.080566] usb usb3: root hub lost power or was reset
> [  370.080566] usb usb4: root hub lost power or was reset
> [  370.080572] xhci_hcd 0000:04:00.0: Host halt failed, -19
> [  370.080574] xhci_hcd 0000:04:00.0: Host not accessible, reset failed.
> [  370.080575] xhci_hcd 0000:04:00.0: PCI post-resume error -19!
> [  370.080586] xhci_hcd 0000:04:00.0: HC died; cleaning up
> 
> This can be fixed by not runtime suspend the controller at all.
> 
> So disable runtime suspend for EJ168 xHCI device.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Use a new quirk to avoid changing existing behavior.
> 
>  drivers/usb/host/xhci-pci.c | 4 +++-
>  drivers/usb/host/xhci.h     | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 766b74723e64..1658fa4c3e4e 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -227,6 +227,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  		xhci->quirks |= XHCI_RESET_ON_RESUME;
>  		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
>  		xhci->quirks |= XHCI_BROKEN_STREAMS;
> +		xhci->quirks |= XHCI_DISABLE_RUNTIME_SUSPEND;
>  	}
>  	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
>  	    pdev->device == 0x0014) {
> @@ -371,7 +372,8 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  		xhci->shared_hcd->can_do_streams = 1;
>  
>  	/* USB-2 and USB-3 roothubs initialized, allow runtime pm suspend */
> -	pm_runtime_put_noidle(&dev->dev);
> +	if (!(xhci->quirks & XHCI_DISABLE_RUNTIME_SUSPEND))
> +		pm_runtime_put_noidle(&dev->dev);

This cannot possibly be correct.  You have changed an unconditional 
runtime-put to a conditional one, but you have not made the 
corresponding change to the matching runtime-get.  Every runtime-PM 
put must be balanced by a get, and vice versa.

Alan Stern

