Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF0FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E015B20774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663626;
	bh=JGU2E7uNvE/H0Unwrj+QZI+Tf0ra4DIfV4lDvJH1jyw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Zd52Qys33TukxmUnnYlUAFabI23cc/sbPPm5njjN9+LWujjKTIMfUOsxOabJuI7Pu
	 cjD4nsUnQnDdqQafc2FttQ8XZmaSZN5xUBaMyY24hS56j28cZKsXSPban+Z6OLS6wD
	 YyLQxyHuY0m+n7IYuUZuyGOF4nVGkP37nww/xRBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733300AbgFIArG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgFHXL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:11:27 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B437C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 16:11:26 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r125so11258184lff.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 16:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJSjfmdfr+D+EmPNk3Z1nkRrfh0xejQwx7NnJnA0lQQ=;
        b=NVKuaGPaceMWcOFgmw1eVTMtvPeIOd7UPz0InJHeUglJC6pO7meWTznIv4HlInxEsP
         qMQgwleLcz6X507SYBkJQ3i4xKuJHtsDur1ubxtMuiaAj8TxKUQC+5hEXyknSsMAk+cF
         flW6msFmdj0cxi7sYaPDtJVVjWDmY2xdEwIQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJSjfmdfr+D+EmPNk3Z1nkRrfh0xejQwx7NnJnA0lQQ=;
        b=SMizElHZ9Ec2vRyNzMtKSJISmG1QhSyN2Usb6b+CnITI65dgjapt4oPPavqfNVuSkB
         aGsssjYbqWJToGVUDPdgtXVw1I5g1r3z4XeGpPEU0veHZvIxC2SVeDHqM1oecyw9DkVI
         7n2072dv3YD7aBypLrZNoJM6YLXU4fqlKJIMB334VfS7puJiH1h0szNVCj2/BqIbueEu
         YlzdiDzJus4drcMtYtnw9k5uR9kaoEI5SRHrAYW8sCIJu444WibBe6zHWbPNx2kegoVU
         8lPcfgiXK3AmfmU/TzlX+kCEnuDwAoWE9UT8XzGL+qDznZySB0EzSb60cObLo2ZCBTXc
         ZmoA==
X-Gm-Message-State: AOAM533i9aoEp82EG7YMn4Km2cokUfJ74k+TnO8xMFC+NshLbx1uKix6
        AjhGlVflUTk9FpvE52q0/pGdDJSc0UI=
X-Google-Smtp-Source: ABdhPJy+4inaTRspSTk661s3MAAUNOn/5SQYr5rAdETK1FpPRgP8GIyTbF/AGWNn8tp2Pr/NjPBiKQ==
X-Received: by 2002:a19:f111:: with SMTP id p17mr13568615lfh.91.1591657884752;
        Mon, 08 Jun 2020 16:11:24 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id o23sm5326434lfg.0.2020.06.08.16.11.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 16:11:23 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id e4so22683300ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 16:11:23 -0700 (PDT)
X-Received: by 2002:a2e:8991:: with SMTP id c17mr10842600lji.421.1591657883003;
 Mon, 08 Jun 2020 16:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <159110310259.14558.3096683243532489290.tglx@nanos.tec.linutronix.de>
In-Reply-To: <159110310259.14558.3096683243532489290.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 Jun 2020 16:11:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyF0uSwVVvJ8hjVdP=s1m8hXPUzqtbWaNRqz+B52DU5g@mail.gmail.com>
Message-ID: <CAHk-=whyF0uSwVVvJ8hjVdP=s1m8hXPUzqtbWaNRqz+B52DU5g@mail.gmail.com>
Subject: Re: [GIT pull - RFC] locking/kcsan for v5.8
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 6:07 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> please consider to pull the latest locking/kcsan branch from:

Gaah. So I left this until I had cleared out my queues, and now that I
start looking at it, I find myself more annoyed by the messy history
than by the kcsan code.

For example, it generates conflicts with the sparc tree, because the
sparc page table changes weren't done as a shared branch, but
duplicated as commits (and the subsequent changes cause some
conflicts).

And the read-once/write-once changes that I was aware of and approve
of, are similarly mixed in here randomly, rather than being as a
branch of their own. I see that Will then made his own branch, but
then we'd have the same issue as with the sparc changes.

The things I was _expecting_ to find annoying (various random changes
to random code due to kcsan reports), I don't actually see.

Instead I see odd small completely unrelated things like the
x86/purgatory changes that were merged in for odd reasons.

How painful would it be to sort this out properly? I'll happily take
the read-once changes as a separate branch, for example. There's
nothing really controversial there., even if the gcc version bump
might annoy some (I personally think we could bump it further up to
4.9, and require _Generic, for example - I suspect we have a number of
places that could use _Generic instead of nasty sizeof games).

I'd even make an exception and say "ok, just rebase the kcsan stuff on
top" to clean up the messy history, because this is the kind of new
feature that shouldn't affect a normal build, and I'd hate to have
other changes that _can_ affect a normal build - like those atomic
changes - mixed up in the middle of the kcsan stuff.

So my first reaction from looking at this is that I'd rather get the
infrastructure separately (like I already got the sparc32 page table
changes), so that once I _do_ get the kcsan bits, they really would be
"this introduces no semantic changes what-so-ever when not enabled".

IOW, I'd be inclined to instead pull Will's branch, and then whatever
x86 entry branches, and then kcsan last with _just_ kcsan stuff.

Will that make everybody else cry tears of frustration?

               Linus
