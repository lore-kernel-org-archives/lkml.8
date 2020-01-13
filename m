Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024CDC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1FE21556
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ucEiag0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgAMNke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:40:34 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37971 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgAMNkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:40:33 -0500
Received: by mail-pj1-f65.google.com with SMTP id l35so4306040pje.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 05:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ejCMkWWKwAoPI8u4KcGTMFwvY/YANPU/hMabfiSeUWY=;
        b=ucEiag0OE86mT0+xHRiS4rf3+pJ8ZcTZjYKFIUZq1UogkOZ9pyd8qUlITMHqvfyYz3
         gCZJiqd2ZRmknv8B10q0Nu2YZw249kz3EmPExGBVGZPpYLlSs2M79K9ATENcScWlgzC7
         zIER/DZY9r2fndqCL3vWq/5gemEga2FeqcgSZhNNfhGGFawR5kvwTBCvndHxv41v1aX6
         5KhqIPLElw1QigUzSWr0E5bWH3sL1qOMO1mX2PUGVOeRJDbNFS/6kP3rh7bD+gCCwSP6
         c6S3xUbhl9bRDg401XWpz/45GH+zglbzTY9djLULueyAnK6XebPE0kjSdZ5axv3uBy/u
         haJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ejCMkWWKwAoPI8u4KcGTMFwvY/YANPU/hMabfiSeUWY=;
        b=GeIFNOmgvHkRi2SxUL1KTgW+yuPbfTzD5FB7ynxbGziElEq6Hwy42PtSqlnRqWZL+4
         jm56OGQVqMMppN4UnS2c7v5Kdl5K32xp1eyTaBSTd0yDNuB07eRGb0n+BDUK8mBY5YrS
         Ec1rU8lHQJbdkPTjXexNycIBIdQHeRewrEZNnoQh7U9rhXM4gXNud8UuAEogLv0LmXcn
         8ciFBJ9SteJ9ZagpE6OrSenIffQaFqY2VPDsLyZfeOitxDL0R/MC6t86ipT+9e+cYQPS
         HUnGz9x1oEKmndvYIT+g4JR60HaF1WKrUQjD+QuAh8ENNOuvpXkh6fGLBD8Bt/Enkcde
         UDYg==
X-Gm-Message-State: APjAAAWnIIEgfRam27P+5ohkISmPwGKvN/EMCViRQfQHfcDTqcGmDZ3u
        /r+NlbQuZndHzpPJaOQrBf2QSGkQ+HOMoYWbj8lTnA==
X-Google-Smtp-Source: APXvYqwpVDtR7a+YeUtFgWE31wFU/5VDAT2mqpXM1oQMEgw6UQkfLNMA8pNEyGKxEhTdX/pSnyP8ALm+BgkUQ/hgJpE=
X-Received: by 2002:a17:902:704b:: with SMTP id h11mr5765181plt.147.1578922832774;
 Mon, 13 Jan 2020 05:40:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576697098.git.andreyknvl@google.com> <6cd46f8512dc12e20667c2b02d487591868cb20f.1576697098.git.andreyknvl@google.com>
 <20200111193156.GC435222@kroah.com>
In-Reply-To: <20200111193156.GC435222@kroah.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 13 Jan 2020 14:40:21 +0100
Message-ID: <CAAeHK+z2+_UHNp4_D2iL9FzPtDoU1YBohCaDJG8sAy12uc_-ew@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] usb: gadget: add raw-gadget interface
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 9:02 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 18, 2019 at 08:26:57PM +0100, Andrey Konovalov wrote:
> > USB Raw Gadget is a kernel module that provides a userspace interface for
> > the USB Gadget subsystem. Essentially it allows to emulate USB devices
> > from userspace. Enabled with CONFIG_USB_RAW_GADGET. Raw Gadget is
> > currently a strictly debugging feature and shouldn't be used in
> > production.
> >
> > Raw Gadget is similar to GadgetFS, but provides a more low-level and
> > direct access to the USB Gadget layer for the userspace. The key
> > differences are:
> >
> > 1. Every USB request is passed to the userspace to get a response, while
> >    GadgetFS responds to some USB requests internally based on the provided
> >    descriptors. However note, that the UDC driver might respond to some
> >    requests on its own and never forward them to the Gadget layer.
> >
> > 2. GadgetFS performs some sanity checks on the provided USB descriptors,
> >    while Raw Gadget allows you to provide arbitrary data as responses to
> >    USB requests.
> >
> > 3. Raw Gadget provides a way to select a UDC device/driver to bind to,
> >    while GadgetFS currently binds to the first available UDC.
> >
> > 4. Raw Gadget uses predictable endpoint names (handles) across different
> >    UDCs (as long as UDCs have enough endpoints of each required transfer
> >    type).
> >
> > 5. Raw Gadget has ioctl-based interface instead of a filesystem-based one.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> This looks good to me, with the one minor problem below that you can fix
> with a follow-on patch.

Great, thanks! I'd prefer to send out v5 to keep this a single patch
if that's OK.

I've also found an issue, but I'm not sure if that is the bug in Raw
Gadget, or in the gadget layer (in the former case I'll add this fix
to v5 as well). What I believe I'm seeing is
__fput()->usb_gadget_unregister_driver()->usb_gadget_remove_driver()->gadget_unbind()
racing with dummy_timer()->gadget_setup(). In my case it results in
gadget_unbind() doing set_gadget_data(gadget, NULL), and then
gadget_setup() dereferencing get_gadget_data(gadget).

Alan, does it look possible for those two functions to race? Should
this be prevented by the gadget layer, or should I use some kind of
locking in my gadget driver to prevent this?

> This should probably go through Felipe's tree
> though, so I'll wait for him to review the gadget side and then queue it
> up in his tree:

OK, looking forward to Felipe's review.

> > +/* The type of event fetched with the USB_RAW_IOCTL_EVENT_FETCH ioctl. */
> > +enum usb_raw_event_type {
> > +     USB_RAW_EVENT_INVALID,
> > +
> > +     /* This event is queued when the driver has bound to a UDC. */
> > +     USB_RAW_EVENT_CONNECT,
> > +
> > +     /* This event is queued when a new control request arrived to ep0. */
> > +     USB_RAW_EVENT_CONTROL,
> > +
> > +     /* The list might grow in the future. */
> > +};
>
> You have to manually specify the enum values in the .h file for all
> entries in order to assure that both userspace and the kernel will be in
> sync with the same values.  I think that's documented in the "how to
> write an ioctl interface" document that is somewhere in
> Documentation/...

Will fix in v5, thanks!
