Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A34C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC8C220724
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esvL0VK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgDUVWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:22:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60822 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgDUVWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587504164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j0OOdK3DXtQCBZ/bSdHvigSbjQLSkz9kPwFTn49a0go=;
        b=esvL0VK4p6EZsuZbv1Bs8TwcAmCjOuCtYQarhOZJCs2cTaSLT4Q4qkdD8cYUJ9RJntumNb
        ZcRBoEfZ7VWyY2Hqnu9ZOR9fsRvXRvpMn9Y+dlHM6/m+2R6IIZZIeQWfd1e1Ye3pEXgST+
        O2U+6v+btJed+OO959b5TH7wc6wS4/4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-JhyzH39HN8GtDs7U0kzDig-1; Tue, 21 Apr 2020 17:22:43 -0400
X-MC-Unique: JhyzH39HN8GtDs7U0kzDig-1
Received: by mail-wm1-f69.google.com with SMTP id n127so1965815wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j0OOdK3DXtQCBZ/bSdHvigSbjQLSkz9kPwFTn49a0go=;
        b=A2xNUqEOl/+677THR5gY1CoVctcPP8/Yp4sNngr40MG8cGy12RlBsIwxBBgaSk4INg
         idll3ivvtDzjyyv/0ECZiFEOBRgkY9KQJ0HHUYisrGnF9r1SyeMrk04waod4DIYTkvlc
         135Y7TCvwcOCeFemXbay6swHAyFfQC5J7bI7cit7MId8dMqZ/nHs3xnoIenvzYEFvGau
         Rj3I+b7DzH9Qw9jE81+NpcLciTVxXT5sEvHRLEZbEEGDCfXQMZew4A3pEqbFygCX2oOI
         dbl3DVp54cQ6ZCNzkd8Z0aAphaeOA2xGkbhZ8Xq8ZkEkk4tmBvNwAmhvOUwLUU/KD1bn
         LeYw==
X-Gm-Message-State: AGi0PuatOyDX1bD+8aTJtpXTwofD6CEIuTmVUuxeT1XMovbPMkOBf8l7
        EcRw7ELT6YaqiSIuvA+sy0dyTDZHYtIo0gEBUJB6B96siVwqzhCD5X3kGS8F7X7qaqWOmKCyh6P
        UwndGRTJoig1wlFDbgzhlIL3D
X-Received: by 2002:a5d:640a:: with SMTP id z10mr20415579wru.280.1587504161806;
        Tue, 21 Apr 2020 14:22:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypLa18an1RGVvp0uK77fZIPNzLDq2b9ZzWAAvpEnVucWFgXqg3uFCUbnfzEYCy33am1kmErblA==
X-Received: by 2002:a5d:640a:: with SMTP id z10mr20415539wru.280.1587504161481;
        Tue, 21 Apr 2020 14:22:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446? ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
        by smtp.gmail.com with ESMTPSA id p7sm5559855wrf.31.2020.04.21.14.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 14:22:40 -0700 (PDT)
Subject: Re: [PATCH v1 02/15] nitro_enclaves: Define the PCI device interface
To:     Andra Paraschiv <andraprs@amazon.com>, linux-kernel@vger.kernel.org
Cc:     Anthony Liguori <aliguori@amazon.com>,
        Benjamin Herrenschmidt <benh@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Alexander Graf <graf@amazon.de>,
        Martin Pohlack <mpohlack@amazon.de>,
        Matt Wilson <msw@amazon.com>, Balbir Singh <sblbir@amazon.com>,
        Stewart Smith <trawets@amazon.com>,
        Uwe Dannowski <uwed@amazon.de>, kvm@vger.kernel.org,
        ne-devel-upstream@amazon.com
References: <20200421184150.68011-1-andraprs@amazon.com>
 <20200421184150.68011-3-andraprs@amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bfbb7242-b818-337d-4cff-fc48b7bb1cc0@redhat.com>
Date:   Tue, 21 Apr 2020 23:22:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200421184150.68011-3-andraprs@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/20 20:41, Andra Paraschiv wrote:
> The Nitro Enclaves (NE) driver communicates with a new PCI device, that
> is exposed to a virtual machine (VM) and handles commands meant for
> handling enclaves lifetime e.g. creation, termination, setting memory
> regions. The communication with the PCI device is handled using a MMIO
> space and MSI-X interrupts.
> 
> This device communicates with the hypervisor on the host, where the VM
> that spawned the enclave itself run, e.g. to launch a VM that is used
> for the enclave.
> 
> Define the MMIO space of the PCI device, the commands that are
> provided by this device. Add an internal data structure used as private
> data for the PCI device driver and the functions for the PCI device init
> / uninit and command requests handling.
> 
> Signed-off-by: Alexandru-Catalin Vasile <lexnv@amazon.com>
> Signed-off-by: Alexandru Ciobotaru <alcioa@amazon.com>
> Signed-off-by: Andra Paraschiv <andraprs@amazon.com>
> ---
>  .../virt/amazon/nitro_enclaves/ne_pci_dev.h   | 266 ++++++++++++++++++
>  1 file changed, 266 insertions(+)
>  create mode 100644 drivers/virt/amazon/nitro_enclaves/ne_pci_dev.h

Can this be placed just in drivers/virt/nitro_enclaves, or
drivers/virt/enclave/nitro?  It's not unlikely that this device be
implemented outside EC2 sooner or later, and there's nothing
Amazon-specific as far as I can see from the UAPI.

Paolo

