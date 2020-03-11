Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	PDS_HP_HELO_NORDNS,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44081 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbgCKRVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:21:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id b186so2312132lfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:20:58 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id f26sm25221210ljn.104.2020.03.11.10.20.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:20:57 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id l7so2388128lfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200311162735.GA152176@google.com>
In-Reply-To: <20200311162735.GA152176@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Mar 2020 10:20:40 -0700
Message-ID:
 <CAHk-=wjES_Si7rUtu_EuYu4PDz4OGdA4BWhYGJ=zOoJiELiykw@mail.gmail.com>
Subject: Re: [GIT PULL] f2fs for 5.6-rc6
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List
        <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200311172040.8d0--SGXVHqp7SruIxIXDYHaRTToZRfr9re_0YukBGY@z>

On Wed, Mar 11, 2020 at 9:27 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> Sorry for late pull request. Could you please consider this?

I pulled this, and then immediately unpulled.

Most (all?) of the commits have been committed basically minutes
before you sent the pull request.

That's simply not acceptable. Not when we're in late rc, and with
hundreds of lines of changes, and when there is no explanation for a
late pull request that was very very recently generated.

                Linus

