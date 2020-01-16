Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AC4C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EACC20748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZH4J0bC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgAPPJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:09:38 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:43965 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPPJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:09:38 -0500
Received: by mail-lj1-f182.google.com with SMTP id a13so23068840ljm.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 07:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HkvDWOy71Un4Ejg7NBoHIcDQf5aqCtLjt/UBVhVpHi8=;
        b=UZH4J0bCrKnCrsAO6plDNw1EmK2V0kEafwxzYnHiQYZ+Jq12m68cqhHFo8lxY4vhIg
         EuioDNB3JEFkAa8rcy53jocgSYWgm9DxOpXydhrYY/a/RdRrJzl9R+VOzRfiauzOgMXE
         GUXQuWjYSe1Rh0cT3mMWw7hiItYqCvA766VHT2AJ1IvJGhH0Fh2e7OX5WfsVbY6cwnQO
         81VLlFlRAcImsl7y7rkBTfTEH4OfkyGybByNF3PcklQiSB+ZAgdcXh7eiaHwwmLmnruQ
         IBOl8Jeh8SwjzNgVuyzBrHcGDVN4W3QRJ4Luvq3s+GdAqYzNuCMjRbpoEnc3hEHMt53E
         SBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HkvDWOy71Un4Ejg7NBoHIcDQf5aqCtLjt/UBVhVpHi8=;
        b=MKUDEXd+mEVCufFzWuGdanVDd3bd+ry2akRsXv7cuLrQv42cGZZWXlQi1mb4ZLqytx
         fhKuCS7MBIw+0hVw3CgcSlMm19E7c5psMmHFs16u63sIVXnuoLeXkSlB3psjuoLGYs/F
         aK9RSta7uAMgvfN0KSJ9ivp1D4OGlc7qez8Ldk0xQOQkVvLDEAuyCmuPkf9F83JUrfEo
         VubEa+c99XtGe7z50PSGVEUWr5tmS2KZpUxbxQW+j1izRH2+sqRVFbLuCfhJUsU1WChN
         sw9HsjmMORPpJBmBsP8wMKvkAdT/xnzagqbhO0TGK2S9oS50ZZlVUPE/C4q0h1es7DyG
         WAzA==
X-Gm-Message-State: APjAAAWl8A5AqY3Z2J/Yf9d3DI7DM+EAwV9itDj7F8cOobijD+usd85S
        6PUNHXIu5LSWa0p0w42qKlWZVbZK9ckS8rOlbYc=
X-Google-Smtp-Source: APXvYqxM+7sopMisYJHuyrSdpEeUeoidxWDpIFKdCi1aQ2PjQTOuT/UA2GPgy8IeOIqjNG4mJqphH2ZWLRoXz907QhI=
X-Received: by 2002:a2e:7009:: with SMTP id l9mr2580636ljc.96.1579187375648;
 Thu, 16 Jan 2020 07:09:35 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007523a60576e80a47@google.com> <CACT4Y+b3AmVQMjPNsPHOXRZS4tNYb6Z9h5-c=1ZwZk0VR-5J5Q@mail.gmail.com>
 <20180928070042.GF3439@hirez.programming.kicks-ass.net> <CACT4Y+YFmSmXjs5EMNRPvsR-mLYeAYKypBppYq_M_boTi8a9uQ@mail.gmail.com>
 <CACT4Y+ZBYYUiJejNbPcZWS+aHehvkgKkTKm0gvuviXGGcirJ5g@mail.gmail.com>
 <CACT4Y+bTGp1J9Wn=93LUObdTcWPo2JrChYKF-1v6aXmtvoQgPQ@mail.gmail.com> <CAM_iQpVtcNFeEtW15z_nZoyC1Q-_pCq+UfZ4vYBB3Lb2CMm4Mg@mail.gmail.com>
In-Reply-To: <CAM_iQpVtcNFeEtW15z_nZoyC1Q-_pCq+UfZ4vYBB3Lb2CMm4Mg@mail.gmail.com>
From:   Taehee Yoo <ap420073@gmail.com>
Date:   Fri, 17 Jan 2020 00:09:24 +0900
Message-ID: <CAMArcTUJ=Nemq=hsEeOzc-hOU4bPOKq_Xa1ECGDk4ceZHzhGVw@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAINS too low!
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 at 06:53, Cong Wang <xiyou.wangcong@gmail.com> wrote:
>

Hi Cong,

> On Mon, Jan 13, 2020 at 3:11 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > +Taehee, Cong,
> >
> > In the other thread Taehee mentioned the creation of dynamic keys for
> > net devices that was added recently and that they are subject to some
> > limits.
> > syzkaller creates lots of net devices for isolation (several dozens
> > per test process, but then these can be created and destroyed
> > periodically). I wonder if it's the root cause of the lockdep limits
> > problems?
>
> Very possibly. In current code base, there are 4 lockdep keys
> per netdev:
>
>         struct lock_class_key   qdisc_tx_busylock_key;
>         struct lock_class_key   qdisc_running_key;
>         struct lock_class_key   qdisc_xmit_lock_key;
>         struct lock_class_key   addr_list_lock_key;
>
> so the number of lockdep keys is at least 4x number of network
> devices.
>
> I think only addr_list_lock_key is necessary as it has a nested
> locking use case, all the rest are not. Taehee, do you agree?
>
> I plan to remove at least qdisc_xmit_lock_key for net-next
> after the fix for net gets merged.
>

Yes, I fully agree with this.
If we calculate the subclass for lock_nested() very well, I think we
might use static lockdep key for addr_list_lock_key too. I think
"dev->upper_level" and "dev->lower_level" might be used as subclass.
These values are updated recursively in master/nomaster operation.

Thank you
Taehee Yoo

> Thanks!
