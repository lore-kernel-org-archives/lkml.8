Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513CCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3A02073E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zhnvic0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390255AbgF2VEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389982AbgF2VEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:04:07 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97426C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:04:06 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id u6so3016619uau.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDDadDrSXYKtXL/TsWS5vlQswAboTcT6W+3/Oif1F20=;
        b=Zhnvic0KQUbDVX5LSFm3hAeLEERhKCRPhYViT3hL3yJyva8CW+btVllsX8lmru+EeN
         mvetgyKknHBgMwldDe67snB8PwHBZBQDGudwVnaGCiiwsZng5RVqjW+9G7Ul26gvfXoZ
         55TX9gVBEka/btSKGV2IxuxB22BeiWRHiweFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDDadDrSXYKtXL/TsWS5vlQswAboTcT6W+3/Oif1F20=;
        b=cy0Y6CzEXEj1R3uEeE/p7zpOC/4L/XgpMrx7+w36Mc2z2Plzhm0tl1p6bLezEIeXPS
         m5RLiCufAZgcfp2VbXSSaB0zxfFFephLu76G6wqMupKQbjMtzoyuQqmKnwu7xtfKG4z9
         x+8RM255Re/p7QmrcwWYRC9aP8BSoJFhaSoYq+w7uPNLxO026rA6ki/rCQTLuzKdIG0+
         azoGCXqEfXFvRmHLtAPOCDKGMt5hKCT96uvSvtLOCwNTWO0fH8fY3ZFqB1+FRIrrQdjF
         R+NUKOR4zMrBuV8CqvJpFcMwym/jPJVqaz77iQGHfPsa4ZRx/fY/Ihsswn+RDfGXII7V
         s7mQ==
X-Gm-Message-State: AOAM531IgS9krZm+1vvZND7X5+x188d0RJSH5FDqCIF9kcAnWOlsxuKC
        Uu9SMVWwhv+cxylAWrVgXCpBo1cKs6g=
X-Google-Smtp-Source: ABdhPJznfXDEUKe9puzsUOyOmE/k/240+M6m+Wm2F6tJg5KidSREAYk8sXZp6E1jpYnD5jXE83AktQ==
X-Received: by 2002:ab0:217:: with SMTP id 23mr12435567uas.51.1593464645510;
        Mon, 29 Jun 2020 14:04:05 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id v141sm148622vkd.9.2020.06.29.14.04.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 14:04:04 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id y3so3764701vkg.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:04:04 -0700 (PDT)
X-Received: by 2002:a1f:280c:: with SMTP id o12mr11043341vko.92.1593464644374;
 Mon, 29 Jun 2020 14:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200629171529.558003-1-daniel.thompson@linaro.org>
In-Reply-To: <20200629171529.558003-1-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Jun 2020 14:03:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W9rdEsO1jP-kg6OetXmZO+kC9LenZM=CdxjUvv8BEU4g@mail.gmail.com>
Message-ID: <CAD=FV=W9rdEsO1jP-kg6OetXmZO+kC9LenZM=CdxjUvv8BEU4g@mail.gmail.com>
Subject: Re: [PATCH] kgdb: Resolve races during kgdb_io_register/unregister_module
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 29, 2020 at 10:15 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently kgdb_register_callbacks() and kgdb_unregister_callbacks()
> are called outside the scope of the kgdb_registration_lock. This
> allows them to race with each other. This could do all sorts of crazy
> things up to and including dbg_io_ops becoming NULL partway through the
> execution of the kgdb trap handler (which isn't allowed and would be
> fatal).
>
> Fix this by bringing the trap handler setup and teardown into the scope
> of the registration lock.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/debug_core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 9e5934780f41..9799f2c6dc94 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -1117,9 +1117,8 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
>
>         dbg_io_ops = new_dbg_io_ops;
>
> -       spin_unlock(&kgdb_registration_lock);
> -
>         if (old_dbg_io_ops) {
> +               spin_unlock(&kgdb_registration_lock);
>                 old_dbg_io_ops->deinit();
>                 return 0;
>         }
> @@ -1129,6 +1128,8 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
>         /* Arm KGDB now. */
>         kgdb_register_callbacks();
>
> +       spin_unlock(&kgdb_registration_lock);

From looking at code paths, I think this is illegal, isn't it?  You're
now calling kgdb_register_callbacks() while holding a spinlock, but:

kgdb_register_callbacks()
-> register_console()
--> console_lock()
---> might_sleep()
----> <boom!>


I'm a little curious about the exact race we're trying to solve.
Calling unregister on an IO module before register even finished seems
like an error on the caller, so I guess it would be calling register
from a 2nd thread for a different IO module while the first thread was
partway through unregistering?  Even that seems awfully sketchy since
you're risking registering a 2nd IO ops while the first is still there
and that's illegal enough that we do a pr_err() for it (though we
don't crash), but let's say we're trying to solve that one.

Looking at it closely, I _think_ the only race in this case is if the
one we're trying to unregister had a deinit() function and we going to
replace it?  If it didn't have a deinit function:

cpu1 (unregister)                 cpu2 (register):
-----------------                 ----------------------
kgdb_unregister_callbacks()
                                  spin_lock() <got>
spin_lock() <blocked>
                                  if (old_dbg_io_ops) <true>
                                    if (has dinit) <false>
                                      print error
                                      spin_unlock()
                                      return -EBUSY
<finish unregister>

The above is fine and is the same thing that would happen if the
whole register function ran before the unregister even started, right?

Also: if the unregister won the race that should also be fine.

So really the problem is this:

cpu1 (unregister)                 cpu2 (register):
-----------------                 ----------------------
kgdb_unregister_callbacks()
                                  spin_lock() <got>
spin_lock() <blocked>
                                  if (old_dbg_io_ops) <true>
                                    if (has dinit) <true>
                                      print Replacing
                                  init new IO ops
                                  spin_unlock()
                                  if (old_dbg_io_ops) <true>
                                    finish deinit of old
                                    return true
WARN_ON() <hits and shouts!>
dbg_io_ops = NULL
spin_unlock()
if (deinit) <true>
  double-call to deinit of old

So in this case we'll hit a WARN_ON(), incorrectly unregister the new
IO ops, and call deinit twice.

-Doug
