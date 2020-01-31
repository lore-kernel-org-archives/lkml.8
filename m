Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA1CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF44206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580484159;
	bh=jPJiRD2ReeRm5LemdMYtq04E9loKCU+LdSQ6GTTBXmg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=CQTY4Mbfp6Ox1l+vbab+gJll9q1Sfe2FneadOD9OreGT5arEqZwwZ+JK0pAIW5nmH
	 gZRSstp+1V2zegl0WDmFzJvxghJRNkPn99M9O2xYD1M9pHGU0lsTxkEdn37zfq6JaM
	 slbz5wmrecaCVVF924TN4CmejGqajOwiK1d3ldVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAaPWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:22:38 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40375 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbgAaPWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:22:38 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18so7465855ljo.7;
        Fri, 31 Jan 2020 07:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=OVgIO1CzZRl+XabsXK7plCCJlzTLJUz3Sk5kA7wDx1A=;
        b=L4S/CsXt8WqpVAnU2Fv0ZF2b0G6y71MulvbvxkJxiikxNPvbButZkMKmXPvVg14UBm
         9U+LjVgry8SalWOEDFCemTZPCbVWH2o4Ns+rQNgfUvuTmzntubP3DrmhY1l7jr3AU6F4
         bG7MtSo8m5iRO+AGjj2sUL32VdV4wHqMpevzfIKyJq1rukYs3ReRfo7EuHWM+yQ1k9vh
         MGc6OHS5Sbf1job77UmAnEmD4fK5p2EL3+kNv1lLAiywsLVma616iqIPyyt2RA5oLBhu
         pChtNmro4TCzpzofayFVG1yGn/6SwKUgsxPLlMsCoTR7FpfQNkNj2yifZdnZzIZbmlJS
         LHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=OVgIO1CzZRl+XabsXK7plCCJlzTLJUz3Sk5kA7wDx1A=;
        b=eIL29JG4tn8C1nVDP2+Nz9mSvTMOV2hfQmRzCf2Cq59hz0fYk0EF/qQbk1dAA0UOrr
         Kc2WJGfUu1oHkbxaEIZdMgTxtMF6NbKIDzCR2NnUm2wgIZD+/o8KSMjpPhpVzrUw+0Ed
         8mcJGJk7+AHgpwbt2Kfhneo/LYcIcNC9kEgFa/FJQi7dl3hdltCkby4M6oH4D389YzS+
         zmubLwbmb4B7Ej9eUyJyceyx2FYyC1p6Gnphhcx3GILb9FdudzEyeA2+JUH4pIJ5Rob4
         ICyF+s+Q1ftGzajs066BMXFv5skwD1GjKTMcwURzbJ3h2CQFW6aYn5z+WT+6tLbXzMvW
         woYA==
X-Gm-Message-State: APjAAAWmUAzuMfSByMT2RtPTfLEALEGIVVMLfFpNxDor507X6140+DzX
        x4HtSj6gAaEieJxcx3XTOWQ=
X-Google-Smtp-Source: APXvYqwZxMkzW5sa1W44mtWMkHUwHmnYmN6N25z2/mNDH1Xd6lzfKe4ojSTZX+H9mUmc0we/Pih87Q==
X-Received: by 2002:a2e:9955:: with SMTP id r21mr6031405ljj.283.1580484155402;
        Fri, 31 Jan 2020 07:22:35 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id q10sm4947154ljj.60.2020.01.31.07.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Jan 2020 07:22:34 -0800 (PST)
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
In-Reply-To: <CAAeHK+wwmis4z9ifPAnkM36AnfG2oESSLAkKvDkuAa0QUM2wRg@mail.gmail.com>
References: <cover.1579007786.git.andreyknvl@google.com> <461a787e63a9a01d83edc563575b8585bc138e8d.1579007786.git.andreyknvl@google.com> <87ftfv7nf0.fsf@kernel.org> <CAAeHK+wwmis4z9ifPAnkM36AnfG2oESSLAkKvDkuAa0QUM2wRg@mail.gmail.com>
Date:   Fri, 31 Jan 2020 17:22:09 +0200
Message-ID: <87a7637ise.fsf@kernel.org>
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
>> > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadg=
et/legacy/raw_gadget.c
>> > new file mode 100644
>> > index 000000000000..51796af48069
>> > --- /dev/null
>> > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
>> > @@ -0,0 +1,1068 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>>
>> V2 only
>
> Like this: SPDX-License-Identifier: GPL-2.0 only ?

