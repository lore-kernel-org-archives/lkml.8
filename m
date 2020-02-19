Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0D7C7619D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C827206EF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBVjpzpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgBSWQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:16:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43736 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgBSWQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:16:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id s1so774643pfh.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agg9dtlRi26G3wi4jv/MaG0HU2ZjmqaEprapfxOi6UM=;
        b=WBVjpzpdNwWIccTPMsNDV05FQpzpKjD2OyraxIiagERRtHLFfNfXJAnsbasO79EoPS
         RD8i472USfNKs783FvMU2Yx/TLzazmDSs3AR4zyGU06C9Kny60pp9jGi2sydNTvtvxFm
         xhZfOSkijlD2VvwABYNkQcIM4Azh24ZtuGImTpzKx99Jo+Yi52j+G2hOBB1QZ+TRKcaZ
         jfuvNxOU5EaVScFs7gBXSqPFFyQIntZgJkZ3Ue/smY70pDXReYtNlBh5evCZYN+mtEZC
         PcY4Fn9vOigN+hQspWyUFmdrheeym69kb/kiwSnRwKwYa+1mGj42kJl5M0Sjmte0n7hm
         6MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agg9dtlRi26G3wi4jv/MaG0HU2ZjmqaEprapfxOi6UM=;
        b=H9G3/Do2wW43x74WEV4lyKgkYrTS4i5iFN7i1v1I8bg4lcEbBs8ny9wcc0IgokJWga
         l499pq218pebg7hdNThwV4Op82DE+ZQlz8k70u0IvVrSDKFPBGNXTXRBoI2DOlQ0RVYu
         TL1pRv/jop1MtH/iXofAIxFMOa6Ro84h0aKGWMBFY6MPp3SOXbxwR079Ns+FZJxxJql/
         bJO8g8jpg1cue8yLDlY6Whf97eQ/TUDrb/YVZkPgnnpUvTzW+ORpyIB/DKLJNbfMQIxE
         TEt6UlShjsiSmFmzTkqSFDBp2dQfU8ZLj2X79LhFX9V88pOrvW47631m8SEACAwQgL4N
         KuQw==
X-Gm-Message-State: APjAAAXO2MZuI7veWakypIvWlwUSzCFi373NpL0CxyZS/WuQo7Wox/eI
        fQO4douilo1Omri4qmUv68kwv8A1zI7ekcbyCesYLA==
X-Google-Smtp-Source: APXvYqzOuJj3hSPpoW+lgjC63ICrnC4PAo/GAsuaPxyOWNgetwjRxi4DciFF/dVbn1w2IDqtOvgD2bBaSgg8xHXa6vs=
X-Received: by 2002:aa7:8545:: with SMTP id y5mr29158698pfn.185.1582150573985;
 Wed, 19 Feb 2020 14:16:13 -0800 (PST)
MIME-Version: 1.0
References: <20200126015924.4198-1-sj38.park@gmail.com> <20200127153201.3908-1-sjpark@amazon.com>
In-Reply-To: <20200127153201.3908-1-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 19 Feb 2020 14:16:03 -0800
Message-ID: <CAFd5g444shArgbdwaCdM3VBb9c7M1s7BJ5Dho7KEBU_fCsaJOw@mail.gmail.com>
Subject: Re: [PATCH] docs/kunit/start: Use '_KUNIT_TEST' config name suffix
To:     SeongJae Park <sjpark@amazon.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I didn't see this until now.

On Mon, Jan 27, 2020 at 7:32 AM <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> It is recommended to use '_KUNIT_TEST' config name suffix for kunit
> tests but the example is using only '_TEST' suffix.  This commit fixes
> it to also use '_KUNIT_TEST' suffix.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
