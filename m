Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14B0C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28B420659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8CJLgxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgBFRoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:44:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45349 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727479AbgBFRoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581011045;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=ydCceGnzTfUmJjvCuJdeATRoWtOCLJXWXwDniRNU+sQ=;
        b=J8CJLgxUxVWZ1riuyzrW0vrGuYfI32hT65/BNGHRoBeEe5XTYo0U3YtfwTrn01FnrlbvN3
        D3OvnHbfO0iaq8dEFxD17JtwCbkbzlsd4cz+y7e5Fz2cR1p+leyzYGFAioFN6pKN/4V26F
        oxMFJTihgK8QPHOm8N6XQwLwPzT28+k=
Received: from mail-yw1-f72.google.com (mail-yw1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-kogArqMJMoKS8IKCi3v_7Q-1; Thu, 06 Feb 2020 12:44:01 -0500
X-MC-Unique: kogArqMJMoKS8IKCi3v_7Q-1
Received: by mail-yw1-f72.google.com with SMTP id 13so7900944yww.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 09:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ydCceGnzTfUmJjvCuJdeATRoWtOCLJXWXwDniRNU+sQ=;
        b=Xc4UVZqBB11VOFatogDNa0eeLpbtF6MRjwqQlXmOpfNVlWb2HTBQvDkbPUVoRoDuE5
         pkYHrDJT9+W/WZGm0TUdaPB7dzD4gqkwSSESfbRuABYv697JwcXXXqlZgGBkrU/9+Z13
         Rg1yrEpOZEpgDLdRfXrX0TJRs/f3O6QQZIAWZA2lIxYvsJWJcQAnedFcuWWXaIywiyYA
         LTpAD/4Edy6he85q5S/nTnLVoWn3OHVhMSpB/jkxf5ZVq0Y7Ta1sGsszakV6OgOt1IzT
         5T8nqfFlt2a55G2LEs5wqN6VC32dLWSg6SHzKjTXs+8PVE/sQL9uhE0RJm2ooirz/3gU
         gsGQ==
X-Gm-Message-State: APjAAAUHcPtjx3DnRfhjT2vSYSZ/VYisHTaliVqVsC7LUbjQLK4v4U6C
        lZerzyWUPV2yBspfmLbReb9l0tSXjXCWqOCoh8BwT/eYcc25aF50Sh9JlAJ6mlveoIwLG5fZ8uA
        fXZVLwusxta5LIRv9yDVceE1h
X-Received: by 2002:a81:f208:: with SMTP id i8mr4116038ywm.101.1581011041080;
        Thu, 06 Feb 2020 09:44:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1+Vm90JnKO8MBT7JzL1aoYT2iFLHgit4g8rrBU5dYWq0Eo9Rl1DNvzk1y1eVKb3h7deZUOw==
X-Received: by 2002:a81:f208:: with SMTP id i8mr4116021ywm.101.1581011040755;
        Thu, 06 Feb 2020 09:44:00 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id d13sm46272ywj.91.2020.02.06.09.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 09:44:00 -0800 (PST)
Date:   Thu, 6 Feb 2020 10:43:58 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: warning from domain_get_iommu
Message-ID: <20200206174358.shzhieijle5wdshr@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
References: <20200204200714.u4ezhi6vhqhxog6e@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200204200714.u4ezhi6vhqhxog6e@cantor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Feb 04 20, Jerry Snitselaar wrote:
>I'm working on getting a system to reproduce this, and verify it also occurs
>with 5.5, but I have a report of a case where the kdump kernel gives
>warnings like the following on a hp dl360 gen9:
>
>[    2.830589] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>[    2.832615] ehci-pci: EHCI PCI platform driver
>[    2.834190] ehci-pci 0000:00:1a.0: EHCI Host Controller
>[    2.835974] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
>[    2.838276] ehci-pci 0000:00:1a.0: debug port 2
>[    2.839700] WARNING: CPU: 0 PID: 1 at drivers/iommu/intel-iommu.c:598 domain_get_iommu+0x55/0x60
>[    2.840671] Modules linked in:
>[    2.840671] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.0-170.el8.kdump2.x86_64 #1
>[    2.840671] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 07/21/2019
>[    2.840671] RIP: 0010:domain_get_iommu+0x55/0x60
>[    2.840671] Code: c2 01 eb 0b 48 83 c0 01 8b 34 87 85 f6 75 0b 48 63 c8 48 39 c2 75 ed 31 c0 c3 48 c1 e1 03 48 8b 05 70 f3 91 01 48 8b 04 08 c3 <0f> 0b 31 c0 c3 31 c9 eb eb 66 90 0f 1f 44 00 00 41 55 40 0f b6 f6
>[    2.840671] RSP: 0018:ffffc900000dfab8 EFLAGS: 00010202
>[    2.840671] RAX: ffff88ec7f1c8000 RBX: 0000006c7c867000 RCX: 0000000000000000
>[    2.840671] RDX: 00000000fffffff0 RSI: 0000000000000000 RDI: ffff88ec7f1c8000
>[    2.840671] RBP: ffff88ec6f7000b0 R08: ffff88ec7f19d000 R09: ffff88ec7cbfcd00
>[    2.840671] R10: 0000000000000095 R11: ffffc900000df928 R12: 0000000000000000
>[    2.840671] R13: ffff88ec7f1c8000 R14: 0000000000001000 R15: 00000000ffffffff
>[    2.840671] FS:  0000000000000000(0000) GS:ffff88ec7f600000(0000) knlGS:0000000000000000
>[    2.840671] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[    2.840671] CR2: 00007ff3e1713000 CR3: 0000006c7de0a004 CR4: 00000000001606b0
>[    2.840671] Call Trace:
>[    2.840671]  __intel_map_single+0x62/0x140
>[    2.840671]  intel_alloc_coherent+0xa6/0x130
>[    2.840671]  dma_pool_alloc+0xd8/0x1e0
>[    2.840671]  e_qh_alloc+0x55/0x130
>[    2.840671]  ehci_setup+0x284/0x7b0
>[    2.840671]  ehci_pci_setup+0xa3/0x530
>[    2.840671]  usb_add_hcd+0x2b6/0x800
>[    2.840671]  usb_hcd_pci_probe+0x375/0x460
>[    2.840671]  local_pci_probe+0x41/0x90
>[    2.840671]  pci_device_probe+0x105/0x1b0
>[    2.840671]  driver_probe_device+0x12d/0x460
>[    2.840671]  device_driver_attach+0x50/0x60
>[    2.840671]  __driver_attach+0x61/0x130
>[    2.840671]  ? device_driver_attach+0x60/0x60
>[    2.840671]  bus_for_each_dev+0x77/0xc0
>[    2.840671]  ? klist_add_tail+0x3b/0x70
>[    2.840671]  bus_add_driver+0x14d/0x1e0
>[    2.840671]  ? ehci_hcd_init+0xaa/0xaa
>[    2.840671]  ? do_early_param+0x91/0x91
>[    2.840671]  driver_register+0x6b/0xb0
>[    2.840671]  ? ehci_hcd_init+0xaa/0xaa
>[    2.840671]  do_one_initcall+0x46/0x1c3
>[    2.840671]  ? do_early_param+0x91/0x91
>[    2.840671]  kernel_init_freeable+0x1af/0x258
>[    2.840671]  ? rest_init+0xaa/0xaa
>[    2.840671]  kernel_init+0xa/0xf9
>[    2.840671]  ret_from_fork+0x35/0x40
>[    2.840671] ---[ end trace e87b0d9a1c8135c4 ]---
>[    3.010848] ehci-pci 0000:00:1a.0: Using iommu dma mapping
>[    3.012551] ehci-pci 0000:00:1a.0: 32bit DMA uses non-identity mapping
>[    3.018537] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
>[    3.021188] ehci-pci 0000:00:1a.0: irq 18, io mem 0x93002000
>[    3.029006] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
>[    3.030918] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.18
>[    3.033491] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>[    3.035900] usb usb1: Product: EHCI Host Controller
>[    3.037423] usb usb1: Manufacturer: Linux 4.18.0-170.el8.kdump2.x86_64 ehci_hcd
>[    3.039691] usb usb1: SerialNumber: 0000:00:1a.0
>
>It looks like the device finishes initializing once it figures out it
>needs dma mapping instead of the default
>passthrough. intel_alloc_coherent calls iommu_need_mapping, before it
>calls __intel_map_single, so I'm not sure why it is tripping over the
>WARN_ON in domain_get_iommu.
>
>one thing I noticed while looking at this is that domain_get_iommu can
>return NULL. So should there be something like the following in
>__intel_map_single after the domain_get_iommu call?
>
>if (!iommu)
>   goto error;
>
>It is possible to deref the null pointer later otherwise.
>
>Regards,
>Jerry

I reproduced the warning with a 5.5 kernel on an Intel NUC5i5MYBE.

