Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CB8C34024
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3491920836
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgBQRsO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:48:14 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:60719 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgBQRsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:48:14 -0500
Received: from [192.168.1.183] ([37.4.249.150]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MpUQk-1jowEF3hTY-00pw6F; Mon, 17 Feb 2020 18:47:51 +0100
Subject: Re: [PATCH] usb: xhci-pci: Raspberry Pi FW loader for VIA VL805
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oneukum@suse.com, linux-kernel@vger.kernel.org,
        tim.gover@raspberrypi.org, linux-rpi-kernel@lists.infradead.org,
        phil@raspberrypi.com, linux-arm-kernel@lists.infradead.org
References: <20200217100701.19949-1-nsaenzjulienne@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <bf77d351-ca8c-d9fd-e5ea-71441ac00ab3@i2se.com>
Date:   Mon, 17 Feb 2020 18:47:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200217100701.19949-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:MEb+cWca3hrW4nDZ1ggAgFk9coBvX+/65EOeZDFWM3YU2lCE+4z
 CCfBEJUUKkrd8L/4PY7EkBKjZXrhu32tNcDRrjg56fDdcT2HzI+AwBEoBgZVhniQNzy6LC3
 vGIOE+c++1IckNzQa5YhE43tZRPZeoAE2ORAgaVMGIKjj/CbYtDdW6OUaHVoseC0DyHLYe0
 ejGE14WZ9wqBihuviT8RA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CtL1K4btfg8=:b0MJWvqdGLbwBJHopp8Gjc
 qsJ0ntfLMykISUkWPD0JlJVXJ2/yHpHMSCm7tYteY65wDgapLBWxAiSfVZeIohXvSTazvkkfz
 4udwZDxnW2sUSGsehbUy6sPWW1fyePxQcWinLlsXS2xV3WTTDrRM0bmBFbhUzFINc4GFWQ8Tj
 t372TSdmNb6TZYJFzpnrvix1110aCgcYdaEKTrMt+YIYnxoLXdtM72agogIzw0SAmvl7mSWsk
 +ecYM/86NfwtMMvzYMRBST1VKbbBJKQ0bm6Qtt2at4cKkDTdKYuYMdrj26IZ5UUFMnsjDQOcs
 elc9vUJWtWZkVJwi8/IUHznIUsFGB+UQWHTvhId4dcs6i725+UDHD6wpy98v0ex+DLByL+mFR
 nQTeLZSbpRs9AUQqqhAOykM6H3VXmoCXP0aDTMEnbXRPmMSj7R3DSe11u0Jz1xBVeB/N2/WBF
 cf7zpKKCfF9A8CLkJ7lFeV4fmXPi0eY1X1wG/h1YMuY8NY0p6DQXbvLQlKLHXBCmQjagD07J9
 0Jy5SOaRKb0lMz0KXzXBiveE+amPWGAhAI+AE3FCAgePEmLaFKyF5VqdLhO5Zv+m10tdFdOEb
 bga7zeSu/xtXenvOg1QoQoP7xapQo0NEt6eIW6JVtELZKA64QsRlOR0u2J669wktqWcNEwMHm
 ovUP/lrKZ9dt8BfAqIx5oG7CZlKUtlAOs5Y15aIvypLcYQLUJ/5VtGjz1V/XLbY5a2jlkU6iE
 RYSbN4NDG28IX35ztFa4Y2RXYhvERkEfjaV6zeeD6+AGHoNaUlYaTWq8hsWS5SIiYTPowi+TP
 u3fKJ1HlgahtFGLqpLGF2z/lZQI+ArTyL+wLWbfn2vvTSkp+SXQ85+76vgdh6mkSp3U6bVx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Am 17.02.20 um 11:07 schrieb Nicolas Saenz Julienne:
> On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
> loaded directly from an EEPROM or, if not present, by the SoC's
> VideCore.  Inform VideCore that VL805 was just reset, or defer xhci's
> probe if not yet joinable trough the mailbox interface.
>
> Based on Tim Gover's downstream implementation.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/usb/host/xhci-pci.c                | 50 ++++++++++++++++++++++
>  include/soc/bcm2835/raspberrypi-firmware.h |  2 +-
>  2 files changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 4917c5b033fa..eadace4a9339 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -13,6 +13,8 @@
>  #include <linux/module.h>
>  #include <linux/acpi.h>
>  
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
>  #include "xhci.h"
>  #include "xhci-trace.h"
>  
> @@ -308,6 +310,44 @@ static int xhci_pci_setup(struct usb_hcd *hcd)
>  	return xhci_pci_reinit(xhci, pdev);
>  }
>  
> +/*
> + * On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
> + * loaded directly from an EEPROM or, if not present, by the SoC's VideCore.
> + * Inform VideCore that VL805 was just reset, or defer xhci's probe if not yet
> + * joinable trough the mailbox interface.
> + */
> +static int raspberrypi_load_vl805_fw(struct pci_dev *pdev)
> +{
> +#ifdef CONFIG_RASPBERRYPI_FIRMWARE
> +	struct device_node *fw_np;
> +	struct rpi_firmware *fw;
> +	u32 dev_addr;
> +	int ret;
> +
> +	fw_np = of_find_compatible_node(NULL, NULL,
> +					"raspberrypi,bcm2835-firmware");
> +	if (!fw_np)
> +		return 0;
> +
> +	fw = rpi_firmware_get(fw_np);
> +	of_node_put(fw_np);
> +	if (!fw)
> +		return -EPROBE_DEFER;
> +
> +	dev_addr = pdev->bus->number << 20 | PCI_SLOT(pdev->devfn) << 15 |
> +		   PCI_FUNC(pdev->devfn) << 12;
> +
> +	ret = rpi_firmware_property(fw, RPI_FIRMWARE_NOTIFY_XHCI_RESET,
> +				    &dev_addr, sizeof(dev_addr));
> +	if (ret)
> +		return ret;
not sure, but there could be a corner case which should be handled
differently. In case the Raspberry Pi 4 has an EEPROM for the VL805
firmware but the firmware is too old to handle
RPI_FIRMWARE_NOTIFY_XHCI_RESET, we should return with 0. I don't know
there is a change to detect this reliable. I just want to mention this.
> +
> +	dev_dbg(&pdev->dev, "loaded Raspberry Pi's VL805 firmware\n");
> +
> +#endif
> +	return 0;
> +}
> +
>  /*
>   * We need to register our own PCI probe function (instead of the USB core's
>   * function) in order to create a second roothub under xHCI.
> @@ -321,6 +361,16 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  
>  	driver = (struct hc_driver *)id->driver_data;
>  
> +	if (dev->vendor == PCI_VENDOR_ID_VIA && dev->device == 0x3483) {
> +		retval = raspberrypi_load_vl805_fw(dev);
> +		if (retval) {
> +			if (retval != -EPROBE_DEFER)
> +				dev_err(&dev->dev,
> +					"Failed to load VL805's firmware");
> +			return retval;
> +		}
> +	}
> +
>  	/* Prevent runtime suspending between USB-2 and USB-3 initialization */
>  	pm_runtime_get_noresume(&dev->dev);
>  
> diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
> index 7800e12ee042..cc9cdbc66403 100644
> --- a/include/soc/bcm2835/raspberrypi-firmware.h
> +++ b/include/soc/bcm2835/raspberrypi-firmware.h
> @@ -90,7 +90,7 @@ enum rpi_firmware_property_tag {
>  	RPI_FIRMWARE_SET_PERIPH_REG =                         0x00038045,
>  	RPI_FIRMWARE_GET_POE_HAT_VAL =                        0x00030049,
>  	RPI_FIRMWARE_SET_POE_HAT_VAL =                        0x00030050,
> -
> +	RPI_FIRMWARE_NOTIFY_XHCI_RESET =                      0x00030058,

In past we updated the firmware mailbox property interface in a bunch as
a separate patch. So we can avoid those gaps.

Best regards
Stefan

>  
>  	/* Dispmanx TAGS */
>  	RPI_FIRMWARE_FRAMEBUFFER_ALLOCATE =                   0x00040001,

