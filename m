Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6D5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C63C206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aiclBWRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgHFR4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbgHFR4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:56:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F3FC061575
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 10:55:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so44835784wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 10:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VLToQkSGb9Fyj+rMmCyIoE12BtD4sRvLhirgEOkP9W4=;
        b=aiclBWRQsaqlr4rxoQqEFfHk424DkMeqTmreM/zu7IQoemedoiGmY1RO05MmpZR6+P
         w7xGe9fU76E3VMZ7Isj9CVyq5FEg4I8VDs+q0YobHeP9Ohy4GB5+BKuoR/WEUbUXJdph
         UquQ9WkUAjpPvjtyL6o6gTPDC/x9qzlzrlEYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VLToQkSGb9Fyj+rMmCyIoE12BtD4sRvLhirgEOkP9W4=;
        b=ZmlagJCKYN9ntCKFfDGpb1Z8jB+wj8MYTE1pxKvvcrj3ncv3NK453oCpxtDINGPPyF
         78Bl98V1tcJ23zhuxRTO3Xn8yqm7CwVSf1Z1kLUu/UAOOdeS1rWjdTMxOabV8v0Tbm/f
         hqqye8z1ewOSZx5u3lbIcwiHBE2GhirVi5pZSXpmYfqiMVlGoBW3YjmxTywzl5dxuhks
         RQasZbGf5LSxdETxTvurPYSGE6SvFoL4DWsBdwyvJ9Op5Nzgklq4Is4RZf5Gn+X67AhY
         Efq3IR32NE/4vkt3n3D6auNJUimx/VBycukMFBPWfw/ldO2vGd53Wn6JGIQTaxoxs9+3
         pJDQ==
X-Gm-Message-State: AOAM531TKHe/jPi31WRAIEmKoxyqebx0AflPPD7KcvNaBj4A1Gl5yHAJ
        JKMcu5FwxxNtoneGWBwqfH/684B5/5PJUyNVP0oC23dr9YA6sQUzgZ4kTmJ8oOtn0nHGUTiRy8Y
        cMTHQRxS1xHl02OpfoE3So44pSkunQil+wwomGUQJxDfUU9cDPuSGkibzoIPbAeYvQ8VqOwRHRa
        RDzrvMda4P
X-Google-Smtp-Source: ABdhPJzbtHnvN2YvogoQjvg6Nr1wWat0eDA9t2hrW3lsNiU9zCFscq1A7+T3HDp3Wo7bjV+9E+cWiQ==
X-Received: by 2002:adf:bb07:: with SMTP id r7mr8403518wrg.102.1596736558012;
        Thu, 06 Aug 2020 10:55:58 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l11sm6978590wme.11.2020.08.06.10.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 10:55:57 -0700 (PDT)
Subject: Re: [PATCH v4] PCI: Reduce warnings on possible RW1C corruption
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        ray.jui@broadcom.com, helgaas@kernel.org, sbranden@broadcom.com,
        f.fainelli@gmail.com, lorenzo.pieralisi@arm.com, robh@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200806041455.11070-1-mark.tomlinson@alliedtelesis.co.nz>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <16cbd3f5-722a-cf8b-487e-82a0bbf95053@broadcom.com>
Date:   Thu, 6 Aug 2020 10:55:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806041455.11070-1-mark.tomlinson@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.

On 2020-08-05 9:14 p.m., Mark Tomlinson wrote:
> For hardware that only supports 32-bit writes to PCI there is the
> possibility of clearing RW1C (write-one-to-clear) bits. A rate-limited
> messages was introduced by fb2659230120, but rate-limiting is not the
> best choice here. Some devices may not show the warnings they should if
> another device has just produced a bunch of warnings. Also, the number
> of messages can be a nuisance on devices which are otherwise working
> fine.
>
> This patch changes the ratelimit to a single warning per bus. This
> ensures no bus is 'starved' of emitting a warning and also that there
> isn't a continuous stream of warnings. It would be preferable to have a
> warning per device, but the pci_dev structure is not available here, and
> a lookup from devfn would be far too slow.
>
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Fixes: fb2659230120 ("PCI: Warn on possible RW1C corruption for sub-32 bit config writes")
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
> changes in v4:
>  - Use bitfield rather than bool to save memory (was meant to be in v3).
>
>  drivers/pci/access.c | 9 ++++++---
>  include/linux/pci.h  | 1 +
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 79c4a2ef269a..b452467fd133 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -160,9 +160,12 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
>  	 * write happen to have any RW1C (write-one-to-clear) bits set, we
>  	 * just inadvertently cleared something we shouldn't have.
>  	 */
> -	dev_warn_ratelimited(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
> -			     size, pci_domain_nr(bus), bus->number,
> -			     PCI_SLOT(devfn), PCI_FUNC(devfn), where);
> +	if (!bus->unsafe_warn) {
> +		dev_warn(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
> +			 size, pci_domain_nr(bus), bus->number,
> +			 PCI_SLOT(devfn), PCI_FUNC(devfn), where);
> +		bus->unsafe_warn = 1;
> +	}
>  
>  	mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
>  	tmp = readl(addr) & mask;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 34c1c4f45288..85211a787f8b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -626,6 +626,7 @@ struct pci_bus {
>  	struct bin_attribute	*legacy_io;	/* Legacy I/O for this bus */
>  	struct bin_attribute	*legacy_mem;	/* Legacy mem */
>  	unsigned int		is_added:1;
> +	unsigned int		unsafe_warn:1;	/* warned about RW1C config write */
>  };
>  
>  #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)

