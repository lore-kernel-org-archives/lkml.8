Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49169C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25888206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A4dLEmZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgHYAil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYAij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:38:39 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8664C061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 17:38:39 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y8so5447651vsq.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 17:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y7P6WkRur/Wi1nF0hQV3VdSO9RWelS35A2+LFPlb/Uw=;
        b=A4dLEmZsScgkGVFoBW/ZD/K+W5FlpYsKMIOncqMhANo9TeioVu6heRzICP8VIjCOej
         X13V/SiFz0gPIZiIuNnsTArDIufgYzWQxLyhszvX/HQ2WdhufUrqfWBvFoXNfaPEFq9R
         AKm/U+0B9Cl9HksWRnDPx/i8nBlvVajpBfkp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7P6WkRur/Wi1nF0hQV3VdSO9RWelS35A2+LFPlb/Uw=;
        b=lHByfZ8mEbM1hw+O2pXhm3R+FGK8mlbSIK8CizVjzYq5IUmP+Kwcu5tMlJ/KNm0F/L
         v6aCsl2UOncvtS1lIPbBaXqEGhPZ2rRwQzsfc1zvufcJJI2M+LatHVzADeEO+duQVnzg
         DI4ieeEu+3i7VQ3aUl9jsZIQLNRzZeZP38xQXX1mdVFLB2T37Tl4vXzgShucAjlmlh4d
         e/oL5j6x50d99JAxbi2rqNhxfOgcEUlTWzTbuD7RKvUZEZeXSZ3nkMNAIJEIWhPn/nZt
         65iV0Nfy8u5xbJDQ+dYKoE5buEWUnbkjvDny070zXQFcw78Wy0KcPEz6R0tMqknZ+3pa
         wiNQ==
X-Gm-Message-State: AOAM5314ICrwNuonkRT4tUxkFVAtnZhE515lhdO34aT1Bz9teWeIE1el
        rydAA1rE+AjvRIiWSm3EcfFXFlYuFSN4f/9njE/BQw==
X-Google-Smtp-Source: ABdhPJyGrJQ3BTXk72neawiE/wop5TF/z06m1M/EvRmFPlgVpgNQcH1fZn4GuY31+fa2UfdmPKqLjnOVR07AkeRgA/g=
X-Received: by 2002:a67:bb06:: with SMTP id m6mr4308771vsn.54.1598315918860;
 Mon, 24 Aug 2020 17:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200824105852.v5.1.I4feb11d34ce7a0dd5ee2c3327fb5a1a9a646be30@changeid>
 <20200824093020.073ae8d8@oasis.local.home>
In-Reply-To: <20200824093020.073ae8d8@oasis.local.home>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 25 Aug 2020 08:38:27 +0800
Message-ID: <CANMq1KCQjX1632qyo5+8kv8TXNu_Onh4gz7oMx3rx79XQX2fqg@mail.gmail.com>
Subject: Re: [PATCH v5] kernel/trace: Add DISALLOW_TRACE_PRINTK make option
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Will Deacon <will@kernel.org>, Yue Hu <huyue2@yulong.com>,
        linux-kbuild@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 9:30 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 24 Aug 2020 10:59:13 +0800
> Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> > ---
> >

> > +ifeq ($(KBUILD_DISALLOW_TRACE_PRINTK),1)
> > +KBUILD_CFLAGS += -DDISALLOW_TRACE_PRINTK
> > +endif
> > +
> >  KBUILD_CFLAGS += $(DEBUG_CFLAGS)
> >  export DEBUG_CFLAGS
> >
>
>
> There's one more thing we need to do, is if you build without this option
> then build with it, you should trigger a full kernel rebuild.
> Otherwise, if you build without the option, then build with it, and it
> doesn't rebuild the tree, it wont catch anything.

This already works. I'll be honest, I'm not 100% sure why (and if
fully intentional)...

The CFLAGS end up in 3 generated assembly files:
# grep -R DISALLOW_TRACE_PRINTK * | grep -v ".cmd:"
arch/x86/kernel/asm-offsets.s:# -imultiarch x86_64-linux-gnu -D
__KERNEL__ -D DISALLOW_TRACE_PRINTK
kernel/bounds.s:# -imultiarch x86_64-linux-gnu -D __KERNEL__ -D
DISALLOW_TRACE_PRINTK
scripts/mod/devicetable-offsets.s:# -D DISALLOW_TRACE_PRINTK
(along with all *.cmd files)

and I suspect some/all of those force a complete kernel rebuild.

> -- Steve
