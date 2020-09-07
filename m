Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E04C2D0A8
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D48421556
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599469211;
	bh=JF85xGjWoRX+WrNUAU5CsZa6td8+W6Un9M2aQK9o5p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nI8XpAQ2chwSHy9NqcgY49GmiguJ577zHOQl1eUNh9VyGtUUcM6UkwmQNcpIQ3DaP
	 7kbMArxHgZ8RFKIlQ04A5qkoAxWXXQQACIvoHWHTQqnsoT2FjlFLv8jM4YcUauEPH+
	 VUviS7Ig998Jb4ogakYiID3W154TOzjumJayO+Tk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgIGJAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:00:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbgIGI75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:59:57 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09ADE208C7;
        Mon,  7 Sep 2020 08:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599469196;
        bh=JF85xGjWoRX+WrNUAU5CsZa6td8+W6Un9M2aQK9o5p8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNO0RWR6L4n9l5OKvvfGF/K6aGrMS8ZiHwtUcdg3WA7Vnwd7Sa3SDKzXc+nHVCak4
         s4gN1UzXClbv3Z8NmKrbl5p0PKAhugA+y1SAmmH7eiMMiVP2NPsziVMK/OoRq8l8Cx
         p2A9G/OLFFqBMZXBl0bu0nlL3eWak462QMakLZe0=
Date:   Mon, 7 Sep 2020 11:00:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andra Paraschiv <andraprs@amazon.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Anthony Liguori <aliguori@amazon.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        David Duncan <davdunc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Alexander Graf <graf@amazon.de>, Karen Noel <knoel@redhat.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        Matt Wilson <msw@amazon.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Balbir Singh <sblbir@amazon.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stewart Smith <trawets@amazon.com>,
        Uwe Dannowski <uwed@amazon.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm <kvm@vger.kernel.org>,
        ne-devel-upstream <ne-devel-upstream@amazon.com>
Subject: Re: [PATCH v8 15/18] nitro_enclaves: Add Makefile for the Nitro
 Enclaves driver
Message-ID: <20200907090011.GC1101646@kroah.com>
References: <20200904173718.64857-1-andraprs@amazon.com>
 <20200904173718.64857-16-andraprs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904173718.64857-16-andraprs@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 08:37:15PM +0300, Andra Paraschiv wrote:
> Signed-off-by: Andra Paraschiv <andraprs@amazon.com>
> Reviewed-by: Alexander Graf <graf@amazon.com>
> ---
> Changelog
> 
> v7 -> v8
> 
> * No changes.
> 
> v6 -> v7
> 
> * No changes.
> 
> v5 -> v6
> 
> * No changes.
> 
> v4 -> v5
> 
> * No changes.
> 
> v3 -> v4
> 
> * No changes.
> 
> v2 -> v3
> 
> * Remove the GPL additional wording as SPDX-License-Identifier is
>   already in place.
> 
> v1 -> v2
> 
> * Update path to Makefile to match the drivers/virt/nitro_enclaves
>   directory.
> ---
>  drivers/virt/Makefile                |  2 ++
>  drivers/virt/nitro_enclaves/Makefile | 11 +++++++++++
>  2 files changed, 13 insertions(+)
>  create mode 100644 drivers/virt/nitro_enclaves/Makefile
> 
> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> index fd331247c27a..f28425ce4b39 100644
> --- a/drivers/virt/Makefile
> +++ b/drivers/virt/Makefile
> @@ -5,3 +5,5 @@
>  
>  obj-$(CONFIG_FSL_HV_MANAGER)	+= fsl_hypervisor.o
>  obj-y				+= vboxguest/
> +
> +obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
> diff --git a/drivers/virt/nitro_enclaves/Makefile b/drivers/virt/nitro_enclaves/Makefile
> new file mode 100644
> index 000000000000..e9f4fcd1591e
> --- /dev/null
> +++ b/drivers/virt/nitro_enclaves/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> +
> +# Enclave lifetime management support for Nitro Enclaves (NE).
> +
> +obj-$(CONFIG_NITRO_ENCLAVES) += nitro_enclaves.o
> +
> +nitro_enclaves-y := ne_pci_dev.o ne_misc_dev.o
> +
> +ccflags-y += -Wall

That flag is _really_ risky over time, are you _SURE_ that all new
versions of clang and gcc will never produce any warnings?  People work
to fix up build warnings quite quickly for new compilers, you shouldn't
prevent the code from being built at all just for that, right?

thanks,

greg k-h
