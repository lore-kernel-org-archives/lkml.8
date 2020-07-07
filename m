Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455CBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1523020702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594117299;
	bh=+cBelIs0ehSsds8X4dHmvK2864Wy8QgaOL5fQnupcLk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=pYncniMbl5d8cqM3i9Z/OIY8GZ6hsdHuhZkxTLhSMSx/GXcl03li2Y10ChDKLD0La
	 qdr6WxPH3GTq3rc9V18QvvVGw6X5o+aRJcIjkm/Hd3WOQySKbcrvu7kgF8954DQ0D6
	 3VKUhauYj3PA8dDjNTnm+OY2vEXH8cE3v5YaXT58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgGGKVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgGGKUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:20:50 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E657206F6;
        Tue,  7 Jul 2020 10:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594117249;
        bh=+cBelIs0ehSsds8X4dHmvK2864Wy8QgaOL5fQnupcLk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ZAvb6I9vDb3w6KWUww8p1xAQaAhA2POMmlykCDVLQumMM5h/pWVPlOzvEn2QDf+KP
         QOx8pEn3NzKUIwSz7/iLevs8Cg2BUcXxvR9e7pzUoo4/UUNnsEHyOtOTM1oKfXlXAV
         +XdZlgf6w/1mnxL7QlX+4Yax43oPMPgkMNFx/GwU=
Date:   Tue, 7 Jul 2020 12:20:46 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
cc:     Marius Zachmann <mail@mariuszachmann.de>,
        Jean Delvare <jdelvare@suse.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v7] hwmon: add Corsair Commander Pro driver
In-Reply-To: <20200630021642.GA155878@roeck-us.net>
Message-ID: <nycvar.YFH.7.76.2007071220210.15962@cbobk.fhfr.pm>
References: <20200626055936.4441-1-mail@mariuszachmann.de> <20200630021642.GA155878@roeck-us.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020, Guenter Roeck wrote:

> On Fri, Jun 26, 2020 at 07:59:36AM +0200, Marius Zachmann wrote:
> > This is v7 of a driver for the Corsair Commander Pro.
> > It provides sysfs attributes for:
> > - Reading fan speed
> > - Reading temp sensors
> > - Reading voltage values
> > - Writing pwm and reading last written pwm
> > - Reading fan and temp connection status
> > 
> > It is an usb driver, so it needs to be ignored by usbhid.
> > The Corsair Commander Pro is a fan controller and provides
> > no means for user interaction.
> > The two device numbers are there, because there is a slightly
> > different version of the same device. (Only difference
> > seem to be in some presets.)
> > 
> > This is based on the staging/hwmon tree.
> > 
> > Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
> 
> For my reference:
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Waiting for Ack from HID maintainer.

Acked-by: Jiri Kosina <jkosina@suse.cz>

for the drivers/hid/hid-quirks.c hunk. Thanks,

-- 
Jiri Kosina
SUSE Labs

