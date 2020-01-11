Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4051AC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 20:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E5D20866
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 20:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578772920;
	bh=HhPDLLL17aVBcq2CTWlrH10b+8vgm49G9JMbYET2lFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WG/ie/EeyZoj+L1j9L8bxp/inbRk8DHXX8BmqwC2ok09eueCL4F00PSCsMQEFPoaU
	 l5aWPODwOtFqedOFHI/xOlBg7bLg0A1cfs/nL0n8Q/if8bmWUyzRDnHBqmU2i03QoL
	 OexsgsALNLulsVKS2pw33Ss7go/MNH/J1rN6skCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbgAKUB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 15:01:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:55762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731003AbgAKUB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 15:01:58 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95E482082E;
        Sat, 11 Jan 2020 20:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578772917;
        bh=HhPDLLL17aVBcq2CTWlrH10b+8vgm49G9JMbYET2lFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FOYJSJFj+K/oMzKqDmSGXkXeIpuo9sB4qFxR2ePfRaENgzjXVkSMkNIf0km7XjgHz
         2OYWiiUFGIZEraIOKnR0lgCxgfoC0JqGQqQvGhd5SBskmaNYeFDa3DhDL3cdt3Pvt+
         eW6yTlKbEkKWAn77iYSHKXXnSYmZb8H3EnOSQYN0=
Date:   Sat, 11 Jan 2020 20:31:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Felipe Balbi <balbi@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v4 1/1] usb: gadget: add raw-gadget interface
Message-ID: <20200111193156.GC435222@kroah.com>
References: <cover.1576697098.git.andreyknvl@google.com>
 <6cd46f8512dc12e20667c2b02d487591868cb20f.1576697098.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cd46f8512dc12e20667c2b02d487591868cb20f.1576697098.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 08:26:57PM +0100, Andrey Konovalov wrote:
> USB Raw Gadget is a kernel module that provides a userspace interface for
> the USB Gadget subsystem. Essentially it allows to emulate USB devices
> from userspace. Enabled with CONFIG_USB_RAW_GADGET. Raw Gadget is
> currently a strictly debugging feature and shouldn't be used in
> production.
> 
> Raw Gadget is similar to GadgetFS, but provides a more low-level and
> direct access to the USB Gadget layer for the userspace. The key
> differences are:
> 
> 1. Every USB request is passed to the userspace to get a response, while
>    GadgetFS responds to some USB requests internally based on the provided
>    descriptors. However note, that the UDC driver might respond to some
>    requests on its own and never forward them to the Gadget layer.
> 
> 2. GadgetFS performs some sanity checks on the provided USB descriptors,
>    while Raw Gadget allows you to provide arbitrary data as responses to
>    USB requests.
> 
> 3. Raw Gadget provides a way to select a UDC device/driver to bind to,
>    while GadgetFS currently binds to the first available UDC.
> 
> 4. Raw Gadget uses predictable endpoint names (handles) across different
>    UDCs (as long as UDCs have enough endpoints of each required transfer
>    type).
> 
> 5. Raw Gadget has ioctl-based interface instead of a filesystem-based one.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

This looks good to me, with the one minor problem below that you can fix
with a follow-on patch.  This should probably go through Felipe's tree
though, so I'll wait for him to review the gadget side and then queue it
up in his tree:


> +/* The type of event fetched with the USB_RAW_IOCTL_EVENT_FETCH ioctl. */
> +enum usb_raw_event_type {
> +	USB_RAW_EVENT_INVALID,
> +
> +	/* This event is queued when the driver has bound to a UDC. */
> +	USB_RAW_EVENT_CONNECT,
> +
> +	/* This event is queued when a new control request arrived to ep0. */
> +	USB_RAW_EVENT_CONTROL,
> +
> +	/* The list might grow in the future. */
> +};

You have to manually specify the enum values in the .h file for all
entries in order to assure that both userspace and the kernel will be in
sync with the same values.  I think that's documented in the "how to
write an ioctl interface" document that is somewhere in
Documentation/...

thanks,

greg k-h
