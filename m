Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0932C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1333206D3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585785363;
	bh=8MW4IauE+eEnJhMmqznDU0abqEG4r/721eygO1jhEpc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=blQF7Pxurtt5ThlCNNVTQK5aGUipKFrhHm7q0dfaeZfFIzltABZg60l/sNFVO8oyP
	 /fN9ivWO5eYAUaHBQOQ6wkUDryA+AvFXzpvDtX7YWAuXtmzETKGoVMwjfNJp22+PyO
	 g2sKAYPQ5wDkYD95Y0PaEfE0oAW/AwyVY3ZHnkrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbgDAX4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:56:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38933 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732682AbgDAX4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:56:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id i20so1335557ljn.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 16:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/BfWZS5+9as5lD6vEMwl/6xxGz06a9gloYkQ+RKeiao=;
        b=JfE6FWMW0WrTIHwAtwqL3bo+qhTInr5LXI005KEawz6BRmX/rJrge8UmPsiMK5pPpc
         uTi9rFGFrfCf6pGgobgz2x2SN1yInjn8O4MwUNtnjY4Fxxg3pNbTXYvif4DrVZeLWFYk
         NwMooEZifjvk8bHNwWTVKU9ykqNbijKLOcb/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BfWZS5+9as5lD6vEMwl/6xxGz06a9gloYkQ+RKeiao=;
        b=YU2MYCumhCxn+JS5IPD5n29dsRIk0+otE2Pxd/IU6dXUs3YUdttyXlFgFaSCllzg/2
         egu5ighlEZSAivDGLfMHKiv59w0MaVHJVW+qVpYK4t0gRgqVUv2f3Wi2yF8At7q8cb+b
         EhgHvszxBBXiOeI5APaWidyw9Qpv5qpe+hOkB7ha9BHg+LEmYRedZFZnaS9K6vBKO+lz
         AUzH6APKhic5BzF/3ivBZAr4xwzOriIAiSRv0v8aTAdfjNnqMQW20oXkVT9WWAxSksiN
         HbKaiB8NB01EYlCyI2nkNWdKqlHFj2kJiJpx0dr2Q9h/rRU3KN2Fwh7pkBwgDRToOhwu
         mNGg==
X-Gm-Message-State: AGi0Pub321KyI+6BUOpYCWObDY9ePzenRjyF2QcLxjToZxj8xqdXyJde
        FHiPHkeiVcdVfgdF08r/d60jn6DQ380=
X-Google-Smtp-Source: APiQypJ583oXCoga9l1vThnpP9mBE227RekpIi+UWs8sEri5o4eWlzjUnfisQi3B9VrbyxCjxuaQxQ==
X-Received: by 2002:a05:651c:404:: with SMTP id 4mr365946lja.281.1585785359846;
        Wed, 01 Apr 2020 16:55:59 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 6sm2634827lft.83.2020.04.01.16.55.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 16:55:59 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id k21so1376216ljh.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 16:55:58 -0700 (PDT)
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr371604ljm.201.1585785358260;
 Wed, 01 Apr 2020 16:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200324215049.GA3710@pi3.com.pl> <202003291528.730A329@keescook>
 <87zhbvlyq7.fsf_-_@x220.int.ebiederm.org> <CAG48ez3nYr7dj340Rk5-QbzhsFq0JTKPf2MvVJ1-oi1Zug1ftQ@mail.gmail.com>
 <CAHk-=wjz0LEi68oGJSQzZ--3JTFF+dX2yDaXDRKUpYxtBB=Zfw@mail.gmail.com>
In-Reply-To: <CAHk-=wjz0LEi68oGJSQzZ--3JTFF+dX2yDaXDRKUpYxtBB=Zfw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Apr 2020 16:55:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgM3qZeChs_1yFt8p8ye1pOaM_cX57BZ_0+qdEPcAiaCQ@mail.gmail.com>
Message-ID: <CAHk-=wgM3qZeChs_1yFt8p8ye1pOaM_cX57BZ_0+qdEPcAiaCQ@mail.gmail.com>
Subject: Re: [PATCH] signal: Extend exec_id to 64bits
To:     Jann Horn <jannh@google.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Adam Zabrocki <pi3@pi3.com.pl>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 4:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's literally testing a sequence counter for equality. If you get
> tearing in the high bits on the write (or the read), you'd still need
> to have the low bits turn around 4G times to get a matching value.

Put another way: first you'd have to work however many weeks to do 4
billion execve() calls, and then you need to hit basically a
single-instruction race to take advantage of it.

Good luck with that. If you have that kind of God-like capability,
whoever you're attacking stands no chance in the first place.

                  Linus
