Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A112C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C94F206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgEENjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:39:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:54666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729023AbgEENjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:39:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F2597AFA1;
        Tue,  5 May 2020 13:39:12 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] usb: xhci: Load Raspberry Pi 4 VL805's firmware
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        u-boot@lists.denx.de, bmeng.cn@gmail.com, marex@denx.de,
        linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com
References: <20200430130433.11248-1-nsaenzjulienne@suse.de>
 <20200430130433.11248-3-nsaenzjulienne@suse.de>
 <0958ece3-feda-65c0-b0e2-893e2dfeb508@suse.com>
 <cefb0be789dba88b3e3ad825fd74f49195110f97.camel@suse.de>
From:   Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; prefer-encrypt=mutual; keydata=
 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
 HxUCQ9Y1Y/Ct
Message-ID: <38448831-9f22-f887-e938-065fed195414@suse.com>
Date:   Tue, 5 May 2020 15:39:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cefb0be789dba88b3e3ad825fd74f49195110f97.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/2020 14:53, Nicolas Saenz Julienne wrote:
> Hi Matthias,
> 
> On Tue, 2020-05-05 at 14:15 +0200, Matthias Brugger wrote:
>>
>> On 30/04/2020 15:04, Nicolas Saenz Julienne wrote:
>>> When needed, RPi4's co-processor (called VideoCore) has to be instructed
>>> to load VL805's firmware (the chip providing xHCI support). VideoCore's
>>> firmware expects the board's PCIe bus to be already configured in order
>>> for it to load the xHCI chip firmware. So we have to make sure this
>>> happens in between the PCIe configuration and xHCI startup.
>>>
>>> Introduce a callback in xhci_pci_probe() to run this platform specific
>>> routine.
>>>
>>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>>
>>> ---
>>>
>>> Changes since v1:
>>>  - Create callback
>>>
>>>  board/raspberrypi/rpi/rpi.c | 12 ++++++++++++
>>>  drivers/usb/host/xhci-pci.c |  6 ++++++
>>>  include/usb/xhci.h          |  3 +++
>>>  3 files changed, 21 insertions(+)
>>>
>>> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
>>> index e367ba3092..8aa78d1f48 100644
>>> --- a/board/raspberrypi/rpi/rpi.c
>>> +++ b/board/raspberrypi/rpi/rpi.c
>>> @@ -14,6 +14,7 @@
>>>  #include <lcd.h>
>>>  #include <memalign.h>
>>>  #include <mmc.h>
>>> +#include <usb/xhci.h>
>>>  #include <asm/gpio.h>
>>>  #include <asm/arch/mbox.h>
>>>  #include <asm/arch/msg.h>
>>> @@ -494,3 +495,14 @@ int ft_board_setup(void *blob, bd_t *bd)
>>>  
>>>  	return 0;
>>>  }
>>> +
>>> +#ifdef CONFIG_BCM2711
>>
>> This won't work with rpi_arm64_defconfig.
>> Can't we just evaluate at runtime if we need to do anything in xhci_pci_fixup.
> 
> I can't see why, who is going to call xhci_pci_probe() in RPi3?
> 

If you do make rpi_arm64_defconfig and inspect the .config, you will see that
CONFIG_BCM2711 is not defined, so this code won't be called on RPi4.

Regards,
Matthias

> Regards,
> Nicolas
> 
>> I wonder if the newer RPi4 have also a newer revision ID (see get_board_rev).
>> If
>> so we could add another bool to struct rpi_model which will indicate us if we
>> need to notify VideoCore about vl805's firmware.
>>
>>> +void xhci_pci_fixup(struct udevice *dev)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = bcm2711_notify_vl805_reset();
>>> +	if (ret)
>>> +		printf("RPI: Failed to notify VideoCore about vl805's
>>> firmware\n");
>>> +}
>>> +#endif
>>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>>> index c1f60da541..1285dde1ef 100644
>>> --- a/drivers/usb/host/xhci-pci.c
>>> +++ b/drivers/usb/host/xhci-pci.c
>>> @@ -11,6 +11,10 @@
>>>  #include <usb.h>
>>>  #include <usb/xhci.h>
>>>  
>>> +__weak void xhci_pci_fixup(struct udevice *dev)
>>> +{
>>> +}
>>> +
>>>  static void xhci_pci_init(struct udevice *dev, struct xhci_hccr **ret_hccr,
>>>  			  struct xhci_hcor **ret_hcor)
>>>  {
>>> @@ -40,6 +44,8 @@ static int xhci_pci_probe(struct udevice *dev)
>>>  	struct xhci_hccr *hccr;
>>>  	struct xhci_hcor *hcor;
>>>  
>>> +	xhci_pci_fixup(dev);
>>> +
>>>  	xhci_pci_init(dev, &hccr, &hcor);
>>>  
>>>  	return xhci_register(dev, hccr, hcor);
>>> diff --git a/include/usb/xhci.h b/include/usb/xhci.h
>>> index c16106a2fc..57feed7603 100644
>>> --- a/include/usb/xhci.h
>>> +++ b/include/usb/xhci.h
>>> @@ -16,6 +16,7 @@
>>>  #ifndef HOST_XHCI_H_
>>>  #define HOST_XHCI_H_
>>>  
>>> +#include <usb.h>
>>>  #include <asm/types.h>
>>>  #include <asm/cache.h>
>>>  #include <asm/io.h>
>>> @@ -1281,4 +1282,6 @@ extern struct dm_usb_ops xhci_usb_ops;
>>>  
>>>  struct xhci_ctrl *xhci_get_ctrl(struct usb_device *udev);
>>>  
>>> +extern void xhci_pci_fixup(struct udevice *dev);
>>> +
>>>  #endif /* HOST_XHCI_H_ */
>>>
> 
