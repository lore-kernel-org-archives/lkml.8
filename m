Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4225C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B230E207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PbUozQIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgAMRko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:40:44 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44172 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgAMRkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:40:43 -0500
Received: by mail-pf1-f193.google.com with SMTP id 195so5183825pfw.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 09:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BVAS/5gDM35E+vwqcWj4iTNingff3wxRTXoRrLJ2q00=;
        b=PbUozQIiNWcYiivH2d8I/Q2/mmC03ElGYL8BeMeEiv7rT62VOBMRJhYp6DUZdsTLzB
         i2aruOVld4neB7dXlGb+PPyKcrcD2QBO7p1lE3z6d08KbBBzfy/of7wNgpej6eO2NiRH
         qyJAc0F8pnU6MMVWkY81NPm7xe2OA+QsZbE4LIIRcqIBn0OPKdrPC1Q8XPCsPpyspboN
         sUr3+8leOwyY89F/oSFv3cGrNSHmUlynYX2bOUbH+MV0uOTI5ztlTTSvZTB7f47EB940
         9BYe61kQnH0QOdtBTCSmRfuc3h358BlzcWmxeCAZgWOqtNXs9cMTpai7VPRj19osxYe3
         hHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BVAS/5gDM35E+vwqcWj4iTNingff3wxRTXoRrLJ2q00=;
        b=Vd7Ih9nz5QfrdOIM/GMAE91/MY7CqJwzgnuBKxtDLP+jYdEY/53EWdQjUk+M8bOieK
         lUqJ7pu7GfonjsPcnDIUSns7a9F4ppP6klxj8SBJ9FGe7Bs+TvJ1/pfJcJ29fCZVZELM
         hWzexLbSBLdU+TrVOnD2qA5kA+93qATzOZCBiSijZwqKHztn+CFkLfcWhIzGgpblpsDx
         vGQNKFcfmbtkw+4ZaX3T7/QnJS+J9pgjoxjWo6QjOZINUt/FkVT7kZ18Wl7RXaLohbFH
         OKS0epg3vVA8EdwIP+0vxqvhLLWXrLfJmdPCi8Eb3KHQVIyrDerqJBTCfqDIunnb2N9V
         jU8A==
X-Gm-Message-State: APjAAAV9GcGdCOs3iRYR1sCnfrwgymWfEkIJY9Mh73dtniPIVhUipIie
        enBdkmsFiSKtwsJdo3gY3ujq8SZgPoYZnepkDGhrQQ==
X-Google-Smtp-Source: APXvYqwZIQ4UdM7SZQDr51CoDArHUpzRGAe6Q8bNEvEr3P+INcGbapfQuu3m6Q3BghOv0Yv945p4cNNPuIJi/eX8d7k=
X-Received: by 2002:a63:d906:: with SMTP id r6mr22112095pgg.440.1578937242731;
 Mon, 13 Jan 2020 09:40:42 -0800 (PST)
MIME-Version: 1.0
References: <CAAeHK+z2+_UHNp4_D2iL9FzPtDoU1YBohCaDJG8sAy12uc_-ew@mail.gmail.com>
 <Pine.LNX.4.44L0.2001131049090.1502-100000@iolanthe.rowland.org> <CAAeHK+x9Gk3cD77MA9jkhpwO8S62i6KT7PP3NZ6QTZ2qk2FB6w@mail.gmail.com>
In-Reply-To: <CAAeHK+x9Gk3cD77MA9jkhpwO8S62i6KT7PP3NZ6QTZ2qk2FB6w@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 13 Jan 2020 18:40:31 +0100
Message-ID: <CAAeHK+zKAHGAgYKxMNJEiaBhreGB0MgWNsEUFCO8Sxiqvcq57Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] usb: gadget: add raw-gadget interface
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
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

On Mon, Jan 13, 2020 at 6:34 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Mon, Jan 13, 2020 at 5:50 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Mon, 13 Jan 2020, Andrey Konovalov wrote:
> >
> > > I've also found an issue, but I'm not sure if that is the bug in Raw
> > > Gadget, or in the gadget layer (in the former case I'll add this fix
> > > to v5 as well). What I believe I'm seeing is
> > > __fput()->usb_gadget_unregister_driver()->usb_gadget_remove_driver()->gadget_unbind()
> > > racing with dummy_timer()->gadget_setup(). In my case it results in
> > > gadget_unbind() doing set_gadget_data(gadget, NULL), and then
> > > gadget_setup() dereferencing get_gadget_data(gadget).
> > >
> > > Alan, does it look possible for those two functions to race? Should
> > > this be prevented by the gadget layer, or should I use some kind of
> > > locking in my gadget driver to prevent this?
> >
> > In your situation this race shouldn't happen, because before
> > udc->driver->unbind() is invoked we call usb_gadget_disconnect().  If
> > that routine succeeds -- which it always does under dummy-hcd -- then
> > there can't be any more setup callbacks, because find_endpoint() will
> > always return NULL (the is_active() test fails; see the various
> > set_link_state* routines).  So I don't see how you could have ended up
> > with the race you describe.
>
> I've managed to reproduce the race by adding an mdelay() into the
> beginning of the setup() callback. AFAIU what happens is setup() gets
> called (and waits on the mdelay()), then unbind() comes in and does
> set_gadget_data(NULL), and then setup() proceeds, gets NULL through
> get_gadget_data() and crashes on null-ptr-deref. I've got the same
> crash a few times after many days of fuzzing, so I assume it can
> happen without the mdelay() as well.
>
> > However, a real UDC might not be able to perform a disconnect under
> > software control.  In that case usb_gadget_disconnect() would not
> > change the pullup state, and there would be a real possibility of a
> > setup callback racing with an unbind callback.  This seems like a
> > genuine problem and I can't think of a solution offhand.
> >
> > What we would need is a way to tell the UDC driver to stop invoking
> > gadget callbacks, _before_ the UDC driver's stop callback gets called.
> > Maybe this should be merged into the pullup callback somehow.

Perhaps for the dummy driver we need to wait for setup() to finish if
it's being executed and then stop the dummy timer in dummy_pullup()?
