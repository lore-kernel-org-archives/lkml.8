Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C81C35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 04:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F45B24681
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 04:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PtLRFYdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgBYEsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 23:48:18 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:47103 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgBYEsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 23:48:17 -0500
Received: by mail-oi1-f194.google.com with SMTP id a22so11308704oid.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 20:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hFw/2+e8yIu+oTQjZtUyU9ErjqR4pVSuUZ3rcndg9o=;
        b=PtLRFYdfyktEzYOdMmbb3eY6tduFNbai+BV6dXjHQCTHU+3fydBmhbTlqegbs1yR16
         LPNSt855td+Q0EsunAbcNQj1mLHMp7F4jvI/ZmEmyHG/AKi/GXyE9EdahXOih1/2Lmyx
         jy/kxHEjGzdCyWqbc4cNybxMZNnupy/PgEawcaJ/tsZLG8bJLJ3dXRDhVjyngu645E3X
         jjeVWrkTqEjHjfL00MQXDmUJpuaicDcS9KPMCECwe1yu+LE48wXVUEejUkih+FBoWjhl
         XxWLgeAQjgqudo1cmUEZpS4KFF05sU/ytaHw136r5YPg9/5tS3KuszIAKr+UhOJm59zH
         2zOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hFw/2+e8yIu+oTQjZtUyU9ErjqR4pVSuUZ3rcndg9o=;
        b=cYzCVrg5S6KW6L6MnKx0dnKfp4xyYz4g3F0J04X6RRpI6K6WQMPESEmBFqCvSF3qwP
         dOXQBlLBEMM2p8IzuY/jp9tBMQH0vzWIHNWQz7EsJY2xsVxEboqHpL+BdVYPr4XCznNz
         QpnFuvPsegZ1y2X+R4yt4yr41lqR5RhkDmC7JhoeQWQ5qy3eAgCAXmuPiwReAaM6tew+
         dJPkxDuvwDw4dWaqsQOJAD+moM5/SMsVcK3KwjRdIOHOT3kuzMK9fOTxmkuIE2e0iGiz
         eHrK6vsjBXFdVOCszUBT5Yr1OlG23VWzSlEQnoIufDX0ZPsRBBpwa5eHfTt35pdT8mBk
         f95A==
X-Gm-Message-State: APjAAAUTQm+x6fAhE7ytkqL5U6E4giS/GE7Rb/p7podUsjH0JPWJteRF
        fC+ouPLTBS2SoGiHZIxI6MTNlYJQqdznyac3yA6Hzg==
X-Google-Smtp-Source: APXvYqwQ2ScdUlCWKvSQ/ccc0w/PD1wrET6jN+awWxy5+xpXca7W/SbgKWYlDVYNHanQ8IXhf/O29RbhRyXCMS/3WE0=
X-Received: by 2002:aca:50cd:: with SMTP id e196mr2001704oib.178.1582606095459;
 Mon, 24 Feb 2020 20:48:15 -0800 (PST)
MIME-Version: 1.0
References: <20200224235824.126361-1-john.stultz@linaro.org> <a8af6c423501d5d49f1d81997b3a2295c0df7b9e.camel@perches.com>
In-Reply-To: <a8af6c423501d5d49f1d81997b3a2295c0df7b9e.camel@perches.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 24 Feb 2020 20:48:03 -0800
Message-ID: <CALAqxLW7xjPh8SZtZ+ES9fghdMDQZfG_ToSrX+u7DMAOixyQ1Q@mail.gmail.com>
Subject: Re: [RFC][PATCH] checkpatch: Properly warn if Change-Id comes after
 first Signed-off-by line
To:     Joe Perches <joe@perches.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 6:13 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-02-24 at 23:58 +0000, John Stultz wrote:
> > Quite often, the Change-Id may be between Signed-off-by: lines or
> > at the end of them. Unfortunately checkpatch won't catch these
> > cases as it disables in_commit_log when it catches the first
> > Signed-off-by line.
> >
> > This has bitten me many many times.
>
> Hmm.  When is change-id used in your workflow?

Since I have a few kernel repos that I use for both upstream work and
work targeting AOSP trees, I usually have the gerrit commit hook
enabled in my tree (its easier to strip with sed then it is to re-add
after submitting to gerrit), and at least the commit-msg hook I have
will usually append a Change-Id: line at the end of the commit
message, usually after the signed-off-by line.

Even in the example in the README from:
  https://android.googlesource.com/kernel/common/+/android-mainline
shows how one might have the change-id and other AOSP tags added after
the existing sob-chain. So it doesn't seem to be that rare.

Some other examples from the android-mainline tree:
https://android.googlesource.com/kernel/common/+/5fba1b18cfc72e264e5f3ce49020ed322aa6ac9f
https://android.googlesource.com/kernel/common/+/6ea0a439a15ba42b6c5f81618e53d5c61f89e4ac
https://android.googlesource.com/kernel/common/+/99f4553ab4a6b008b37e878f7046a2202cdb2ec4

> > I suspect this patch will break other use cases, so it probably
> > shouldn't be merged, but I wanted to share it just to help
> > illustrate the problem.
> >
> > Cc: Andy Whitcroft <apw@canonical.com>
> > Cc: Joe Perches <joe@perches.com>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
>
> Yes, I expect this will break things.

Suggestions for a better approach? I can't say I'm very familiar with
checkpatch's code.

> And it's probably better to not add a Signed-off-by: when
> you intend this not to be merged.

So, I try to add Sign-off-by to all the patches I send as it certifies
that I wrote it or otherwise have the right to pass it on as an
open-source patch - not as "ok to merge" criteria.

More vendor code then I'd like is usually not intended to be merged
upstream, but it's still important that folks sign off their patches.
:)

thanks
-john
