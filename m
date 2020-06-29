Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FF9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4646E2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466367;
	bh=Uoq248fVFUS7nUmxb0KXFHCYIbklwNYP4+WvgbTtC1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SVc3mGvb1i6KKVYcHk2GPQ4k7f2kvwr/nH/dw5tVsYcH14awf48nRyQ+G9lnox49+
	 HkCpPVxdfZBjT6iYJisfK3njvtfSJ46745EId5V2eKAkxmHS8kmRmyeeZpb9fHoNk4
	 F4Oc9sRNUho6aPA5BQwDLIVdMngs1TIGczyFUFGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgF2Vco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728652AbgF2SlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3880C23C92;
        Mon, 29 Jun 2020 11:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593431020;
        bh=Uoq248fVFUS7nUmxb0KXFHCYIbklwNYP4+WvgbTtC1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XpeHWz9EqU044sGwnG7+DdW/u7FkYkft+eJigTVeZK0S7erx+eQJm3cTif2Jnqubr
         JZNXSHPfFZsaoN1WacMh0LsuISkXsGW8rvwjy/6rlvPQm2EiSCuT1JbKk1RXhlraRj
         fSNWAmxvj/yNBQp9VsB8r5nmHK1PVohkw3clDgP4=
Date:   Mon, 29 Jun 2020 13:43:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        "kurahul@cadene.com" <kurahul@cadene.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: Re: [PATCH RFC 2/5] usb:cdns3: Add pci to platform driver wrapper
Message-ID: <20200629114315.GA121549@kroah.com>
References: <20200626045450.10205-1-pawell@cadence.com>
 <20200626045450.10205-3-pawell@cadence.com>
 <20200626134344.GA4030531@kroah.com>
 <DM6PR07MB5529755E72D87EFDD1867A7BDD6E0@DM6PR07MB5529.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR07MB5529755E72D87EFDD1867A7BDD6E0@DM6PR07MB5529.namprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 11:35:32AM +0000, Pawel Laszczak wrote:
> 
> >
> >On Fri, Jun 26, 2020 at 06:54:47AM +0200, Pawel Laszczak wrote:
> >> Patch adds PCI specific glue driver that creates and registers in-system
> >> cdns-usbssp platform device.
> >
> >Ick, no.
> >
> >Platform devices are ONLY to be used for when you have a real platform
> >device.  If your device is a PCI device, use that.  Don't try to be cute
> >and make a platform device when you don't have one please.
> >
> >> Thanks to that we will be able to use
> >> the cdns-usbssp platform driver for USBSS-DEV controller
> >> build on PCI board.
> >
> >No, fix up that driver to not care about it being a platform device,
> >make it just accept any type of 'struct device'.
> >
> Ok, I will remove it form this driver but probably in a few months I will have to add 
> such support.  

For a real platform device, that's fine, but that is not what you are
doing here.

thanks,

greg k-h
