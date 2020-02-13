Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5E5C352A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 00:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004BC20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 00:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="aSjmmByi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgBMAsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 19:48:18 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40448 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbgBMAsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 19:48:18 -0500
Received: by mail-qk1-f196.google.com with SMTP id b7so4064908qkl.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 16:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=179Yt5PBUg2b6L8viYwRFsPlTIoidUR/f0EhWo/bqrQ=;
        b=aSjmmByiXUpWFynH1CKOAB5S58PeRgELd/7h0zyhU5tXXXr+K6/NhngkvT6XOw9hj4
         CmWurt+Jale4K7dB238hZ8meqeEQxgivd4X/gap6SOh8cBUJZvXxpHxejNzWeseESkFO
         HdXszEgneWAm6jdXf2w5FS65rEaSOgfCiCAqaerXux70hbQYoyxgbS9aXc9j9tNBO3po
         19dQvym2kLkqC5InJUrCUv2D7qFXOzreokSyxPcN/hRqVh8G2GhNzU63EgjMEXIU2Pjw
         FGZq22YUAlCXse5vBiSXvSK90ywzeyZN4wdcHrffB5S4bnPwgYOKd3fiCvsRCWGvoLUC
         KsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=179Yt5PBUg2b6L8viYwRFsPlTIoidUR/f0EhWo/bqrQ=;
        b=N0HrBVN2+3XsxaLjkvqEBUJCJTIc8neVm1z5uQaCS1oZMFOK23kaZ+5gkNfhGE9ei9
         WZYPGEv5ZYce4EOE0JBcl22dA0rX+f7ZbDVrjBjZ/hZkrB2+NwqfNXWeSIu5qxNkIgYF
         k/q9OPd8jbTbo20f4bs9sapeTqbvVLGGAFqs5htbzxPQxgVxiAxm6U2J5WUKWzcE01nj
         plsIMNySY/eeVO2NZMm3ClCrRTxDNcREt3lqpIuLJNy43ZhlEUO6NroWoCb1Fp+2KwMd
         emVyouRZyWOFJKiZyKEwgYesfXVmbk2ZlfzFFCNW7TPHPa3Qd6DRtWwr4Cc3wvJgmE2N
         KF0w==
X-Gm-Message-State: APjAAAUbV5/aHYZFJBOxDdRZ8QLx7fJoAiPqQ9XngxS20hHAgRiaE51p
        +lHMOwiin6pTygbYqLUfRv4fyw==
X-Google-Smtp-Source: APXvYqzOPvx9ypE9Cx7jsnK8Q3PCVT6KNkVVIroDyhA6gT7xUK96DxPUBGSPyZsdAzY10BS8J6B6UA==
X-Received: by 2002:ae9:c318:: with SMTP id n24mr13889195qkg.38.1581554897259;
        Wed, 12 Feb 2020 16:48:17 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 13sm356902qke.85.2020.02.12.16.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 16:48:16 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v2 5/5] kcsan: Introduce ASSERT_EXCLUSIVE_BITS(var, mask)
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200212214029.GS2935@paulmck-ThinkPad-P72>
Date:   Wed, 12 Feb 2020 19:48:15 -0500
Cc:     Marco Elver <elver@google.com>, John Hubbard <jhubbard@nvidia.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>
Content-Transfer-Encoding: quoted-printable
Message-Id: <79934F2A-E151-480F-B1B1-1C713F932CEC@lca.pw>
References: <CANpmjNOWzWB2GgJiZx7c96qoy-e+BDFUx9zYr+1hZS1SUS7LBQ@mail.gmail.com>
 <ED2B665D-CF42-45BD-B476-523E3549F127@lca.pw>
 <20200212214029.GS2935@paulmck-ThinkPad-P72>
To:     "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 12, 2020, at 4:40 PM, Paul E. McKenney <paulmck@kernel.org> =
wrote:
>=20
> On Wed, Feb 12, 2020 at 07:30:16AM -0500, Qian Cai wrote:
>>=20
>>=20
>>> On Feb 12, 2020, at 5:57 AM, Marco Elver <elver@google.com> wrote:
>>>=20
>>> KCSAN is currently in -rcu (kcsan branch has the latest version),
>>> -tip, and -next.
>>=20
>> It would like be nice to at least have this patchset can be applied =
against the linux-next, so I can try it a spin.
>>=20
>> Maybe a better question to Paul if he could push all the latest kcsan =
code base to linux-next soon since we are now past the merging window. I =
also noticed some data races in rcu but only found out some of them had =
already been fixed in rcu tree but not in linux-next.
>=20
> I have pushed all that I have queued other than the last set of five,
> which I will do tomorrow (Prague time) if testing goes well.
>=20
> Could you please check the -rcu "dev" branch to see if I am missing =
any
> of the KCSAN patches?

Nope. It looks good to me.=
