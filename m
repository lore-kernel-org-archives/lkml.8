Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943A8C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744BB206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgBQPwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:52:10 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41878 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbgBQPwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:52:10 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1FA3F293C88;
        Mon, 17 Feb 2020 15:52:08 +0000 (GMT)
Date:   Mon, 17 Feb 2020 16:52:04 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [RFC v2 0/4] Introduce i3c device userspace interface
Message-ID: <20200217165204.7f2d2774@collabora.com>
In-Reply-To: <CH2PR12MB4216459E37F9AB1AAF0B2EFDAE160@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <cover.1580299067.git.vitor.soares@synopsys.com>
        <20200217155141.08e87b3f@collabora.com>
        <CH2PR12MB4216459E37F9AB1AAF0B2EFDAE160@CH2PR12MB4216.namprd12.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 15:32:55 +0000
Vitor Soares <Vitor.Soares@synopsys.com> wrote:

> Hi Boris,
> 
> From: Boris Brezillon <boris.brezillon@collabora.com>
> Date: Mon, Feb 17, 2020 at 14:51:41
> 
> > Hello Vitor,
> > 
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
> My idea was to expose every device to user-space by default so we can 
> test them without a driver (more or less the i2c use case) but as we 
> agreed during the i3c subsystem only expose devices that doesn't have 
> device driver.

Those that do not have a driver *yet*. What if i3cdev is compiled-in
and other I3C drivers are enabled as modules? When the device is
discovered at boot time is will be automatically bound to the i3cdev
driver since no matching drivers are available at that point. But
the end user probably expects this device to be attached to the in
kernel driver.

> I considered to have a uevent but to expose the devices by default it 
> would required something generic, what I didn't figure out and tend to 
> follow the i2c-dev module.

Well, I3C and I2C/SPI are quite different in this regard. I2C dev
exposes the whole bus, and SPI devs don't have a standard way to
uniquely identify the device connected on the bus (unless it has a
dedicated compatible for DT-based boards). In that case it might make
sense to auto-bind all orphan devs to the default spidev driver, though
I'm not entirely sure it's really necessary since that's probably a
per-board decision, and having a udev rule matching the bus/CS would
make sense too.

> 
> With this current approach even if a device has a driver we can unbind it 
> through the Sysfs and have access from user space which I found useful 
> for debug.

That's my point. We're making the default 'on-demand driver loading'
use case more complicated to ease the less common 'userspace driver'
use case.
