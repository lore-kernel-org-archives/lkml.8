Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CE3C2D0ED
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F54920658
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgC0QZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:25:35 -0400
Received: from netrider.rowland.org ([192.131.102.5]:43553 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727705AbgC0QZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:25:35 -0400
Received: (qmail 16088 invoked by uid 500); 27 Mar 2020 12:25:34 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Mar 2020 12:25:34 -0400
Date:   Fri, 27 Mar 2020 12:25:34 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     vladimir.stankovic@displaylink.com
cc:     gregkh@linuxfoundation.org, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <mausb-host-devel@displaylink.com>
Subject: Re: [PATCH v4 1/8] usb: Add MA-USB Host kernel module
In-Reply-To: <20200327152614.26833-2-vladimir.stankovic@displaylink.com>
Message-ID: <Pine.LNX.4.44L0.2003271213350.14887-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 vladimir.stankovic@displaylink.com wrote:

> Added utility macros, kernel device creation and cleanup, functions for
> handling log formatting and a placeholder module for MA-USB Host device
> driver.
> 
> Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>

> index 235ab38ed478..12aac44196d7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10226,6 +10226,13 @@ W:	https://linuxtv.org
>  S:	Maintained
>  F:	drivers/media/radio/radio-maxiradio*
>  
> +MA USB HOST DRIVER

It would be an excellent idea to change this title to:

MA (MEDIA-AGNOSTIC) USB HOST DRIVER

Otherwise to me it looks like the Massachusetts USB HOST DRIVER, since
MA is the 2-letter abbreviation for the state where I live.  A
two-letter acronym is just too generic; you mustn't expect people to
understand it.

> +M:	Vladimir Stankovic <vladimir.stankovic@displaylink.com>
> +L:	mausb-host-devel@displaylink.com
> +W:	https://www.displaylink.com
> +S:	Maintained
> +F:	drivers/usb/mausb_host/*
> +

> --- /dev/null
> +++ b/drivers/usb/mausb_host/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Kernel configuration file for MA-USB Host driver.
> +#
> +# Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
> +#
> +
> +config HOST_MAUSB
> +	tristate "MA-USB Host Driver"
> +	depends on USB=y
> +	default n

No need for this line; n is always the default setting unless you
specify otherwise.

> +	help
> +		This is a MA-USB Host driver which enables host communication
> +		via MA-USB protocol stack.

And I insist that you insert "Media Agnostic" in here somewhere, either 
in the "tristate" line or in the help.  Without this, people trying to 
configure their kernels will have no idea whether or not they should 
enable the setting because they won't know what MA-USB is.

It also wouldn't hurt to mention in the help text that if the driver is
built as a module, the name of the module will be "mausb_host".

Alan Stern

