Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F8EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6582206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHZY67fF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgGVK7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:59:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54218 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726161AbgGVK7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595415578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+wVWS16Js3jNxs8fWvzPR0bJin1jJLMhqNvzBKpigTI=;
        b=dHZY67fFc74Kim10davzuwBatNSKlFMm/7nJ/Ogv6Ck0R3y6ahwtHk2hkoSAl3i6fjVIki
        Nbk73+zggPhUhrMfbUbzO5mZ3+rXMGzecoZh0Y4Gc+mgXxWAyGeY/5mikhsKXZa8r7HyA8
        lOSdLMc1COQU6J2ULuEgaizEepLlILo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-Y_hqJt8IP868xE2IdigitQ-1; Wed, 22 Jul 2020 06:59:35 -0400
X-MC-Unique: Y_hqJt8IP868xE2IdigitQ-1
Received: by mail-wr1-f72.google.com with SMTP id s23so307290wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+wVWS16Js3jNxs8fWvzPR0bJin1jJLMhqNvzBKpigTI=;
        b=ocpeS03jjzBLOGWwa+Qkb2KONqZc35F1WN84YStT/5LqtFM2oM+yHW8ww1WM6vnpyG
         ++o1t8wkmkI9zQXlO1jFky0l9yKeqxYrNnE6oC1BiUtlOG6nZauabNxMCZdfV0EUvIgQ
         6J+AIlsqqbPVoOl7MJotobzXLyXfzsAjbhMD4X3EmCBp6IL3lNTwJV0Rqc/QYJk9md0w
         Qu7myAcv2sv+6j4dn2w/k45UYLzzA6pEz2LbGCUZVfG8zo8MfepSoEXJiNdgXDneDW4w
         G+N3DLNCG4E7cXjQCTGwJlAIVgR9rfvlTd/PU4bOEX3OWww0ZbfAcYfqkK+9ztnz2rTN
         hXTw==
X-Gm-Message-State: AOAM531fa4M1hO6fDHgY6s1g2837HAZybkgbt2iMrHkoEoHj7jjCgkv/
        Bxfq/7zLv8uPRde2NtKxYR70I0MY75xm4Q0oR7qBGyFuTUBLJ+zOXWGe7TAFVU4bd57UYuu2SyT
        Dij1WNMvwsIRA1ySbdEwQSXwB
X-Received: by 2002:a1c:9914:: with SMTP id b20mr7993420wme.15.1595415574373;
        Wed, 22 Jul 2020 03:59:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9QZoRxSWvVHYtlSvEF7S2m18o1nfqujK/Ho3Q48PC8wDk+ZICYWfCoWyUKVT38ewRFkGEVA==
X-Received: by 2002:a1c:9914:: with SMTP id b20mr7993399wme.15.1595415574103;
        Wed, 22 Jul 2020 03:59:34 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id 65sm48376335wre.6.2020.07.22.03.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:59:33 -0700 (PDT)
Date:   Wed, 22 Jul 2020 06:59:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Julia Suvorova <jusual@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] x86/PCI: Use MMCONFIG by default for KVM guests
Message-ID: <20200722052600-mutt-send-email-mst@kernel.org>
References: <20200722001513.298315-1-jusual@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722001513.298315-1-jusual@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 02:15:13AM +0200, Julia Suvorova wrote:
> Scanning for PCI devices at boot takes a long time for KVM guests. It
> can be reduced if KVM will handle all configuration space accesses for
> non-existent devices without going to userspace [1]. But for this to
> work, all accesses must go through MMCONFIG.
> This change allows to use pci_mmcfg as raw_pci_ops for 64-bit KVM
> guests making MMCONFIG the default access method.
> 
> [1] https://lkml.org/lkml/2020/5/14/936
> 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>

Thanks for the patch!
Some comments:


I guess the point is that on KVM, MMIO accesses of mmcfg are
faster than two accesses needed for classic access - is that right?
Worth mentioning in the commit log.

> ---
>  arch/x86/pci/direct.c      | 5 +++++
>  arch/x86/pci/mmconfig_64.c | 3 +++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/x86/pci/direct.c b/arch/x86/pci/direct.c
> index a51074c55982..8ff6b65d8f48 100644
> --- a/arch/x86/pci/direct.c
> +++ b/arch/x86/pci/direct.c
> @@ -6,6 +6,7 @@
>  #include <linux/pci.h>
>  #include <linux/init.h>
>  #include <linux/dmi.h>
> +#include <linux/kvm_para.h>
>  #include <asm/pci_x86.h>
>  
>  /*
> @@ -264,6 +265,10 @@ void __init pci_direct_init(int type)
>  {
>  	if (type == 0)
>  		return;
> +
> +	if (raw_pci_ext_ops && kvm_para_available())
> +		return;
> +
>  	printk(KERN_INFO "PCI: Using configuration type %d for base access\n",
>  		 type);
>  	if (type == 1) {
> diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
> index 0c7b6e66c644..9eb772821766 100644
> --- a/arch/x86/pci/mmconfig_64.c
> +++ b/arch/x86/pci/mmconfig_64.c
> @@ -10,6 +10,7 @@
>  #include <linux/init.h>
>  #include <linux/acpi.h>
>  #include <linux/bitmap.h>
> +#include <linux/kvm_para.h>
>  #include <linux/rcupdate.h>
>  #include <asm/e820/api.h>
>  #include <asm/pci_x86.h>
> @@ -122,6 +123,8 @@ int __init pci_mmcfg_arch_init(void)
>  		}
>  
>  	raw_pci_ext_ops = &pci_mmcfg;
> +	if (kvm_para_available())
> +		raw_pci_ops = &pci_mmcfg;
>  
>  	return 1;
>  }

The issue with anything like this is that it breaks if we ever do
some config accesses that affect mmconfig, e.g. to move it, or if
disabling or sizing BARs on some device (e.g. the PCI bridge)
also disables MMCFG.

I guess the explanation for why this works with QEMU is basically
that at least on QEMU right now disabling memory on the root
device does not disable MMCFG, and linux does not bother
tweaking MMCFG range set up by the bios.

Some suggestions:

1.  It's worth mentioning all this in the commit log.

2.  How do we know the above will always be correct?
    Something like checking the ID of the root might be a good idea.
    And given we know the ID, we can also make sure we don't
    disable MMCFG. Does this make sense?

3. Another idea: how about preferring pcbios on kvm instead? That can do
   what's appropriate for the platform ...

> -- 
> 2.25.4

