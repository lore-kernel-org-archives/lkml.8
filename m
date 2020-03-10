Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD37C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A73E2051A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583879495;
	bh=tEuIyD+rULeJqoBS7AOB6GQLX+7U3/XRKzvQ9EQgC7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jW3Nz/RK7gt/YwiAU/9ufpjZx+vgvd3yYkwYexLBUz7MW61X1HI5p+kJGnSco3eF9
	 fe5YkXlIDXLeE05zWC7kd2k6pwPwzS6m7yRJ1Jyz0Sbr89/53dQlvkAx+SucU+tX44
	 vMnZs5HGTukjtoqd0K4K6oEJ+QtNJw9l/pPclvrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgCJWbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:31:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42546 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgCJWbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:31:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id t21so12313966lfe.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 15:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRzFDMWVFAVW4g21VSZ2BZmn8vOI4KiazeKxqVX5u1M=;
        b=U3r0UrKX6PpyZ4UFRD1frE5J1x+pHwGop7H4CtDm8VEhXvpGaQKTaPU7hqrv9eUVcg
         sBiNBF7mZoDTWUjiPW3TYHFgpIRzw9h0sFKsRtexWHe9y0tSObM4tGw+sRYYPqfdFqY7
         fQANRaStPwMQNZIfgu6bwlvlAR81omWYDfZks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRzFDMWVFAVW4g21VSZ2BZmn8vOI4KiazeKxqVX5u1M=;
        b=pqMsiy77+jNIDCCMlQa4kNOjNJLKFBPxT+ZBp0nhlbQ9f1j1qFh3ASZAVJzk81mX8w
         8Rgaq1BcYxybpwO15x1p1R7rF8FcF/cPk+EJeAJChOZQt/aZK6phsOWblCY9UNaNd713
         dzfM6B1eYegQOTWf/lMqOlBWSLdXN7PGVbOlckQzbxa/JQQ7zy7aPdUPiGNXWweRpAZt
         ylOjqjXVU2IqRJgCPu1+6Rm2/SY4EPyJN6ecTGu+H21a2BehQ4DqRj1mGZli85vua4BS
         RJg7z7cbIOoJOJVEmSaZwVfA2BQgi8IMdHbEJp89hfwm4jV8ThhrRxEmKkad+9Aoi2Ke
         p20w==
X-Gm-Message-State: ANhLgQ0fUn7oftyqtw0yDT8OvIybIG9Y1j7MuWpDnSkU5h7HzcqtN02F
        a4TJ04NeVRD5u+v8GH2DduvCiuXGRBw=
X-Google-Smtp-Source: ADFU+vtEHR6Fh0sVzKvwzFQkRlLJZdCqo622QRGvchQOxjEDTVL58+PKDgShURXKZ7sl0wX4Qis90g==
X-Received: by 2002:ac2:4145:: with SMTP id c5mr172590lfi.71.1583879488525;
        Tue, 10 Mar 2020 15:31:28 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id d4sm224010lfa.75.2020.03.10.15.31.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 15:31:27 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id f13so126534ljp.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 15:31:26 -0700 (PDT)
X-Received: by 2002:a2e:6819:: with SMTP id c25mr246698lja.16.1583879486442;
 Tue, 10 Mar 2020 15:31:26 -0700 (PDT)
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
In-Reply-To: <0066a9f150a55c13fcc750f6e657deae4ebdef97.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Mar 2020 15:31:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUgeZGcs5YAfZa07BYKNDCNO=xr4wT6JLATJTpX0bjGg@mail.gmail.com>
Message-ID: <CAHk-=whUgeZGcs5YAfZa07BYKNDCNO=xr4wT6JLATJTpX0bjGg@mail.gmail.com>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6% regression
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 3:07 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> Given that, and the fact that Neil pointed out that yangerkun's latest
> patch would reintroduce the original race, I'm leaning back toward the
> patch Neil sent yesterday. It relies solely on spinlocks, and so doesn't
> have the subtle memory-ordering requirements of the others.

It has subtle locking changes, though.

It now calls the "->lm_notify()" callback with the wait queue spinlock held.

is that ok? It's not obvious. Those functions take other spinlocks,
and wake up other things. See for example nlmsvc_notify_blocked()..
Yes, it was called under the blocked_lock_lock spinlock before too,
but now there's an _additional_ spinlock, and it must not call
"wake_up(&waiter->fl_wait))" in the callback, for example, because it
already holds the lock on that wait queue.

Maybe that is never done. I don't know the callbacks.

I was really hoping that the simple memory ordering of using that
smp_store_release -> smp_load_acquire using fl_blocker would be
sufficient. That's a particularly simple and efficient ordering.

Oh well. If you want to go that spinlock way, it needs to document why
it's safe to do a callback under it.

                  Linus
