Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1E4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3882F2075F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7nH/71V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404469AbgE2CDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390805AbgE2CC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:02:58 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801C8C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:02:58 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id mb16so483523ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zR58kZNkDITa3zkTRVIi9Vv+iIxtpv5vYAhOcit9LUI=;
        b=S7nH/71Vpr+3SyllwwS7tZsIiGVMAwRxpn8tZQtlVVfv/+0pwrXniGDAQvL1xS3QGh
         j6N9ySgl9oxTOxSVpeny4vGIA6onFpb515ACrcnkxQTqc1dqXG8z9eaOvZHmoWh0akmB
         5U4Atvj08baUPGMWPrBO1BEvWLBUaVvbH0c1TeogyPJOl4K19F1bbpp1lQqcbTK0BYp/
         Oh+u3eLTF8/bxle3ZJeAhloD3xA8CtaoFsz0QXeCFsyPlMH0XNAqAi3E4rEz6T8uqVYF
         vDYPeTu4h1FukdrMd5O9hL8GDb10nzpEqwpXYBgmK2mm6HQ5YQTn2szUINiCvgaYbB0X
         r4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zR58kZNkDITa3zkTRVIi9Vv+iIxtpv5vYAhOcit9LUI=;
        b=sEC+2PX4mzjh0OdExwO9dHFb9NeFm/u589Sywd+NfWZ0PhhQBYX07qIj9/rktRKfOg
         00D0oF7sdxU+XSwlNXiHtvNbDHypWAVljfFpJLf4z/sgKEgnDaOBITB/ZLvlCmLQdei1
         vPvDYocefRgoMDoo87/c/F9eWgmsf4SbCrABj+4yuQuGgTzB6LkFGXwEhbOTpdybDkwp
         rZyaSoovZm64OjkKK9O7jExYN9tBS3xp+A9WtsWlzr1HZWMcRpRrTFxZj6B/fEaRWlSG
         fLx31L8dDgS6AnsDn1nm5n4AWZIo3OhCWLY7MOHWLAcZ1sy8ntIAlw8Vpm1qbI0Eurvj
         u6YA==
X-Gm-Message-State: AOAM531juA9abCL6+sU/UxhV0UdRUyqd3pfRjVRdKJ1WBvjqr4ptNaz0
        o25KTCQ4HSnCxZxnk1jXUi7ndyJFNrPPCpUZnGpISwPrupY=
X-Google-Smtp-Source: ABdhPJwCHqfRwTsoKAcO4U64g1rHpI/UOlZrfwrpHlnqUK2gBOvZPVU1dHxRLKJPnEFuqYpl9g4tjOjUiq/dxLRQpJA=
X-Received: by 2002:a17:906:fb0e:: with SMTP id lz14mr5481366ejb.237.1590717777003;
 Thu, 28 May 2020 19:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9ty+Vyn8aSxNqWY+_KEnqj8nGZbp2PRJTvQLcV1iPhG7dA@mail.gmail.com>
 <CAHk-=wgo1HUhSj-kGO8u+iUCxp+QS+rNenbM8gywbF3pdQ_DQA@mail.gmail.com>
In-Reply-To: <CAHk-=wgo1HUhSj-kGO8u+iUCxp+QS+rNenbM8gywbF3pdQ_DQA@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 29 May 2020 12:02:45 +1000
Message-ID: <CAPM=9ty5ce2mm7Di6qvRKy2Jg2Tw-Cd8U6ypN=Abc2NCGmQWWQ@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.7-rc8/final
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 at 11:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, May 28, 2020 at 5:21 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > Seems to have wound down nicely, a couple of i915 fixes, amdgpu fixes
> > and minor ingenic fixes.
>
> Dave, this doesn't even build. WTF?
>
> In drivers/gpu/drm/i915/gt/selftest_lrc.c, there's a
> engine_heartbeat_disable() function that takes two arguments, but the
> new "live_timeslice_nopreempt()" gives it only one.
>
> I'd blame a merge problem, since the failure is in new code, but the
> problem exists in your top-of-tree, not just my merge.
>
> In fact, it's not even your merge of the i915 tree that is the source
> of the problem (although the fact that you clearly didn't _test_ the
> end result most definitely is _part_ of the problem!).
>
> Because the problem exists in the commit that introduced that thing:
> commit 1f65efb624c4 ("drm/i915/gt: Prevent timeslicing into
> unpreemptable requests").
>
> It's garbage, and never compiled.

I thought I'd dropped the ball completely. but I see it's a selftest
failure, I must not have selftests built in my config here, I don't do
exhaustive builds randconfig

This has also been built by Intel, but I'm assuming they missed their
selftest bits as well.

I'll revert that and resend.

Sorry for the noise. I'll add self tests to my builds here for future ones.
Dave.
