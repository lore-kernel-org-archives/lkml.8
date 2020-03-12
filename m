Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFACC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B570206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584029293;
	bh=ihv6hg/tKn1K/Ay/TkjzJkw+/FlX30ltPT/FPEEZvVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oDMinbNg4XKmRAKFVgUFJ5bAE2zd7NJOgOEjcnPJ9I5etkpZpg0BablP+IqDRh81C
	 5ihWFgENBPdc2x2AS4Of0oEEL7oc4BhdssHhxZ36v90vrKFKY+8pGm5qyXlFcYi9lz
	 GZt6v4UNpc8e6ZcqMX4Gs1CeolkY7Y/Tcbt5uj64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgCLQIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:08:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34925 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbgCLQIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:08:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id u12so7104944ljo.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 09:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2DKQlgbyOC9/p2tyJFfgudLvzI9KBST86uO21FB/HE=;
        b=gxaOeubgWCfcszroEzizTLF7jfTrElVOLETtRnOv7nnrl5pq44iR+1BpgLFx8gW0Xv
         ojpHVDgI5DzYKuBO4SuFbfiMaNHO8D2gcN75Yc1b6BHtKJsg+GSUTgv18HCqyhGAWYGL
         p0tUzHPHALi4izP3Bzi09sccOCHHZV8F1gpG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2DKQlgbyOC9/p2tyJFfgudLvzI9KBST86uO21FB/HE=;
        b=sc0tA4dsTclNQvlA7Bukl9SCtoCDKNhAv80g5zRJzJo+JfRgY6o8s5gUfIizDt9IrB
         y2kk8sPCDDVbSUrWFto4nae18zy2UKpXF+urainLh7q3CWgJZbBaFkLbRytRkMzlGUly
         6rwee7+v9ICH3aTe6jTxdI6qmnGbqR0RKwOW+FEhW7DftsMg42rwX/xdWc0/PpY8dWHY
         UQo7DmasHEI2kCiIxxTCxjS6FBZ+Jy1nJeYvCv+4TfUD3DjtnRUsyPqzYqGQipdL+k3V
         Ip0X1i09cstB/rd5yEH3Bfx5mjwn3k4Sbdcnt3PYLKOtF29nCxOanHrx4bY4fXW6AILi
         k+Hg==
X-Gm-Message-State: ANhLgQ2BD3DBqW1n2W0pQs5kiIlnqXzOhLPlKGFo8FFVCxp3bS6qAic5
        4uE8UvB2jCdDa9hrCL1ZCtUYVeT0pC4=
X-Google-Smtp-Source: ADFU+vs51/mqu45EN2NuBauKK+r0cz7c4aG+3aataWy6FG+tJvRTl/7Cl/7e/q3dvD755kWSxcUPvQ==
X-Received: by 2002:a2e:b801:: with SMTP id u1mr5646304ljo.188.1584029287677;
        Thu, 12 Mar 2020 09:08:07 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id e9sm17850738ljp.24.2020.03.12.09.08.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 09:08:06 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id r7so7063177ljp.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 09:08:06 -0700 (PDT)
X-Received: by 2002:a05:651c:555:: with SMTP id q21mr5548601ljp.241.1584029285717;
 Thu, 12 Mar 2020 09:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200308140314.GQ5972@shao2-debian> <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org>
 <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com>
 <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org>
 <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org>
 <87blp5urwq.fsf@notabene.neil.brown.name> <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org>
 <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com> <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org>
 <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org>
 <878sk7vs8q.fsf@notabene.neil.brown.name> <c4ef31a663fbf7a3de349696e9f00f2f5c4ec89a.camel@kernel.org>
 <875zfbvrbm.fsf@notabene.neil.brown.name> <CAHk-=wg8N4fDRC3M21QJokoU+TQrdnv7HqoaFW-Z-ZT8z_Bi7Q@mail.gmail.com>
 <0066a9f150a55c13fcc750f6e657deae4ebdef97.camel@kernel.org>
 <CAHk-=whUgeZGcs5YAfZa07BYKNDCNO=xr4wT6JLATJTpX0bjGg@mail.gmail.com>
 <87v9nattul.fsf@notabene.neil.brown.name> <CAHk-=wiNoAk8v3GrbK3=q6KRBrhLrTafTmWmAo6-up6Ce9fp6A@mail.gmail.com>
 <87o8t2tc9s.fsf@notabene.neil.brown.name>
In-Reply-To: <87o8t2tc9s.fsf@notabene.neil.brown.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Mar 2020 09:07:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5jOYxjZSUNu_jdJ0zafRS66wcD-4H0vpQS=a14rS8jw@mail.gmail.com>
Message-ID: <CAHk-=wj5jOYxjZSUNu_jdJ0zafRS66wcD-4H0vpQS=a14rS8jw@mail.gmail.com>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6% regression
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 9:42 PM NeilBrown <neilb@suse.de> wrote:
>
> It seems that test_and_set_bit_lock() is the preferred way to handle
> flags when memory ordering is important

That looks better.

The _preferred_ way is actually the one I already posted: do a
"smp_store_release()" to store the flag (like a NULL pointer), and a
smp_load_acquire() to load it.

That's basically optimal on most architectures (all modern ones -
there are bad architectures from before people figured out that
release/acquire is better than separate memory barriers), not needing
any atomics and only minimal memory ordering.

I wonder if a special flags value (keeping it "unsigned int" to avoid
the issue Jeff pointed out) might be acceptable?

IOW, could we do just

        smp_store_release(&waiter->fl_flags, FL_RELEASED);

to say that we're done with the lock? Or do people still look at and
depend on the flag values at that point?

                Linus
