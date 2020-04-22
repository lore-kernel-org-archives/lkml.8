Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AF9C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA4362076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dECYwC87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgDVLFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgDVLFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:05:53 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51283C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:05:52 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id j4so1626617otr.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ua829JJkYBZUaS7OvERcUI6nSagxxxKkmMkhojcO/w=;
        b=dECYwC87TGzR0PPYXGM4EoY/ahwVrWMHIcNp4S24KkPjixaFvhz85M3MQzFjQ4/zsJ
         rCKJEJKdVPld8GIqAJu5Hk023HPbBYugaOcvd5NHFIvMwVIi4lLGDn1prBJusUXfeh/k
         96K8Lyfup1w7v7OOHoACpRPNQaZs+w9ZxrWIGQTce6MR0qvLCvcrlByWIp5Xo9r4AiZB
         R/FsqoDqjQB9NntpPixHFVdBc+IxLz4Ad8Iu2bGL++oh0Ck27PlFAKoP2wX3k5A34Pvk
         hcxSYF8fAqT8mCQJiodnCaQzfn8T4gilCVJ/xmTSrWsxwu5JzLI8SSQBYCgnxRvkwI05
         OUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ua829JJkYBZUaS7OvERcUI6nSagxxxKkmMkhojcO/w=;
        b=nMv0GJnYcahFgSWIIIAVrXp0mF4cZc5lEj4dDUy+x1naxT6BWjb16jRjaWUNG5yp/l
         7h5VqolY6F+4LLR3Whkh6BXwnkqpaOrwoQ1sUiAHjQIm2Y8HW0b52Z2izSx7nYmbNQZu
         WD8H4rKTel4t6hLVZEcxVahZNebJkn4Zog4zN6Dry6F3NqFVgiF7Q7C6UVf9Gwh/Ks3D
         uZ8V5YPg8RFWChytT6iRfxiI8dfiCtYoe+gE323eKocbbfblO4QoVShL6gwx/EVivr/Q
         306lJkAWTjSgIQVro7BwqylSBhih6Qqg12t1sjXToZdTSG56031l/mWJ4lWRcvCbbTmN
         L9Og==
X-Gm-Message-State: AGi0Puas8MWt73lbCPV41XMxBOQhBmO1IaVRamOZ4gLU+IhA0WLCY3Li
        YPluDDW6pj62j9KUM3rXB5ryIEFd3UjvUxS0zv+jdA==
X-Google-Smtp-Source: APiQypKqDQFlwlVMNU/xBAKxK9coMX73yES94AnayN5DUQJdaeHSzK+8UbzFgxFMv1bYxzq/04dqTJkLMaFLEOdKrAA=
X-Received: by 2002:a9d:412:: with SMTP id 18mr17906271otc.233.1587553551366;
 Wed, 22 Apr 2020 04:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200416114256.226329-1-elver@google.com> <alpine.LRH.2.21.2004171103160.32364@localhost>
In-Reply-To: <alpine.LRH.2.21.2004171103160.32364@localhost>
From:   Marco Elver <elver@google.com>
Date:   Wed, 22 Apr 2020 13:05:39 +0200
Message-ID: <CANpmjNNsSX+C1oXezj+WuW-DQpGJ2ETvqH6n6XryVwmKB0phxw@mail.gmail.com>
Subject: Re: [PATCH] kunit: Add missing newline in summary message
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        frank.rowand@sony.com, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020 at 12:03, Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Thu, 16 Apr 2020, Marco Elver wrote:
>
> > Add missing newline, as otherwise flushing of the final summary message
> > to the console log can be delayed.
> >
> > Fixes: e2219db280e3 ("kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display")
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> Thanks for finding/fixing this!
>
> Alan
>
> > ---
> >  lib/kunit/test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

Which tree will pick this up? I cannot yet see this in -next.

Thanks,
-- Marco


> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 7a6430a7fca0..ccb2ffad8dcf 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -93,7 +93,7 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
> >        * representation.
> >        */
> >       if (suite)
> > -             pr_info("%s %zd - %s",
> > +             pr_info("%s %zd - %s\n",
> >                       kunit_status_to_string(is_ok),
> >                       test_number, description);
> >       else
> > --
> > 2.26.1.301.g55bc3eb7cb9-goog
> >
> >
