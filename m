Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A51C0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAF3206B1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583973516;
	bh=M0b8KPvR/gLuc/ReK/i0DasriG+S9u1FqGtZdG2LmTE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IQbKxfJ+mhrLlWlnRfX/cuVC1D/2bEeOOvCP1hr+uL2B4/IRnYq3xersvt7WjHKqI
	 16MvAhB+AozjgblFmy8qNnvJrZOyg7z2oyKGRs2pw/KkHoH9+yksW1Mi8FF79shu+0
	 qG/u1JDSnsWdXeGrIqErBBayFyezCRwGFD8NSyAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbgCLAif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:38:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36971 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbgCLAie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:38:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so4433131ljd.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 17:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLKsPDUE1GSvDBpqdETPjKLJMVmpkRahrPwuhoHrW/Q=;
        b=aWiKx0/Fl3mcmfdqhjXRNIjpIXRXQA9lXQuH4XULt8QTL2rBWyhdbifyR+qeKRaNoI
         x0Hxy1YTXIwg5BI6xuZDajLdVT9NfgEGBc8lPciBykJqj2ZTl9wIKY+kgOBsd5Ut6QBk
         rDMVJkdtREVZ9sdyt6WJK5wZ306w1GTPToDjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLKsPDUE1GSvDBpqdETPjKLJMVmpkRahrPwuhoHrW/Q=;
        b=XGi+mXfDhO73pGfPx6CasxHzWFtY5htb4yRvplZToynWRIXJ/P2L1Sowprx7IcKYQ9
         uNMNubhsBn2Ov74NoYLJIamV0/RcrrzyG7MpuvPEo9oj8o0gNELxAtklFj/5+RdoMQF1
         1uWAvBKvqeIJ8GEwzJw7woXP2QTsDQ/hvlFE+4P6HoPWPPkmVOmuQQk8U5SLD4ctw2Mu
         nbTvQhFsiGnBvH4HrBFdZCCtpH7zpQoKKBR+lsWO5B50Z8ovtBbuvnDw2alxcgrJi83y
         kF0dbZBeQQzWPHxaiHk+Jdm7ZVlmtP+d45GoLHSSOjwgR3X90ezUgsTY8WHC2yGTiLR1
         udaA==
X-Gm-Message-State: ANhLgQ2zYEIEn5Kya17D5ze+Egt5kdHjQf9+8zkoKifBmHlsmtYO5hVM
        USrbPmd9dLbWIUcv1O7IOKOKK4P0C8g=
X-Google-Smtp-Source: ADFU+vuzWI8QgEkFYlvmtSIaR2KTO55s+B1txxMMYoteQk3VR6s5yVmVtCnJ6PyCZuj64IK1sjwDJw==
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr3331024ljp.66.1583973512002;
        Wed, 11 Mar 2020 17:38:32 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id p133sm9992283lfa.82.2020.03.11.17.38.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 17:38:30 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id w1so4433889ljh.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 17:38:30 -0700 (PDT)
X-Received: by 2002:a2e:6819:: with SMTP id c25mr3564744lja.16.1583973510152;
 Wed, 11 Mar 2020 17:38:30 -0700 (PDT)
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
 <CAHk-=whUgeZGcs5YAfZa07BYKNDCNO=xr4wT6JLATJTpX0bjGg@mail.gmail.com> <87v9nattul.fsf@notabene.neil.brown.name>
In-Reply-To: <87v9nattul.fsf@notabene.neil.brown.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Mar 2020 17:38:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNoAk8v3GrbK3=q6KRBrhLrTafTmWmAo6-up6Ce9fp6A@mail.gmail.com>
Message-ID: <CAHk-=wiNoAk8v3GrbK3=q6KRBrhLrTafTmWmAo6-up6Ce9fp6A@mail.gmail.com>
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

On Wed, Mar 11, 2020 at 3:22 PM NeilBrown <neilb@suse.de> wrote:
>
> We can combine the two ideas - move the list_del_init() later, and still
> protect it with the wq locks.  This avoids holding the lock across the
> callback, but provides clear atomicity guarantees.

Ugfh. Honestly, this is disgusting.

Now you re-take the same lock in immediate succession for the
non-callback case.  It's just hidden.

And it's not like the list_del_init() _needs_ the lock (it's not
currently called with the lock held).

So that "hold the lock over list_del_init()" seems to be horrendously
bogus. It's only done as a serialization thing for that optimistic
case.

And that optimistic case doesn't even *want* that kind of
serialization. It really just wants a "I'm done" flag.

So no. Don't do this. It's mis-using the lock in several ways.

             Linus
