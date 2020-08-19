Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CA6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 05:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23EAC207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 05:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597816448;
	bh=7JTMi4mGGs7FnfIVJimozrVukuiOHNixS4gVormp8S0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZKguvldrKCfdALzXUSdFkm7B4cAJAINoT9lKiXCvKRKWOraJIcX5x9pmyVZZcqioW
	 zuIK78GBg0b1lqlxBArNnqDrjzlKrA/q8AALiwmRE3Hc4G/T8Pi9gyvPuZyBvCU4Ir
	 aGfK4Rmh4JqKlDkHUsHxHgkGrnZW1YHRqqpxXN+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHSFyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 01:54:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:32830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgHSFyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 01:54:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC49320772;
        Wed, 19 Aug 2020 05:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597816445;
        bh=7JTMi4mGGs7FnfIVJimozrVukuiOHNixS4gVormp8S0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rebZCrheWVgpDfkuB4bbsq5b0AVbjOJPei3t/JXJysuW0fPH6TyRyinMKSzjvoKxs
         6FQgQ2+RCNX8dDy4E5wVD2dmK62Tr1Pc7091TUg6JdSS40rxEMRZWACahVwugWaUsp
         TYzdG9eySvZTzkUHF1KHShMeC7ewNGNRYU3+U2hQ=
Date:   Wed, 19 Aug 2020 07:54:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vaishnav M A <vaishnav@beagleboard.org>
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, johan@kernel.org, elder@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Ivan =?utf-8?B?UmFqa292acSH?= <rajkovic@mikroe.com>,
        chrisfriedt@gmail.com, zoran.stojsavljevic@gmail.com
Subject: Re: [RFC PATCH v2 0/3] mikroBUS driver for add-on boards
Message-ID: <20200819055427.GB853200@kroah.com>
References: <20200818124815.11029-1-vaishnav@beagleboard.org>
 <20200818152426.GA713928@kroah.com>
 <CALudOK4jgtJiB8sn4CsDm2c=va=d8M7ocoa55f=NV9sTaBHJJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALudOK4jgtJiB8sn4CsDm2c=va=d8M7ocoa55f=NV9sTaBHJJg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 03:22:48AM +0530, Vaishnav M A wrote:
> On Tue, Aug 18, 2020 at 8:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Aug 18, 2020 at 06:18:12PM +0530, Vaishnav M A wrote:
> > > Hi,
> > >
> > > This Patch series is an update to the mikroBUS driver
> > > RFC v1 Patch : https://lkml.org/lkml/2020/7/24/518 .
> >
> > Please use lore.kernel.org for links, we have no idea if lkml.org will
> > be working tomorrow or not :)
> >
> Hi Greg,
> 
> Thanks, will use lore.kernel.org for the links, attaching the corresponding
> link to the v1 RFC patch thread for reference:
> https://lore.kernel.org/lkml/20200724120637.GA427284@vaishnav-VirtualBox/
> 
> > > The mikrobus driver is updated to add mikrobus ports from device-tree
> > > overlays, the debug interfaces for adding mikrobus ports through sysFS
> > > is removed, and the driver considers the extended usage of mikrobus
> > > port pins from their standard purposes.
> >
> > I don't know what "properties" and "device" mean with regards to things
> > here, any chance you can provide a patch to the greybus spec itself that
> > adds this information so we can better understand the reasoning here to
> > see if the kernel changes match up with the goals?
> >
> > thanks,
> >
> > greg k-h
> Sure, I will add a patch to the greybus-spec to describe the new descriptors,
> the property and device descriptors are introduced to add information
> about the SPI/I2C/UART chip/sensor which is required by the corresponding
> device drivers, With these descriptors, it will be possible to describe devices
> on I2C, SPI, UART, etc. behind a greybus device so as to bind existing kernel
> drivers to them, This is not what is currently being done within the mikroBUS
> driver, now it tries to instantiate devices on actual I2C, SPI, UART from
> describing manifests, but the ultimate goal is to describe the devices on
> I2C/SPI/UART behind a greybus device, thus enabling to attach existing
> kernel drivers to devices present in add-on boards attached to mikroBUS
> ports added via greybus.
> 
> Shall I submit a pull request to https://github.com/projectara/greybus-spec
> for the specs, is there a different official upstream to greybus-spec?

That's a good place, but for now, you can submit it as part of your
patch series as well, so we can all see it and review it easier.

thanks,

greg k-h
