Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0230BC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 09:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CDE2051A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 09:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="ylpat4kR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgCGJyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 04:54:32 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35149 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgCGJyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 04:54:32 -0500
Received: by mail-lf1-f68.google.com with SMTP id z9so3875894lfa.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 01:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+iY7vg8Db28lbZpkj8YbZ4nAiqLqC1ZkxS8MIhuLcMU=;
        b=ylpat4kRdMth3tgWlvM26uho69yQ9OBDlJqz9C4W2FP/opded7R33Gs9dCZ441sDeE
         XXcCUprakY2Zx3bRayE+q+uD4obMIAircprbTxdJYpe0/qTADFTqpBe8JJ2igckRHAvT
         dP4JYIuo8Y/qjWN7nj4ykCDfVsEOCmPMALohd4iLGEzL4XbxBtw8A+esMWN4Y62zJU9t
         eGNr4baLxZ2rUHx2gNf2f5QIze1ZEoBsuHtfznFaQerUm+yB8zo/NKsh2ibjgx4tEY6e
         Hd8Xp1eCtoOc1T7H4kcg3+4wc1scUop9Bh1WiUdxKbXAe3XK/R1Nx3UcKD5Hdmv6qH/1
         whIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+iY7vg8Db28lbZpkj8YbZ4nAiqLqC1ZkxS8MIhuLcMU=;
        b=j3mB6jXlagV3Q1Ge+a+IeBEczHIonG9HVdlQ01afD9fK+8q1/+gK999JNXGJr13at1
         I4u7q0iMt4td6zMuXb8Ocw1TWray3r+EUxIFhGrHK0wFqqZYgD+/1wMwXGlSPtoyiI5B
         9NhNvEgFDlnfE7iEdjWdNRFYIfePgAjPOW58MppWJuYDG7QdokWfkNcwtPPwygoqmYGf
         ncAyGJyNpBUi/jiTo72D2VA4co96l1vhMuwJ2sp9pogxcbOaTO65B36lyPX3gbCvpn1j
         Xz46EC0aHBq+CDD6cM41Rs5G3PW2m+xnhg9qd2wuqgpehRzqec+tWqTprcHzGNy/8k8A
         +76w==
X-Gm-Message-State: ANhLgQ1+alRSptBWGL8swQz5n2n2EabTjZIM8U5kShP+vTTMrKsaYIKx
        5ArQ9Ss7qaB7oIVftdmuTE1OoQ==
X-Google-Smtp-Source: ADFU+vv6OIWzoXOg4mWHENdK4mbxgfXz8v6v9hX1jJMwhRRBJ60rFJUXuMg07DvgtCrrYsNkhjdr7Q==
X-Received: by 2002:a05:6512:692:: with SMTP id t18mr4284908lfe.212.1583574870677;
        Sat, 07 Mar 2020 01:54:30 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:402:864b:dd24:504:68eb:a9fe? ([2a00:1fa0:402:864b:dd24:504:68eb:a9fe])
        by smtp.gmail.com with ESMTPSA id j17sm2554029ljc.0.2020.03.07.01.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2020 01:54:29 -0800 (PST)
Subject: Re: [PATCH v4 4/4] USB: pci-quirks: Add Raspberry Pi 4 quirk
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, wahrenst@gmx.net
References: <20200306114348.5172-1-nsaenzjulienne@suse.de>
 <20200306114348.5172-5-nsaenzjulienne@suse.de>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b4fb58f0-6d51-657b-bcf6-5f4b0c798312@cogentembedded.com>
Date:   Sat, 7 Mar 2020 12:54:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306114348.5172-5-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 06.03.2020 14:43, Nicolas Saenz Julienne wrote:

> On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
> loaded directly from an EEPROM or, if not present, by the SoC's
> VideCore. Inform VideCore that VL805 was just reset.
> 
> Also, as this creates a dependency between XHCI_PCI and VideoCore's
> firmware interface, reflect that on the firmware interface Kconfg.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
> 
> Changes since v3:
>   - Add more complete error message.
>   - Add braces around if statement
> 
> Changes since v1:
>   - Make RASPBERRYPI_FIRMWARE dependent on this quirk to make sure it
>     gets compiled when needed.
> 
>   drivers/firmware/Kconfig      |  1 +
>   drivers/usb/host/pci-quirks.c | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+)
[...]
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index beb2efa71341..452f5f12b042 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -16,6 +16,9 @@
>   #include <linux/export.h>
>   #include <linux/acpi.h>
>   #include <linux/dmi.h>
> +
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
>   #include "pci-quirks.h"
>   #include "xhci-ext-caps.h"
>   
> @@ -1243,11 +1246,24 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
>   
>   static void quirk_usb_early_handoff(struct pci_dev *pdev)
>   {
> +	int ret;
> +
>   	/* Skip Netlogic mips SoC's internal PCI USB controller.
>   	 * This device does not need/support EHCI/OHCI handoff
>   	 */
>   	if (pdev->vendor == 0x184e)	/* vendor Netlogic */
>   		return;
> +
> +	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483) {
> +		ret = rpi_firmware_init_vl805(pdev);
> +		if (ret) {
> +			/* Firmware might be outdated, or something failed */
> +			dev_warn(&pdev->dev, "Failed to load VL805's firmware: %d\n", ret);
> +			dev_warn(&pdev->dev, "Will continue to attempt to work, "
> +				 "but bad things might happen. You should fix this...\n");

    Don't break up the long kernel messages (checkpatch.pl should not complain 
about them).

[...]

MBR, Sergei
