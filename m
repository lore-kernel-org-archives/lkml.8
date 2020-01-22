Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC20C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5163524673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579704617;
	bh=u9SBj+9hYN9VEo3dzqDkTH/o4P8ccCPD7ZsTLNri4aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GmT1r9ApcxJDzqtLhBKKRX8RavnERyywAqJ+pQpL79invtlw2tu+xzCF6gXiXcSgc
	 YlbH5srkHQjDAzwD/PPmDrCe5hO4AgkYTrien/7BVtMzRLPb8X1Nc5hvUmcSd2yFXw
	 4LiM7xttc3fniDv9IaWMSmU29LopqU4wB7V8iF/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAVOuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgAVOuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:50:15 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6816921835;
        Wed, 22 Jan 2020 14:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579704615;
        bh=u9SBj+9hYN9VEo3dzqDkTH/o4P8ccCPD7ZsTLNri4aw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7YzUKuNndmXKoO2rM4SrZLuKSnydO9PlMvUeQ3rj1CKNIANMTqpQwfcA6GWCaVQC
         3M9X9ZG53L1luNJjJ+VZ47im0+k4GH1tbyi1TBnmR5OoGH9edilIf/ajhcMIStBF2T
         SSqQW2BQSR+EAhwPUsY67/UORTIOhqTYpRc+jKAY=
Date:   Wed, 22 Jan 2020 15:50:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Felipe Balbi <balbi@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/1] usb: gadget: add raw-gadget interface
Message-ID: <20200122145012.GB59473@kroah.com>
References: <cover.1579007786.git.andreyknvl@google.com>
 <461a787e63a9a01d83edc563575b8585bc138e8d.1579007786.git.andreyknvl@google.com>
 <CAAeHK+wGijhTaCdoD+xcUY=PRWLUOv5uwg7OjD=uMrU8nqqrdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+wGijhTaCdoD+xcUY=PRWLUOv5uwg7OjD=uMrU8nqqrdw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 03:37:46PM +0100, Andrey Konovalov wrote:
> On Tue, Jan 14, 2020 at 2:24 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
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
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >
> > Greg, I've assumed your LGTM meant that I can add a Reviewed-by from you.
> >
> > Felipe, looking forward to your review, thanks!
> 
> Hi Greg and Felipe,
> 
> I was wondering if it's feasible to get this reviewed and merged
> during the upcoming merge window? This patch is the only piece missing
> to enable USB fuzzing for Android common kernels on syzbot.

No objection from me, if Felipe acks it I can take it...

thanks,

greg k-h
