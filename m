Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22480C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A7020724
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFIDTDub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgCVQbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:31:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38905 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVQbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 12:31:16 -0400
Received: by mail-oi1-f195.google.com with SMTP id w2so1210967oic.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 09:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4iL/vxcmuCGdmEbGF65JPTkLwm3vbSnxis9k9yz7zYU=;
        b=CFIDTDuboOmS5h57Eudf0IOM+t8BzaWRSenk2qqS+UCiQSEQDcK68Ay6EsBL7FiqJe
         cRl715GSB3yvnyV3i7HqgOBcSIwatwYdyiCTcrSl2C+rsODPDabazvC5JL3l1e671qS8
         6MfpFENsIXCidvU9Vg9++kwJWzgjmArPMkjPE0KBnaYGCDbCFBfh1RNcv63cG7m/c5gg
         lBoDc75R1GAE8xmT4mBSdXZ8FN0ZWlEGz2iPuwsBZ8V6Nuo+ocqDsCSAlIONXFZFFtPy
         jm09NEk2e+679EIXBmgrgAHwxPLuFyMUkEOgeWPnDRdeGB8Cgf/mXV69Tq2JltuO/L/7
         8pDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4iL/vxcmuCGdmEbGF65JPTkLwm3vbSnxis9k9yz7zYU=;
        b=r4KrpryL0fsb3GsntMm88EG/4na03HXknYVqFCSEXiB9P/Ec9DHVeVt4uDo+yW5S6+
         PQ9DZsTDM3VVNCdPzSikvtqvQ5r7AWg9qJCFMnZgyC0qDc3BV87C1huCROpYcfFx9nnM
         OPsjR7HHL1F6FRKF7Z0KISdkN6rGR+uj2CA42YtHXtBzx5cacc3bVbMtcUBMOvRxJt4c
         bvxGTRsn2v/QLQ+hLCWT75cmwdN9ZQqfqPgNItM6ljKebNVX2K6JxWInxeheiGC+ASMe
         lUUlk5sCRzOvbjnp+5T7352CKDOFHk7+50J/M6GRxgjLMBcMk/BQpWDNwb9t7pDUxbiq
         Imlg==
X-Gm-Message-State: ANhLgQ0oiugjl0QKxCbm7KGrjp+KvOZg9wi/efEYXILyiMAl0OwW+rEU
        tf4m6pLOcwx4imylgmbXTai7RspP9nq+b9e1UZBQ2Q==
X-Google-Smtp-Source: ADFU+vvf96FZtlsIS//BVK2SjBJ0SPGxMqpePrWO3JlyPSAiQzURgqIuQEuzA9/RPMvltp9B0Rl8UZJfYgX3OvsxOoA=
X-Received: by 2002:aca:ed54:: with SMTP id l81mr14515219oih.69.1584894675252;
 Sun, 22 Mar 2020 09:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200322013525.1095493-1-aquini@redhat.com>
In-Reply-To: <20200322013525.1095493-1-aquini@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 22 Mar 2020 09:31:04 -0700
Message-ID: <CALvZod4GjRFLRX=S_YFYnJk-kL6tjveYEDOBFS76NqrURERHHQ@mail.gmail.com>
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
To:     Rafael Aquini <aquini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 6:35 PM Rafael Aquini <aquini@redhat.com> wrote:
>
> Changes for commit 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")
> break this test expectations on the behavior of mlock syscall family immediately
> inserting the recently faulted pages into the UNEVICTABLE_LRU, when MCL_ONFAULT is
> passed to the syscall as part of its flag-set.

mlock* syscalls do not provide any guarantee that the pages will be in
unevictable LRU, only that the pages will not be paged-out. The test
is checking something very internal to the kernel and this is expected
to break.

>
> There is no functional error introduced by the aforementioned commit,
> but it opens up a time window where the recently faulted and locked pages
> might yet not be put back into the UNEVICTABLE_LRU, thus causing a
> subsequent and immediate PFN flag check for the UNEVICTABLE bit
> to trip on false-negative errors, as it happens with this test.
>
> This patch fix the false negative by forcefully resorting to a code path that
> will call a CPU pagevec drain right after the fault but before the PFN flag
> check takes place, sorting out the race that way.
>
> Fixes: 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")

This is fixing the actual test and not about fixing the mentioned
patch. So, this Fixes line is not needed.
