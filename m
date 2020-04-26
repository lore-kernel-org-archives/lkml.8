Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B732C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 17:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B3C2071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 17:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="iPOY9kIB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LV9t/QMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgDZRJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 13:09:07 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59561 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726143AbgDZRJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 13:09:06 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id CF9805C0112;
        Sun, 26 Apr 2020 13:09:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 26 Apr 2020 13:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=U
        z0IZa8nk56SgTTPFUxSsQ9v7SwozUUUONCAK2vrfSE=; b=iPOY9kIBpwBL4AATZ
        EkNZZZSyvTqLTe3+OEqQKam/DCvqtsFA4iZyhDBJ6q40imtZ+uU0q3nTZydyZzS0
        S0ZpZcCF0cJn+YkE4Kdp6RkDRYwgMatbUjrEmD59SN87lk2N1yBEa1SO/5q+Opad
        czeBUh9jVFETvh85CJrQeC1BWfc/ZM78GO5vOSl/tIRG8gTkHDGndwSIKJ0p2Jds
        zw2YuvWi2LgmtyvEhAxgdTeJlsyfTKWYYy6Bfp+pRHIreYYvVGvATRfHDCL22ep7
        mA1jxUoEIWQyQ3LsV4t+gQzsUIJob2endgVl4wcsY4Soqplf0MTMC1QhDjULGTwN
        TMPUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Uz0IZa8nk56SgTTPFUxSsQ9v7SwozUUUONCAK2vrf
        SE=; b=LV9t/QMd4orRsGtxzekAEltsZNVIydrPCTc68d/sC8vFe4KGrbjDHlg7m
        LLfJXLMPi4MZxRXl498g/JhErn5o+DRFmgYVps0jBibJu8ozN8FAVvDr6ugjDiZa
        yFT8T5fNPgNjX7Ihl/jho/DslK7N/CkSs+ybao+X9JBRAqLraW061xsNpY/Wmhik
        9ciykw7Q4XiEx0h099240SLDrqWjy7s7kYz7WVMD1n9DVG4tFC1xxlO1vEgbqK7V
        iR3g9QmTghsabjOZLRoFl7TsRq3NSHDZmRS2ZX4gxAoV0gky79pe1BNPrDXGXpob
        L94CRWdDg3pRoTgpLtdJ88WcuuuXw==
X-ME-Sender: <xms:McClXm0eSURzYnXkT8u9aQBOuYgKo1CBEYhzFwrJy1-zm_FYMkh0jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrheejgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggugfgjsehtke
    ertddttddunecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucfkphepkeefrdekiedrkeelrddutdejnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:McClXh9UVyJRXms-vqnKrmAXgyX4OvO62HfyTdLDr2xtN2kUw62XWw>
    <xmx:McClXt1boz8olS_x0CjjXPmPOmo1p8TnqA7sIkyVDARcz3Gx0PrpQA>
    <xmx:McClXh5fJ2cTDhkwlGk9rZtWHDj5HI34P2vhgHSLClGKvRsFjayVkQ>
    <xmx:McClXkw8ZsSZn6_PvQ4or2woypnWgaOAXO-cdRd5QEP0ieaJuijgrw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2EE1D3280059;
        Sun, 26 Apr 2020 13:09:05 -0400 (EDT)
Date:   Sun, 26 Apr 2020 19:09:01 +0200
From:   Greg KH <greg@kroah.com>
To:     Akira shimahara <akira215corp@gmail.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Changes in w1_therm.c and adding w1_therm.h
Message-ID: <20200426170901.GA2139089@kroah.com>
References: <20200423144116.GA7319@kroah.com>
 <20200425153141.247055-1-akira215corp@gmail.com>
 <20200426075141.GB2100063@kroah.com>
 <1b002fb8caf1755b89882fd7a3bbac1565959a6d.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b002fb8caf1755b89882fd7a3bbac1565959a6d.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 02:36:52PM +0200, Akira shimahara wrote:
> Le dimanche 26 avril 2020 à 09:51 +0200, Greg KH a écrit :
> > On Sat, Apr 25, 2020 at 05:31:41PM +0200, Akira Shimahara wrote:
> > > From: Akira SHIMAHARA <akira215corp@gmail.com>
> > > 
> > > Patch for enhacement of w1_therm module. Added features :
> > >  - Bulk read : send one command for all the slaves
> > >  		on the bus to trigger temperature conversion
> > >  - Optimized conversion time regarding to device resolution
> > >  - Dedicated sysfs entry for powering read,
> > >  		resolution set/get, eeprom save/restore
> > >  - Alarms settings and reading
> > >  - Code optimization to mitigate bus traffic
> > >  		(devices information are stored to avoid
> > > 		interrogating each device every-time)
> > > 
> > > Following sysfs entry are added :
> > >  - temperature (RO) : return the temperature in 1/1000°
> > >  - ext_power (RO) : return the power status of the device
> > >  - resolution (RW) : get or set the device resolution (supported
> > > devices)
> > >  - eeprom (WO) :trigger a save or restore to/from device EEPROM
> > >  - alarms (RW) : read or write TH and TL in the device RAM
> > >  - therm_bulk_read (RW) : Attribute at master level to trigger
> > >  		bulk read and to survey the progress of devices
> > > conversions
> > >  - w1_slave has been kept for compatibility
> > > 
> > > Main motivation was to improve temperature reading speed, which
> > > depend
> > > on resolution settings of devices. The module store the powwer
> > > status and
> > > the resolution of each device so that during reading operation, no
> > > transaction is required on the bus, which improve speed.
> > > The hardware status is checked as soon as a new device is
> > > detected, 
> > > when a user change occurred, or when the corresponding sys file is 
> > > accessed by user.
> > > 
> > > The bulk read allow to trigger convserion of all devices on the bus
> > > at
> > > the same time. It will apply a strong pull up on the line if at
> > > least
> > > one device required it. The duration of the pull up is the max time
> > > required by a device on the line.
> > > 
> > > Please let me know any feedback you have on this patch.
> > > 
> > > Thanks ahead,
> > > 
> > > Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
> > > ---
> > > Changes in v2:
> > >  - Adding documentation in Documentatin/ABI/testing/sysfs-driver-
> > > w1_therm
> > >  - Updating existing documentation in
> > > Documentation/w1/slaves/w1_therm.rst
> > > 
> > >  drivers/w1/slaves/w1_therm.c | 1406 ++++++++++++++++++++++++++--
> > > ------
> > >  drivers/w1/slaves/w1_therm.h |  386 ++++++++++
> > >  2 files changed, 1470 insertions(+), 322 deletions(-)
> > >  create mode 100644 drivers/w1/slaves/w1_therm.h
> > 
> > No documentation files are added here :(
> > 
> 
> It's in the PATCH 2/2 included in the previous mail. You want me to
> merge in one commit ?. I thought it was easier for you to keep a track
> of the v1.

What previous mail?  I don't see a patch 2/2 here, did you not cc: me?

thanks,

greg kh
