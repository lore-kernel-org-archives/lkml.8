Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FDCC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5937221775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580969979;
	bh=ywptDfU402JGs16qnq0/4nmoDy5j21FxCKlQuiOngpo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=GHeu2E5VKcAH/a7odbWRN0P8fnC/AgwgzNN5Th/S+O9d89hYP/EJ+uBIBSVpZ2Hgi
	 MMhK67fef6w4wm9Imk6ESvEzYKWEMQshX4YhxeACvJvjIAo5i8h6qfcbUsbPiCrX88
	 dTPUtLkLXIbhsISP6Hzh5/fZvDDvK2k8Sfzurj0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgBFGTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:19:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34763 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgBFGTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:19:38 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so3249415lfc.1;
        Wed, 05 Feb 2020 22:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=x2J1K3gDWMkZqzszFsE6VHoS8CdLur1gXmxUe6ymZyM=;
        b=VftAuwDfaaZy4VfCo+iy3UeRk7mVF/zDESc+BFU57alLEXQlClkPTi3gE3iaE88pDd
         p4pkV1lndIZ/cbqZ+2afKym3dJ5zVplUnWsWmh2QBetBCDXmAZZ6WN4wM2nyhRIzC63f
         9/EAPZV7OiOCk3EI/BIw0LoIN8jWh7HGdb2bcty9uwfW4bFircff7lQGHpI3Kren3UE2
         WNBPT5EEEcP5eODARYDVsr9f2YnhFU7sxNjNG7G47aeOvD/dx9YmerCIZ9rB5qfpmamM
         ZPp8Z1ixsQAiygxfDXgKvBLFL7pzQ5U7jp0WRPWDvFoN+0xk5npUDT3MSTqqZbmg3fJZ
         WhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=x2J1K3gDWMkZqzszFsE6VHoS8CdLur1gXmxUe6ymZyM=;
        b=gT4ORmrxCs/WL2dNAda13BnH/yiuOtAHfyM6/IWpXBUihLO1HiNLumNldueI+6vaC8
         q1xzMtPK6QaK3vei+beOZ2Thkr15i3QGGjjZDzpAXSyi55MzIH57V5ZZUnC1e5J5Wp8c
         2SYfTEZcXnYqFbLP8oRM2iPbiUNu5qIN5ryMgQ8J3eVyCfGLbtA09V53f1ZMryaCLt+u
         D8mG/qsbqRlro8X9GNq42N3JygRtWgQZYISLy8ceH6S2tMZdNBb+9uiCy+F9yhHzocCN
         tMYtDBrV0GyOUnrfOWjLbE1/3jQ3G1ZBO5pKFdA27u7XeY5jXFCyTeq9m+cJVNZrjx92
         LgqQ==
X-Gm-Message-State: APjAAAWDR2VHZavMEOeeeZARA1EUWFX8T9uMAIo9cNMOeaLitf9ULft7
        eA3ZM4V9EKXv7Pot3z2xBEyvaLc7FyY=
X-Google-Smtp-Source: APXvYqwyx1/khM+remA5TRnWgTRX6AQfIUll4Y8ZgCzxYLUsMxA9Xa6Xow2H/ahlV/Mn1SBSlinh2Q==
X-Received: by 2002:a19:6449:: with SMTP id b9mr881454lfj.5.1580969974430;
        Wed, 05 Feb 2020 22:19:34 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id n3sm723522ljc.100.2020.02.05.22.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 22:19:33 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v5 1/1] usb: gadget: add raw-gadget interface
