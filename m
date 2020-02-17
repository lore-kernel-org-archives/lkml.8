Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620DEC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4100120725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgBQRGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:06:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42602 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbgBQRGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:06:23 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6751B293BEA;
        Mon, 17 Feb 2020 17:06:21 +0000 (GMT)
Date:   Mon, 17 Feb 2020 18:06:17 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>
Subject: Re: [RFC v2 0/4] Introduce i3c device userspace interface
Message-ID: <20200217180617.79bc5b1d@collabora.com>
In-Reply-To: <CAK8P3a2O23=Jjmj0xTQC7pePnwHBrcJ1YeRAKp-1hVf1GNmA5w@mail.gmail.com>
References: <cover.1580299067.git.vitor.soares@synopsys.com>
        <20200217155141.08e87b3f@collabora.com>
        <CAK8P3a0jAbevb6mjy7Q=C-TFGn7uHRvshHNEO8XrDPRvRoAiTA@mail.gmail.com>
        <20200217163622.6c78fa3f@collabora.com>
        <CH2PR12MB42166ED8E84503B53340F80DAE160@CH2PR12MB4216.namprd12.prod.outlook.com>
        <20200217172309.26697082@collabora.com>
        <CAK8P3a2O23=Jjmj0xTQC7pePnwHBrcJ1YeRAKp-1hVf1GNmA5w@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 17:31:08 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Mon, Feb 17, 2020 at 5:23 PM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> > On Mon, 17 Feb 2020 15:55:08 +0000 Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> >
> > Okay, I have clearly not read the code carefully enough. I thought you
> > were declaring a new i3c_device_driver and were manually binding all
> > orphan devices to this driver. Looks like the solution is more subtle
> > than that, and i3cdevs are actually subdevices that are automatically
> > created/removed when the I3C device is unbound/bound. That means the
> > 'on-demand driver loading' logic is not impacted by this new layer. I'm
> > still not convinced this is needed (I expect i3cdev to be used mostly
> > for experiment, and in that case, having a udev rule, or manually
> > binding the device to the i3cdev driver shouldn't be a problem).  
> 
> I'm fairly sure it's not needed, other approaches could be used to
> provide user space access, but it's not clear if any other way is
> better either. It also took me a while to figure out what is going on
> when I read the code.
> 
> One thought that I had was that this could be better integrated into
> the core, with user space being there implicitly through sysfs rather
> than a /dev file.

Hm, doing I3C transfers through sysfs sounds a bit odd. sysfs entries
are most of the time exposing human readable/writable stuff (plain text
data, that is).

> 
> > I'm also not sure what happens if the device is still used when
> > i3cdev_detach() is called, can transfers still be done after the device
> > is attached to its in-kernel driver?  
> 
> I think this is still an open issue that I also pointed out. The driver
> binding/unbinding and user space access definitely needs to
> be properly serialized, whichever method is used to implement the
> user access.

Well, going for the spidev approach would solve that and make the
whole implementation more straightforward and less invasive (no
notifier, no need to expose internal device types to this i3cdev
driver, no concurrency issues, ...). We can always revisit this solution
if it proves to be to limited and we feel the need for a
kernel-driven i3cdev auto-binding logic, but I doubt we'll ever be
in that position since udev can handle that for us, and if we start
having actual userspace drivers (which is not the case yet), I expect
distros to add the relevant udev rules to take care of this auto-bind.
