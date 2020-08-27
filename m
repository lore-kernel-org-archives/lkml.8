Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BDAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AEAD22B4D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hTYxcSPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgH0SNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgH0SNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:13:08 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8171C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:13:08 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id e5so2396298qvr.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ssRaouXMj2o/HtEZZ3R9vlEAQEleSnlrqRH6Z6mK0YM=;
        b=hTYxcSPYcs/JpYjOgeSQeg6Xl3LxylMwCdjgvYwx1aZ0q9UMPVlNcB95FXYna3al52
         IbTaBhRvKMuLTqjFu5nwJvvcRfM5hlW4mr0CAIw5t/TZ9K03o40d9+HsdyT9aHbx1V9u
         6lZyigyUUK6y9vpQiHxICC3q0LPAv4EOwqGca0jbl9DK/0ufdjWzxlzp4M+vIrJCDfLD
         rTLXzM7s1yCsMnkF3SLfrSOCuq2rWL6RINgYVQ1ynhxBGMt2E2ZfHWhIMvb97fvURbWm
         /4HAoGwQtJz95MMLCIXruMdQ2RP37flfW+Z+PMdo9OixEUHbUjbtaq1V5cLjd1XtAf10
         iwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ssRaouXMj2o/HtEZZ3R9vlEAQEleSnlrqRH6Z6mK0YM=;
        b=kEdKlyPWoGigOW1PpkrdCizMj0Jt+4iHC3xiVJFYktQQCWdd+4Bu4BtzpQdMjaP8qY
         UzvwrCYmh4y7KnUsrIGtSMxSY7VQ1GxVJQXIWZU3VSPxM1xtNT7PnM4cpx+h4G7+7oku
         L8zae+x7gUuz0dZoZVRmFWqIimPDlw69U1NWnkuyjB8W4tUMJptQHs5c4ErYpPXHyq3I
         /Vq/JG+K3vrVWDy5OWPq45nbZkyVeqR5VGnoL/Tbp+9j15OsEw/ZkDkipEBZXgao9xPl
         R6+3+VUnJopJdHw23k7NIa0/Nlgk7fOynfKfhNutTmDm04ikA7FD+Xd233neshHvxar2
         MrtQ==
X-Gm-Message-State: AOAM530FaPb1JcBuvvfZbBGod0Kq5+AishPvsLdV+dEHSM9m6lytZDl+
        akTsIsOBNJpNXdciXQMeU6D40gcBK5a5yoQ5GfeNoQ==
X-Google-Smtp-Source: ABdhPJy+icwO9xKN//159CWIuCBqk8MV0Dp0jEhUL4JCTuBiRCitMg1ap+ZOEoYO7Yy4bHcgdPptWx3uVVGIwM6G+34=
X-Received: by 2002:a05:6214:10ca:: with SMTP id r10mr232930qvs.185.1598551987724;
 Thu, 27 Aug 2020 11:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200729212721.1ee4eef8@canb.auug.org.au> <87ft8lwxes.fsf@turtle.gmx.de>
 <CAMzD94Rz4NYnhheS8SmuL14MNM4VGxOnAW-WZ9k1JEqrbwyrvw@mail.gmail.com>
 <87y2m7gq86.fsf@turtle.gmx.de> <87pn7gh3er.fsf@turtle.gmx.de>
In-Reply-To: <87pn7gh3er.fsf@turtle.gmx.de>
From:   Brian Vazquez <brianvv@google.com>
Date:   Thu, 27 Aug 2020 11:12:56 -0700
Message-ID: <CAMzD94Rkq1RTZJG5UsEz9VhaCBbvObD1azqU2gsJzZ6gPYcfag@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To:     Sven Joachim <svenjoac@gmx.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

I've been trying to reproduce it with your config but I didn't
succeed. I also looked at the file after the preprocessor and it
looked good:

ret = ({ __builtin_expect(!!(ops->match == fib6_rule_match), 1) ?
fib6_rule_match(rule, fl, flags) : ops->match(rule, fl, flags); })

Note that fib4_rule_match doesn't appear as the
CONFIG_IP_MULTIPLE_TABLES is not there.

Could you share more details on how you're compiling it and what
compiler you're using??

Thanks,
Brian



