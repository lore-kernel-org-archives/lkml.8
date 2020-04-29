Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A75AC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 612C22074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588153306;
	bh=AG5TFQjS0TvO7P2NrdT+6GM8hq5daMrhEGzYpdrsVw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IQ05PknHGYKs561d4cJiUxM3SnoDaCrNTUP5xM3qtWxITZZH6okDjnhp2NNP1943A
	 ujGzvEmgqLRn1SVPrrJa343A9Phc3Uu/zp7all02HiYCrma3nm9R+rsbDYsMH4FFn2
	 8g01ooZikh8VkTh2/waz8P8cU5Xzlg/yw82adAJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgD2Jlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2Jlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:41:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00DE62073E;
        Wed, 29 Apr 2020 09:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588153303;
        bh=AG5TFQjS0TvO7P2NrdT+6GM8hq5daMrhEGzYpdrsVw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hm8896I728fS54R8e60Rm+0EU2cD8L9ZwDgyfgFL+9eaCwKaqGavDdau5oK8KOPjV
         c2uOqi6/bwTgKj33Wnfuvgw1PubZmlJvzbH/jYgTIZtTbd49msJ5wyKLH1SQ/q1E+r
         GNcegYa6TkdGV7gtBbMvfahji+toB12Z74Agvm+o=
Date:   Wed, 29 Apr 2020 11:41:41 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Stahl, Manuel" <manuel.stahl@iis-extern.fraunhofer.de>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sojkam1@fel.cvut.cz" <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH v4] Add new uio device for PCI with dynamic memory
 allocation
Message-ID: <20200429094141.GB2080576@kroah.com>
References: <1507296707.2915.14.camel@iis-extern.fraunhofer.de>
 <20200416163830.30623-1-manuel.stahl@iis-extern.fraunhofer.de>
 <20200428135443.GA1437053@kroah.com>
 <eb405ab3782844e379629a655a3dcaf38dd2552d.camel@iis-extern.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb405ab3782844e379629a655a3dcaf38dd2552d.camel@iis-extern.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 07:51:01AM +0000, Stahl, Manuel wrote:
> On Di, 2020-04-28 at 15:54 +0200, gregkh @ linuxfoundation . org wrote:
> > On Thu, Apr 16, 2020 at 06:38:30PM +0200, Manuel Stahl wrote:
> > > 
> > > + *
> > > + * Since the driver does not declare any device ids, you must allocate
> > > + * id and bind the device to the driver yourself.  For example:
> > > + *
> > > + * # echo "8086 10f5" > /sys/bus/pci/drivers/uio_pci_dmem_genirq/new_id
> > > + * # echo -n 0000:00:19.0 > /sys/bus/pci/drivers/e1000e/unbind
> > > + * # echo -n 0000:00:19.0 > /sys/bus/pci/drivers/uio_pci_dmem_genirq/bind
> > > + * # ls -l /sys/bus/pci/devices/0000:00:19.0/driver
> > > + * .../0000:00:19.0/driver -> ../../../bus/pci/drivers/uio_pci_dmem_genirq
> > > + *
> > > + * Or use a modprobe alias:
> > > + * # alias pci:v000010EEd00001000sv*sd*sc*i* uio_pci_dmem_genirq
> > > + *
> > > + * Driver won't bind to devices which do not support the Interrupt Disable Bit
> > > + * in the command register. All devices compliant to PCI 2.3 (circa 2002) and
> > > + * all compliant PCI Express devices should support this bit.
> > > + *
> > > + * The DMA mask bits and sizes of dynamic regions are derived from module
> > > + * parameters.
> > > + *
> > > + * The format for specifying dynamic region sizes in module parameters
> > > + * is as follows:
> > > + *
> > > + * uio_pci_dmem_genirq.dmem_sizes := <uio_dmem_sizes_def>[;<uio_dmem_sizes_def>]
> > > + * <uio_dmem_sizes_def>           := <pci_id>:<size>[,<size>]
> > > + * <pci_id>                       := <vendor>:<device>
> > > + * <size>                         := standard linux memsize
> > > + *
> > > + * Examples:
> > > + *
> > > + * 1) UIO dmem device with 3 dynamic regions:
> > > + * uio_pci_dmem_genirq.dmem_sizes=8086:10f5:4K,16K,4M
> > > + *
> > > + * 2) Two UIO dmem devices with different number of dynamic regions:
> > > + * uio_pci_dmem_genirq.dmem_sizes=8086:10f5:4K,16K,4M;1234:0001:8K
> > 
> > Module parameters are horrid, are you sure there is no other way?
> 
> You're right, seemed to be the simplest solution back when we started developing this driver. I will try to change it to sysfs, so that one can add regions while the module is already loaded.

/me hands you some \n characters...

Anyway, configfs is for configuring stuff, don't make a sysfs file that
you have to somehow "parse" please.

thanks,

greg k-h
