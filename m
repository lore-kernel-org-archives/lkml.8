Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F12DC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0B62176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgBSIRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:17:05 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60918 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgBSIRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:17:04 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1EB82292F60;
        Wed, 19 Feb 2020 08:17:02 +0000 (GMT)
Date:   Wed, 19 Feb 2020 09:16:58 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>
Subject: Re: [PATCH v3 0/5] Introduce i3c device userspace interface
Message-ID: <20200219091658.7506e7bd@collabora.com>
In-Reply-To: <CH2PR12MB421604E9272413A6C456AB16AE100@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
        <CH2PR12MB421604E9272413A6C456AB16AE100@CH2PR12MB4216.namprd12.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 00:39:31 +0000
Vitor Soares <Vitor.Soares@synopsys.com> wrote:

> Hi Boris,
> 
> From: Vitor Soares <vitor.soares@synopsys.com>
> Date: Wed, Feb 19, 2020 at 00:20:38
> 
> > For today there is no way to use i3c devices from user space and
> > the introduction of such API will help developers during the i3c device
> > or i3c host controllers development.
> > 
> > The i3cdev module is highly based on i2c-dev and yet I tried to address
> > the concerns raised in [1].
> > 
> > NOTES:
> > - The i3cdev dynamically request an unused major number.
> > 
> > - The i3c devices are dynamically exposed/removed from dev/ folder based
> >   on if they have a device driver bound to it.
> > 
> > - For now, the module exposes i3c devices without device driver on
> >   dev/bus/i3c/<bus>-<pid>
> > 
> > - As in the i2c subsystem, here it is exposed the i3c_priv_xfer to
> >   userspace. I tried to use a dedicated structure as in spidev but I don't
> >   see any obvious advantage.
> > 
> > - Since the i3c API only exposes i3c_priv_xfer to devices, for now, the
> >   module just makes use of one ioctl(). This can change in the future with
> >   the introduction hdr commands or by the need of exposing some CCC
> >   commands to the device API (private contract between master-slave).
> >   Regarding the i3c device info, some information is already available
> >   through sysfs. We can add more device attributes to expose more
> >   information or add a dedicated ioctl() request for that purpose or both.
> > 
> > - Similar to i2c, I have also created a tool that you can find in [2]
> >   for testing purposes. If you have some time available I would appreciate
> >   your feedback about it as well.
> > 
> > [1] https://lkml.org/lkml/2018/11/15/853
> > [2] https://github.com/vitor-soares-snps/i3c-tools.git
> > 
> > Changes in v3:
> >   Use the xfer_lock to prevent device detach during ioctl call
> >   Expose i3cdev under /dev/bus/i3c/ folder like usb does
> >   Change NOTIFY_BOUND to NOTIFY_BIND, this allows the device detach occur
> >   before driver->probe call
> >   Avoid use of IS_ERR_OR_NULL
> >   Use u64_to_user_ptr instead of (void __user *)(uintptr_t) cast
> >   Allocate k_xfer and data_ptrs at once and eliminate double allocation
> >   check
> >   Pass i3cdev to dev->driver_data
> >   Make all minors available
> >   Add API documentation
> > 
> > Changes in v2:
> >   Use IDR api for minor numbering
> >   Modify ioctl struct
> >   Fix SPDX license
> > 
> > Vitor Soares (5):
> >   i3c: master: export i3c_masterdev_type
> >   i3c: master: export i3c_bus_type symbol
> >   i3c: master: add i3c_for_each_dev helper
> >   i3c: add i3cdev module to expose i3c dev in /dev
> >   userspace-api: add i3cdev documentation
> > 
> >  Documentation/userspace-api/i3c/i3cdev.rst | 116 ++++++++
> >  drivers/i3c/Kconfig                        |  15 +
> >  drivers/i3c/Makefile                       |   1 +
> >  drivers/i3c/i3cdev.c                       | 429 +++++++++++++++++++++++++++++
> >  drivers/i3c/internals.h                    |   2 +
> >  drivers/i3c/master.c                       |  16 +-
> >  include/uapi/linux/i3c/i3cdev.h            |  38 +++
> >  7 files changed, 616 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/userspace-api/i3c/i3cdev.rst
> >  create mode 100644 drivers/i3c/i3cdev.c
> >  create mode 100644 include/uapi/linux/i3c/i3cdev.h
> > 
> > -- 
> > 2.7.4  
> 
> I want to make you know that none of your previous comments was ignored 
> and  I would like to start the discussion from this point.

Sure, np. I'll probably wait for a v4 exploring the option I proposed
then.
