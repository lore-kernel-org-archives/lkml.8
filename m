Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A22BC2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 06:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E1F206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 06:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgDFGOo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 02:14:44 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48383 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgDFGOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 02:14:43 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id D7545CED2C;
        Mon,  6 Apr 2020 08:24:15 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v5 3/3] Bluetooth: btusb: Indicate Microsoft vendor
 extension for Intel 9160/9260
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200403203058.v5.3.I56c3ba2ec2bcfaadf57575c5c74a03dd4f8487d0@changeid>
Date:   Mon, 6 Apr 2020 08:14:41 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3361CF04-0C56-4787-9A74-99664DCB4312@holtmann.org>
References: <20200404033118.22135-1-mcchou@chromium.org>
 <20200403203058.v5.3.I56c3ba2ec2bcfaadf57575c5c74a03dd4f8487d0@changeid>
To:     Miao-chen Chou <mcchou@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miao-chen,

> This adds a bit mask of driver_info for Microsoft vendor extension and
> indicates the support for Intel 9160/9260. This was verified with Intel
> ThunderPeak BT controller where msft_opcode is 0xFC1E.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
> ---
> 
> Changes in v5:
> - Extract the changes on btusb as a different commit.
> 
> Changes in v4:
> - Introduce CONFIG_BT_MSFTEXT as a starting point of providing a
> framework to use Microsoft extension
> - Create include/net/bluetooth/msft.h and net/bluetooth/msft.c to
> facilitate functions of Microsoft extension.
> 
> Changes in v3:
> - Create net/bluetooth/msft.c with struct msft_vnd_ext defined internally
> and change the hdev->msft_ext field to void*.
> - Define and expose msft_vnd_ext_set_opcode() for btusb use.
> - Init hdev->msft_ext in hci_alloc_dev() and deinit it in hci_free_dev().
> 
> Changes in v2:
> - Define struct msft_vnd_ext and add a field of this type to struct
> hci_dev to facilitate the support of Microsoft vendor extension.
> 
> drivers/bluetooth/btusb.c | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 3bdec42c96123..f73ad18c04559 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -20,6 +20,7 @@
> 
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> +#include <net/bluetooth/msft.h>
> 
> #include "btintel.h"
> #include "btbcm.h"
> @@ -58,6 +59,7 @@ static struct usb_driver btusb_driver;
> #define BTUSB_CW6622		0x100000
> #define BTUSB_MEDIATEK		0x200000
> #define BTUSB_WIDEBAND_SPEECH	0x400000
> +#define BTUSB_MSFT_VND_EXT	0x800000
> 
> static const struct usb_device_id btusb_table[] = {
> 	/* Generic Bluetooth USB device */
> @@ -335,7 +337,8 @@ static const struct usb_device_id blacklist_table[] = {
> 
> 	/* Intel Bluetooth devices */
> 	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW |
> -						     BTUSB_WIDEBAND_SPEECH },
> +						     BTUSB_WIDEBAND_SPEECH |
> +						     BTUSB_MSFT_VND_EXT },
> 	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW |
> 						     BTUSB_WIDEBAND_SPEECH },
> 	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW |
> @@ -3800,6 +3803,12 @@ static int btusb_probe(struct usb_interface *intf,
> 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
> 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
> +
> +		/* All Intel controllers that support the Microsoft
> +		 * vendor extension are using 0xFC1E for VsMsftOpCode.
> +		 */
> +		if (id->driver_info & BTUSB_MSFT_VND_EXT)
> +			msft_set_opcode(hdev, 0xFC1E);

I decided to actually set the MSFT extension support in the btusb_setup_intel_new handler based on our firmware version information. I think that this will be better than USB products IDs. We can revisit this later, but for now, this should be enough.

Johan also applied the whole series and you should base your next steps on bluetooth-next.

Regards

Marcel

