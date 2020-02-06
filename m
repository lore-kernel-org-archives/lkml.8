Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE11C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338E820659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSYWbCvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgBFRpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:45:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41553 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727479AbgBFRpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581011152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4hsoXsRg+iOgMi2y4QFgOCLUXFqAzwDFmk/kVRs23KY=;
        b=BSYWbCvFqDavEokGdNpYJ7np9PZmraZd6eKcwBLaVyV2zsUca25vEWJoFSh17pOJTwWx3h
        c/wrZLw9C+Xm4y93OYXWPtrdyqEbGNhswgy31S8ItAjLCCQFQeU/nuqI9jHiv/qaNl/1ts
        HnhJmIIgEdIUI6tARntzFbawugWqBIU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-O7aBC9YwMxWs5LaowHTENw-1; Thu, 06 Feb 2020 12:45:43 -0500
X-MC-Unique: O7aBC9YwMxWs5LaowHTENw-1
Received: by mail-qt1-f197.google.com with SMTP id c10so4342528qtk.18
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 09:45:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hsoXsRg+iOgMi2y4QFgOCLUXFqAzwDFmk/kVRs23KY=;
        b=DjT4LwAWOIbUSqqWZCpYcrxu1XLLZyzVaHU1pxmmhDaDxErjAOEI8fTlyMC8m7omKe
         XUFj52lHYmd5fvJPejc79B7e1LI4VPHkIcL85jhl6DS4NQuBAnC/KbRAYcWL/dCQW9Uz
         6F+7oXXbwp5beA8RErohRy5NpyZXMEbVMblecWgcscb8DSBjikKEWqcR8M9hi24Q+OLt
         iKffRY+HOF2v91+W7ZXqDIebvfVr99dnM+QkfXWfMsJGoxJFOlgUZf9fcSvYLRJDwMXn
         GLf2ppP5bVUM/vy4FupQ5jsW0iFDaCYPMn5EjmlWq6x46eAZDqFiMKyj2bryadJiDeoY
         5vtA==
X-Gm-Message-State: APjAAAXeKZSia7OhI36amSU0WbipwDyNxQVbc5XEBaK4G7GpMZHnYxHY
        R5H714R4b7gvc1pJzbQRPBtmyp+mJkqk1Wenvb8uwAfTFuD3JAxWWtXSHRhZ23tkPpETZxDmM2e
        mlqUN581LmN8LjqxSkiqmj46hpDU7qqiHfPvUrQMi
X-Received: by 2002:ad4:46ce:: with SMTP id g14mr3412088qvw.67.1581011143240;
        Thu, 06 Feb 2020 09:45:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwKRB7vkxQEkCWZs7vP69Tg0A3LNsGiv7qJZN7sCeRx4ict/EL2tpk34DTb+uKvvvrnh+M8sEwyc6lJPQuMAj8=
X-Received: by 2002:ad4:46ce:: with SMTP id g14mr3412070qvw.67.1581011142921;
 Thu, 06 Feb 2020 09:45:42 -0800 (PST)
MIME-Version: 1.0
References: <20200126194513.6359-1-martyn@welchs.me.uk> <CAEc3jaDjVZF_Z7Guj1YUo5J5C_-GEOYTH=LKARKccCwQAwuZnQ@mail.gmail.com>
 <fb8850c6c1766b4360a69419845aa8bf7a3aa7a6.camel@welchs.me.uk>
 <CAEc3jaB9ubRLJJG9eWL8-QnEU1s-6cOYsY-PKd57e_K9BiPkSA@mail.gmail.com>
 <nycvar.YFH.7.76.2002031100500.31058@cbobk.fhfr.pm> <CAO-hwJ+k8fxULS1xC-28jHmhZLZVN5EGc=kY5sqNX1GCNKpt4A@mail.gmail.com>
 <nycvar.YFH.7.76.2002031218230.26888@cbobk.fhfr.pm> <CAO-hwJJk411hGTJ6uSdzAFCzf1WJehhifdN0r5kMG6aqL=dnpw@mail.gmail.com>
 <CAEc3jaDC5ddBPDy_Z96eZs-VZQ3051LVAb91-U_Oce9jj1wk8Q@mail.gmail.com>
In-Reply-To: <CAEc3jaDC5ddBPDy_Z96eZs-VZQ3051LVAb91-U_Oce9jj1wk8Q@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 6 Feb 2020 18:45:31 +0100
Message-ID: <CAO-hwJK8yGiRpTr9D86r1kB8pWdCT8A8No40t_YQdtiVm9z26Q@mail.gmail.com>
Subject: Re: [PATCH] HID: Sony: Add support for Gasia controllers
To:     Roderick Colenbrander <thunderbird2k@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Martyn Welch <martyn@welchs.me.uk>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Conn O'Griofa" <connogriofa@gmail.com>,
        "Colenbrander, Roelof" <roderick.colenbrander@sony.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Thu, Feb 6, 2020 at 4:31 PM Roderick Colenbrander
