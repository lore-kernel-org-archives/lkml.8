Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001BBC35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB64120836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgBXLWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:22:11 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54092 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXLWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:22:11 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6730E29047B;
        Mon, 24 Feb 2020 11:22:09 +0000 (GMT)
Date:   Mon, 24 Feb 2020 12:22:06 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH v3 4/5] i3c: add i3cdev module to expose i3c dev in /dev
Message-ID: <20200224122206.10984b3f@collabora.com>
In-Reply-To: <CH2PR12MB42163351853CCC029D28164BAEEC0@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
        <e093ae9da81e7702c188a20d1e8b9d7f8024bfeb.1582069402.git.vitor.soares@synopsys.com>
        <20200221233216.3b2038f8@collabora.com>
        <CH2PR12MB42163351853CCC029D28164BAEEC0@CH2PR12MB4216.namprd12.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 11:04:50 +0000
Vitor Soares <Vitor.Soares@synopsys.com> wrote:

> Hi Boris,
> 
> From: Boris Brezillon <boris.brezillon@collabora.com>
> Date: Fri, Feb 21, 2020 at 22:32:16
> 
> > On Wed, 19 Feb 2020 01:20:42 +0100
> > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> >   
> > > +static int i3cdev_detach(struct device *dev, void *dummy)
> > > +{
> > > +	struct i3cdev_data *i3cdev;
> > > +	struct i3c_device *i3c;
> > > +
> > > +	if (dev->type == &i3c_masterdev_type)
> > > +		return 0;
> > > +
> > > +	i3c = dev_to_i3cdev(dev);
> > > +
> > > +	i3cdev = i3cdev_get_drvdata(i3c);
> > > +	if (!i3cdev)
> > > +		return 0;
> > > +
> > > +	/* Prevent transfers while cdev removal */
> > > +	mutex_lock(&i3cdev->xfer_lock);
> > > +	cdev_del(&i3cdev->cdev);  
> > 
> > When cdev_del() returns there might be opened FDs pointing to your
> > i3cdev [1] ...  
> 
> Yes, I know. I protected the driver part but I missed the 
> file->private_data.

Not sure what you mean by protection, but if you meant locking, then
it's not enough: you need to refcnt the struct if you want to prevent
use-after-free situations.

BTW, I had a closer look at the usbdev implementation, and maybe you
should base yours on usb instead of i2c. They seem to register a cdev at
module init time, and add a dev_t per device at device registration
time. Not sure how they handle the userspace-driver vs kernel-driver
concurrency, but maybe returning EACCES (or EBUSY) instead of
detaching/attaching the i3cdev everytime a device is bound/unbound
would be simpler.

Also, I think Arnd was right, it'd be simpler if i3cdev support was
integrated to the core (still left as a option so it can be disabled,
but with a dedicated i3cdev field in i3c_device instead hijacking the
driver private field).

