Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BD4C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0653420CC7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm5/aToo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404440AbgDCRui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:50:38 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42186 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404156AbgDCRuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:50:37 -0400
Received: by mail-il1-f196.google.com with SMTP id f16so8095000ilj.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmbhyIXmrz+eNo1jIqzI2XdU/nrTp4OGNmpl1Xh9tlE=;
        b=lm5/aTooU44NMBlr4XRbWZlbS90lcTyzPtJs3e5G9WlcH4qFPFb5U4V79JlJC7zpy2
         lyrtFy5OH0aEDUc5ex72Pda5HrQr3cTwgr87ENFQD51Nz2aINFcg/PhHV9DXvCZkK+Ut
         6Zwu2LhZ0Sd3/42DaffSxvg4C5ob4Ds5w/A4lEZH0bNSiJshH8znQcbnPhdtdAWxbvgk
         UqVhMiu7mQCjEP7tbjSih2juMFe9yJ1nL0113WbzkaQjo6qtlm9tBEAEweTX5R8OXk8W
         LNUebeKogogKCyTq6xi1XCg+D8BLAxLgf1sV++4auatsVXM9Veb5K2nHR2Si4vzlSGzU
         e3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmbhyIXmrz+eNo1jIqzI2XdU/nrTp4OGNmpl1Xh9tlE=;
        b=jM1FLyB6nxUYO1U3r3YOk2ziV1tMnMImGXT8nencUkfM8UwR+O1HL4HhSUJl6+baXI
         8LghA3XFObq4ibULvGHaVhh07YHcu36/pILRBYT4nZE6Wju2bcBvxgaRrDEUX1KGVTcd
         K+Mfel8nLeJt7izhcEj3jfisB91EFnZ3g3zREVCygKd/PKf8IqdA61PlKuliFKIPVK8E
         Qp+KnxunPL/1HaxKg/cfSbULNuCn3IVpB2i/ymFWOrJJ0rxVFxW7/YwHJA0w++N50l1S
         qtfuKIAuN6sgaLmP8yVTUXqs80rexKF1NDoJC9rFLj4JJFB0dePY1e5ICQBGPMrcgxyZ
         EsTw==
X-Gm-Message-State: AGi0PuZud1hrxLS2AaQYolyZatnjiK+mRpwvRm819PTIK3HpHUZnc5D7
        UPvVOkToQQlUgmlsj+z1fjgS4CL6UUwlYME2mzF70pMZ3yQ=
X-Google-Smtp-Source: APiQypJUI/cNcfEfFINez/lK2NJEElF5lQsf2V1rbSAdEODWz872zQxP1xvg9cmBBo5EnsX29e+foBCKOP2nOJZSx5Q=
X-Received: by 2002:a92:8d0e:: with SMTP id s14mr9593675ild.117.1585936234915;
 Fri, 03 Apr 2020 10:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAOkhzLWMB8rr0x4KKfqruCcTLVq4dH6nZ365auMqA1arZ57J7g@mail.gmail.com>
 <CAOkhzLVvmoB0TgS4bioP4PnxwmnT_+h0LbCya2=KkcHu1UT_Zw@mail.gmail.com>
 <CAKb7UvgLr2A88jbx9Zvi3SjXoKbk4iZEg7LNQ4aL3VZhKVQu3A@mail.gmail.com>
 <CAOkhzLU+buL3J3XUbzC6JUAfbnMR-27qwS3Vm7ofrAPPCipXuw@mail.gmail.com> <CAKb7UvhvBG49P7t6XD==26q70YywmhUHvP=hW=wj8mT6V0gpHA@mail.gmail.com>
In-Reply-To: <CAKb7UvhvBG49P7t6XD==26q70YywmhUHvP=hW=wj8mT6V0gpHA@mail.gmail.com>
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Fri, 3 Apr 2020 19:50:23 +0200
Message-ID: <CAOkhzLUE62zCKt1wCQjOVz=7keSHVFHDfqZhN54_-0LtC7BoAw@mail.gmail.com>
Subject: Re: acr: failed to load firmware with Kernel 5.6. Kernel 5.5 works
 just fine.
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 7:23 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>
> On Fri, Apr 3, 2020 at 1:21 PM Zeno Davatz <zdavatz@gmail.com> wrote:
> >
> > On Fri, Apr 3, 2020 at 6:59 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> > >
> > > Ben -- probably the ACR changes in 5.6 don't fall back nicely anymore
> > > when there's no firmware? The load shouldn't be failed, just GR
> > > disabled...
> > >
> > > Zeno -- if you grab linux-firmware, it should be all better. Not sure
> > > if you're missing it on purpose or by accident.
> >
> > Thank you, Ilia
> >
> > I will try that on my Gentoo/Funtoo machine now. So far linux-firmware
> > was not needed with Kernel 5.5, so it was not installed on my machine.
>
> It was needed on 5.5 as well. It's just that it fell back gracefully
> without firmware, and you didn't get any acceleration features.

Thank you, Ilia

Installing linux-firmware-20200122 on Gentoo/Funtoo Linux with Kernel
5.6 did not really help.

I still get the same message.

~> dmesg | grep nouveau
[    0.762819] nouveau 0000:05:00.0: NVIDIA GP107 (137000a1)
[    0.875252] nouveau 0000:05:00.0: bios: version 86.07.42.00.4a
[    0.875552] nouveau 0000:05:00.0: acr: failed to load firmware
[    0.875651] nouveau 0000:05:00.0: acr: failed to load firmware
[    0.875751] nouveau 0000:05:00.0: acr ctor failed, -2
[    0.875850] nouveau: probe of 0000:05:00.0 failed with error -2
~> uname -a
Linux zenogentoo 5.6.0 #74 SMP Fri Apr 3 19:44:55 CEST 2020 x86_64
Intel(R) Core(TM) i7 CPU 960 @ 3.20GHz GenuineIntel GNU/Linux

is there any other Kernel setting I need for 5.6?

Best
Zeno
