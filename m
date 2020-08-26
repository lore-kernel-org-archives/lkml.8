Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756D0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D882075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9xvvuXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgHZQO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgHZQOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:14:23 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13586C061574;
        Wed, 26 Aug 2020 09:14:23 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t11so1116193plr.5;
        Wed, 26 Aug 2020 09:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t3DkmFYSh/PNi/jL2jKO8hC9605cQHihPLJZWMDyQs8=;
        b=n9xvvuXc029BaP+m2A9caFLFih9mwolooVPqJOvtbDN7lKiKTu5bM+QxK19FN0n4ot
         nIod6NdUhgAQ5nAv8sDGJNKAh97ezPxFx4chqfFxn/xsbOQntkqZh9o7w2LV5e99Z6ze
         bJN3bxEYJa6X5YRJp3KCSKa+Ph8TQGBqIAXm11gs0E1alvW996JTimLnGYWac98Xfl1y
         CEmHGHUj6xT+ZX1mjuftomrSJV1j04f+8rf96Y0lVfnoajVLZs7tYQdL6jkhcvAZvhwG
         x7utydffMXP0GUfqT4Mx4O8HPc/pN3y7QybqQO//crkZuAFo3dHQrhIn2W23fSho0eGV
         Y/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t3DkmFYSh/PNi/jL2jKO8hC9605cQHihPLJZWMDyQs8=;
        b=Wq15kFSRel3Esh1ff0tDmyFuRIISsB6gSQrfdR4tJcyNSOlBkZyx/rF+clSgb4mNwT
         PeV9tBsdHN6ouh+Tt4D4jkd3g5X/u7BwK2kVM+faTSO5CV6vmgHunAIJAFJQvznIof91
         qh9+fcnvTCeXKKR2ZQg6ISzx9T41v4abjRwAgE1i7y7hOzXXxzx90kiWPJRMzSEX/Cy4
         fwF9RMHa0UbzLXZJWazMvWoYhS8vn9jzqR7oWsQWldlGTgLFCOSrTlAL+IV8JAGPWluf
         E8HYb9OE5BEIbqmT4CO5eV35wVtEGbrrVnf37PINkhc5+rOGFXHEQewN2HSaTOU3DNhT
         x5WQ==
X-Gm-Message-State: AOAM5323sntNiUoXSZT/cbNnQIbS9yCaho6jbTzk/Ix9DDg9VPpDoApt
        y89MmSu2Nr//2WcVsH+du7CZ1vvmFBMuYO6RZr4=
X-Google-Smtp-Source: ABdhPJwyExZmfsgFER45Qg3uptOtSogRTxWmZy68kCNcJSRvRkZ6+OM5lmlQaJe6ru+xODum0001mHLA3nrCZXU60qo=
X-Received: by 2002:a17:90a:2c06:: with SMTP id m6mr6893582pjd.129.1598458462429;
 Wed, 26 Aug 2020 09:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200826134315.GA3882506@kroah.com> <CGME20200826150239eucas1p24c59716cc31edfeb2eece84d97936b93@eucas1p2.samsung.com>
 <1425ab4f-ef7e-97d9-238f-0328ab51eb35@samsung.com> <20200826153347.GB4187816@kroah.com>
 <202008260856.5DAEFCEFF@keescook>
In-Reply-To: <202008260856.5DAEFCEFF@keescook>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Aug 2020 19:14:05 +0300
Message-ID: <CAHp75VcyswCWJOV+aMx3rnWwN+3r9HaLvwXCYUJQfo4CHsLowQ@mail.gmail.com>
Subject: Re: [GIT PULL] USB fixes for 5.9-rc3
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Brooke Basile <brookebasile@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 7:00 PM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Aug 26, 2020 at 05:33:47PM +0200, Greg KH wrote:
> > On Wed, Aug 26, 2020 at 05:02:38PM +0200, Marek Szyprowski wrote:
> > > On 26.08.2020 15:43, Greg KH wrote:

...

> > Why is slub.c erroring?  How is this related to freeing memory?
>
> I assume this is related to the size calculations in the VLA macros...
> nothing _looks_ wrong with that patch, but obviously something is. :)
> Hmmm

What about the idea I have shared above? (summary: different scope of
two offset variables, and thus outer one is always 0)


-- 
With Best Regards,
Andy Shevchenko
