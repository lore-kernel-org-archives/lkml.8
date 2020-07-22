Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E73C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 765E8207CD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="C5QgKmMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732849AbgGVPZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbgGVPZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:25:07 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D42C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:25:07 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b11so1527435lfe.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ZZVwlxeqmX6G0EA/Mr693geGtRjCRxDovI8UeX3tF/E=;
        b=C5QgKmMNi+duOmChNMdNcV7BGLjrPc3dfMM+ZXrRADwRwk9gQmIk9fyldZ8raTbfsY
         +OoZL6gEZ+O+mW/cguLPp4m+bFPF2MyxCw8213plzO16nE+FM2d/mwgx1v89BPTVDE0A
         onNVGJZK10OLklPw6MDZurhbTKsl32XQFTgDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ZZVwlxeqmX6G0EA/Mr693geGtRjCRxDovI8UeX3tF/E=;
        b=QJKqhDbj81BwAgO5OHXfh7cyjN8RXjv7YRSVij7lG7tKM1BKad1RKb37p3oecdk9Pc
         2j6H7tkZB+0FUPZTVV5Cjg60ert5VCzoOzqjDxPnziPMpz4O3MSm+DzxtT0dlYzaC3L+
         WULUxwlOwB8JNoVS6elZ9gLBQEe7JQS8iQjrQOu17WbrRHkdLfw5HzB+BsMEEIh8Lsut
         GWE6UB3FuSMSzPOIE2WlPbrR28Wbyp1IARAobW0WdPLSUNOgBBAVzK8tWiXkl+PkqCHs
         c1p+hEPuX8xg9KfYzhiEPdzb6/vqAKLswxYSFo6KHlou3bF2jGyGwpft9DzNO0Khr8tL
         bPDA==
X-Gm-Message-State: AOAM5300zhh8P8r78r3AMPt5hBAmO/r5f0eGIkXzkX+oXXNsN+gedELj
        mCThnOpBVHqDZHstcfTHKARJOQ==
X-Google-Smtp-Source: ABdhPJytm/cO+POWytM1rrXYfKAEreT3hfBCxb11O1PqsNQPR1Eago6islkfmq8GEVq+PzNlx90VdA==
X-Received: by 2002:ac2:4158:: with SMTP id c24mr16372289lfi.109.1595431505679;
        Wed, 22 Jul 2020 08:25:05 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id h21sm194610ljk.31.2020.07.22.08.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 08:25:05 -0700 (PDT)
References: <87wo2vwxq6.fsf@cloudflare.com> <20200722144212.27106-1-kuniyu@amazon.co.jp> <87v9ifwq2p.fsf@cloudflare.com> <CA+FuTScto+Z_qgFxJBzhPUNEruAvKLSTL7-0AnyP-M6Gon_e5Q@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the bpf-next tree with the net tree
In-reply-to: <CA+FuTScto+Z_qgFxJBzhPUNEruAvKLSTL7-0AnyP-M6Gon_e5Q@mail.gmail.com>
Date:   Wed, 22 Jul 2020 17:25:04 +0200
Message-ID: <87tuxzwp0v.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 05:05 PM CEST, Willem de Bruijn wrote:
> On Wed, Jul 22, 2020 at 11:02 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>
>> On Wed, Jul 22, 2020 at 04:42 PM CEST, Kuniyuki Iwashima wrote:
>> > Can I submit a patch to net tree that rewrites udp[46]_lib_lookup2() to
>> > use only 'result' ?
>>
>> Feel free. That should make the conflict resolution even easier later
>> on.
>
> Thanks for the detailed analysis, Jakub.
>
> Would it be easier to fix this wholly in bpf-next, by introducing
> reuseport_result there?

Did you mean replicating the Kuniyuki fix in bpf-next, or just
introducing the intermediate 'reuseport_result' var?

I'm assuming the former, so that the conflict resolving later on will
reduce to selecting everything from bpf-next side.

TBH, I don't what is the preferred way to handle it. Perhaps DaveM or
Alexei/Daniel can say what would make their life easiest?
