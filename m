Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF12C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0B6206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHUxH4h7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgAMRej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:34:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45569 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbgAMRej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:34:39 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22so4067892pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 09:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1PJ13D+KFCkNQkN2EIudaVpEqGNZODR++Sj1BPuo/ZE=;
        b=bHUxH4h7szTdb1IgkxMSHl1LpvDPXrw+WDyMWAPf7c3MB7w02xunVZWtUZCdADY4Hj
         d4D1Pu0lWUi+wPPmAy3uzD0euIaNsbCAPIz8+Cagp4fmYrOq0UhEk87VexH5DYwPKmAw
         /Pjdwsn1VaK9QJNhO0HysvG3+1jGwUqp8hNiu+oHH+A/Yx4ohJ/GUdBmu+TzZ8LH4ggx
         tUUbFCBVCMQPhKtP2uMS/a/VSRMvzKpB7bHmBGAj1zq3ru2OFCsSfI2MhGcHDlpOeQ25
         j5RTtLChMAGY9IKx/APGv0aBRW+NqAclwtjgFbkPAyYnEmHvjmSZG2qkQsndOH+MLqeC
         XYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1PJ13D+KFCkNQkN2EIudaVpEqGNZODR++Sj1BPuo/ZE=;
        b=ALgOExJtZ4bABsd1+tFe91q3H5bR5Qn4eXWe6/48GhnG1el0X9MCuWtyRZCl5Kkx1Y
         IWOoLDw0b8L+ZyiTq5HedrhOrAjT29oFdLSrfTq2AIyEbt6YGh5XmHLWX+Pw4v+CmFvv
         mL6UcRR31hl2bY8RrNhwrM1SQdBZ8jxRILbZlYmy54ETOE+wqJE4rohlgTfqzKMIujs1
         7ceftT6d8Kuar/WmmsS1vkFSI/BM0G1+szfCR1+La2SXrGVUSEAtMT+9WrkpqHK7IGNy
         MoGbSntmD42UQh1juYxhRqXR1U4EWm8ya++kaVGo796wVJzs0zDELfaR7iWw02mCS1hR
         ffzg==
X-Gm-Message-State: APjAAAXM8jO4QLSqEbjpnWfJSLQwrH+XxHg//+dMNN8sZomhGM1FO9fm
        QWSPEaRhGtl4UVrJo1iZ1cv85eCPLtZ2soL2XhlBJA==
X-Google-Smtp-Source: APXvYqzhSw66ss9J19Bjac2oaOFq/pDddpDORRAOnLXq4ahSX0R0wKp+qgDirMl7EaPEK0XTjarlevURK39Dyda2jqo=
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr7931281plp.252.1578936878099;
 Mon, 13 Jan 2020 09:34:38 -0800 (PST)
MIME-Version: 1.0
References: <CAAeHK+z2+_UHNp4_D2iL9FzPtDoU1YBohCaDJG8sAy12uc_-ew@mail.gmail.com>
 <Pine.LNX.4.44L0.2001131049090.1502-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2001131049090.1502-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 13 Jan 2020 18:34:27 +0100
Message-ID: <CAAeHK+x9Gk3cD77MA9jkhpwO8S62i6KT7PP3NZ6QTZ2qk2FB6w@mail.gmail.com>
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

On Mon, Jan 13, 2020 at 5:50 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 13 Jan 2020, Andrey Konovalov wrote:
>
> > I've also found an issue, but I'm not sure if that is the bug in Raw
> > Gadget, or in the gadget layer (in the former case I'll add this fix
> > to v5 as well). What I believe I'm seeing is
> > __fput()->usb_gadget_unregister_driver()->usb_gadget_remove_driver()->gadget_unbind()
> > racing with dummy_timer()->gadget_setup(). In my case it results in
> > gadget_unbind() doing set_gadget_data(gadget, NULL), and then
> > gadget_setup() dereferencing get_gadget_data(gadget).
> >
> > Alan, does it look possible for those two functions to race? Should
> > this be prevented by the gadget layer, or should I use some kind of
> > locking in my gadget driver to prevent this?
>
> In your situation this race shouldn't happen, because before
> udc->driver->unbind() is invoked we call usb_gadget_disconnect().  If
> that routine succeeds -- which it always does under dummy-hcd -- then
> there can't be any more setup callbacks, because find_endpoint() will
> always return NULL (the is_active() test fails; see the various
> set_link_state* routines).  So I don't see how you could have ended up
> with the race you describe.

I've managed to reproduce the race by adding an mdelay() into the
beginning of the setup() callback. AFAIU what happens is setup() gets
called (and waits on the mdelay()), then unbind() comes in and does
set_gadget_data(NULL), and then setup() proceeds, gets NULL through
get_gadget_data() and crashes on null-ptr-deref. I've got the same
crash a few times after many days of fuzzing, so I assume it can
happen without the mdelay() as well.

> However, a real UDC might not be able to perform a disconnect under
> software control.  In that case usb_gadget_disconnect() would not
> change the pullup state, and there would be a real possibility of a
> setup callback racing with an unbind callback.  This seems like a
> genuine problem and I can't think of a solution offhand.
>
> What we would need is a way to tell the UDC driver to stop invoking
> gadget callbacks, _before_ the UDC driver's stop callback gets called.
> Maybe this should be merged into the pullup callback somehow.
>
> Alan Stern
>
