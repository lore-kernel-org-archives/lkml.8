Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E927BC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4C19207EA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jgOG3A76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgHaPMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgHaPM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:12:29 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2E6C061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:12:29 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id v20so2120163ual.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MkA7kkMZ28SM9aq6Oba8O8kVaNHfOTZlxqtGBVCQhrc=;
        b=jgOG3A76uagJjEXXUrgjaviRJXDyL5GPp/LE3dmC5pKG/zAdmf4V5gCOhr5ivUElnI
         X1SMWQyEUxlFSjx7OYK2dYZ5r6QEBc7mdzqWGKJZH4knTpXSGrjvnV9gXhi9GGxwrxn/
         pONqUFY418QiUIAXCy7S6jhIYDHmM4D0e9+Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MkA7kkMZ28SM9aq6Oba8O8kVaNHfOTZlxqtGBVCQhrc=;
        b=mr/FqvyF6XIt/bR72yu1XAQVHQeEkUz55wkdKZ/NIKgnUxPh7WGk0FCHDqMR3yA5cq
         rp5oc+xqecMGcXI+Ozmsu3tRQFj/+yBkfXEN4PfWZmXvANd/m0OBn+bAa1WgZUpkgpXN
         UScZH93bpJaHYreKV9yNfwk3xapRosIup6JO5jIR/ACG2qLmuDYtPLA37EQCWb9UXGGA
         X3QMzD8UwXEvrqiSlXTvZ1Fi0hHkHMQydusbUI7VpyCV7DBO2fHq7OESr0641ZJCZ+uL
         Pa32arENW99zAVYfu8ZTDYaaB3JbFXXVaOLrE6ci6nxN7Kg+pozGliOTVLUHr+kSIIBr
         ceng==
X-Gm-Message-State: AOAM53210iJwem70VVOt74zowMANxT9l9mq/Wy2bpb7Jag88LGW5cPI5
        B7eKvA7ijFdK8FPgB9xTsf0KS1thL8jDnQ==
X-Google-Smtp-Source: ABdhPJz0sH+RCv87qnycCTJ5K0LYHKl358mjsoOUO2501RYcxmaKskaAUdMXuOkX0qmbFHlmUndSqA==
X-Received: by 2002:ab0:638d:: with SMTP id y13mr1296417uao.101.1598886748318;
        Mon, 31 Aug 2020 08:12:28 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id a26sm1134460uaq.19.2020.08.31.08.12.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 08:12:27 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id n12so1371635vkk.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:12:26 -0700 (PDT)
X-Received: by 2002:a1f:f848:: with SMTP id w69mr1345108vkh.86.1598886745879;
 Mon, 31 Aug 2020 08:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <1598113021-4149-1-git-send-email-mkshah@codeaurora.org>
 <1598113021-4149-4-git-send-email-mkshah@codeaurora.org> <159835036999.334488.14725849347753031927@swboyd.mtv.corp.google.com>
 <874koqxv6t.fsf@nanos.tec.linutronix.de> <8763521f-b121-877a-1d59-5f969dd75e51@codeaurora.org>
 <87y2m1vhkm.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87y2m1vhkm.fsf@nanos.tec.linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 31 Aug 2020 08:12:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XXf3_tjqK14WdMuKygJptMTS+bKhH_ceiUE3wyYoCnxg@mail.gmail.com>
Message-ID: <CAD=FV=XXf3_tjqK14WdMuKygJptMTS+bKhH_ceiUE3wyYoCnxg@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] genirq/PM: Introduce IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND
 flag
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        LinusW <linus.walleij@linaro.org>, Marc Zyngier <maz@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Wed, Aug 26, 2020 at 3:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, Aug 26 2020 at 15:22, Maulik Shah wrote:
> > On 8/26/2020 3:08 AM, Thomas Gleixner wrote:
> >>> Where is the corresponding change to resume_irq()? Don't we need to
> >>> disable an irq if it was disabled on suspend and forcibly enabled here?
> >>>
> > I should have added comment explaining why i did not added.
> > I thought of having corresponding change to resume_irq() but i did not
> > kept intentionally since i didn't
> > observe any issue in my testing.
>
> That makes it correct in which way? Did not explode in my face is hardly
> proof of anything.
>
> > Actually the drivers which called (disable_irq() + enable_irq_wake()),
> > are invoking enable_irq()
> > in the resume path everytime. With the driver's call to enable_irq()
> > things are restoring back already.
>
> No, that's just wrong because you again create inconsistent state.
>
> > If above is not true in some corner case, then the IRQ handler of
> > driver won't get invoked, in such case, why even to wake up with such
> > IRQs in the first place, right?
>
> I don't care about the corner case. If the driver misses to do it is
> buggy in the first place. Silently papering over it is just mindless
> hackery.
>
> There are two reasonable choices here:
>
> 1) Do the symmetric thing
>
> 2) Let the drivers call a new function disable_wakeup_irq_for_suspend()
>    which marks the interrupt to be enabled from the core on suspend and
>    remove the enable call on the resume callback of the driver.
>
>    Then you don't need the resume part in the core and state still is
>    consistent.
>
> I'm leaning towards #2 because that makes a lot of sense.

IIUC, #2 requires that we change existing drivers that are currently
using disable_irq() + enable_irq_wake(), right?  Presumably, if we're
going to do #2, we should declare that what drivers used to do is now
considered illegal, right?  Perhaps we could detect that and throw a
warning so that they know that they need to change to use the new
disable_wakeup_irq_for_suspend() API.  Otherwise these drivers will
work fine on some systems (like they always have) but will fail in
weird corner cases for systems that are relying on drivers to call
disable_wakeup_irq_for_suspend().  That doesn't sound super great to
me...

...or, if doing the symmetric thing isn't too bad, we could do that?

-Doug
