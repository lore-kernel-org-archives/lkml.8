Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF04C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4662F206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391079AbgDCRXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:23:45 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38527 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgDCRXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:23:45 -0400
Received: by mail-vs1-f68.google.com with SMTP id x206so5441457vsx.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 10:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VaG0J6TcwrQRrhJdGp1aQjEpbn+t6z6Op/0x/M/OrqA=;
        b=aVlY7Mp8ZvkdpnhkTObjLgPLKdBh3ynJUa6uMna5HR/OVy7kFn+u3FiKcVTOBpsNz8
         uVCuyAt3rBkcuQLWF9/R/0pwuIB/E9LxnuovjAAxpyGcO1fJiexwp9W01Xsahtf/fo2h
         ccz/peWhY8iXeL/VCsmcUuvp9V86HKt0pw7rdL4XXEFKlJYrBctNXp+YfSNT3VHwKLm1
         EOtHJT//xAMhXbUzXe56iWL5I2qrE2pfFSPvhby6WN8mxHTBIYNDPv+zht9ytl8X74JW
         ANBF3k7iAFaOLcHcB5GOU9LR+xkDVXMTuUB/+U2y5CK+S0AYCc2MpDrGVrlXKM58Seex
         29LQ==
X-Gm-Message-State: AGi0PuZ8NTDeOdgs4SOI06jYRWqKPFr+emSEoVqyNgu9TVr+X4sMhkzq
        srJa/Xko6LvIspIIiEd+GjE2oRv6RlQETxLzuE4=
X-Google-Smtp-Source: APiQypI9/APBBqT5TAeFzEsrAZKxbGJSqx02OnCkRE/9/KLWU5Y9hGOKTVl6IWDGfcFXW7oecrPRZ9rjxMg+lEqArIY=
X-Received: by 2002:a67:f754:: with SMTP id w20mr7082757vso.220.1585934623824;
 Fri, 03 Apr 2020 10:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAOkhzLWMB8rr0x4KKfqruCcTLVq4dH6nZ365auMqA1arZ57J7g@mail.gmail.com>
 <CAOkhzLVvmoB0TgS4bioP4PnxwmnT_+h0LbCya2=KkcHu1UT_Zw@mail.gmail.com>
 <CAKb7UvgLr2A88jbx9Zvi3SjXoKbk4iZEg7LNQ4aL3VZhKVQu3A@mail.gmail.com> <CAOkhzLU+buL3J3XUbzC6JUAfbnMR-27qwS3Vm7ofrAPPCipXuw@mail.gmail.com>
In-Reply-To: <CAOkhzLU+buL3J3XUbzC6JUAfbnMR-27qwS3Vm7ofrAPPCipXuw@mail.gmail.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Fri, 3 Apr 2020 13:23:32 -0400
Message-ID: <CAKb7UvhvBG49P7t6XD==26q70YywmhUHvP=hW=wj8mT6V0gpHA@mail.gmail.com>
Subject: Re: acr: failed to load firmware with Kernel 5.6. Kernel 5.5 works
 just fine.
To:     Zeno Davatz <zdavatz@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 1:21 PM Zeno Davatz <zdavatz@gmail.com> wrote:
>
> On Fri, Apr 3, 2020 at 6:59 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> >
> > Ben -- probably the ACR changes in 5.6 don't fall back nicely anymore
> > when there's no firmware? The load shouldn't be failed, just GR
> > disabled...
> >
> > Zeno -- if you grab linux-firmware, it should be all better. Not sure
> > if you're missing it on purpose or by accident.
>
> Thank you, Ilia
>
> I will try that on my Gentoo/Funtoo machine now. So far linux-firmware
> was not needed with Kernel 5.5, so it was not installed on my machine.

It was needed on 5.5 as well. It's just that it fell back gracefully
without firmware, and you didn't get any acceleration features.

Cheers,

  -ilia
