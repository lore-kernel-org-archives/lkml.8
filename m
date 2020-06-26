Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A0AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 434B620885
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgFZUxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:53:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44751 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZUxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:53:22 -0400
Received: by mail-ot1-f68.google.com with SMTP id 5so7854205oty.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/jpiOSxIPklmjV4crA6Cpt6MrjawRGqijNcJ3ByhUI=;
        b=Ga+tQo0VYCO9JVzAALQ7Wic4l4/4D+BEu/gjT2CvS/MszbNj6Z41Y3PY91Ye37yOhk
         futXHa2tu4EuzE2w6osdSwDkVfz2JJRykzkSRBFN7OCRks0QTjVfSgW7IsDJWOQONaMv
         xzCoQ/XL2ZgKAIpvp7PLl2pcfaUJRDoEFhVk98ryQRU6L4I5S3v1sTwEy9ityF3C7Ri2
         7/Un725HiDsnzEJW49B6v61MFxRwTt1BdIYLS1hMRr/kIeO4GcfTedKRLYZv858rqTqg
         ueMA7cTekX8tEQpeoG9QuHZU5GJ93aQnx1ixgMBRVE1dsCYRUg0i+BYKlKu9awtKtHZL
         WetA==
X-Gm-Message-State: AOAM533tg8801TY4kU3KtnSUHmnNf76lM2SZxzuuyuZ46S8xV/SROSSt
        3LJKETEqQtZaw0acRcHycX+h3yavnqxrTfMb9LY=
X-Google-Smtp-Source: ABdhPJxgf+K2uCb1qGp7EwCs1G9m4R+EUQ+gENzqCPiDw7cHoxTSYkd2WtpLgxwXnI0f7PoXH5iIGyJGrjjLJirJx94=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr3761957otb.107.1593204801432;
 Fri, 26 Jun 2020 13:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200625032430.152447-1-saravanak@google.com> <CAJZ5v0h1JHLK2PA45ZfNBeQrRoH+UkEi6-vRR-=HLz7AAnC1vA@mail.gmail.com>
 <CAGETcx8AQPZ92vKKwq6-U8fbToCWtHvu4OT4hXzOGiCUst15fw@mail.gmail.com>
 <CAJZ5v0i=riYAA1wnuDBhBLfWQiGnaRW8fxkCU5X-3=noqSEhrQ@mail.gmail.com>
 <CAGETcx8J5fs42_HMVyYvbX1=gqGTnavEuDOH+LHprZYRbXvUzw@mail.gmail.com>
 <CAJZ5v0i-ySdNmToh=ExT9H_88bhHVeUNfTNWxXG1SzaP8a5j-w@mail.gmail.com>
 <CAGETcx9iLH8fBEA0a9=iPsObzaePg9Zj0A9T_7NSKH6KSq3vFg@mail.gmail.com>
 <CAJZ5v0iONFBX00NqzUaZ9kNWr6yLBNtLnA+sF-Ge-QNtY9qSug@mail.gmail.com>
 <CAGETcx-YqJDnc6fNu5dncc=DSHwS_=-uOMHvR8V=b-QQJ7HOcA@mail.gmail.com>
 <CAJZ5v0ju58LxvRckv2T=H0D=aDooGUoGfqFze5zWQ1ARAAJcag@mail.gmail.com> <CAGETcx8KknvzZxfW4o=siswB__c9yeh=1wOVyvtM2112WEBizQ@mail.gmail.com>
In-Reply-To: <CAGETcx8KknvzZxfW4o=siswB__c9yeh=1wOVyvtM2112WEBizQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 26 Jun 2020 22:53:09 +0200
Message-ID: <CAMuHMdXbzXnWQSaQ44p-cL9TA=ng20UB=vjscRDjpf7N=S4fjg@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix suspend/resume order issue with
 deferred probe
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Fri, Jun 26, 2020 at 10:34 PM Saravana Kannan <saravanak@google.com> wrote:
> On Fri, Jun 26, 2020 at 4:27 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Thu, Jun 25, 2020 at 7:52 PM Saravana Kannan <saravanak@google.com> wrote:
> > > On Thu, Jun 25, 2020 at 10:47 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > Note that deferred probing gets in the way here and so the problem is
> > > > related to it.
> > >
> > > I mean, we officially support deferred probing. Shouldn't we fix it so
> > > that it doesn't break suspend/resume?
> >
> > Yes, we should fix deferred probing.

Please take into account that breakage is an actual regression.

> > > Also, it's pretty easy to have
> > > cases where one module probes multiple device instances and loading it
> > > in one order would break dpm_list order for one device and loading it
> > > in another order would break it for another device. And there would be
> > > no "proper" order to load modules (because module order != device
> > > order).
> >
> > I'm not saying that the current code is perfect.  I'm saying that the
> > fix as proposed adds too much cost for everybody who may not care IMO.
>
> Ok, how about I don't do this reordering until we see the first
> deferred probe request? Will that work for you? In that case, systems
> with no deferred probing will not incur any reordering cost. Or if
> reordering starts only towards the end, all the previous probes won't
> incur reordering cost.

That first deferred probe request is more or less as of the first probe,
since commit 93d2e4322aa74c1a ("of: platform: Batch fwnode parsing when
adding all top level devices"), at least on DT systems.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
