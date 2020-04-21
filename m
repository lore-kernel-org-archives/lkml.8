Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E66C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 533F520724
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587503836;
	bh=kFU2dgolJgSwGTDef1I5rI/vXFpK+Nlf0oa4fBuvSqo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Rpipyo3R9/3wS3KC2O68VgyPLzx2Ql/IyiAYfFhLvx8kdTwLQevXh8ox15E/7E52x
	 RS4PP3MDOTeQr1SJejy87ma8eO/i96gLl8qNwT+pk7J6IQfSMHj9leqI42yKoOpIrE
	 dfHDfN61UNqFkjDNAd1fVwuP1G+GtJ6rE4AuGp1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgDUVRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbgDUVRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:17:14 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BF0C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:17:14 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id f8so12293487lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5pLl+D5tNip97GFPQ+tLS3+5WUwZ1zuA/I0ykv4UqE=;
        b=GJM81lIK3eo2XovGG5vBhA2ndv5S6gnrXVRfHf4R3TiUc6Xb+F0svBJRHZsPsTf6pt
         pLeWZrS3E/cSwGAou5y0Obvsp5+HTLH6XKr0OaRHcyBdU2Fu9AWeM9V+HkvG7SpPKOjc
         GbzjIUODzR4GrMODTgAQo56kyr4aXnNKLO40I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5pLl+D5tNip97GFPQ+tLS3+5WUwZ1zuA/I0ykv4UqE=;
        b=OCVbhSAfxNjQGO0aNOhtaQJY84l+Kyteriap5NcxtSoiIJ2bXygusPiB5NLuFD2QKk
         MvVJdk8gYcHs+0xhLlaqi9yQIU6h7IcdCkUqR08tE0ev7Cq2sRVLI6hJRnLErryhRP0S
         mQ2dumqA8ZMYVKYrrzgvgLmEodBHE8Q2pIM+0sY7wvlrezrFkfBWMdbUtL1n19lcgybs
         H4pGw3eLWNdDxyskWP5DuJtAKOv6PWWkxEhd8kkfUswH7hdUtzcao+HY/iLb47pt5L25
         s+qQ3g4sBXBiQPWoKEExbaV4u5IpXJ0II+GkkZh91p+hhg4MeFrA0Ke1vNKniTo6uu5t
         zmmw==
X-Gm-Message-State: AGi0PubyB0AG2f+wo60UJ+5Dy5KDqco0/3qtOz6prDJ35v6tRa3Ev56k
        sGTLB9WMkYSCsy2AosFjpE3LHeg8T2M=
X-Google-Smtp-Source: APiQypKxvB9U1lkwBawN72OpDFO5sDRnf4kNYSAPhHXR3GM4cTLpsj2W/aNM7dxrI53qyC6jCL/XNA==
X-Received: by 2002:ac2:4551:: with SMTP id j17mr14837831lfm.147.1587503832347;
        Tue, 21 Apr 2020 14:17:12 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id j14sm3051252lfm.73.2020.04.21.14.17.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 14:17:11 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id j14so12293073lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:17:11 -0700 (PDT)
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr14628462lfk.192.1587503831120;
 Tue, 21 Apr 2020 14:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200420190916.GA11695@gmail.com> <CAHk-=wiejBvKnrDysDva=DNFgyX02TZred_JMjzUnjFgVOUtOg@mail.gmail.com>
 <CAP-5=fVhWREzzjnXH4j+dcnP-GbSMnT_07qVrZM8huAhx6wtVw@mail.gmail.com>
In-Reply-To: <CAP-5=fVhWREzzjnXH4j+dcnP-GbSMnT_07qVrZM8huAhx6wtVw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Apr 2020 14:16:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifecOQcL6vbL0uOY68jH4i3nBCksmc+As9hrUm_hjw1Q@mail.gmail.com>
Message-ID: <CAHk-=wifecOQcL6vbL0uOY68jH4i3nBCksmc+As9hrUm_hjw1Q@mail.gmail.com>
Subject: Re: [GIT PULL] clang-format for v5.7-rc3
To:     Ian Rogers <irogers@google.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 2:03 PM Ian Rogers <irogers@google.com> wrote:
>
> We (Google, Stephane Eranian, ..) have a tool that converts Intel's
> topdown metrics:
> https://download.01.org/perfmon/TMA_Metrics.xlsx
> into the json format used for metrics in perf. It is written in C++
> and we are planning to upstream it.

Oh, ok.

> There's a little more motivation in the commit message too.

Well, not really. I _did_ check the commit message. It says nothing
very useful at all, in that the kernel doesn't use C++ (aside from a
couple of clang tests), so the commit message didn't at all clarify
why we should care about C++ namespace rules..

              Linus
