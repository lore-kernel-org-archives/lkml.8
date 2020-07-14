Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B7CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6988921897
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULwKSSLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgGNI2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgGNI2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:28:01 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92537C061755;
        Tue, 14 Jul 2020 01:28:01 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so7304016pgf.0;
        Tue, 14 Jul 2020 01:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFASHkwcTOcp5xJmcZ6cr6YyCkNb4rp9EMZoB3APeEs=;
        b=ULwKSSLYkH+bjGYv5JxlkMvcFS4rwLeo8EWsF8xUFQDq33RBMR3P4tXOWkrtgiOSwn
         yXU3tTBk9X6raRX/hmHLwrPivEbgy4Aw2IFqE6C0HhH8ZswZh4FcMatEgN2aPTU5r21B
         A7xq0B+hteJs5aqnD3We1qYIfLfyg7sgIb+ZOQXH9VXaFuj1nhLpLQmRFHIczqQ2v26v
         P/LpX/7D8fRyBXbw8ORi0JWRehF6tUh4zp9nJMrKfXuV5WH3mCBtVt83Bk/Dvy8bhWn6
         rfeezApSCQVKzQW18J+E1/JReIdJzotb61bOHY0biXkpeWPJjQNk/R4mNxppiQnxiSiW
         /Okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFASHkwcTOcp5xJmcZ6cr6YyCkNb4rp9EMZoB3APeEs=;
        b=Bmy1cEPX+uB9goPyYPDD/QNXS6uemt3It0L49ufrbswrW/CtnpRympdq8pdAw+m/ER
         mX0B5sRNZfK/gjM2xOX7HivydM0Cg9falJf6CZT/RAEfTxuFliKqXpYdfY0l/7W6rL19
         97XII1cE0wbyrHRPQFTJuwxLDMBWH7c5OSQ4RzfDU+JjosjBXZDo8sChEOxEJxEudWde
         eM5C9rOBOGkQdDm8WMI8s35Q9vLOzyCsypkiSwZ3YIMaCaQz9pmvia/cg8Y8w3a7snZN
         6r9RLFa4BFMRUptbbxTyuvKwJXigeom+PnC9LuSlygOylpv0kfEXfjOSO6ltRtqjvRAA
         bEIA==
X-Gm-Message-State: AOAM531A136IBLVwLEc2OVNbRGIeROUoLDng2saLe2MdrmQPfJhgLiWg
        /o9rw5hqygVQfvwXUguKEly3LxOYokDQnzFWVsQ=
X-Google-Smtp-Source: ABdhPJy1EYtUDBT/tte1IBbm2WCblUvd+mmLWT5JgnWMWmxUN4zvKXGVtrhbtl66aUckEFjZ0g/VeOlVNdEJb1zRQO0=
X-Received: by 2002:a63:924b:: with SMTP id s11mr2506093pgn.74.1594715281116;
 Tue, 14 Jul 2020 01:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200714081510.6070-1-hdegoede@redhat.com> <CAHp75Vd6uGNw5m3-Tc1tkABLT_Wi7CtW2yo8+B5TpYV4U8XE9A@mail.gmail.com>
In-Reply-To: <CAHp75Vd6uGNw5m3-Tc1tkABLT_Wi7CtW2yo8+B5TpYV4U8XE9A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jul 2020 11:27:43 +0300
Message-ID: <CAHp75Ve9HF4WVkiUA77s9LsN6d8oaFPRgjLi86FnDSHgmVvTNA@mail.gmail.com>
Subject: Re: [PATCH 5.8 regression fix] platform/x86: thinkpad_acpi: Revert:
 Use strndup_user() in dispatch_proc_write()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:21 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jul 14, 2020 at 11:15 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Commit 35d13c7a0512 ("platform/x86: thinkpad_acpi: Use strndup_user()
> > in dispatch_proc_write()") cleaned up dispatch_proc_write() by replacing
> > the code to copy the passed in data from userspae with strndup_user().
>
> user space
>
> > But strndup_user() expects a 0 terminated input buffer and the buffer
> > passed to dispatch_proc_write() is NOT 0 terminated.

Second though, perhaps it's a simple wrong count parameter?
strndup_user(..., min(count, PAGE_SIZE)) or so would work?

> > So this change leads to strndup_user() copying some extra random bytes
> > from userspace till it hits a 0 byte.
> >
> > This commit reverts the change to use strndup_user() fixing the
> > buffer being passed to the ibm_struct.write() call back containing extra
> > junk at the end.
>
> Can we simply use memdup_user()?
> And thanks for catching this up!



-- 
With Best Regards,
Andy Shevchenko
