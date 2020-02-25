Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B047CC35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C492084E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="p8sCpfw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbgBYRAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:00:31 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:34588 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbgBYRAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:00:30 -0500
Received: by mail-il1-f193.google.com with SMTP id l4so2183810ilj.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P2GVz4Iq1B6C2YKd9O6ohn5EL9TclinOo1pocZp95IA=;
        b=p8sCpfw/p08Lo6U8L+k6kM8USZ5CwWkLlPbgQaJjkLtcPsZh5NrA2Ps67flReYI/4n
         hghT+FQI+l58zAiMIn1MARUWuiSz9vVx/eiTzUZ8xYNj9EdH7vQ+KLhKjS9WuwLRHgm+
         2bzQT2Y5C/KFjjarX+YW+VcSviNGlI1SV6s9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2GVz4Iq1B6C2YKd9O6ohn5EL9TclinOo1pocZp95IA=;
        b=o/eFFa/lNi89hwW6s+oRYK+8LvVIxxRTq3zm22TFFTaDN7cKycgIY8b9gC4e9a1WM+
         VkszF4u0mqxs5IQTLcqOzdlcIRDzlzttqwfORVAN07wvEeB3tmtISMlyD1L5UbFXCyJO
         mmqPS28l4pRKxE8EBCI/jpSoKNprSmyBNnWeFZXgzARGrOwidgKLMybApuTEqUIiRyHY
         ZWiNRvY35gQN/0oOWTnmTKX9RhsKgLLVNq3h9bK2YsFvNYUDNDfGXe9iEBpeYKxVyp9Y
         AS+VNZd8beLGEIGRYJmTris7zxVNqMRPLKdQBn3bccI35RAKAvbg+lSwrsekD0iKpTL1
         NtNw==
X-Gm-Message-State: APjAAAWit1N2GdDHyaEmaKouyiVGhtrMl90ZXQQj7oDlB/6XCvF/t455
        VWy8TeYuyPngkvl8s58oP3meIEz0MQflyaLfZNElfA==
X-Google-Smtp-Source: APXvYqyNFOHLlj/QoHkAcLf85jC57Gxqly833jAKwmIid1aJZYLpTF0A8eFk3iYW5D90BhPg10mRHZU2wkJ4r/EXVg4=
X-Received: by 2002:a92:844b:: with SMTP id l72mr67233730ild.262.1582650029886;
 Tue, 25 Feb 2020 09:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20200220045233.GC476845@mit.edu> <20200221003035.GC2935@paulmck-ThinkPad-P72>
 <20200221131455.GA4904@pc636> <20200221202250.GK2935@paulmck-ThinkPad-P72>
 <20200222222415.GC191380@google.com> <20200223011018.GB2935@paulmck-ThinkPad-P72>
 <20200224174030.GA22138@pc636> <20200225020705.GA253171@google.com>
 <20200225035549.GU2935@paulmck-ThinkPad-P72> <CAEXW_YQbiHW=yKiYAs0=8Mp84W6UunM6OOkHE66yXT6cSchm7A@mail.gmail.com>
 <20200225163826.GW2935@paulmck-ThinkPad-P72>
In-Reply-To: <20200225163826.GW2935@paulmck-ThinkPad-P72>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 25 Feb 2020 12:00:19 -0500
Message-ID: <CAEXW_YScMp3LHd5kUzsi6TcneD8js_QLYpGjEWCSX4ymBcUZ-Q@mail.gmail.com>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 11:42 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Feb 25, 2020 at 09:17:11AM -0500, Joel Fernandes wrote:
> > On Mon, Feb 24, 2020 at 10:55 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > [...]
> > > > > As for "task_struct's rcu_read_lock_nesting". Will it be enough just
> > > > > have a look at preempt_count of current process? If we have for example
> > > > > nested rcu_read_locks:
> > > > >
> > > > > <snip>
> > > > > rcu_read_lock()
> > > > >     rcu_read_lock()
> > > > >         rcu_read_lock()
> > > > > <snip>
> > > > >
> > > > > the counter would be 3.
> > > >
> > > > No, because preempt_count is not incremented during rcu_read_lock(). RCU
> > > > reader sections can be preempted, they just cannot goto sleep in a reader
> > > > section (unless the kernel is RT).
> > >
> > > You are both right.
> > >
> > > Vlad is correct for CONFIG_PREEMPT=n and CONFIG_DEBUG_ATOMIC_SLEEP=y
> > > and Joel is correct otherwise, give or take the possibility of other
> > > late-breaking corner cases.  ;-)
> >
> > Oh yes, but even for PREEMPT=n, rcu_read_lock() is just a NOOP for
> > that configuration and doesn't really mess around with preempt_count
> > if I recall :-D. (doesn't need to mess with preempt_count because
> > being in kernel mode is non-preemptible for PREEMPT=n anyway).
>
> For PREEMPT=n, rcu_read_lock() is preempt_disable(), see the code
> in include/linux/rcupdate.h.  ;-)

Paul....

;-) ;-)

thanks,

 - Joel
