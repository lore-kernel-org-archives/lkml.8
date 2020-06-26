Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664FFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A3020679
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593179031;
	bh=gaVWyq4+IVSLWllMUFqnDbLAUXdRuZKIN4lmZPsTZgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jR5zpERQx9FGqk0O0AUt14ajevHsaCqH6U2+AfHdNRwQOPhHatRwko9jl0D9F5TSe
	 I+G2D1MaIpvpwxMoNrXHYRJPGgMrYtW8kKCOJB9o0xiz5dA5i6iPUuq4HumlYQ21Az
	 khxVwH5sT12nTFrjEH5hiLtSMy4Gh/AcykYq9DjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgFZNnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgFZNnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:43:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA69B20656;
        Fri, 26 Jun 2020 13:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593179029;
        bh=gaVWyq4+IVSLWllMUFqnDbLAUXdRuZKIN4lmZPsTZgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rrLUh2Ym53eHVizZ0IDbQM/gCch3S7adJ8rKLLF1XNvslldix/AH6OmUpjU3Biqts
         6eqg0o4NUrVLKj+DhTI0hl66ajOcfEOlakGPUZGtSf55r9EZgyC6CIGAcco58IzT+e
         0LMTmznNhBeQBKWfrHns88X3u9jYZR+DwjErCBa4=
Date:   Fri, 26 Jun 2020 15:43:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     robh+dt@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org,
        devicetree@vger.kernel.org, dan.carpenter@oracle.com,
        ben.dooks@codethink.co.uk, colin.king@canonical.com, rogerq@ti.com,
        peter.chen@nxp.com, weiyongjun1@huawei.com, jpawar@cadence.com,
        kurahul@cadene.com, sparmar@cadence.com
Subject: Re: [PATCH RFC 2/5] usb:cdns3: Add pci to platform driver wrapper
Message-ID: <20200626134344.GA4030531@kroah.com>
References: <20200626045450.10205-1-pawell@cadence.com>
 <20200626045450.10205-3-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626045450.10205-3-pawell@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 06:54:47AM +0200, Pawel Laszczak wrote:
> Patch adds PCI specific glue driver that creates and registers in-system
> cdns-usbssp platform device.

Ick, no.

Platform devices are ONLY to be used for when you have a real platform
device.  If your device is a PCI device, use that.  Don't try to be cute
and make a platform device when you don't have one please.

> Thanks to that we will be able to use
> the cdns-usbssp platform driver for USBSS-DEV controller
> build on PCI board.

No, fix up that driver to not care about it being a platform device,
make it just accept any type of 'struct device'.

thanks,

greg k-h