Right, you need to choose if you want 2.0-only or 2.0-or-later and make
sure spdx and module_license() agree.

https://spdx.org/licenses/GPL-2.0-only.html

What you had before, implies GPL-2.0-only...

>> > +MODULE_LICENSE("GPL");

but this is GPL 2+

/me goes look

Actually Thomas Gleixner changed the meaning of MODULE_LICENSE("GPL"),
so I don't really know how this should look today.

>> > +static int raw_event_queue_add(struct raw_event_queue *queue,
>> > +     enum usb_raw_event_type type, size_t length, const void *data)
>> > +{
>> > +     unsigned long flags;
>> > +     struct usb_raw_event *event;
>> > +
>> > +     spin_lock_irqsave(&queue->lock, flags);
>> > +     if (WARN_ON(queue->size >=3D RAW_EVENT_QUEUE_SIZE)) {
>> > +             spin_unlock_irqrestore(&queue->lock, flags);
>> > +             return -ENOMEM;
>> > +     }
>> > +     event =3D kmalloc(sizeof(*event) + length, GFP_ATOMIC);
>>
>> I would very much prefer dropping GFP_ATOMIC here. Must you have this
>> allocation under a spinlock?
>
> The issue here is not the spinlock, but that this might be called in
> interrupt context. The number of atomic allocations here is restricted
> by 128, and we can reduce the limit even further (until some point in
> the future when and if we'll report more different events). Another
> option would be to preallocate the required number of objects
> (although we don't know the required size in advance, so we'll waste
> some memory) and use those. What would you prefer?

I think you shouldn't do either :-) Here's what I think you should do:

1. support O_NONBLOCK. This just means conditionally removing your
   wait_for_completion_interruptible().

2. Every time user calls write(), you usb_ep_alloc(), allocate a buffer
   with the write size, copy buffer to kernel space,
   usb_ep_queue(). When complete() callback is called, then you free the
   request. This would allow us to amortize the cost of copy_from_user()
   with several requests being queued to USB controller.

3. Have a pre-allocated list of requests (128?) for read(). Enqueue them
   all during set_alt(). When user calls read() you will:

   a) check if there are completed requests to be copied over to
      userspace. Recycle the request.

   b) if there are no completed requests, then it depends on O_NONBLOCK

      i) If O_NONBLOCK, return -EWOULDBLOCK
      ii) otherwise, wait_for_completion

I think this can all be done without any GFP_ATOMIC allocations.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl40RiMACgkQzL64meEa
mQYV4Q//ePpfN2tBzCDehixHUQTXhIq4ew54FBKuq5CG4qbTYTxFIRyRt7P9FyEV
/NUmAbR1CWvhmWzwV1+5ovClrKNrym1l/cp19y8vErqfQRMAhTad/PgA4oErL6Wc
oxguUrspkvwywX2T+8WhynEijLoHrofVQKDpxZ1sDXIobNabFpIKTf6uGfs4+nP5
KKt0dmRfs3+r363SslfkCahjwbnggkenKH3R4pVtcImrDjq16Mxqfgf8XY0CMVge
zihwa9SMxT4D4Yp/g6vc9UKlHLIDKk/Xuon++TaeCxiSgH/E+S0SM538nrsiWDoD
B2X/aopWmS36QDf4sq86GEYZvaZbhcUIYWvMOhNPg8kcvbtOeKk05/AXYtoHH48i
7ubvT/gl5k254b37NZRU8pkBxQZ1E/JNtQtMpG2AcQNljvYLoC2TYP7AnLj8ZanN
O84PpwkI7gUCMU+bkBWaxlvMuDmA1jhm7KNrLtyyhM5/q2puEMVjYvh9pUtyOuiT
AB2k4S0JHIsatIUVD0w6dCyZpbVLxAabmZpNkpkc6ix8JHR8b4nI3hnOsyGq4xsL
J6knw+9i27uYhQEnryjCxD7Dw9Ui1n8B13+n13waP9wS4Qd7E4fNuZAd/4obHzUA
V/JmqrX4GG2gWk1BpuQGdxSWZfXlcKUXgTqfXJ/GRx1JwPN5NvY=
=mPo5
-----END PGP SIGNATURE-----
--=-=-=--
