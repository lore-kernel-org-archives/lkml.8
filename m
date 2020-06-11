Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE54C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A200920792
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591898470;
	bh=ZvB6xGLGbaXd7GYLGjnjcoJ6qL/EFOX+NtFTVjvcGz8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YQmjjGyQ37NrfDaFzcsjdp65TDLvQseI5H31AnG7fZdW5cQtm5A1Vwix7rmI8w41u
	 ptSZa8GmGNPwqNAaWA8dojyRmmxmNev+2aFUkvs4eCYpq2moafTwlHErvB2R3gjiqI
	 m7y66d5ufUp9JVe9Ox7aXGgsscr8P+TkQeIeGBxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgFKSBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgFKSBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:01:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228F8C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 11:01:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so8006289ljv.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 11:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BulRtyYimxYCM3JqpK8tF3IaJrXUR0A9VD3QaE4GUiU=;
        b=F+EXHlVbvkMTRVWWzv8ZcPEHGpfAID2Da8N5jJ9jwq/Sk5UFdV4BndnY890mbolBO3
         xJbuERV3mR0f+F5yKntH8xwiKR2kUGoUueLXNO5RnIgcO1PBh7DEHUydmD5yKAclq+vQ
         balMdqIjrUuK2NFsEurmgSTtX0E/N5pRMm69I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BulRtyYimxYCM3JqpK8tF3IaJrXUR0A9VD3QaE4GUiU=;
        b=D5zJHQH3rv8JEHtNNoWq9lFXmnqY3CttiOxZ2esT4DAqyi5s7WbYiEqJe7tNbODKsj
         4LXhi0woV/6+nAFJL0b/NTl3m87KK9kATdEeyXN7G39siAlyRe2agq6ZrXrx70tktT2G
         Ip3jyAoCF3XUJYlSiJK0Sy0db0UE2buI1Y25DD91Wsvb5UbXcJljJdZ8g4CgOXJvQG2D
         1l6UWGz6Vkqb0u1bhZqEd9+BmQB4JIRIf/aD8XLoqgYuL1a2/0ORRAQ4SWf/rMW7UAxH
         Ywvz8Dqd4HNRcd35uZNx7aJMT5E8+jtevRyKh/FByPU/Cu84YPwc8tlcr/1PXISR91bi
         OAIg==
X-Gm-Message-State: AOAM5312qerAmR6ZHi/lW98tjic97F7jS1PsJvQcvRy9CU1QZUX9G89l
        +J6lzoLGWFuCs+7t+yizhe957ggUKuc=
X-Google-Smtp-Source: ABdhPJx4w9ts5enygS4N/8zPyZOrF53Xk+cI+dr0LcDRWVtLAm52MXtTNlH+lQgAajaeKdQmk1iyIg==
X-Received: by 2002:a2e:9b16:: with SMTP id u22mr4667371lji.295.1591898462374;
        Thu, 11 Jun 2020 11:01:02 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id w24sm885303ljd.14.2020.06.11.11.01.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 11:01:00 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id i3so3466588ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 11:01:00 -0700 (PDT)
X-Received: by 2002:a2e:8e78:: with SMTP id t24mr4854187ljk.314.1591898459839;
 Thu, 11 Jun 2020 11:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200611024248.GG11245@magnolia>
In-Reply-To: <20200611024248.GG11245@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Jun 2020 11:00:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTMxCAHVgtKkbSJt=1pBm+86bz=RbZiZE-2sszwmcKvQ@mail.gmail.com>
Message-ID: <CAHk-=wgTMxCAHVgtKkbSJt=1pBm+86bz=RbZiZE-2sszwmcKvQ@mail.gmail.com>
Subject: Re: [GIT PULL] vfs: improve DAX behavior for 5.8, part 3
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, ira.weiny@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 7:43 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> I did a test merge of this branch against upstream this evening and
> there weren't any conflicts.  The first five patches in the series were
> already in the xfs merge, so it's only the last one that should change
> anything.  Please let us know if you have any complaints about pulling
> this, since I can rework the branch.

I've taken this, but I hate how the patches apparently got duplicated.
It feels like they should have been a cleanly separated branch that
was just pulled into whoever needed them when they were ready, rather
than applied in two different places.

So this is just a note for future work - duplicating the patches like
this can cause annoyances down the line. No merge issues this time
(they often happen when duplicate patches then have other work done on
top of them), but things like "git bisect" now don't have quite as
black-and-white a situation etc etc.,

("git bisect" will still find _one_ of the duplicate commits if it
introduced a problem, so it's usually not a huge deal, but it can
cause the bug to be then repeated if people revert that one, but
nobody ever notices that the other commit that did the same thing is
still around and it gets back-ported to stable or whatever..)

So part of this is just in general about confusing duplicate history,
and part of it is that the duplication can then cause later confusion.

                Linus
