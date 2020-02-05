Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5A7C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983BF218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580920972;
	bh=U4clQViwQuFittBNQc2BKG2XXqMC8cbcw544VaTM3II=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=wpg+j8D7a/4sXyqacbRwuoxKdxQvO/GM030d1sWiwIoZ4nxYTTJStVADKYH8n+XB3
	 tctis9GXpDS/VOhwefk3t6hVnK9NDB9+GlLm9IdsXiuPkGannaC/jgazuYXWcIY8Op
	 xkCkwqXmQjk1qSACKo5T/5rp0Xy0x+fCtnW3EWP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgBEQmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:42:51 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46994 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgBEQmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:42:51 -0500
Received: by mail-lf1-f68.google.com with SMTP id z26so1930954lfg.13;
        Wed, 05 Feb 2020 08:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=scSwiQFthFrVr8AZFqvZPMKdfsM0fsLE0F72IBN61+U=;
        b=KGIebHXFXEghhylaEyZ3TL+sb9qaXi/pKeSJHeg353IwwtPfwvY9xif214Z//m7dE+
         YGEhhM9Gw2AWex9JDlWMQ1eEGXxcS7GW73xb3WZPHssE2KUY2qfHwpR/Y/WmXLt8Odht
         AEJWak3ODEZ31oaaN5viJUpngh4vR3k4s1nE66rTAm5BcLBVVxl+9BayIUoGUv94Znqz
         j8xHV8e5sLfkXY0m0H0nKkaOFZ5XFBK7Ryd3zh3wzvvD7f2Nyk602s4RoAm/mq+eEceS
         O4ItJaNo/V4BmE1r+TZKpdJ3ZUQttn0YaTIozPEdt23JrffmwQQ3Ns7j+RjlKCN9HU0W
         Z4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=scSwiQFthFrVr8AZFqvZPMKdfsM0fsLE0F72IBN61+U=;
        b=VMUR40l3s31k4m45h1lEwdmsmc0b8GMO55XQhksgvGDAAXHrqwp/PDwCSF5Rg4KyLf
         wxB8giGjGlS1j8EeFOxLaBQkA12htPqmDThjvbbsbGFz6QLa41OZTWL5Po15zAHTOE2C
         PFQSRMRlsalO60oIi8xDEzNJx63TAod1XoxpK4vK/bWe6Es4Qyuq1xGT9R00zQpnrlQW
         q0MowhtOEfLLxFDC+PuMpUhCuGkwVLJiQLRREmJC858mN4LNuNN4arykTaNxjuQAR/yC
         iVNHEL7btnhzRODgxHa/0i8XFI6Kdu86RHX59i1UzUEUhrFyz3p+BN5pqj3aW4rBcVp+
         IHIA==
X-Gm-Message-State: APjAAAUopT5g0di7WnOiQ6sF9fjRIYCbiasJC1n3i/i9ZGf9Sv3tcR/y
        OrOf/i09aNlL4zF0onqMf2+WcAXc0nmnBw==
X-Google-Smtp-Source: APXvYqwFmjRkLj0rtIw1OdLSo/ygIPc1pDlhrrVs0lc77aohF3npjC39O3zHZv6f/xk9YW24mLPjaQ==
X-Received: by 2002:a19:f610:: with SMTP id x16mr18117250lfe.80.1580920968663;
        Wed, 05 Feb 2020 08:42:48 -0800 (PST)