In-Reply-To: <CAAeHK+zE6N3W-UQ7yjrSkbfwGCBmd0cTv=z7LKNRa2Er1KMPew@mail.gmail.com>
References: <cover.1579007786.git.andreyknvl@google.com> <461a787e63a9a01d83edc563575b8585bc138e8d.1579007786.git.andreyknvl@google.com> <87ftfv7nf0.fsf@kernel.org> <CAAeHK+wwmis4z9ifPAnkM36AnfG2oESSLAkKvDkuAa0QUM2wRg@mail.gmail.com> <87a7637ise.fsf@kernel.org> <CAAeHK+zNuqwmHG4NJwZNtQHizdaOpriHxoQffZHMffeke_hsGQ@mail.gmail.com> <87tv4556ke.fsf@kernel.org> <CAAeHK+zE6N3W-UQ7yjrSkbfwGCBmd0cTv=z7LKNRa2Er1KMPew@mail.gmail.com>
Date:   Thu, 06 Feb 2020 08:19:27 +0200
Message-ID: <87o8uc5jbk.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Andrey Konovalov <andreyknvl@google.com> writes:
>> Andrey Konovalov <andreyknvl@google.com> writes:
>> >> >> > +static int raw_event_queue_add(struct raw_event_queue *queue,
>> >> >> > +     enum usb_raw_event_type type, size_t length, const void *d=
ata)
>> >> >> > +{
>> >> >> > +     unsigned long flags;
>> >> >> > +     struct usb_raw_event *event;
>> >> >> > +
>> >> >> > +     spin_lock_irqsave(&queue->lock, flags);
>> >> >> > +     if (WARN_ON(queue->size >=3D RAW_EVENT_QUEUE_SIZE)) {
>> >> >> > +             spin_unlock_irqrestore(&queue->lock, flags);
>> >> >> > +             return -ENOMEM;
>> >> >> > +     }
>> >> >> > +     event =3D kmalloc(sizeof(*event) + length, GFP_ATOMIC);
>> >> >>
>> >> >> I would very much prefer dropping GFP_ATOMIC here. Must you have t=
his
>> >> >> allocation under a spinlock?
>> >> >
>> >> > The issue here is not the spinlock, but that this might be called in
>> >> > interrupt context. The number of atomic allocations here is restric=
ted
>> >> > by 128, and we can reduce the limit even further (until some point =
in
>> >> > the future when and if we'll report more different events). Another
>> >> > option would be to preallocate the required number of objects
>> >> > (although we don't know the required size in advance, so we'll waste
>> >> > some memory) and use those. What would you prefer?
>> >>
>> >> I think you shouldn't do either :-) Here's what I think you should do:
>> >>
>> >> 1. support O_NONBLOCK. This just means conditionally removing your
>> >>    wait_for_completion_interruptible().
>> >
>> > I don't think non blocking read/writes will work for us. We do
>> > coverage-guided fuzzing and need to collect coverage for each syscall.
>> > In the USB case "syscall" means processing a USB request from start to
>> > end, and thus we need to wait until the kernel finishes processing it,
>> > otherwise we'll fail to associate coverage properly (It's actually a
>> > bit more complex, as we collect coverage for the whole initial
>> > enumeration process as for one "syscall", but the general idea stands,
>> > that we need to wait until the operation finishes.)
>>
>> Fair enough, but if the only use case that this covers, is a testing
>> scenario, we don't gain much from accepting this upstream, right?
>
> We gain a lot, even though it's just for testing. For one thing, once
> the patch is upstream, all syzbot instances that target upstream-ish
> branches will start fuzzing USB, and there won't be any need for me to
> maintain a dedicated USB fuzzing branch manually. Another thing, is
> that syzbot will be able to do fix/cause bisection (at least for the
> bugs that are fixed/introduced after this patch is merged). And
> finally, once this is upstream, we'll be able to backport this to
> Android kernels and start testing them as well.

A very respectable goal :-)

I just want to take the opportunity to turn this into something more
generic so we stop depending on kernel patches to support newer USB
classes.

I'll try to allocate some time during next week (this week, I'm totally
swamped) to carefully review your submission.

