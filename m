Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31B9C43332
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 17:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994C220663
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 17:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584813597;
	bh=ZuSbGGhVk7ElppFEqcvOSgLGvokuNn1yu1rZCbs0kLc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=T9764RZJzz16N5aMmCBVgUBWUDYSbmfC/2HcfQYD2VDcSOvyhfyvJpavc/6Kjpf97
	 qXYYLxJ8MXCcy/BYTv8NmpTAJSMcrFckrf6Dk7UmDT0tkcQzer2HGawx3Dcw/sRRca
	 dy5nJkhKJxm/BQ7T9pxPjDAWWa088eu4ijyP5m50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgCUR74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 13:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgCUR74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 13:59:56 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 281F920663
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 17:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584813595;
        bh=ZuSbGGhVk7ElppFEqcvOSgLGvokuNn1yu1rZCbs0kLc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xXFV2aBD5/J82q4O1hmTkXBtsj7YBtcg2BEaN/STukf4zsn8ZYoIlbw5ZnYzBrF9H
         2o9e4DXG32XBWiOCGVm5jah8zLILiCV9bD50cBNHNaurK9M5ihvNxF0R2a+fpLYFes
         KSPGTRXTD/PzeYsSRmB00sn+H3cN3FB570lfZVeU=
Received: by mail-wr1-f50.google.com with SMTP id h4so11517301wru.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 10:59:55 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3JdR0w8P5tqa+vhLNqFtW81I3QmDvGxiZtXu+hoDm3+Kv+wWQK
        CrN1r73j0A3eHxnHFqyKBi7qjnsi9F2AdPmmNupVtA==
X-Google-Smtp-Source: ADFU+vuKInd6HLK3CpjXtrY2FJ7SVmSBD1uxiV4Y4RKiP50pxec4KIoEPSyoO18WS7CfNZcZSZUrSaI1LOQ+973El/c=
X-Received: by 2002:adf:f504:: with SMTP id q4mr12140926wro.257.1584813593681;
 Sat, 21 Mar 2020 10:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200319021629.GC23230@ZenIV.linux.org.uk>
In-Reply-To: <20200319021629.GC23230@ZenIV.linux.org.uk>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 21 Mar 2020 10:59:41 -0700
X-Gmail-Original-Message-ID: <CALCETrULZc+T6MeRwfcf=JGoh0xE0YEsTFeLiB5=zdH8AX+3bg@mail.gmail.com>
Message-ID: <CALCETrULZc+T6MeRwfcf=JGoh0xE0YEsTFeLiB5=zdH8AX+3bg@mail.gmail.com>
Subject: Re: [RFC][possible bug] when should SS_AUTODISARM have effect?
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Stas Sergeev <stsp@list.ru>, Ingo Molnar <mingo@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 7:16 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Consider the following scenario:  SIGPIPE has SA_ONSTACK
> handler, SIGSEGV - non-SA_ONSTACK one.  SIGPIPE is delivered
> and we fail halfway through setting a sigframe for it.
> OK, we get SIGSEGV forced in, which gets handled not on altstack.
> But what should happen if we fail *after* having saved the
> altstack settings into the sigframe that got abandoned?
>
>         AFAICS, we get them reset and the original setting
> entirely lost.  Shouldn't that thing be applied only after
> we have succeeded in building the frame?  In signal_delivered(),
> perhaps...
>
>         I realize that this is out of scope for POSIX, so it's
> not a matter of standard compliance, but it looks like a bit
> of a QoI issue...

I suspect that the number of real programs that usefully handle
SIGSEGV due to signal delivery failure is extremely low.  And the
number of real programs that use SA_ONSTACK and expect to survive when
the alternate stack is bad may well be zero.

Honestly, if we actually want to make any of this useful, I think a
better design would be to use an entirely separate signal specifically
for signal delivery failure.  So we'd have SIGBADSIG, and signal
delivery failure tries to deliver SIGBADSIG.  The current design is
like if x86 handled exception failure by sending #PF.  The results
would be nonsensical.

But adding a feature like this would be silly unless someone actually
wanted to use it.