Received: from saruman ([2001:999:81:d599:3b1e:9c62:de71:2a9d])
        by smtp.gmail.com with ESMTPSA id e8sm6652ljb.45.2020.02.05.08.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 08:42:47 -0800 (PST)
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
In-Reply-To: <CAAeHK+zNuqwmHG4NJwZNtQHizdaOpriHxoQffZHMffeke_hsGQ@mail.gmail.com>
References: <cover.1579007786.git.andreyknvl@google.com> <461a787e63a9a01d83edc563575b8585bc138e8d.1579007786.git.andreyknvl@google.com> <87ftfv7nf0.fsf@kernel.org> <CAAeHK+wwmis4z9ifPAnkM36AnfG2oESSLAkKvDkuAa0QUM2wRg@mail.gmail.com> <87a7637ise.fsf@kernel.org> <CAAeHK+zNuqwmHG4NJwZNtQHizdaOpriHxoQffZHMffeke_hsGQ@mail.gmail.com>
Date:   Wed, 05 Feb 2020 18:42:41 +0200
Message-ID: <87tv4556ke.fsf@kernel.org>
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
>> >> > +static int raw_event_queue_add(struct raw_event_queue *queue,
>> >> > +     enum usb_raw_event_type type, size_t length, const void *data)
>> >> > +{
>> >> > +     unsigned long flags;
>> >> > +     struct usb_raw_event *event;
>> >> > +
>> >> > +     spin_lock_irqsave(&queue->lock, flags);
>> >> > +     if (WARN_ON(queue->size >=3D RAW_EVENT_QUEUE_SIZE)) {
>> >> > +             spin_unlock_irqrestore(&queue->lock, flags);
>> >> > +             return -ENOMEM;
>> >> > +     }
>> >> > +     event =3D kmalloc(sizeof(*event) + length, GFP_ATOMIC);
>> >>
>> >> I would very much prefer dropping GFP_ATOMIC here. Must you have this
>> >> allocation under a spinlock?
>> >
>> > The issue here is not the spinlock, but that this might be called in
>> > interrupt context. The number of atomic allocations here is restricted
>> > by 128, and we can reduce the limit even further (until some point in
>> > the future when and if we'll report more different events). Another
>> > option would be to preallocate the required number of objects
>> > (although we don't know the required size in advance, so we'll waste
>> > some memory) and use those. What would you prefer?
>>
>> I think you shouldn't do either :-) Here's what I think you should do:
>>
>> 1. support O_NONBLOCK. This just means conditionally removing your
>>    wait_for_completion_interruptible().
>
> I don't think non blocking read/writes will work for us. We do
> coverage-guided fuzzing and need to collect coverage for each syscall.
> In the USB case "syscall" means processing a USB request from start to
> end, and thus we need to wait until the kernel finishes processing it,
> otherwise we'll fail to associate coverage properly (It's actually a
> bit more complex, as we collect coverage for the whole initial
> enumeration process as for one "syscall", but the general idea stands,
> that we need to wait until the operation finishes.)

Fair enough, but if the only use case that this covers, is a testing
scenario, we don't gain much from accepting this upstream, right? We can
still support both block and nonblock, but let's at least give the
option.

>> 2. Every time user calls write(), you usb_ep_alloc(), allocate a buffer
>>    with the write size, copy buffer to kernel space,
>>    usb_ep_queue(). When complete() callback is called, then you free the
>>    request. This would allow us to amortize the cost of copy_from_user()
>>    with several requests being queued to USB controller.
>
> I'm not sure I really get this part. We'll still need to call
> copy_from_user() and usb_ep_queue() once per each operation/request.
> How does it get amortized? Or do you mean that having multiple
> requests queued will allow USB controller to process them in bulk?

yes :-)

> This makes sense, but again, we"ll then have an issue with coverage
> association.

You can still enqueue one by one, but this would turn your raw-gadget
interface more interesting for other use cases.

>> 3. Have a pre-allocated list of requests (128?) for read(). Enqueue them
>>    all during set_alt(). When user calls read() you will:
>>
>>    a) check if there are completed requests to be copied over to
>>       userspace. Recycle the request.
>>
>>    b) if there are no completed requests, then it depends on O_NONBLOCK
>>
>>       i) If O_NONBLOCK, return -EWOULDBLOCK
>>       ii) otherwise, wait_for_completion
>
> See response to #1, if we prequeue requests, then the kernel will
> start handling them before we do read(), and we'll fail to associate
> coverage properly. (This will also require adding another ioctl to
> imitate set_alt(), like the USB_RAW_IOCTL_CONFIGURE that we have.)

set_alt() needs to be supported if we're aiming at providing support for
various USB classes to be implemented on top of what you created :-)

>> I think this can all be done without any GFP_ATOMIC allocations.
>
> Overall, supporting O_NONBLOCK might be a useful feature for people
> who are doing something else other than fuzzing, We can account for
> potential future extensions that'll support it, so detecting
> O_NONBLOCK and returning an error for now makes sense.
>
> WDYT?

If that's the way you want to go, that's okay. But let's, then, prepare
the code for extension later on. For example, let's add an IOCTL which
returns the "version" of the ABI. Based on that, userspace can detect
features and so on.

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl468IEACgkQzL64meEa
mQbQMhAAgHkXWa6Mj+ZVUhk34gzLEnK4mir1nXAPMaip4WKnc2nJFFQC7Fs0xvpg
8MKJppu981gZIDYVsJH+oOaEuTzHpXYRMIXUdqSV3fz6UvHh0x52MUgtMDoQuKhF
+rA8ppVe608FQzhneiReUS3rp7HXspRASRoDx2IW1TNcJzAXzGJ412+9bH5FQD7s
1RWJksQJzGqiOBk2dhsm8DGePNtABtS2z27AjMzESbNkE4w+4D7bDX7Kf9jkz3PF
1JxvuEErvIXdItESNUa8UvKg1UyJsx6kLbimqMSdCA6/3sUBzMuVJJe72Trv9Fvd
W+BTHKuvSUtjHVc8oNhLk6uCjLbB2WiBaqpA6nDsO4GeMPOkBfI61wUW+EIuXurS
SWYFZZHQoHzt8BlXLnheZDbKx7Xdo0unbpt7qUwTwFTqBh/Jbh6+ZbKR5y1FDH8x
xnOZbeeTqlVBMzxfh/upANX6HZsNK5sgFgqjT8Kg0MOFF5kXl6tcJm1G7VbbiR/g
3LcItJmQjBvvpKq4LBjEpDcAiiCzDHLV3OOKvr+8waUQU992Zk62OH125n98S8GS
TCYksbMYXmXgR9IouV4ExK/YV1AZZYmbtuwZfMaYIsINBiLI8gCQ0zNvbqcttvAT
4D4pNzilC6/syDeHnQccteGy21yaprhaiWsGmrrghrlA3VKG6S0=
=ddZ0
-----END PGP SIGNATURE-----
--=-=-=--
