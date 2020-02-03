Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725B8C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F1120661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJf3cu2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgBCKsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:48:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30292 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727368AbgBCKsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580726911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4vl9t6G+rR4BEVeLAiNKfNbHtFriLKQ5FIXsIeC8dtI=;
        b=CJf3cu2hO5MzBy85zH6+/Zl9aYfKrXQ9A5hQ1oEnQl7X0ksbBeIHvvgKbXQwy+ofesgl7F
        pA1elqz41a0Ke0Pe0UCouJOY/Ms1E4/IRN7I1jsKsze9tTELfnmciEv9jTCiVvfyMeKdx7
        FtulYpva2MagHUALhOsmQaZE8iR2A+0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-1OjsCVGnO9azAcFPn-YtVg-1; Mon, 03 Feb 2020 05:48:26 -0500
X-MC-Unique: 1OjsCVGnO9azAcFPn-YtVg-1
Received: by mail-qv1-f72.google.com with SMTP id dw11so9192672qvb.16
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 02:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4vl9t6G+rR4BEVeLAiNKfNbHtFriLKQ5FIXsIeC8dtI=;
        b=r4zSESJ30rji9sVqz7iADWthm1v08fHl+gDhdIv0rQSsyBtgcgab8F5zBgQWAzJQUE
         xkBBjVH2WoUpR+hg2WYFsX6j8byFQNkk8mz0OsEXkADc5OiDw5feZImbZ5PGWYdtzz5r
         fws0bJ++AdKIljT1l4+FYG2xtJBTWnix5thXDusKZNVsawMcMjTXMPz9oXiFDU4RIav9
         +/tecJpTyuuSrfSBf53cqXlp/uAai/tLdZyPUWTS3lRftVXw43RxnKG+xD/WxBadh4Mw
         6V1dGEpb0jy4CvxoZo567pURhC3p2dEGRmJkqQet78WvZt5VszOvUSk/hyMvT3byhtaZ
         G8EQ==
X-Gm-Message-State: APjAAAU3lxhTCfZt5xeqwpNXhKUuV/RAM4HjGJoEDuHeCAhJYGmimEI/
        EANW7C7YPdiDvVbuv1AqtCb2PyvQzBsYmbkbhDsQ1mqyUdaFG1GQt5vjJ0eM0cDNBYMEkD9KqgC
        BqdqDP6/KATzzwuoNPs8c7CBP939gsADfdbeYdJIZ
X-Received: by 2002:a05:620a:782:: with SMTP id 2mr23117412qka.169.1580726906229;
        Mon, 03 Feb 2020 02:48:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqw57KilUvEJk+H5dJAZYGiDk0XG43+Td/Vmu8tcnt+BfPz8KNU+iEHA3MSmVGjSVNMCiuK60JC28Q8bOkYLWfE=
X-Received: by 2002:a05:620a:782:: with SMTP id 2mr23117385qka.169.1580726905695;
 Mon, 03 Feb 2020 02:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20200126194513.6359-1-martyn@welchs.me.uk> <CAEc3jaDjVZF_Z7Guj1YUo5J5C_-GEOYTH=LKARKccCwQAwuZnQ@mail.gmail.com>
 <fb8850c6c1766b4360a69419845aa8bf7a3aa7a6.camel@welchs.me.uk>
 <CAEc3jaB9ubRLJJG9eWL8-QnEU1s-6cOYsY-PKd57e_K9BiPkSA@mail.gmail.com> <nycvar.YFH.7.76.2002031100500.31058@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2002031100500.31058@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 3 Feb 2020 11:48:14 +0100
Message-ID: <CAO-hwJ+k8fxULS1xC-28jHmhZLZVN5EGc=kY5sqNX1GCNKpt4A@mail.gmail.com>
Subject: Re: [PATCH] HID: Sony: Add support for Gasia controllers
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Roderick Colenbrander <thunderbird2k@gmail.com>,
        Martyn Welch <martyn@welchs.me.uk>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Conn O'Griofa" <connogriofa@gmail.com>,
        "Colenbrander, Roelof" <roderick.colenbrander@sony.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 11:02 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Tue, 28 Jan 2020, Roderick Colenbrander wrote:
>
> > Let me explain the situation a little bit better from our angle. These
> > devices exist and from the Linux community perspective of course they
> > should see some level of support. And as I said since this is PS3
> > generation I don't have much of a concern.
> >
> > Where it becomes tricky for any company in our situation is the support
> > side. We don't know these devices and don't have access to datasheets or
> > anything, but when such code is in our "official driver" it means we
> > have to involve them in our QA process and support them in some manner
> > (kind of legitimizing their existence as well). We now support this
> > driver in a large capacity (pretty much all mobile devices will start
> > shipping it) it puts challenges on our partners (not a big issue since
> > just PS3 right now).
> >
> > As you can see this creates an awkward situation. I'm sure there other
> > such devices as well e.g. counterfeit Logitech keyboards, USB serial
> > adapters and other periperhals with similar challenges. In an ideal
> > world the support would live in another driver, but since in case of
> > this "fake" PS3 controller it "share" our product / vendor ids it is
> > tricky. At this point there is not a strong enough case yet to augment
> > the "hid-quirks" to do so, but perhaps if it became a serious issue
> > (e.g. for newer controllers) maybe we need to think of something.
>
> If this is a big issue for you, one possible way around it would be
> creating a module parameter which would tell the driver whether it should
> those "fake" devices, and you can then turn it off in your products (or we
> can of course start the "what should the default setting me" bikeshedding
> :) ).
>

I am definitely not in favour of that :(

The basic problem we have here is that some vendors are overriding
your VID/PIDs, and this is nasty. And I do not see any reasons why you
can't say: "well, we broke it, sorry, but we only support *our*
devices, not third party ones".

One thing that comes to my mind (probably not the best solution), is
to taint the kernel if you are facing a non genuine product. We do
that for nvidia, and basically, we can say: "well, supporting the
nvidia blob is done on a best effort case, and see with them directly
if you have an issue".
Tainting the kernel is a little bit rough, but maybe adding an info
message in the dmesg if you detect one of those can lead to a
situation were we can count on you for supporting the official
products, and you can get community support for the clones.

One last thing. Roderick, I am not sure if I mentioned that or not,
but I am heavily adding regression tests for HID in
https://gitlab.freedesktop.org/libevdev/hid-tools/
Given that hid-sony.ko seems to only use pure HID communication, it
should be easy enough to write regression tests for the devices, and
this way you can split up the QA in 2: automated and upstream tests
run by me for all devices handled by hid-sony, and your QA can focus
on the actual physical hardware, and ignore all of the clones.

Cheers,
Benjamin

