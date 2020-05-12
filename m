Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67BBC2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17B3206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3tVDish"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbgELUAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 16:00:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54940 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728275AbgELUAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 16:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589313632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LvbGY8ZvCj9G+3gYhr3VTgORuP6wjyLO9gJ7K3lpE20=;
        b=J3tVDishT7mHfWbSBE9/vhiD/k3FM0ADSBnRMXOdhEODn4pZT5WHS2hFXIZVqOniFaJUxs
        hqjcqwJwI3cYU7807DNZP8r3ityZKaX6nz2E0nE4UaCYYDlThliVzmp7mZS7IgGG2KRWyP
        lype4IMqtUW0fw/6LPN5nSIZt7jBtok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-kRTDR0SrOPmN0VHAUC4PiA-1; Tue, 12 May 2020 16:00:30 -0400
X-MC-Unique: kRTDR0SrOPmN0VHAUC4PiA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EB97835B41;
        Tue, 12 May 2020 20:00:28 +0000 (UTC)
Received: from [10.10.65.2] (ovpn-65-2.rdu2.redhat.com [10.10.65.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 780425C1BB;
        Tue, 12 May 2020 20:00:27 +0000 (UTC)
Subject: Re: Failure to shutdown/reboot with intel_iommu=on
To:     Joerg Roedel <jroedel@suse.de>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        tglx@linutronix.de, x86@kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
References: <20200506144558.GA4019@taurus.defre.kleine-koenig.org>
 <20200508150734.GP8135@suse.de>
 <ff5eb4e2-89a3-57a5-c6d6-42bf743e5d16@redhat.com>
 <20200512133429.GZ8135@suse.de>
From:   Lenny Szubowicz <lszubowi@redhat.com>
Message-ID: <26b328dc-2161-fdaa-f533-bf0027c13efc@redhat.com>
Date:   Tue, 12 May 2020 16:00:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200512133429.GZ8135@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/20 9:34 AM, Joerg Roedel wrote:
> On Mon, May 11, 2020 at 09:43:11AM -0400, Lenny Szubowicz wrote:
>> I suspect that you have TPM 2.x functionality enabled in the BIOS/firmware.
>>
>> Unless you are actually using the TPM, try setting it to TPM 1.2 mode.
>> I've seen an incompatiblity on other Lenovo laptops between using the
>> IOMMU, TPM 2.x implementation in firmware, and shutdown/suspend.
> 
> Interesting, has this been debugged further into the TPM code?
> 
> 
> 	Joerg
> 

I believe the problem is in the Lenovo firmware and not in the kernel.

There are essentially two problems:
  1. TPM 2.0 doesn't work when the IOMMU is enabled
  2. Suspend/shutdown hangs when problem 1 is encountered on boot

Lenovo's firmware implementation of TPM 2.0 functionality on some of their
laptops uses DMA. When you ask the kernel to enable the IOMMU, this DMA
access is correctly blocked by the IOMMU hardware. If you look at your
dmesg log from when you have TPM 2.0 and the IOMMU enabled, there are
TPM timeout messages that indicate the inability to initialize and use
the TPM capability.

The hang on shutdown or S3 suspend appears to be in firmware, i.e.
after the kernel has transferred control back to the firmware.
It makes no difference if the kernel actively shuts down the IOMMU
before transferring control to the firmware on a suspend or shutdown.
The hang still occurs.

My guess is that the firmware wants to do some TPM related processing
on shutdown and suspend and can't handle the TPM state that exists
due to the startup failure. But that's just a guess. I don't know
what the firmware is actually doing.

Some Lenovo laptops provide an ACPI DMAR RMRR that identifies the memory
range that the kernel should open up for permissable DMA access
for this purpose. Unfortunately, the PCI device that performs these
DMA operations is hidden from the kernel by the BIOS. Given that the
associated PCI device is hidden, the Linux kernel does not act upon
the associated DMAR RMRR.

                        -Lenny.


