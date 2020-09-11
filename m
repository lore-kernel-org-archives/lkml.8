Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AF7C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943A4221E3
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bLp4ORPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgIKI2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgIKI2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:28:22 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E445C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 01:28:20 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q13so12627674ejo.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nqgDSp1th5G/M0PdFYX7mO5hM3ICiXr7qIaeDpTGTcU=;
        b=bLp4ORPpJWoJtKrU+PnODJE/eis6yKpsPkzVKH0XHf5eamhhp8RlA6XpgfAoeCardL
         vSLYmlyzYTJgoJ0DeDlSn07sKUvKDJlETmJZC4TQQacwtvHXpF/Fe8uiZIzgFLwOwJVe
         LPKLtwG73oVlviO1tBSrM62bZtJgw3TvG8ftE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nqgDSp1th5G/M0PdFYX7mO5hM3ICiXr7qIaeDpTGTcU=;
        b=NF2gS5M6Sxw6O8vREo3ccYI2wB/fXM/sjTH3T+C5Ng+T+TonsJf2Bo4Syd9VeHvRg6
         V0SCFoJId+IDutzhCs3CHFnRmA1kKf/znIoA5V/99KI1GGVNUU6dQ6teGdtDbk2PHZyv
         jDxAcKzgibdEeURHyYMfHCmootBe8OpnnzKOvMAuyoIbOTPk7KHAJhagxiKQb8USHU8B
         zZx/zpSl+IW0/HcC8tfYNS0EO/yBrbaz9tGtiNMjdGbhfRNmlwA/LDe/ebr12X57q2bs
         DwW++TnTVpXbXCPFkTP8diexNg0o17qVRAif9EvYXYw6SwWPTjDbmDUe+1ihNYROR+Re
         vEYA==
X-Gm-Message-State: AOAM533kWG3akXtvhILprfo7nA4kj8TvVGNrLtjAmNIqyNwE4lFTQqJU
        pArcwIZIhsxBUIrLRiWtd3GvijppB9GphpMldrI=
X-Google-Smtp-Source: ABdhPJzp7/QLZCNmQ/5O5Y2BA2ClIC2TTMD60/G0LfBFa8gP6mFdzJOTxg5yuLdeJcqn6ImyI2052w==
X-Received: by 2002:a17:906:692:: with SMTP id u18mr929591ejb.43.1599812898711;
        Fri, 11 Sep 2020 01:28:18 -0700 (PDT)
Received: from [192.168.1.149] (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id z10sm1053225eje.122.2020.09.11.01.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 01:28:18 -0700 (PDT)
Subject: Re: [PATCH] scripts/setlocalversion: make git describe output more
 reliable
To:     Brian Norris <briannorris@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200910112701.13853-1-linux@rasmusvillemoes.dk>
 <CAK7LNARE6NpCYAd7=--m-oO8_LweBWhP2aWfSRdTz=TX8dM5rw@mail.gmail.com>
 <CA+ASDXOuK=iCdzWbtc+aRhBy=8xy860XqxwJg+wFuQaXKfg3UQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f3ce9b3e-d3c1-a96b-e14b-a8d3c4600b09@rasmusvillemoes.dk>
Date:   Fri, 11 Sep 2020 10:28:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+ASDXOuK=iCdzWbtc+aRhBy=8xy860XqxwJg+wFuQaXKfg3UQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2020 21.05, Brian Norris wrote:
> On Thu, Sep 10, 2020 at 7:35 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>> On Thu, Sep 10, 2020 at 8:57 PM Rasmus Villemoes
>> <linux@rasmusvillemoes.dk> wrote:
>>> So in order to avoid `uname -a` output relying on such random details
>>> of the build environment which are rather hard to ensure are
>>> consistent between developers and buildbots, use an explicit
>>> --abbrev=15 option (and for consistency, also use rev-parse --short=15
>>> for the unlikely case of no signed tags being usable).
> 
> For the patch:
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> 
>> I agree that any randomness should be avoided.
>>
>> My question is, do we need 15-digits?
> ...
>> So, I think the conflict happens
>> only when we have two commits that start with the same 7-digits
>> in the _same_ release. Is this correct?

No.

> For git-describe (the case where we have a tag to base off):
> "use <n> digits, or as many digits as needed to form a unique object name"

Yes, the abbreviated hash that `git describe` produces is unique among
all objects (and objects are more than just commits) in the current
repo, so what matters for probability-of-collision is the total number
of objects - linus.git itself probably grows ~60000 objects per release.

As for "do we need 15 digits", well, in theory the next time I merge the
next rt-stable tag into our kernel I could end up with a commit that
matches some existing object in the first 33 hex chars at which point I
should have chosen 34 - but of course that's so unlikely that it's
irrelevant.

But the upshot of that is that there really is no objective answer to
"how many digits do we need", so it becomes a tradeoff between "low
enough probability that anyone anywhere in the next few years would have
needed more than X when building their own kernel" and readability of
`uname -r` etc. So I decided somewhat arbitrarily that each time one
rolls a new release, there should be less than 1e-9 probability that
HEAD collides with some other object when abbreviated to X hexchars.
X=12 doesn't pass that criteria even when the repo has only 10M objects
(and, current linus.git already has objects that need 12 to be unique,
so such collisions do happen in practice, though of course very rarely).
13 and 14 are just weird numbers, so I ended with 15, which also allows
many many more objects in the repo before the probability crosses that
1e-9 threshold.

Rasmus

Side note 1: Note that there really isn't any such thing as "last
tag/previous tag" in a DAG; I think what git does is a best-effort
search for the eligible tag that minimizes #({objects reachable from
commit-to-be-described} - {objects reachable from tag}), where eligible
tag means at least reachable from commit-to-be-described (so that set
difference is a proper one), but there can be additional constraints
(e.g. --match=...).

Side note 2: Linus or Greg releases are actually not interesting here
(see the logic in setlocalversion that stops early if we're exactly at
an annotated tag) - the whole raison d'etre for setlocalversion is that
people do maintain and build non-mainline kernels, and it's extremely
useful for `uname -a` to accurately tell just which commit is running on
the target.