>> >> 3. Have a pre-allocated list of requests (128?) for read(). Enqueue t=
hem
>> >>    all during set_alt(). When user calls read() you will:
>> >>
>> >>    a) check if there are completed requests to be copied over to
>> >>       userspace. Recycle the request.
>> >>
>> >>    b) if there are no completed requests, then it depends on O_NONBLO=
CK
>> >>
>> >>       i) If O_NONBLOCK, return -EWOULDBLOCK
>> >>       ii) otherwise, wait_for_completion
>> >
>> > See response to #1, if we prequeue requests, then the kernel will
>> > start handling them before we do read(), and we'll fail to associate
>> > coverage properly. (This will also require adding another ioctl to
>> > imitate set_alt(), like the USB_RAW_IOCTL_CONFIGURE that we have.)
>>
>> set_alt() needs to be supported if we're aiming at providing support for
>> various USB classes to be implemented on top of what you created :-)
>
> What do you mean by supporting set_alt() here? AFAIU set_alt() is a
> part of the composite gadget framework, which I don't use for this.
> Are there some other actions (besides sending/receiving requests) that
> need to be exposed to userspace to implement various USB classes? The
> one that I know about is halting endpoints, it's mentioned in the TODO
> section in documentation.

Yeah, halting endpoints, cancelling all pending requests, tell userspace
about it, and so on.

>> >> I think this can all be done without any GFP_ATOMIC allocations.
>> >
>> > Overall, supporting O_NONBLOCK might be a useful feature for people
>> > who are doing something else other than fuzzing, We can account for
>> > potential future extensions that'll support it, so detecting
>> > O_NONBLOCK and returning an error for now makes sense.
>> >
>> > WDYT?
>>
>> If that's the way you want to go, that's okay. But let's, then, prepare
>> the code for extension later on. For example, let's add an IOCTL which
>> returns the "version" of the ABI. Based on that, userspace can detect
>> features and so on.
>
> This sounds good to me. Let's concentrate on implementing the part
> that is essential for testing/fuzzing, as it was the initial reason
> why I started working on this, instead of using e.g. GadgetFS. I'll
> add such IOCTL in v6.

Greg doesn't want it, so let's stop that for now.

> Re GFP_ATOMIC allocations, if we're using the blocking approach,
> should I decrease the limit of the number of such allocations or do
> something else?

I would prefer to not see GFP_ATOMIC at all here and I think it's
totally doable, but I could be wrong.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl47r+8ACgkQzL64meEa
mQYrtxAAmlwcFZC5nhqN30yJOozQ+ja34CO9SzXJMAN7FctUV1cMuHh5NGQQHHEH
9nyFbWZGMS559QS8n9Z9879ATfCNZxcGPoa/eNf97tanKANdfF2vie+9CALtMGsC
/p1gkYTu1PFm9xTj5ISebBAEe1GxOo1NB2k/7iGTgyK5iaT0JO7jbxjRAu9Ut1di
eZgLA0pZ3lsuWVaOgTBw6Bnlv+Hkc7q+wZeZh/ddW+YsEkmqByc23v3/JgNZxTRD
FSxunddsz9y08WOxAi98tL7sI2WIc6Np4h7MINDgk6jMzFUpwhEfVv0ubGiXuL0s
I47ihLNAe+ikx0KVTPmYw38LPgTfcnolIztCGiR0R3D0e5j/Y5ZwiGlr5qbB8Nie
K4HkeaOjbh2QZzYRaL+UqqXkxdjz9QSlcYdOCVHxCo4r/TdcO6yRfjNGXetQsjqr
OCDFx2Fr+JYFg6mtPiTDMzGOGn97FH8LTe+Blxf+YPxVsLFfdqvGNIpeyIZReoTf
PNTfUXP2qyRDpixWEt93ZhBFwoCjN3sM9UuJYrVbKOVvUFYQ8Hmo9N0cgbtzYT7v
97DQXyeMwtNdP4KkwDPqzWvtDMMOsrOI3ViL17QuhgUhBo4jttl8lGJ3ASSpSHpn
g30wMP/EWzHqiHPt1x+10en+L2Xjn0i7MNuCaf7ZTu4fYqF8z1w=
=H6pc
-----END PGP SIGNATURE-----
--=-=-=--
