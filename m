Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483EAC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA264207DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599645356;
	bh=oW9sGTfpiej5ovWQSbJStjKHYBiux00aeHx6wsMQ0k8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QV72P2CXlD5aRJXMX1vjczwFZz4PN+CganIK/+HAiW8JMW2xdWAQO4CDCxyCLku0p
	 tSGDMLdFXBZYzkHvUKn4zjZY9b3VYR0r8y2b6N527izCCTmE7EMuRi3MAArai3MfWu
	 x/k0x4dVxLuGiOuQ+xd5cMVm51mcGKuvSK1NZ0T4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgIIJzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:55:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgIIJzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:55:53 -0400
Received: from coco.lan (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AFBF20758;
        Wed,  9 Sep 2020 09:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599645352;
        bh=oW9sGTfpiej5ovWQSbJStjKHYBiux00aeHx6wsMQ0k8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CRyBsf4e7x/l6cL6zwOPaCDDv20LXbVWqAR7TqLN717Cppst6Iwg6O2pOhfqec24t
         ymRVdAUnU4sSuIA22fZm/Lnz+Sy2W63kyOiQs238KNx/cXwbVhk6QcY9gV4j2ZTVti
         cHV1CN03zvICh5TVS6HdP1HcV6rhkiwK2+uc/oCE=
Date:   Wed, 9 Sep 2020 11:55:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Yu Chen <chenyu56@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/11] misc: hisi_hikey_usb: Driver to support
 onboard USB gpio hub on Hikey960
Message-ID: <20200909115547.1678cd88@coco.lan>
In-Reply-To: <20200909104442.20f63e9b@coco.lan>
References: <cover.1599493845.git.mchehab+huawei@kernel.org>
        <d53de8ab89c23e4be6d2a4fd24b10bcd76dad97d.1599493845.git.mchehab+huawei@kernel.org>
        <20200909083555.GA579996@kroah.com>
        <20200909104442.20f63e9b@coco.lan>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 9 Sep 2020 10:44:42 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Wed, 9 Sep 2020 10:35:55 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> 
> > On Mon, Sep 07, 2020 at 05:59:32PM +0200, Mauro Carvalho Chehab wrote:  
> > > From: Yu Chen <chenyu56@huawei.com>
> > > 
> > > The HiKey960 has a fairly complex USB configuration due to it
> > > needing to support a USB-C port for host/device mode and multiple
> > > USB-A ports in host mode, all using a single USB controller.
> > > 
> > > See schematics here:
> > >   https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf
> > > 
> > > This driver acts as a usb-role-switch intermediary, intercepting
> > > the role switch notifications from the tcpm code, and passing
> > > them on to the dwc3 core.
> > > 
> > > In doing so, it also controls the onboard hub and power gpios in
> > > order to properly route the data lines between the USB-C port
> > > and the onboard hub to the USB-A ports.
> > > 
> > > Signed-off-by: Yu Chen <chenyu56@huawei.com>
> > > [jstultz: Major rework to make the driver a usb-role-switch
> > >           intermediary]
> > > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  MAINTAINERS                   |   7 ++
> > >  drivers/misc/Kconfig          |   9 ++
> > >  drivers/misc/Makefile         |   1 +
> > >  drivers/misc/hisi_hikey_usb.c | 205 ++++++++++++++++++++++++++++++++++
> > >  4 files changed, 222 insertions(+)
> > >  create mode 100644 drivers/misc/hisi_hikey_usb.c    
> > 
> > Can this, and the next patch, go into my char-misc tree independent of
> > the other patches in this series?   
> 
> Yes, they can go via char-misc tree. The drivers are independent.
> 

Forgot to ask: should I re-send the patches on a separate series?

Thanks,
Mauro
