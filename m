Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69491C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44E8B2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ESkBcoVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504751AbgDNT2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504730AbgDNT2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:28:44 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57030C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:28:43 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id t3so10821470qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IORMumCebuze4EyI4LOyKESUzl1Jcbf1Jp+K7sS8I70=;
        b=ESkBcoVswaFsly4kmPHKJVb+78TgajiEpVqF1tU8LgTu2iXzxsXcGjF6O4bKbweLq1
         yAQyXkmWSkH2sJteZkfThdHQuCVtX1fQnjNJNaUhMmNW8h3CJ71kdPd2cvsWt6Fb0CVO
         GSik1aq66pL6+LZtJGgw9+TAdLXakjfM3U6maibzKy4wrcqSd3Y2xxIvL+CgzJDFI3Xp
         iMAHRD64SR81483P2dlIEAK1g+52a29rb9wNCuZY4ejZVt5VR3Fn8kBmkuCSrv0CJ2q9
         PQ3p0/IQVHwYXwHjfJkdI8dsgbY5bPk90FFDhPPafBqy9qH5KsM2868wUhY67qDcrOSK
         yXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IORMumCebuze4EyI4LOyKESUzl1Jcbf1Jp+K7sS8I70=;
        b=eyPITpFah5eZKa5MX/MMYmekoq/wXAFt8Ags/rLGpV+T8i2UYNhYU6zkGqx/YBFCPY
         v25as7MB3H+lW8VC+Dm7Aj8j5F17KHmFi7A88AiH06hEj/6vI5hW/tOzzksXnhhf8a9z
         mZoxULQRuo7x7dzPC3s3NS6fxLk3AK0xEed1EQUrj09S7KzRe7iyJnXUnkUlxaYuUfOT
         /txlmj4cfx5yXFZiiG0hMFJktp9KOQ900ZWXrJ94lOar4ehRPo/YgBLQdMoscJsNKORK
         EtT9dXEaJ4Zn7MrWcb1YYiAEggBp5lw734//VC/Pd5yP6HPgPBwPqGAiLef6Pv6WwpOR
         Jw+g==
X-Gm-Message-State: AGi0PuaKSvlo4eUcE+QAV84+Z2b3j0VoqchtTqmWOsxP6Cv1KYS/bfR7
        AjczAwYGlY9wwHhxX+dQCWaQYg==
X-Google-Smtp-Source: APiQypI3u+h9kUnqMBm13TwpxGsENaSz5GhDxDugW473o9Jks3w0wtIYTRQcpCEOvn4Q7jD3a2excQ==
X-Received: by 2002:ae9:e214:: with SMTP id c20mr11087674qkc.107.1586892522518;
        Tue, 14 Apr 2020 12:28:42 -0700 (PDT)
Received: from localhost ([2601:441:27f:8f73:faf4:f79d:8a53:5ca2])
        by smtp.gmail.com with ESMTPSA id m1sm11944411qtm.22.2020.04.14.12.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 12:28:41 -0700 (PDT)
Date:   Tue, 14 Apr 2020 14:28:40 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Qian Cai <cai@lca.pw>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Message-ID: <20200414192840.4yp3zqbe2tgtesve@xps.therub.org>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
 <CACT4Y+bhQVcpSkSh_OZ5ZanfFZUqn2iypLhG_Z-nWKTkaYr1jw@mail.gmail.com>
 <CAHk-=wgjGgfUfVm_DpTay5TS03pLCgUWqRpQS++90fSE2V-e=g@mail.gmail.com>
 <20200410092951.6db32bfe@canb.auug.org.au>
 <7325374A-6072-44E4-85EE-F97FC7E8565F@lca.pw>
 <CACT4Y+ZE1XhYpTsjP1J1PyUsEHYKvchww71aHb7UnSk5=4xUrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZE1XhYpTsjP1J1PyUsEHYKvchww71aHb7UnSk5=4xUrw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 01:12:50PM +0200, Dmitry Vyukov wrote:
> On Tue, Apr 14, 2020 at 12:06 AM Qian Cai <cai@lca.pw> wrote:
> > Well, there are other CI's beyond syzbot.
> > On the other hand, this makes me worry who is testing on linux-next every day.
> 
> How do these use-after-free's and locking bugs get past the
> unit-testing systems (which syzbot is not) and remain unnoticed for so
> long?...
> syzbot uses the dumbest VMs (GCE), so everything it triggers during
> boot should be triggerable pretty much everywhere.
> It seems to be an action point for the testing systems. "Boot to ssh"
> is not the best criteria. Again if there is a LOCKDEP error, we are
> not catching any more LOCKDEP errors during subsequent testing. If
> there is a use-after-free, that's a serious error on its own and KASAN
> produces only 1 error by default as well. And as far as I understand,
> lots of kernel testing systems don't even enable KASAN, which is very
> wrong.
> I've talked to +Dan Rue re this few days ago. Hopefully LKFT will
> start catching these as part of unit testing. Which should help with
> syzbot testing as well.

LKFT has recently added testing with KASAN enabled and improved the
kernel log parsing to catch more of this class of errors while
performing our regular functional testing.

Incidentally, -next was also broken for us from March 25 through April 5
due to a perf build failure[0], which eventually made itself all the way
down into v5.6 release and I believe the first two 5.6.x stable
releases.

For -next, LKFT's gap is primarily reporting. We do build and run over
30k tests on every -next daily release, but we send out issues manually
when we see them because triaging is still a manual effort. We're
working to build better automated reporting. If anyone is interested in
watching LKFT's -next results more closely (warning, it's a bit noisy),
please let me know. Watching the results at https://lkft.linaro.org
provides some overall health indications, but again, it gets pretty
difficult to figure out signal from noise once you start drilling down
without sufficient context of the system.

Dan

[0] https://lore.kernel.org/stable/CA+G9fYsZjmf34pQT1DeLN_DDwvxCWEkbzBfF0q2VERHb25dfZQ@mail.gmail.com/

-- 
Linaro LKFT
https://lkft.linaro.org
