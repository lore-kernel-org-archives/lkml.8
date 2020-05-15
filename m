Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D65C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF5E20787
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kocurkovo.cz header.i=@kocurkovo.cz header.b="Vi/1DPnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgEOOzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:55:42 -0400
Received: from mail.kocurkovo.cz ([185.8.236.170]:59162 "EHLO
        mail.kocurkovo.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgEOOzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:55:41 -0400
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id 78F5818CB; Fri, 15 May 2020 16:55:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz 78F5818CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1589554538;
        bh=pDkXalda7bV0b2weLUQ604K7SfSCx5HTnM8p3DPSRY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vi/1DPnb/yS/pv4FXIMYNIM2Ezna9PHr5bxhd4jfRcaJWgVlZrQJzB6CI4QlnoD37
         F58jBUqi5S/i/pz3Wv23A6qXHRRh/ZmQUzBRkWeaJcVj5YktChvTCeapq1nicbdF3b
         WhGIRwKN1eFN3jzQZytEKmlqjjiuInJMYw+bFd98=
Date:   Fri, 15 May 2020 16:55:38 +0200
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] staging: vt6655: vt6656: change order of makefile
 variable definitions
Message-ID: <20200515145538.GA28808@new.kocurkovo.cz>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <1589397351-24655-1-git-send-email-mdujava@kocurkovo.cz>
 <1589397351-24655-3-git-send-email-mdujava@kocurkovo.cz>
 <20200515134859.GA2112248@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200515134859.GA2112248@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 03:48:59PM +0200, Greg Kroah-Hartman wrote:
>I still fail to understand the need for this patch at all.  It doesn't
>clean anything up, nor change anything.  There is no rule that this has
>to be in one order or the other, and in fact, I like the order that the
>files currently have :)
>
>thanks,
>
>greg k-h

Most of makefiles has pattern that `obj-${}` is before `driver-y` lines.
If this is not something that was intentional, then this patch is not
adding any value indeed.

Few examples that give me that impression:

./gnss/Makefile-# SPDX-License-Identifier: GPL-2.0
./gnss/Makefile-#
./gnss/Makefile-# Makefile for the GNSS subsystem.
./gnss/Makefile-#
./gnss/Makefile-
./gnss/Makefile:obj-$(CONFIG_GNSS)          += gnss.o
./gnss/Makefile-gnss-y := core.o
./gnss/Makefile-
./gnss/Makefile:obj-$(CONFIG_GNSS_SERIAL)       += gnss-serial.o
./gnss/Makefile-gnss-serial-y := serial.o
--snip end--

./.../go7007/Makefile-# SPDX-License-Identifier: GPL-2.0
./.../go7007/Makefile:obj-$(CONFIG_VIDEO_GO7007) += go7007.o
./.../go7007/Makefile:obj-$(CONFIG_VIDEO_GO7007_USB) += go7007-usb.o
./.../go7007/Makefile:obj-$(CONFIG_VIDEO_GO7007_LOADER) += go7007-loader.o
./.../go7007/Makefile:obj-$(CONFIG_VIDEO_GO7007_USB_S2250_BOARD) += s2250.o
./.../go7007/Makefile-
./.../go7007/Makefile-go7007-y := go7007-v4l2.o go7007-driver.o go7007-i2c.
./.../go7007/Makefile-        snd-go7007.o
./.../go7007/Makefile-
./.../go7007/Makefile-s2250-y := s2250-board.o
--snip end--

Thanks,
Matej
