Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4F0C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E44062076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597165588;
	bh=gHbIwWEGQh8BBQnvGLHlvb5XXf47uZWtZJ9RyXgxn1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OB/T8Kf23hWI+PMd9QPnM/Mk+spTVJTHOaerraD5QhAzMPZVd5s1iASorHehWdVmz
	 MnvP0mYwSc8eAmMDMxjMggvhfl03u0J+VN3LyhcQnXmkikRIzImizF6ZFt27vKF/Aa
	 1mwod8w/9/l/xl1xcK3UfIK3jL+OB48U4j2v9aM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgHKRGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729121AbgHKRGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:06:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5225B2076B;
        Tue, 11 Aug 2020 17:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597165577;
        bh=gHbIwWEGQh8BBQnvGLHlvb5XXf47uZWtZJ9RyXgxn1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q+TtcDIqMBsKn92O1SBEGXNtPDp3KGZ5NdvmZ6C9zPphh+LRV4WaZEYUjiNnjW/pT
         cHY4te50ZEmPIRSzQgPTzXa0AIJfDw01LBHtzFH247bD2d5RJgTp+owoduqeb/ySPk
         hmsAWXgFHHtOzDtUOs9Tn2EUOu/cmrmLNmUGjFHk=
Date:   Tue, 11 Aug 2020 19:06:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gage Eads <gage.eads@intel.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: Re: [PATCH v2 02/19] dlb2: initialize PF device
Message-ID: <20200811170627.GB765993@kroah.com>
References: <20200811162732.1369-1-gage.eads@intel.com>
 <20200811162732.1369-3-gage.eads@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811162732.1369-3-gage.eads@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 11:27:15AM -0500, Gage Eads wrote:
> The driver detects the device type (PF/VF) at probe time, and assigns the
> corresponding 'ops' callbacks from that. These callbacks include mapping
> and unmapping the PCI BAR space, creating/destroying the device, and
> adding/deleting a char device.
> 
> Signed-off-by: Gage Eads <gage.eads@intel.com>
> Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/misc/dlb2/Makefile        |   5 +-
>  drivers/misc/dlb2/dlb2_hw_types.h |  28 +++++++++
>  drivers/misc/dlb2/dlb2_main.c     |  49 ++++++++++++++-
>  drivers/misc/dlb2/dlb2_main.h     |  30 +++++++++
>  drivers/misc/dlb2/dlb2_pf_ops.c   | 126 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 235 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/misc/dlb2/dlb2_pf_ops.c
> 
> diff --git a/drivers/misc/dlb2/Makefile b/drivers/misc/dlb2/Makefile
> index 90ae953d2a8f..95e67e5bd8ff 100644
> --- a/drivers/misc/dlb2/Makefile
> +++ b/drivers/misc/dlb2/Makefile
> @@ -4,5 +4,6 @@
>  
>  obj-$(CONFIG_INTEL_DLB2) := dlb2.o
>  
> -dlb2-objs :=  \
> -  dlb2_main.o \
> +dlb2-objs :=    \
> +  dlb2_main.o   \
> +  dlb2_pf_ops.o \
> diff --git a/drivers/misc/dlb2/dlb2_hw_types.h b/drivers/misc/dlb2/dlb2_hw_types.h
> index a0f908c603eb..10b26356535f 100644
> --- a/drivers/misc/dlb2/dlb2_hw_types.h
> +++ b/drivers/misc/dlb2/dlb2_hw_types.h
> @@ -5,6 +5,25 @@
>  #ifndef __DLB2_HW_TYPES_H
>  #define __DLB2_HW_TYPES_H
>  
> +#include <linux/io.h>
> +
> +#define DLB2_PCI_REG_READ(addr)        ioread32(addr)
> +#define DLB2_PCI_REG_WRITE(reg, value) iowrite32(value, reg)

Why create a macro that is larger than the native call, this saves
nothing except make the reviewer wonder what in the world is happening.

Just use the real call.

