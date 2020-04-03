Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813B8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBE52076E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404069AbgDCSbK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:31:10 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:37028 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390874AbgDCSbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:31:10 -0400
Received: by mail-ua1-f42.google.com with SMTP id l18so3105329uak.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 11:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t/+tAvhZPkT3NQBErD+YA01dd+S7RaKEZEbNC2XphuM=;
        b=eJvzQEVr0WrOy60772+QZYruvUpW8QkcqJbTUSmp/f98bERFcvXqJsIhOSSO5plbtq
         p4HEkw4EQBvz6SJlM3aD65cdlbNRXM056kG/2Ikki03NqRbxVJcyye3kxPar/XNrbUjE
         iHxziLdr70wb0EkNcdmSeWvd91EtVBFI37qt8j3SCKAlbuHNcHmTQ3nSEITeqJXQ8oPt
         a/jSTtX5/Fyt8Z/mYeSZFljAiCMVYjN+ZC/0KaXRarsDOsJpGlHj6AXZmexUs2wvIIt6
         BoXpCJTlqTyI7rcXD5aT1gBsx1yDtv8jqvPTwUwlQsb0G48myzNhpLn/PaV1rDotlauX
         WkYQ==
X-Gm-Message-State: AGi0PuYv7ueoIim6SbC6Qz+XU74R+4au/zGjTks3fnYnrXrh5JhNP8bM
        X/TkYTvKwTayDFvlS2H+R0kffD4kAaAPRp6qlQQ=
X-Google-Smtp-Source: APiQypJiTag/VKFeJYh64r/Qfk3aoztunfqXQSq/NTW4O6p1gtfjHh67vLpjBVv0Hu6nZXFmXAYfl4xbMWaIlRTVKU0=
X-Received: by 2002:ab0:768b:: with SMTP id v11mr7352210uaq.109.1585938668214;
 Fri, 03 Apr 2020 11:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAOkhzLWMB8rr0x4KKfqruCcTLVq4dH6nZ365auMqA1arZ57J7g@mail.gmail.com>
 <CAOkhzLVvmoB0TgS4bioP4PnxwmnT_+h0LbCya2=KkcHu1UT_Zw@mail.gmail.com>
 <CAKb7UvgLr2A88jbx9Zvi3SjXoKbk4iZEg7LNQ4aL3VZhKVQu3A@mail.gmail.com>
 <CAOkhzLU+buL3J3XUbzC6JUAfbnMR-27qwS3Vm7ofrAPPCipXuw@mail.gmail.com>
 <CAKb7UvhvBG49P7t6XD==26q70YywmhUHvP=hW=wj8mT6V0gpHA@mail.gmail.com> <CAOkhzLW42a66wNL7Pz8+d+yO_oyZZJBEps=8WPHaXXFjb54dTQ@mail.gmail.com>
In-Reply-To: <CAOkhzLW42a66wNL7Pz8+d+yO_oyZZJBEps=8WPHaXXFjb54dTQ@mail.gmail.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Fri, 3 Apr 2020 14:30:56 -0400
Message-ID: <CAKb7Uvh=44_S_EAfma+JX9j_igaE3CSWws_TUqLWwJ50zcmA9Q@mail.gmail.com>
Subject: Re: acr: failed to load firmware with Kernel 5.6. Kernel 5.5 works
 just fine.
To:     Zeno Davatz <zdavatz@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 1:59 PM Zeno Davatz <zdavatz@gmail.com> wrote:
>
> On Fri, Apr 3, 2020 at 7:23 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> >
> > On Fri, Apr 3, 2020 at 1:21 PM Zeno Davatz <zdavatz@gmail.com> wrote:
> > >
> > > On Fri, Apr 3, 2020 at 6:59 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> > > >
> > > > Ben -- probably the ACR changes in 5.6 don't fall back nicely anymore
> > > > when there's no firmware? The load shouldn't be failed, just GR
> > > > disabled...
> > > >
> > > > Zeno -- if you grab linux-firmware, it should be all better. Not sure
> > > > if you're missing it on purpose or by accident.
> > >
> > > Thank you, Ilia
> > >
> > > I will try that on my Gentoo/Funtoo machine now. So far linux-firmware
> > > was not needed with Kernel 5.5, so it was not installed on my machine.
> >
> > It was needed on 5.5 as well. It's just that it fell back gracefully
> > without firmware, and you didn't get any acceleration features.
>
> Do I need any of these enabled for linux-firmware to load properly in
> Kernel 5.6?
>
>  -*- Firmware loading facility
>   │ │                                      ()    Build named firmware
> blobs into the kernel binary
>   │ │                                      [ ]   Enable the firmware
> sysfs fallback mechanism
>   │ │                                      [ ]   Enable compressed
> firmware support

Depends on distro specifics. Also the firmware has to be available at
the time that nouveau loads. The corollary to this is:

If it's built into the kernel, then the firmware must also be included
in the kernel (since this happens before any FS stuff)
If it's loaded as a module from initrd, then initrd must contain the firmware

If you need help including firmware in the right place, a distro
support channel is probably your best shot.

Cheers,

  -ilia
