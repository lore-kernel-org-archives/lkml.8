Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BE0C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA6C20718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgBQPg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:36:26 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41696 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgBQPg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:36:26 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DB9A2293D7D;
        Mon, 17 Feb 2020 15:36:24 +0000 (GMT)
Date:   Mon, 17 Feb 2020 16:36:22 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vitor Soares <Vitor.Soares@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-i3c@lists.infradead.org,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [RFC v2 0/4] Introduce i3c device userspace interface
Message-ID: <20200217163622.6c78fa3f@collabora.com>
In-Reply-To: <CAK8P3a0jAbevb6mjy7Q=C-TFGn7uHRvshHNEO8XrDPRvRoAiTA@mail.gmail.com>
References: <cover.1580299067.git.vitor.soares@synopsys.com>
        <20200217155141.08e87b3f@collabora.com>
        <CAK8P3a0jAbevb6mjy7Q=C-TFGn7uHRvshHNEO8XrDPRvRoAiTA@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 16:06:45 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Mon, Feb 17, 2020 at 3:51 PM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> > Sorry for taking so long to reply, and thanks for working on that topic.
> >
> > On Wed, 29 Jan 2020 13:17:31 +0100
> > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> >  
> > > For today there is no way to use i3c devices from user space and
> > > the introduction of such API will help developers during the i3c device
> > > or i3c host controllers development.
> > >
> > > The i3cdev module is highly based on i2c-dev and yet I tried to address
> > > the concerns raised in [1].
> > >
> > > NOTES:
> > > - The i3cdev dynamically request an unused major number.
> > >
> > > - The i3c devices are dynamically exposed/removed from dev/ folder based
> > >   on if they have a device driver bound to it.  
> >
> > May I ask why you need to automatically bind devices to the i3cdev
> > driver when they don't have a driver matching the device id
> > loaded/compiled-in? If we get the i3c subsystem to generate proper
> > uevents we should be able to load the i3cdev module and bind the device
> > to this driver using a udev rule.  
> 
> I think that would require manual configuration to ensure that the correct
> set of devices get bound to either the userspace driver or an in-kernel
> driver.

Hm, isn't that what udev is supposed to do anyway? Remember that
I3C devices expose a manufacturer and part-id (which are similar to the
USB vendor and product ids), so deciding when an I3C device should be
bound to the i3cdev driver should be fairly easy, and that's a
per-device decision anyway.

> The method from the current patch series is more complicated,
> but it means that any device can be accessed by the user space driver
> as long as it's not already owned by a kernel driver.

Well, I'm more worried about the extra churn this auto-binding logic
might create for the common 'on-demand driver loading' use case. At
first, there's no driver matching a specific device, but userspace
might load one based on the uevents it receives. With the current
approach, that means we'd first have to unbind the device before
loading the driver. AFAICT, no other subsystem does that.