<thunderbird2k@gmail.com> wrote:
>
> On Thu, Feb 6, 2020 at 12:10 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > Hi,
> >
> > On Mon, Feb 3, 2020 at 12:23 PM Jiri Kosina <jikos@kernel.org> wrote:
> > >
> > > On Mon, 3 Feb 2020, Benjamin Tissoires wrote:
> > >
> > > > I am definitely not in favour of that :(
> > > >
> > > > The basic problem we have here is that some vendors are overriding your
> > > > VID/PIDs, and this is nasty. And I do not see any reasons why you can't
> > > > say: "well, we broke it, sorry, but we only support *our* devices, not
> > > > third party ones".
> > >
> > > Well, it's not about "we broke it" in the first place, as far as I
> > > can tell.
> > >
> > > Roderick's concern is that 3rd party devices with overriden VID/PID
> > > malfunction for completely unrelated reason to (correctly working) changes
> > > done in favor of stock Sony devices, but it'll be Sony receiving all the
> > > reports/blame.
> >
> > After re-reading the code, I am not sure we can easily detect the
> > clones. So at some point, I think we will break them, but there is not
> > much we can do. I don't really have a solution for that :(
> >
> > >
> > > > One thing that comes to my mind (probably not the best solution), is to
> > > > taint the kernel if you are facing a non genuine product. We do that for
> > > > nvidia, and basically, we can say: "well, supporting the nvidia blob is
> > > > done on a best effort case, and see with them directly if you have an
> > > > issue". Tainting the kernel is a little bit rough, but maybe adding an
> > > > info message in the dmesg if you detect one of those can lead to a
> > > > situation were we can count on you for supporting the official products,
> > > > and you can get community support for the clones.
> > >
> > > Yeah; which I wouldn't like to do for upstream kernel, but Sony could
> > > definitely do this for the products they ship.
> > >
> > > The same way distros are tainting their kernels when unsupported modules
> > > (but otherwise perfectly fine wrt. GPL and everything else) are loaded
> > > into distro-supported kernels.
> > >
> > > > One last thing. Roderick, I am not sure if I mentioned that or not, but
> > > > I am heavily adding regression tests for HID in
> > > > https://gitlab.freedesktop.org/libevdev/hid-tools/
> > >
> > > ... and words can't express how thankful I am for that :)
> > >
> >
> > OK, I played with that idea earlier this week:
> > https://gitlab.freedesktop.org/libevdev/hid-tools/merge_requests/74
> > I only have a Sixaxis controller, and I only implemented the USB part
> > of it (AFAICT).
> > Currently this ensures the button mapping is correct, and that the
> > LEDs are working properly.
> > We are still missing a few bits and pieces, but the initialization
> > (requests made by the kernel to start the device and press on the PS
> > button) is handled properly.
> >
> > If this is something Roderick would be interested in, we can then try
> > to extend this initial work on Bluetooth controllers and the DualShock
> > ones.
>
> We can probably help out there (need to ask official permission). We
> have similar tests in Android (still adding more). Just in case you
> are not familiar this is their framework:
> https://android.googlesource.com/platform/cts/+/master/tests/tests/hardware/src/android/hardware/input/cts/tests/

thanks. That's a good pointer I wasn't aware of.

>
> It is a small Java class and then there is a json blob with the actual
> test (forgot where the json is). It defines the report descriptors
> etcetera.

Found them at https://android.googlesource.com/platform/cts/+/master/tests/tests/hardware/res/raw

Of course, I had to find advantages to my own test suite (in case you
need to explain to management):
- I am running it upstream on any patch that comes in, so less chances
to catch a failure after the fact
- I am emulating the firmware more precisely IMO (it's a python class
and you can overwrite the set_report, get_report and set_output
report)
- I am emulating both USB and Bluetooth (or whatever bus you want)
- I am testing the LED classes
- we can easily extend to test the rumbles and the battery reporting
- I am not relying on preformatted reports, meaning that it's harder
to cheat in the driver and we can extend the test cases more easily
(what if we have a left d-pad + button 7 that runs into a problem in
the driver?)

Anyway, I just merged the PS3 controller I have. I'll try to see if I
can get the DS4 working based on those json files.

Cheers,
Benjamin

>
> Thanks,
> Roderick
>
> > Adding the clones ones based on the current kernel code is something
> > doable, but I do not expect Sony to be involved in that process.
> >
> > That being said, before we merge this particular patch about Gasia
> > controllers, now we need to implement a regression test first :)
> >
> > Cheers,
> > Benjamin
> >
>

