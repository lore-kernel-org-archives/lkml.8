Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8A1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 19:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C32207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 19:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Byh29kc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgHTTjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 15:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgHTTjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 15:39:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203D7C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 12:39:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so1638539pgf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wXIlJgCi0Hc+qjW3EmvatA+4YXMKzONFgX9ZK9vfGVU=;
        b=Byh29kc4cV3ARFPI/Wlk0/U6LwFlY3do928FTIcxGaxbCcgFUm40Fzo6EZmoH3jf45
         +KHAV91KvPEzkBIC7pCOmnlKjPlO9OUxadtclYKUsLIjezrJ5oPyqd+OsJBpn6tvS2gD
         VCLQnLIrRJqQajFge2GUlSju3XU+/A55+NmWf00MIxOvw0bxwSdj3zAI5bL5tGNznh6z
         VHQsBRta/AHkcLLRJV/d9fgZ7ctTUA7xvEWhJGEkw/i6rv0IFX6M62y1ovizLidR9Ypg
         IGYdP77Gjil0K1X56UqtZ8ROL3LlqTumNtyDnnHVrIJ5Clw03mIbYH0jxLXG63DW8k/5
         alKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wXIlJgCi0Hc+qjW3EmvatA+4YXMKzONFgX9ZK9vfGVU=;
        b=SPHwjckkkJ4LrGmFL5RS8Yiiu4M5LKzYdg4T4dmTzA8LXgj+1uIZYu7xhXk/m410cs
         2l649CMfzfzvfKtjDkK9Zd/HKSsO0I1jeB6SCQgiNVwglI1g7WAd4Uqf5BVS33FHnloi
         HuCHJa/WZjO9xGxlayeFN5FhJONt+Lrb3emQjEeqR8omQNafHEpMe+McCtUxJv+MQ0GV
         KQx1EaN2wgMXOF4zKoQF6K5knYyM/abyBZNiY9DLN7ze8dgb8ejsemx07xCPi7NnQsMH
         X9sjDbo/aPrGU9m7YEj0UzpBSTvhSYaTXrGvHqRZFmpXoCx9AHYJVj6ANgkkk1ztPRn4
         sQmg==
X-Gm-Message-State: AOAM5327EoknjEJu8XOmCmmTWo/v4OZtjT7aFPqOshbuQnECWBo3NF5K
        80y/Fa1cFh+Rdb/vLN+J0JVE7NbERcszzaTioOeBaOce+qI=
X-Google-Smtp-Source: ABdhPJym/FbUKNACd+sG+GCzf3AR9j9nUiLJQxeLO2wEIc43GF74XHG+gaLLRAbnKyQMsx9vmJyOQlV2oIBMWjeQigQ=
X-Received: by 2002:a63:fa09:: with SMTP id y9mr271539pgh.0.1597952383386;
 Thu, 20 Aug 2020 12:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200819161907.1155110-1-enric.balletbo@collabora.com>
 <C9E59107-CE83-4554-9447-5DE5BEE09A3B@fw-web.de> <CAGETcx9_A-E5b-JxT2G142mGxqoo8xqFNEgT+CNWt=oOv0Z5+w@mail.gmail.com>
 <a23bac35d20eb002bdfb5263bf5dd213@kernel.org> <CAGETcx-NpRzzeXYN-UBP1eAsC3s_AofSQ9rXOEmCjhLhKLnxWg@mail.gmail.com>
 <14b8f4b9667d29ee25e25eb19c69e3f7@kernel.org>
In-Reply-To: <14b8f4b9667d29ee25e25eb19c69e3f7@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 20 Aug 2020 12:39:07 -0700
Message-ID: <CAGETcx9TB9HNd3WKwQ=p8VYy1-gLYqpGCtvk9QsdG1fvprROYQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "irqchip/mtk-sysirq: Convert to a platform driver"
To:     Marc Zyngier <maz@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Frank Wunderlich <wichtig@fw-web.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 7:53 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-08-20 09:07, Saravana Kannan wrote:
> > On Thu, Aug 20, 2020 at 12:56 AM Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On 2020-08-19 19:51, Saravana Kannan wrote:
> >> > On Wed, Aug 19, 2020 at 9:52 AM Frank Wunderlich <wichtig@fw-web.de>
> >> > wrote:
> >> >>
> >> >> hi,
> >> >>
> >> >> does the fix you've linked to my revert [1] not work in your case?
> >> >>
> >> >> [1] https://patchwork.kernel.org/patch/11718481/
> >> >
> >> > Thanks for pointing it out Frank. Also, might want to avoid top
> >> > posting in the future.
> >> >
> >> > Enric, Can you please try that other fix and see if that solves your
> >> > issue?
> >>
> >> I think Enric was clear that the driver does probe correctly
> >> (meaning that he has the fix in his tree). It is everything else
> >> that breaks, because none of the drivers on the platform are
> >> equipped to defer their own probing.
> >>
> >> I think we need to change this works right now, meaning that we can't
> >> blindly change the behaviour of *built-in* drivers. I'll see if I can
> >> come up with something quickly, but I'll otherwise take Enric patch.
> >
> > Sounds fair Marc.
> >
> > Btw, Enric, out of curiosity, can you try adding "fw_devlink=on" to
> > your kernel command line to see if it helps? It basically ensures
> > proper probe ordering without depending on the drivers. There are some
> > corner cases where it still can't work properly (too much to explain
> > for a late night email), but if the platforms don't have those corner
> > cases it'll work perfectly.
> >
> > I'm fine with the revert if Marc isn't able to find a quick fix to the
> > drivers, but this might also fix your problem right away.
>
> I'm afraid there is no quick fix if we want to preserve the current
> behavior with built-in drivers,

> and not having "fw_devlink=on" by
> default makes it irrelevant for most people.

Agreed.

> fw_devlink also prevents my test platforms from booting (my rk3399
> doesn't find its PCI devices with it), while the same kernel boots
> just fine without it. It could well be that the corner case is
> likely to be more prevalent than you seem to expect.

Yeah, I know it has a few corner cases I need to deal with.

> I will probably end-up end-up queuing reverts for both mtk-sysirq,
> mtk-cirq, and qcom-pdc (the first two can't be built as module with
> mainline anyway, and I seem to remember that the latter caused some
> controversy as well).
>
> As an experiment, I have pushed out a branch[1] that implements
> a "hybrid" probe, retaining the previous early probe mechanism when
> the driver is built-in, and letting things rip when built as a
> module (if you do that, you hopefully know what you are doing).
> I'd welcome some testing on affected platforms (I don't have
> anything I can run mainline on that'd be affected).

I like [1] and the code looks good. Hopefully, we can stick with that.

-Saravana
