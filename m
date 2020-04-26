Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F44C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 07:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B29520700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 07:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="GZzz2Aol";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hWBEp3lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgDZHvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 03:51:47 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54215 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgDZHvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 03:51:46 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 429335C0283;
        Sun, 26 Apr 2020 03:51:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 26 Apr 2020 03:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=d
        laYtzBhqCOJ3VoDX6DtQUz5VK905cLHtYPCSoXmEOk=; b=GZzz2AolPYeHVBkaP
        PBTFKP2TzrAOrbcnUAFbT9qxQylD6OfDuoAIUkRc7bEYyoMcqKjX1qB8x1/2zsNb
        LpcRpaDnw6gBXcUd+Ah5BllMzH5g6/avJGBYu32hT1EvSmFupKlXGo5vgGZPUKS1
        jROniLIsbcpViUSFouFtbHZVfH7+X3njN7/1fFm4fP4YRrJE+knNpg3WHtpjafja
        Qk0y7UmqDXiJAwx+nFkBBZw8FlehxGYDuF/TYJGjSqCCrS4qgeAuo3PVboeDiuUc
        zWhOQOT1hK1Dd8PWQ5LwnWPC7QeMiIou0Mf2ibrvmrS/HkOaHprc6E5f/7oei6Fy
        o8ZfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=dlaYtzBhqCOJ3VoDX6DtQUz5VK905cLHtYPCSoXmE
        Ok=; b=hWBEp3lhIQx+fbVSBne/RSgvH/Ek5XM5M3Pi70xrGtRz4lk1mK0HjuKAD
        X3uIE/EWAcxe1OxOC9MzhJoeuJVXhbWNkKJ4Yki/19GrWF3DolYHIR5pjSdf0qlg
        Co9TNk8130taQjztTXaLQVGMQskHcNpahemFjKzn7ZIrhw/vZdvZjGihDFT6mksQ
        ogDUqM0+899RZ92TsqKBo0omyBsSAt9qBL8++9TFmGFX+eO4AbbNP+cQluXFjv0o
        cbcE9eHDdOzTdoA28938zYnZMAOVHtFVTh6roirtun2NLxVbfT34Ah8a+vtodsr/
        FWhGiq8PYzOOhKPZ0D0I29WQ96/gg==
X-ME-Sender: <xms:kD2lXlv9ZlPKQXnQZuN8D7b25sIaTLzV2sJ--kqDFohlcGYAqK0XwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrheeigdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtugfgjgesthekre
    dttddtudenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necukfhppeekfedrkeeirdekledruddtjeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:kD2lXr2Y3dokQyR-cLceLjD7fXVFORljio9SbPVMLBh9wGJsoyXHZg>
    <xmx:kD2lXkzLsdAyWx1sbG_VBc7dW4ewERWOfaNZEk1dJkRjvHlSPMYwmA>
    <xmx:kD2lXv5ZNIwc6anuGI9rPpGKjhHQ8jNZVaUxKnP4CEDXzl2KuRgyIA>
    <xmx:kT2lXrZR91TbZBGx2a0ycQL0nMGiGLVJ4fQTZvGylbOQPLwv-sdILA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 78B9B3065E19;
        Sun, 26 Apr 2020 03:51:44 -0400 (EDT)
Date:   Sun, 26 Apr 2020 09:51:41 +0200
From:   Greg KH <greg@kroah.com>
To:     Akira Shimahara <akira215corp@gmail.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Changes in w1_therm.c and adding w1_therm.h
Message-ID: <20200426075141.GB2100063@kroah.com>
References: <20200423144116.GA7319@kroah.com>
 <20200425153141.247055-1-akira215corp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200425153141.247055-1-akira215corp@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 05:31:41PM +0200, Akira Shimahara wrote:
> From: Akira SHIMAHARA <akira215corp@gmail.com>
> 
> Patch for enhacement of w1_therm module. Added features :
>  - Bulk read : send one command for all the slaves
>  		on the bus to trigger temperature conversion
>  - Optimized conversion time regarding to device resolution
>  - Dedicated sysfs entry for powering read,
>  		resolution set/get, eeprom save/restore
>  - Alarms settings and reading
>  - Code optimization to mitigate bus traffic
>  		(devices information are stored to avoid
> 		interrogating each device every-time)
> 
> Following sysfs entry are added :
>  - temperature (RO) : return the temperature in 1/1000°
>  - ext_power (RO) : return the power status of the device
>  - resolution (RW) : get or set the device resolution (supported devices)
>  - eeprom (WO) :trigger a save or restore to/from device EEPROM
>  - alarms (RW) : read or write TH and TL in the device RAM
>  - therm_bulk_read (RW) : Attribute at master level to trigger
>  		bulk read and to survey the progress of devices conversions
>  - w1_slave has been kept for compatibility
> 
> Main motivation was to improve temperature reading speed, which depend
> on resolution settings of devices. The module store the powwer status and
> the resolution of each device so that during reading operation, no
> transaction is required on the bus, which improve speed.
> The hardware status is checked as soon as a new device is detected, 
> when a user change occurred, or when the corresponding sys file is 
> accessed by user.
> 
> The bulk read allow to trigger convserion of all devices on the bus at
> the same time. It will apply a strong pull up on the line if at least
> one device required it. The duration of the pull up is the max time
> required by a device on the line.
> 
> Please let me know any feedback you have on this patch.
> 
> Thanks ahead,
> 
> Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
> ---
> Changes in v2:
>  - Adding documentation in Documentatin/ABI/testing/sysfs-driver-w1_therm
>  - Updating existing documentation in Documentation/w1/slaves/w1_therm.rst
> 
>  drivers/w1/slaves/w1_therm.c | 1406 ++++++++++++++++++++++++++--------
>  drivers/w1/slaves/w1_therm.h |  386 ++++++++++
>  2 files changed, 1470 insertions(+), 322 deletions(-)
>  create mode 100644 drivers/w1/slaves/w1_therm.h

No documentation files are added here :(

