Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060ACC2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C039920801
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586550370;
	bh=QP+3yBIEMTRQgOdOYKbUyPaKKRDowEcXxfvHia4gRAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XXmd5JTcxMQ6y6gK83sxVv1urP253tDhmesXPtq3gFTIMN6sk4DJKxVbEcz0RZxcU
	 TFOhvyngDP83J3Qumc9TbsdDt6E6nemy+NSY9Or2PMLoE9cYW0c79Wsrs9WNn8DayW
	 r7uAKPRUXTjRW1VinqKGU5tyB4+Cf2NUZqmq6FPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgDJU0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 16:26:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36869 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDJU0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 16:26:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so3103363ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 13:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VL5G+feLpx+wDhm+cmewwW7uP4NJGohhURRIHJyNA5g=;
        b=aIMiwRDsWaUzyY5lHMTHg1j4RJqrDex4FJ60YJcBuy+jRWovody2HZlxK+o2RIqO1S
         80/xhFpE6dAHEbmgGjIsTUsOachersAnIL8wwBbnEbFh9iwbx60G20XadHndczVNkHr7
         x3daGlDhxgT25W5BJwOrK6PI6Ue2SzcK/l8kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VL5G+feLpx+wDhm+cmewwW7uP4NJGohhURRIHJyNA5g=;
        b=q0BItLLRgAt1OXHThXFCvw/0aM7F8su6U1Aayle7UnXUdc6MBdbv/Ekjq5IICRzkRd
         uyQ7OEL7hOCnxR+Gn15p58aUL581at+2Kbxh2l26TYIxF0Atp4kTdPfFo+jW9awFxOhW
         W86vRAgbD10xyvviUr7PytGSgwq75wM8HOB6ahUY/B0mSMRTDoCb8mekMHsm94Oju7BU
         RimW8+Vlo5z6yyIQBWAEntK6PjcHzohn5rRtEwEE2cKSsyJnFGVlVu2q6eJil7YiwQgy
         HUopStJO4ywyiZR11hUjZIsK9rqI8aC/PxEOmaNHo4oHxa/US/NSo9vtWp/JL2sx+Y/v
         VJnA==
X-Gm-Message-State: AGi0Puap3PbV9dPWWVGJQpC4WWVCjmUQU+IpJO+wIwuQ3BKVHFYNdbaV
        PhNDqDZQ73UlbgSnDUF3Wrr+T09Bq9g=
X-Google-Smtp-Source: APiQypLmycSzU09OveMAoaN3E7qGET3QfcGT8w4rAaB/cQzczJJFAKwrF5qhJVhfcIQNpmY9g+nqeQ==
X-Received: by 2002:a2e:3612:: with SMTP id d18mr4047484lja.97.1586550366019;
        Fri, 10 Apr 2020 13:26:06 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id a14sm1716305ljn.60.2020.04.10.13.26.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 13:26:04 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id m19so2137916lfq.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 13:26:03 -0700 (PDT)
X-Received: by 2002:a05:6512:14a:: with SMTP id m10mr3550865lfo.152.1586550363330;
 Fri, 10 Apr 2020 13:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200407072047.GA18532@amd.ucw.cz> <158624426770.4794.6070200474948860768@build.alporthouse.com>
 <20200407074841.GB18673@amd.ucw.cz>
In-Reply-To: <20200407074841.GB18673@amd.ucw.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Apr 2020 13:25:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixvbCie+EQ-vTPdyrzmdopM_BQc=uetneuSSa7PtCt2g@mail.gmail.com>
Message-ID: <CAHk-=wixvbCie+EQ-vTPdyrzmdopM_BQc=uetneuSSa7PtCt2g@mail.gmail.com>
Subject: Re: Linus, please revert 7dc8f11437: regression in 5.7-rc0, hangs
 while attempting to run X
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Dave Airlie <airlied@redhat.com>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        matthew.auld@intel.com, Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 12:48 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> >
> > Beyond the fix already submitted?
>
> I did not get that one, can I have a pointer?

What's the status of this one?

I'm assuming the fix is commit 721017cf4bd8 ("drm/i915/gem: Ignore
readonly failures when updating relics"), but didn't see a reply to
the query or a confirmation of things working..

Btw, Chris, that __put_user() not testing the error should at least
have a comment. We don't have a working "__must_check" for those
things (because they are subtle macros, not functions), but if we did,
we'd get a compiler warning for not checking the error value.

            Linus
