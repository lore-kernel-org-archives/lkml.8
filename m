Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94FDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A5ED20575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tg2zq48g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgEMU2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 16:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgEMU2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 16:28:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BA9C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:28:51 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l19so1023219lje.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OOQgC2pf3B5Syf6TLKmIKrEujD9kNRWMlMv5Dc9hpys=;
        b=tg2zq48ggb01lc1z0JO1uiDii+dFz54eCmdaVZV7Te3ADliC0G8uwavNfi1lCTUGuu
         AQIoKttlb7g6l7GDyweeKO5Z+u3LzolKkuhkDuT5A5zNPHQqPOx51MQJtASNLNn6BLdy
         Ot4jXeGlUtzLsKfq9+yF09fkqNuZ5vG7wHCTX94DXX4JEYUsAVSYu2+k0Wz+AIfLOxDZ
         farZyx4EJiy/RQpNa0rAnYufz3jtfa+1IZfWnqo24SrDfPf7HBZT/f66J4pKMI0xFBHk
         ALYfsYuNcE25zMN5VIsSGCdJbLdV6uNB1y4MZiD3j9rPFBJ91EEd8Rtdk4okGHvorArR
         nfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=OOQgC2pf3B5Syf6TLKmIKrEujD9kNRWMlMv5Dc9hpys=;
        b=T45Pmg+bP+Sbyo53byTy4w9/Lvfudn30NrYqeIa0YA2TabD5eP7IfJp21HRrV7zqqj
         q71gDGn94fhY7Iqz7ELrdkGiOQr2HJCiMyGlUXOpLbcj+EMmebhSP7ghT+Zt9ZqTiT+8
         P//NEdswD3RegC1JxnqaZ4ZtCH7UCjY3yD3S4oDBirOzRvVt7/WFMBNwfx2JeXHjoAXR
         4dGp8zQqmTODWlFhTQQU6zkAG0u6OngEZbO76lGmcQAeAqVDdDyAVo7TUT+bnC3cjPTm
         iongwuRkjEgtHOrqEMXfDBVek1TEAZMdZ5F+2P6faBoXAxa3CpsY5zBDcBmRjb4xbvtM
         pk3w==
X-Gm-Message-State: AOAM531hpFTkFprU3RZQM9fB7kU/A5kDbl01a5rBYh6nQN+kvEv3dVCr
        pSRVnjEH1fCBo7WDO0uXZs79H9bD
X-Google-Smtp-Source: ABdhPJxYNrTA4OqXKI8N1gCV7LUF0LK6gssfaCCOp2dYmy7WqCWnbLaSzs3XHkhXJGn+TEQonGXfZw==
X-Received: by 2002:a2e:9b50:: with SMTP id o16mr524289ljj.164.1589401729746;
        Wed, 13 May 2020 13:28:49 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u3sm364355lfq.59.2020.05.13.13.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 13:28:48 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] uapi, posix-timers: provide clockid-related macros
 and functions to UAPI
References: <20190923130531.GA27774@asgard.redhat.com>
        <87y2pxvsbr.fsf@osv.gnss.ru> <20200512223103.GC1016@asgard.redhat.com>
        <CALAqxLUGr=+UjYhQSN34fUMCqj1Ya85tbFKu685cN+XTWYfgXg@mail.gmail.com>
        <8736845ha6.fsf@osv.gnss.ru>
        <CALAqxLWkQmiFOCY=YhQLCJHwGHCO9kfZzysCEDLzJFTvgapUwA@mail.gmail.com>
Date:   Wed, 13 May 2020 23:28:48 +0300
In-Reply-To: <CALAqxLWkQmiFOCY=YhQLCJHwGHCO9kfZzysCEDLzJFTvgapUwA@mail.gmail.com>
        (John Stultz's message of "Wed, 13 May 2020 10:11:32 -0700")
Message-ID: <87y2pvy3y7.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Stultz <john.stultz@linaro.org> writes:

> On Wed, May 13, 2020 at 2:13 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> John Stultz <john.stultz@linaro.org> writes:
>>
>> > On Tue, May 12, 2020 at 3:31 PM Eugene Syromiatnikov
>> > <esyr@redhat.com> wrote:
>> >> On Tue, May 12, 2020 at 10:58:16PM +0300, Sergey Organov wrote:
>> >> > Eugene Syromiatnikov <esyr@redhat.com> writes:
>> >> >
>> >> > > As of now, there is no interface exposed for converting pid/fd into
>> >> > > clockid and vice versa; linuxptp, for example, has been carrying these
>> >> > > definitions in missing.h header for quite some time[1].
>> >> > >
>> >> > > [1] https://sourceforge.net/p/linuxptp/code/ci/af380e86/tree/missing.h
>> >> > >
>> >> > > Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
>> >> > > ---
>> >> > > Changes since v1[1]:
>> >> > >  * Actually tried to build with the patch and fixed the build error
>> >> > >    reported by kbuild test robot[2].
>> >> > >
>> >> > > [1] https://lkml.org/lkml/2019/9/20/698
>> >> > > [2] https://lkml.org/lkml/2019/9/22/13
>> >> > > ---
>> >> > >  include/linux/posix-timers.h | 47 +------------------------------------------
>> >> > >  include/uapi/linux/time.h    | 48 ++++++++++++++++++++++++++++++++++++++++++++
>> >> > >  2 files changed, 49 insertions(+), 46 deletions(-)
>> >> >
>> >> > Was this patch applied, rejected, lost?
>> >> >
>> >> > I can't find it in the current master.
>> >>
>> >> IIRC, it was ignored.
>> >
>> > Overlooked. :)  Not intentionally ignored.
>> >
>> > I don't have any major objection with adding helpers, though I feel
>> > like you're exporting a lot more to the uapi then applications likely
>> > need.
>> >
>> > Would it be better to add just the bits from the missing.h header you
>> > pointed to:
>> > #define CLOCKFD 3
>> > #define FD_TO_CLOCKID(fd) ((~(clockid_t) (fd) << 3) | CLOCKFD)
>> > #define CLOCKID_TO_FD(clk) ((unsigned int) ~((clk) >> 3))
>> >
>> >  to the uapi header?
>>
>> Please, no:
>>
>> 1. These macros were copied almost verbatim from the kernel code long
>> ago, and since then kernel has changed them to inline functions, so
>> getting back to these obsolete macros is pointless.
>>
>> 2. If we do need to export macroses, then kernel inline functions are
>> better to be re-implemented in terms of these macros, not to have 2
>> different points of implementation.
>>
>> Overall, I'd vote for the current approach of the patch, provided
>> exporting inline functions to user-space is allowed.
>
> Sure, I just want to make sure we're only exporting the minimal
> necessary amount of details to userland. The current patch is
> exporting a bit more than that.

From userland POV, I've only seen 2 above conversions to be used,
and I have absolutely no idea if the other 2 functions:

static inline __kernel_clockid_t make_process_cpuclock(const unsigned int pid,
static inline __kernel_clockid_t make_thread_cpuclock(const unsigned int tid,

are directly useful from userspace.

Then, I now realize that exporting defines could be a better idea as
their existence could be easily checked from userspace.

However, exporting exactly these defines would likely break existing
userspace due to redefinition, so we probably need to come-up with
different names then.

And then it's probably C library that ideally should provide
corresponding interface to user programs, so there is yet another layer
to be considered?

Personally, I don't feel being experienced enough in kernel-to-userspace
interface subtleties to suggest proper patch that'd expose minimum
details yet doesn't create too much of maintenance burden both in the
kernel and userspace.

Thanks,
-- Sergey

