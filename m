Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28622C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA37204EF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MeStlUVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgFDRql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbgFDRqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:46:40 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7392AC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 10:46:40 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id k13so4019146vsm.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+DfKN1U5A03BOeIRGNtGiuZF8U9fpy/yodWoM58tKM=;
        b=MeStlUVuDIDY8xlSqAdqiPbvepR4yUM08hcSMfi+Bf9woO4keQy4f9hJFgaegH3vn9
         QfqNz8NGOOVFillN/77/HKy930Ycko1/D1/85dJ3VnTUyDq0l8r4IUcREybotGncf836
         Kdd/d1vBIM9HazX5nDs8lehudmCBjs2RicpWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+DfKN1U5A03BOeIRGNtGiuZF8U9fpy/yodWoM58tKM=;
        b=selylnRCZo158n0JlPBf2+HRqy2zTP5LK8UxgnwvY2gVIIn9YGgpN7REMosmdU0gT7
         MmAOwUzmUDy/PrnP61E0NxdnmxmdH3DaFTqPmV+2MALUjLwHNnc6ug43vwm6yk8uR2Ey
         fTMcxNW6lTUR64PbG2jdzRJxWaKZI6dnQsaUhIktXXogRRIpb9l+KnanzUq7IDid+MCa
         /fAQ7jbloYuz6BDQfTLCVtdAsNJUIWHAipdVLaRMDysRwfTMR3u/KB88lKrpDjxeTYE/
         r6FMJdFhDXWFcgQp/jDZsvkvGNYR6TtXgegUrvZNhdBLxhRWKVuy2INGcTP+PtziDnMz
         zEgw==
X-Gm-Message-State: AOAM532u5tQtnXJRYtgYmTH1xCIl+44NX20b7D8vU25lo0sOy2lh5wUH
        V9ghTZDHkmqtJ8XrdXqj7Lw+mqIB3qs=
X-Google-Smtp-Source: ABdhPJyuwtBinWbDty/wBUCNCpacrVZqKkOQtteED00rKffRm+4Mc9bKnLEEpU6XvQnvF6VPTUX/BA==
X-Received: by 2002:a67:4383:: with SMTP id q125mr4293049vsa.167.1591292799212;
        Thu, 04 Jun 2020 10:46:39 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id q76sm855008vkb.36.2020.06.04.10.46.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 10:46:38 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id v6so2362357uam.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:46:38 -0700 (PDT)
X-Received: by 2002:ab0:1684:: with SMTP id e4mr4429632uaf.22.1591292797964;
 Thu, 04 Jun 2020 10:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200507153444.1.I70e0d4fd46d5ed2aaf0c98a355e8e1b7a5bb7e4e@changeid>
 <20200519104151.6evv3hizm5dbjjq2@holly.lan> <CAD=FV=XCFxgO-s--jw9CTgQUxtQfteoQ4XSL_bbjW4s82Wd3pg@mail.gmail.com>
 <20200601161952.3hx6sv5hzdnjnvtj@holly.lan> <CAD=FV=UJLTuMp0uvTY0rC51ir_GgRKYxiPCK_w8TY+MBzkqjeA@mail.gmail.com>
 <20200603120051.dxpavvsxvsxnvuct@holly.lan>
In-Reply-To: <20200603120051.dxpavvsxvsxnvuct@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 4 Jun 2020 10:46:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=ULq602hW2cvzfCN+QK_kcrd=wZUXfRJDLMzqJted4fog@mail.gmail.com>
Message-ID: <CAD=FV=ULq602hW2cvzfCN+QK_kcrd=wZUXfRJDLMzqJted4fog@mail.gmail.com>
Subject: Re: [PATCH] kgdb: Avoid suspicious RCU usage warning
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 3, 2020 at 5:00 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Jun 02, 2020 at 03:56:33PM -0700, Doug Anderson wrote:
> > > > 2. Perhaps remove the whole irq saving / restoring in kgdb_cpu_enter().
> > >
> > > Are you feeling lucky?
> > >
> > > I think there will come a time when bravery is called for but I'd rather
> > > see this as part of a bigger rewrite instead of a single high risk
> > > change.
> >
> > Hrm, maybe.  I guess it depends on whether we want to take baby steps
> > there or try to do it all at once.  If we take baby steps we will
> > occasionally fall down but we'll slowly start getting things cleaned
> > up.  If we wait for a full rewrite then we might be waiting for a long
> > time.  It'll also be harder to figure out which of the big changes in
> > the major rewrite broken someone.  ...or if the major rewrite comes in
> > 20 small/bisectable patches it may be hard to revert patch 2 out of 20
> > if the future patches all build upon it.  If we do one small high-risk
> > change and then wait before building upon it then it'll be easy for
> > someone to bisect and then yell for a revert.
>
> My views are a bit too nuanced for me to agree or disagree with this.
> I'm not against baby steps and I definitely *don't* want kgdb to
> continue to be preserved in aspic.
>
> However I'm still reluctant to start our baby steps with a "let's see
> if this breaks something" patch given we know it could be a very large
> number of kernel cycles before we get an answer.

Yeah, it's kinda amazing how much of a delay there is sometimes.
Perhaps all of the kgdb users are off on downstream kernels so they
only notice changes when they re-sync up.


> I would be much
> happier if those baby steps started, for example, with refactoring to
> decompose the beast into clearer (and dare I say better documented)
> functions.

OK, makes sense.


> Or put another way, even if someone sent me 20 small bisectable patches
> in a single kernel cycle I'd still want the high risk bits to be
> towards the end of the patch set.

OK, fair enough.  You're the maintainer so it's your view on the
matter that's the most important.  I guess one worry I have is that if
neither you nor I really understand the code path that a theoretical
system would take if it didn't already have its interrupts disabled
it'll be hard to keep from breaking it in making other changes to kgdb
in the future.

Anyway, enough discussion for now.  ;-)  My v2 should work like you
suggested and I'm not planning on any other short term changes to this
function, so we should be all good right now.

-Doug
