Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE53C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BB720675
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Inj0g03B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgBKOLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:11:22 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38196 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbgBKOLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:11:22 -0500
Received: by mail-qk1-f195.google.com with SMTP id z19so7111652qkj.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 06:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JxcAI812j3A4wiV4/Vl6agE84VsHI1t5T/6vmM/XtsA=;
        b=Inj0g03Bqo4DTslNX4JeYV3v7BgtZxRmnjM18Drf2zdR/utbbwOcrDitc3JjOvJm+5
         StJ4EMkscwYO2n3aTrfptsuIGORbIVEqRtxzSo8KQbylkmPwpqZKj/pUBT5kL2yGKh2E
         05v6nulKDX51KplEM+IJOoIt76SuSv8Sfp+oAN09BIG2MopV0S+9LeDikiiVgvwm/yET
         o0/g1+I98KPz7YEKdbzwtqFOOLoUbAGykRhcon8/4tRwXPhGYubfwGAG/IG75IvbPGoC
         JwxSF83J+xddMbkLk5TT00Klrb17q9hH0YnBgNHyShiiH6S3u2kQvkg6gf2mHhfrsH07
         sAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JxcAI812j3A4wiV4/Vl6agE84VsHI1t5T/6vmM/XtsA=;
        b=hJlezcA6X/ZFiWzSSZItlHC86EV5OMe+/dQ2xXd9LO7BJND9Vb+D18gLltLiH81dlT
         CJjiuYg0WmwENY1UKMcTX2NA3hK/ezFImQ8wnYrdRBQQK8PExJgKYDaJExFJ7X0F5kd7
         99Ziv5MxCP1prgUaBtqM1Y5PK+ePVlDSWqobhn53J+nlkqjmIVFetcPcBl9bVmIOrShe
         taqHR0SfFOkO2/3hQZrKDXePcfrQ6TUcYBPBHxUu7gR4Q2P7NxhOZ536bdv1IwrhEM16
         RnNqaFIDkfT2QxJ78PZNnmCqKvXV6fIfpHmFnzSnbQ0vHaLELpbPLT4N8Iv59247jzls
         aAEw==
X-Gm-Message-State: APjAAAX+2RpCq2MfyIhchAS/Un+pT/0Zh9f+71hOK3WRidNJ4lMgbGbS
        DXG3AbyOkai4nhYW4/VAmWxf+mrKpOCTy8SfbaxSbA==
X-Google-Smtp-Source: APXvYqw79B+/BXd0sjIulsFNyks4vS4nF4A4ItWArGGHmw1SS9ENVSWXYcMVq/aZNNbcnH+Lqd1rycANCOaQxWwYlZY=
X-Received: by 2002:a37:9d95:: with SMTP id g143mr6128980qke.256.1581430281004;
 Tue, 11 Feb 2020 06:11:21 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003313f0058fea8435@google.com> <8736ek9qir.fsf@miraculix.mork.no>
 <1574159504.28617.5.camel@suse.de> <87pnho85h7.fsf@miraculix.mork.no>
 <CACT4Y+YgLm2m0JG6qKKn9OpyXT9kKEPeyLSVGSfLbUukoCnB+g@mail.gmail.com>
 <CACT4Y+ZjiCDgtGVMow3WNzjuqBLaxy_KB4cM10wbfUnDdjBYfQ@mail.gmail.com>
 <CACT4Y+ZWDMkOmnXpBXFhU8XcHA_-ZcHdZpfrXcCWHRzcbQ39Gg@mail.gmail.com>
 <ebc7b5e0-e968-0bdb-d75d-346e0b763d14@i-love.sakura.ne.jp>
 <CACT4Y+bDNjj_RGLtvRCaV3k9+QX4eENyKyWWAbsHcbwR7CDrWQ@mail.gmail.com>
 <CACT4Y+ZaNNAiRvKCMJ9t4H+H23OcjSd5haAcXkG68L8F6Mq6Wg@mail.gmail.com>
 <bbf26ea3-c11c-1cd2-0072-b78634ae9579@i-love.sakura.ne.jp> <c00063bc-cd0d-2469-5a72-d4d84c9abf3a@i-love.sakura.ne.jp>
In-Reply-To: <c00063bc-cd0d-2469-5a72-d4d84c9abf3a@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 11 Feb 2020 15:11:09 +0100
Message-ID: <CACT4Y+bDhsPDppUjYcm3QxgbjFuzAS1Wi5TEbPoif=iBNGYQjw@mail.gmail.com>
Subject: Re: INFO: task hung in wdm_flush
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Oliver Neukum <oneukum@suse.de>,
        syzbot <syzbot+854768b99f19e89d7f81@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yuehaibing@huawei.com, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 2:55 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2020/02/11 0:21, Tetsuo Handa wrote:
