Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0F7C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6793206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgC0Qhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:37:39 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41721 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727792AbgC0Qhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:37:39 -0400
Received: (qmail 17155 invoked by uid 500); 27 Mar 2020 12:37:38 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Mar 2020 12:37:38 -0400
Date:   Fri, 27 Mar 2020 12:37:38 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     vladimir.stankovic@displaylink.com
cc:     gregkh@linuxfoundation.org, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <mausb-host-devel@displaylink.com>
Subject: Re: [PATCH v4 4/8] usb: mausb_host: Implement initial hub handlers
In-Reply-To: <20200327152614.26833-5-vladimir.stankovic@displaylink.com>
Message-ID: <Pine.LNX.4.44L0.2003271236040.14887-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 vladimir.stankovic@displaylink.com wrote:

> Implemented handlers for subset of HCD events.
> 
> Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
> ---
> +/*
> + * For usb 2.0 logitech camera called multiple times, once during
> + * enumeration of device and later after mausb_reset_device.
> + */
> +static int mausb_address_device(struct usb_hcd *hcd, struct usb_device *dev)

> +/*
> + * For usb 2.0 logitech camera called multiple times, once during enumeration
> + * of device and later after mausb_reset_device. In latter case it is
> + * required to address the device again in order for ep0 to work properly.
> + */
> +static int mausb_enable_device(struct usb_hcd *hcd, struct usb_device *dev)

> +/*
> + * For usb 2.0 logitech camera called multiple times,
> + * followed by either mausb_enable_device or mausb_address_device.
> + * Resets device to non-addressed state.
> + */
> +static int mausb_reset_device(struct usb_hcd *hcd, struct usb_device *dev)

Why on earth do you have all these comments about Logitech cameras?  A 
host controller driver shouldn't care about the type of devices it gets 
connected to.

Alan Stern

