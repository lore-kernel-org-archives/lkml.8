Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E952EC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EA020679
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581955429;
	bh=zQUBgUJ2ADvgmEghqQUPA0mRqlNGYYqucg4WuZ5HL1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rt8SgOo+vcXdv1q7enQ87mMLsr5/Tap1HamjSoz4d9tedLS7ls6nLFGmNOw/8MD4s
	 pCJCAkEJkyVA72Lqd7Rlffs3VaERVrJmNm3C409o7W7aYlRwiLuV4ccT2/OiUGUF9f
	 F8mMGN78IsuS8eHiH2BM8shjzA8WJEqKwa6FRCHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgBQQDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:03:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbgBQQDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:03:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C249F20679;
        Mon, 17 Feb 2020 16:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581955427;
        bh=zQUBgUJ2ADvgmEghqQUPA0mRqlNGYYqucg4WuZ5HL1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E0U1OKN6El32rOayHDQuAh+bO0lJfJkm/Z6RM/Om2xqb6sr2OtupgIkXQZ3bI0UUj
         mfTWoKJs+vBIF2QOfOCesioO7Ke/yq0ZnvgFr5oTqtkSr+e2oFXNsKUtcKWcMs0/vg
         nLzh4lZGDKV/MK9gIZanVyz+nSS0wWIEzO9/Pf4M=
Date:   Mon, 17 Feb 2020 17:03:45 +0100
From:   gregkh <gregkh@linuxfoundation.org>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [RFC v2 0/4] Introduce i3c device userspace interface
Message-ID: <20200217160345.GA1501229@kroah.com>
References: <cover.1580299067.git.vitor.soares@synopsys.com>
 <20200217155141.08e87b3f@collabora.com>
 <CAK8P3a0jAbevb6mjy7Q=C-TFGn7uHRvshHNEO8XrDPRvRoAiTA@mail.gmail.com>
 <20200217163622.6c78fa3f@collabora.com>
 <CH2PR12MB42166ED8E84503B53340F80DAE160@CH2PR12MB4216.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR12MB42166ED8E84503B53340F80DAE160@CH2PR12MB4216.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 03:55:08PM +0000, Vitor Soares wrote:
> Hi,
> 
> From: Boris Brezillon <boris.brezillon@collabora.com>
> Date: Mon, Feb 17, 2020 at 15:36:22
> 
> > On Mon, 17 Feb 2020 16:06:45 +0100
> > Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> > > On Mon, Feb 17, 2020 at 3:51 PM Boris Brezillon
> > > <boris.brezillon@collabora.com> wrote:
> > > > Sorry for taking so long to reply, and thanks for working on that topic.
> > > >
> > > > On Wed, 29 Jan 2020 13:17:31 +0100
> > > > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> > > >  
> > > > > For today there is no way to use i3c devices from user space and
> > > > > the introduction of such API will help developers during the i3c device
> > > > > or i3c host controllers development.
> > > > >
> > > > > The i3cdev module is highly based on i2c-dev and yet I tried to address
> > > > > the concerns raised in [1].
> > > > >
> > > > > NOTES:
> > > > > - The i3cdev dynamically request an unused major number.
> > > > >
> > > > > - The i3c devices are dynamically exposed/removed from dev/ folder based
> > > > >   on if they have a device driver bound to it.  
> > > >
> > > > May I ask why you need to automatically bind devices to the i3cdev
> > > > driver when they don't have a driver matching the device id
> > > > loaded/compiled-in? If we get the i3c subsystem to generate proper
> > > > uevents we should be able to load the i3cdev module and bind the device
> > > > to this driver using a udev rule.  
> > > 
> > > I think that would require manual configuration to ensure that the correct
> > > set of devices get bound to either the userspace driver or an in-kernel
> > > driver.
> > 
> > Hm, isn't that what udev is supposed to do anyway? Remember that
> > I3C devices expose a manufacturer and part-id (which are similar to the
> > USB vendor and product ids), so deciding when an I3C device should be
> > bound to the i3cdev driver should be fairly easy, and that's a
> > per-device decision anyway.
> > 
> > > The method from the current patch series is more complicated,
> > > but it means that any device can be accessed by the user space driver
> > > as long as it's not already owned by a kernel driver.
> > 
> > Well, I'm more worried about the extra churn this auto-binding logic
> > might create for the common 'on-demand driver loading' use case. At
> > first, there's no driver matching a specific device, but userspace
> > might load one based on the uevents it receives. With the current
> > approach, that means we'd first have to unbind the device before
> > loading the driver. AFAICT, no other subsystem does that.
> 
> I'm about to finish v3 (today or tomorrow) and I think I fixed all 
> concerns rise during v2. I would like you to see that version before any 
> change.

Why are there so many "RFC" series here?  I treat "RFC" as "I don't
really like this patch but I'm throwing it out there for others to look
at if they care".  No RFC should ever go on beyond a v1 as obviously you
think this is good enough by now, right?

Also, I almost never review RFC patches, we have enough "real" patches
to review as it is :)

thanks,

greg k-h
