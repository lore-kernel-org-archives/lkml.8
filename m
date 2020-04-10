Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BB8C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A462083E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RdcC29kc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDJTqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:46:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36381 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJTqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:46:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id w29so1922595qtv.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 12:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=F5y8G2ip4xuhyU3WnBDbQ1uPS5AxvvCzzzUjKWHG9gc=;
        b=RdcC29kc5rL57CBoaT4QFEsJaBb9aP5kNW/84IgWgru4NTv2z1oN/vpUwgEn4E27Hd
         IYKtm19F7wu2McF10fcwc0YtUcVhxSrSmIJxfszq5+Dxo77bHgdGhXIo6zWNs01RnWTw
         xQA7zR5uP40nHyp6EeefSUtcERNO9FJ4VmVvwKwXFgvVr/v3xmu/cDlZtydiTZG4gNXD
         tdVa1z8SU1h5RHXegOFlFfqf6VMfyU7cJItiCoO7k22wx05eQDaXniz3iL4N3X5S9bEB
         dyadyCxdxxdQYR/E1lVVjFuy2zXdMGnegb9s/MqpuYcqxFAdn8NDfJSD/YbN73foU7Sg
         ROYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=F5y8G2ip4xuhyU3WnBDbQ1uPS5AxvvCzzzUjKWHG9gc=;
        b=NoIg6GUmZ7alU5YKwqegohgKG8lvhGVypOVphU2YlW92/s+b94c1Am6KJJl3Xb6VcL
         zfus3bCyyHLSUjrV4Xz2KSdZocBOSNstKDg/s4qNngajk0CaEwClkXTxMryz8O7VrY3J
         khiB0cA/CHeAwXi11YYBVbEpqrZl8Af6cqgpjCceb55UFA3OXUBu7NS6VvQfM5S1w1bC
         ngVas3KACVXJRNFAYiM6BZq2LIgeZAnx0nKWvZCRJup8PDL80g0OmPbq+TaMQJOPpwxO
         bRKCyaYqCK9CPdCIzrjh5snSqc4j5b+S4+VrcBB4DwgRUy1pGyejZoe1A+l0Gdzr+S+9
         +GOw==
X-Gm-Message-State: AGi0PuZ2lgC+Wo+cSFsjtlHJDE2lMZaoZUN9qTQAzkE2VVBtnU6utk2c
        Zuh8MYydio4reN84KjNnharGgg==
X-Google-Smtp-Source: APiQypLzUx9NLNu8LTprK3q7/R9+mSDTk92NE6bqb0JzWoLhJXFKnE4hoN4DQl4jVYoZ8afqSwfZfw==
X-Received: by 2002:aed:370a:: with SMTP id i10mr840704qtb.114.1586547991375;
        Fri, 10 Apr 2020 12:46:31 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d23sm2258415qtj.9.2020.04.10.12.46.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 12:46:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200410102609.245f93639ece2667c3f70e5c@linux-foundation.org>
Date:   Fri, 10 Apr 2020 15:46:29 -0400
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9846F450-528E-4690-9A34-9EF4FA151B7A@lca.pw>
References: <CAHk-=wjfngA7nHAsie7bW_JmKBhUyV9oV7zmDbZuchkJK3sR1w@mail.gmail.com>
 <AFD0DADD-0558-463F-B219-5F098E6C2EDF@lca.pw>
 <CAHk-=wgFn4rHZM8ttPWvdSzV3pL1nS3EDcAh+83OObObkot4-g@mail.gmail.com>
 <9C21961E-24D3-4C97-A5AB-B70451E4F952@lca.pw>
 <76e8bbed-21d1-22e1-4148-5a5766652c0d@I-love.SAKURA.ne.jp>
 <22DAFAC7-9F39-4042-BC79-B27963A13E3D@lca.pw>
 <20200410102609.245f93639ece2667c3f70e5c@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 10, 2020, at 1:26 PM, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Fri, 10 Apr 2020 10:26:23 -0400 Qian Cai <cai@lca.pw> wrote:
>=20
>> I don't set panic_on_warn. I'll deal with warnings afterwards.
>=20
> I'm not understanding why sysbot sets panic_on_warn.  This decision
> will needlessly turn many kernel errors into wont-boot situations and
> will block further testing?

I can feel that it is very reasonable to set panic_on_warn for the fully
automatic systems because once those warnings happen, the rest of
things can no longer to be trusted, so the goal to kill the first enemy
on sight, and then deal the next one.

It could be a good idea for some trees more stable like the mainline,
but for linux-next, I could only dream of set it one day.=
