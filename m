Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C88AC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F84206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EV78N2ya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgA0M2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 07:28:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42801 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbgA0M2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 07:28:09 -0500
Received: by mail-pg1-f193.google.com with SMTP id s64so5075509pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 04:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cyKi2C2E/DAzDkpv5Bc8WYZz4cP/WF80nTy9kORAPME=;
        b=EV78N2yaNyur/ZLKrvmzkt7S1u7530+tYPA0SV6rAJ/bY8UyEqtU3oIx8TPXiWAh4+
         v6FLzakE+serof6o+wNI48WjZPub3p1OyfcskqfxSfi3G86L/FXJrnkjp0pmyTumxm3A
         YLmRWV6tnK5PKcjYpkj/nXnYwCZpi0w5f+VYcqIFeHdqAG9XjTQxF5l59hNuw1HtQrai
         nk7h0JXSKpL0emDeQC95VYwa0kjVvUjv8sS6w+mzAL9aSyJhCGjqw3tCz8qJdumcLAEC
         SKCeALbMGNadYxApuDHLkB1ax3fJKDjvlAojAsLRwVcOPOYZtWQ43NlXPNONAtI/6wSR
         pmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cyKi2C2E/DAzDkpv5Bc8WYZz4cP/WF80nTy9kORAPME=;
        b=L7sflkMvOcEo5h4jRK79wRBHQwlCl1bKwKhmz80uQIFFHaKN8Y2kilxFgU2jsSqiNj
         XFGYy5VQwcCp5hrkalXxOyKV5XXCWBFukGfGx5xRS/svvn1HvLwzUh3GXTLPWjV8qMts
         U/Iw/aTwpcpvNyFhFh0fVoGU9+vwAtaBsnyDK4abccoe49fY1N879TujdwShD/YURw4M
         1dJqI2HXvMW9gLr/+69dq6FnlwRBFVXSh4dR90niYnaVfq2+ug5mX/p12GQRzyzUAcgt
         zXMSbGRYXAyM5s2wlGKML4pkBtfGrlU8k+6c5DRwJ2cSsOxiG9NkbwcJL+v8oHJ0oO1U
         l2VA==
X-Gm-Message-State: APjAAAVKLQ8RdMw2oDOddxK0/K9xSNJXFX2K1telju6X7N/w6bqxrlI8
        ZomqesGM7iGmkzVVFl4P6xA2F02TvQOMSH0POSfN+w==
X-Google-Smtp-Source: APXvYqzkc5LvBv1czBSlpohSy32KHfPPbYvVuxg1l19yqW3ryxB3bm5KIKRPhPdwTOrRZKiUXYCREAAmPkPBw8w+WcI=
X-Received: by 2002:a63:d906:: with SMTP id r6mr19362630pgg.440.1580128088829;
 Mon, 27 Jan 2020 04:28:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579007786.git.andreyknvl@google.com> <461a787e63a9a01d83edc563575b8585bc138e8d.1579007786.git.andreyknvl@google.com>
 <CAAeHK+wGijhTaCdoD+xcUY=PRWLUOv5uwg7OjD=uMrU8nqqrdw@mail.gmail.com> <20200122145012.GB59473@kroah.com>
In-Reply-To: <20200122145012.GB59473@kroah.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 27 Jan 2020 13:27:57 +0100
Message-ID: <CAAeHK+xJ_Xhy96vVXQLk2G_DqVtjh+3ivNM=yFVXFPBjZ6P3iA@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] usb: gadget: add raw-gadget interface
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 3:50 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 22, 2020 at 03:37:46PM +0100, Andrey Konovalov wrote:
> > On Tue, Jan 14, 2020 at 2:24 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > >
> > > USB Raw Gadget is a kernel module that provides a userspace interface for
> > > the USB Gadget subsystem. Essentially it allows to emulate USB devices
> > > from userspace. Enabled with CONFIG_USB_RAW_GADGET. Raw Gadget is
> > > currently a strictly debugging feature and shouldn't be used in
> > > production.
> > >
> > > Raw Gadget is similar to GadgetFS, but provides a more low-level and
> > > direct access to the USB Gadget layer for the userspace. The key
> > > differences are:
> > >
> > > 1. Every USB request is passed to the userspace to get a response, while
> > >    GadgetFS responds to some USB requests internally based on the provided
> > >    descriptors. However note, that the UDC driver might respond to some
> > >    requests on its own and never forward them to the Gadget layer.
> > >
> > > 2. GadgetFS performs some sanity checks on the provided USB descriptors,
> > >    while Raw Gadget allows you to provide arbitrary data as responses to
> > >    USB requests.
> > >
> > > 3. Raw Gadget provides a way to select a UDC device/driver to bind to,
> > >    while GadgetFS currently binds to the first available UDC.
> > >
> > > 4. Raw Gadget uses predictable endpoint names (handles) across different
> > >    UDCs (as long as UDCs have enough endpoints of each required transfer
> > >    type).
> > >
> > > 5. Raw Gadget has ioctl-based interface instead of a filesystem-based one.
> > >
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > ---
> > >
> > > Greg, I've assumed your LGTM meant that I can add a Reviewed-by from you.
> > >
> > > Felipe, looking forward to your review, thanks!
> >
> > Hi Greg and Felipe,
> >
> > I was wondering if it's feasible to get this reviewed and merged
> > during the upcoming merge window? This patch is the only piece missing
> > to enable USB fuzzing for Android common kernels on syzbot.
>
> No objection from me, if Felipe acks it I can take it...

Hi Felipe,

Any idea if you'll be able to look at this?

Thanks!