> > On 2020/02/11 0:06, Dmitry Vyukov wrote:
> >>> On Mon, Feb 10, 2020 at 4:03 PM Tetsuo Handa
> >>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>>>
> >>>> On 2020/02/10 21:46, Tetsuo Handa wrote:
> >>>>> On 2020/02/10 19:09, Dmitry Vyukov wrote:
> >>>>>> You may also try on the exact commit the bug was reported, because
> >>>>>> usb-fuzzer is tracking branch, things may change there.
> >>>>>
> >>>>> OK. I explicitly tried
> >>>>>
> >>>>>   #syz test: https://github.com/google/kasan.git e5cd56e94edde38ca4dafae5a450c5a16b8a5f23
> >>>>>
> >>>>> but syzbot still cannot reproduce this bug using the reproducer...
> >>>>
> >>>> It seems that there is non-trivial difference between kernel config in dashboard
> >>>> and kernel config in "syz test:" mails. Maybe that's the cause...
> >>
> >>
> >> syzkaller runs oldconfig when building any kernels:
> >> https://github.com/google/syzkaller/blob/master/pkg/build/linux.go#L56
> >> Is that difference what oldconfig produces?
> >>
> >
> > Here is the diff (with "#" lines excluded) between dashboard and "syz test:" mails.
> > I feel this difference is bigger than what simple oldconfig would cause.
> >
>
> I explicitly tried a commit as of the first report (instead of the latest report)
>
>   #syz test: https://github.com/google/kasan.git e96407b497622d03f088bcf17d2c8c5a1ab066c8
>
> and syzbot reproduced this bug using the reproducer. Therefore, it seems that differences
> in the kernel config used for "syz test:" was inappropriate but "syz test:" failed to detect
> it. Since there might be changes which fixed different bugs (and in order to confirm that
> proposed patch cleanly applies to the current kernel without causing other problems), I guess
> that people tend to test using the latest commit (instead of a commit as of the first report).
>
> I suggest "syz test:" to retest without proposed patch when proposed patch did not reproduce
> the bug. If retesting without proposed patch did not reproduce the bug, we can figure out that
> something is wrong (maybe the bug is difficult to reproduce, maybe the bug was already fixed,
> maybe kernel config was inappropriate, maybe something else).

This is already possible, right? One can request any single testing as
they see fit.
Chaining tests into complex workflows won't necessarily make things
simpler. It will be hard to explain what exactly happened and why.
Also, consider, a reproducer is flaky, it did not crashed with patch,
but crashed without the patch (just because it's flaky).


> Regarding the bug for this report, debug printk() reported that WDM_IN_USE was not cleared
> for some reason. While we need to investigate why WDM_IN_USE was not cleared, I guess that
> wdm_write() should clear WDM_IN_USE upon error
> ( https://syzkaller.appspot.com/x/patch.diff?x=17ec7ee9e00000 ) so that we will surely
> wake up somebody potentially waiting on WDM_IN_USE.
>
> [   38.587596][ T2807] wdm_flush: file=ffff8881d488bb80 flags=2
> [   40.214039][ T2807] wdm_flush: file=ffff8881d63fb400 flags=2
> [   40.304390][ T2842] wdm_flush: file=ffff8881d5e22500 flags=0
> [   40.371742][ T2869] wdm_flush: file=ffff8881d4964c80 flags=0
> [   40.429954][ T2844] wdm_flush: file=ffff8881d5937b80 flags=0
> [   40.461538][ T2858] wdm_flush: file=ffff8881d488b400 flags=0
> [   40.464909][ T2863] wdm_flush: file=ffff8881d488ea00 flags=0
> [   41.576761][ T2896] wdm_flush: file=ffff8881d43dea00 flags=2
> [   41.949941][ T2909] wdm_flush: file=ffff8881d63c3b80 flags=2
> [   43.760828][ T2899] wdm_flush: file=ffff8881d3d7a000 flags=2
> [   43.857364][ T2911] wdm_flush: file=ffff8881d63c2000 flags=2
> [   43.857501][ T2904] wdm_flush: file=ffff8881d3d7a280 flags=2
> [   43.866560][ T2906] wdm_flush: file=ffff8881d5ce4780 flags=2
> [   43.876210][ T2897] wdm_flush: file=ffff8881d385db80 flags=2
> [   72.308895][ T2909] INFO: task syz-executor.0:2909 blocked for more than 30 seconds.
> [   72.316860][ T2909] wdm_flush: file=ffff8881d63c3b80 flags=2
> [   74.228916][ T2906] INFO: task syz-executor.1:2906 blocked for more than 30 seconds.
> [   74.228921][ T2911] INFO: task syz-executor.3:2911 blocked for more than 30 seconds.
> [   74.228935][ T2911] wdm_flush: file=ffff8881d63c2000 flags=2
> [   74.236949][ T2906] wdm_flush: file=ffff8881d5ce4780 flags=2
> [   74.236991][ T2904] INFO: task syz-executor.4:2904 blocked for more than 30 seconds.
> [   74.245459][ T2897] INFO: task syz-executor.2:2897 blocked for more than 30 seconds.
> [   74.251305][ T2904] wdm_flush: file=ffff8881d3d7a280 flags=2
> [   74.257129][ T2897] wdm_flush: file=ffff8881d385db80 flags=2
> [   74.257951][ T2899] INFO: task syz-executor.5:2899 blocked for more than 30 seconds.
> [   74.294465][ T2899] wdm_flush: file=ffff8881d3d7a000 flags=2
>