On Mon, Aug 24, 2020 at 1:08 AM Sven Joachim <svenjoac@gmx.de> wrote:
>
> On 2020-08-22 08:16 +0200, Sven Joachim wrote:
>
> > On 2020-08-21 09:23 -0700, Brian Vazquez wrote:
> >
> >> Hi Sven,
> >>
> >> Sorry for the late reply, did you still see this after:
> >> https://patchwork.ozlabs.org/project/netdev/patch/20200803131948.41736-1-yuehaibing@huawei.com/
> >> ??
> >
> > That patch is apparently already in 5.9-rc1 as commit 80fbbb1672e7, so
> > yes I'm still seeing it.
>
> Still present in 5.9-rc2 as of today, I have attached my .config for
> reference.  Note that I have CONFIG_IPV6_MULTIPLE_TABLES=y, but
> CONFIG_IP_MULTIPLE_TABLES is not mentioned at all there.
>
> To build the kernel, I have now deselected IPV6_MULTIPLE_TABLES.  Not
> sure why this was enabled in my .config which has grown organically over
> many years.
>
> Cheers,
>        Sven
>
>
> >> On Mon, Aug 17, 2020 at 12:21 AM Sven Joachim <svenjoac@gmx.de> wrote:
> >>
> >>> On 2020-07-29 21:27 +1000, Stephen Rothwell wrote:
> >>>
> >>> > Hi all,
> >>> >
> >>> > After merging the net-next tree, today's linux-next build (i386
> >>> defconfig)
> >>> > failed like this:
> >>> >
> >>> > x86_64-linux-gnu-ld: net/core/fib_rules.o: in function
> >>> `fib_rules_lookup':
> >>> > fib_rules.c:(.text+0x5c6): undefined reference to `fib6_rule_match'
> >>> > x86_64-linux-gnu-ld: fib_rules.c:(.text+0x5d8): undefined reference to
> >>> `fib6_rule_match'
> >>> > x86_64-linux-gnu-ld: fib_rules.c:(.text+0x64d): undefined reference to
> >>> `fib6_rule_action'
> >>> > x86_64-linux-gnu-ld: fib_rules.c:(.text+0x662): undefined reference to
> >>> `fib6_rule_action'
> >>> > x86_64-linux-gnu-ld: fib_rules.c:(.text+0x67a): undefined reference to
> >>> `fib6_rule_suppress'
> >>> > x86_64-linux-gnu-ld: fib_rules.c:(.text+0x68d): undefined reference to
> >>> `fib6_rule_suppress'
> >>>
> >>> FWIW, I saw these errors in 5.9-rc1 today, so the fix in commit
> >>> 41d707b7332f ("fib: fix fib_rules_ops indirect calls wrappers") was
> >>> apparently not sufficient.
> >>>
> >>> ,----
> >>> | $ grep IPV6 .config
> >>> | CONFIG_IPV6=m
> >>> | # CONFIG_IPV6_ROUTER_PREF is not set
> >>> | # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> >>> | # CONFIG_IPV6_MIP6 is not set
> >>> | # CONFIG_IPV6_ILA is not set
> >>> | # CONFIG_IPV6_VTI is not set
> >>> | CONFIG_IPV6_SIT=m
> >>> | # CONFIG_IPV6_SIT_6RD is not set
> >>> | CONFIG_IPV6_NDISC_NODETYPE=y
> >>> | CONFIG_IPV6_TUNNEL=m
> >>> | CONFIG_IPV6_MULTIPLE_TABLES=y
> >>> | # CONFIG_IPV6_SUBTREES is not set
> >>> | # CONFIG_IPV6_MROUTE is not set
> >>> | # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> >>> | # CONFIG_IPV6_SEG6_HMAC is not set
> >>> | # CONFIG_IPV6_RPL_LWTUNNEL is not set
> >>> | # CONFIG_NF_SOCKET_IPV6 is not set
> >>> | # CONFIG_NF_TPROXY_IPV6 is not set
> >>> | # CONFIG_NF_DUP_IPV6 is not set
> >>> | # CONFIG_NF_REJECT_IPV6 is not set
> >>> | # CONFIG_NF_LOG_IPV6 is not set
> >>> | CONFIG_NF_DEFRAG_IPV6=m
> >>> `----
> >>>
> >>> > Caused by commit
> >>> >
> >>> >   b9aaec8f0be5 ("fib: use indirect call wrappers in the most common
> >>> fib_rules_ops")
> >>> >
> >>> > # CONFIG_IPV6_MULTIPLE_TABLES is not set
> >>> >
> >>> > I have reverted that commit for today.
> >>>
> >>> Cheers,
> >>>        Sven
> >>>
