Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAACC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDAB2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1T1m6ho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388800AbgAPRFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:05:53 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33249 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388668AbgAPRFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:05:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id d71so19817867qkc.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 09:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RCX1DjLcpjcGUAoMpV6YYMWCiBCtakKXdZrlVb3Tyy8=;
        b=S1T1m6ho4sRqkMHKBW/4e5n523sCceKbTikflTeOEt4Ig55bKYwBg0WI/OOe/h9fmL
         ia8pZQExSIupL6JVJ+sDLATnarRN9Rwp2oQ4NU2Q9aWpDTPQlzwTuiL9oSdZh9+TJny9
         Fi0sAVNH2N7CVKMj2EGMsU/C3E5Vbwx0YOx1YEPSh+bgapvW27Cadwyn3lT6o7zFCw5Q
         nvSRsUX03Go7jC5R4TS/y+HxUP9kruyRp+YLnoG1Hzoo8RAUmDT4avJQ+w0m+zgrH9pS
         Xq8zuCv1XgzqPMRIwjxWDWulmtxO/jJyBGhWIlVuZyN14e3Ky5VMKrKyUxnuNsP6rs6X
         Tqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCX1DjLcpjcGUAoMpV6YYMWCiBCtakKXdZrlVb3Tyy8=;
        b=bPShq2L5UPxiw0H3L8irRnybwcda1mPmkdJTVzjNGe3zj2tX0K1fpVNQkodZ5Y0l6y
         f0XzG65q3nWfBHDvgPAwVNUYGFAOi8aLBT2fD2ElaRWIjr+z0Zg06bBVq0qaGRfKs1/i
         /fi5WQD8peXoJLqDN7rRHfXww2U/3eIBhdzGOlvXM6KbLNcY69BhG2kwxXPdv8gz9xWj
         DLGUuBJNQoo7G5BvDmdo7Kl0P7p/8UcRUca8VMDzOlDPzmrXqT+qe50WRyyGND0dRVAF
         oPO9IYtEvfLHgidmeBYPdwzjz6gTbA1IcOS3fz/YxZmbJO92zwcREQvqrmRbapPNFZ+V
         OsWw==
X-Gm-Message-State: APjAAAVB0Vm8dYyQdg38TsmqsD4E/zjj4x7jMEF3xb2lugoqAw3ryVMh
        B19ESt3ignhPCeX2L8KIwvzBBQXtzTuJFuziN4EPSA==
X-Google-Smtp-Source: APXvYqz46vfy4a+FZ+d8DiyuvxPIYvotyQdaxCP2lI9+LYlkDskGYps8wvhne0M52AdO6zohUr0N1uDXfhZxmvbRnc8=
X-Received: by 2002:a37:5841:: with SMTP id m62mr33034639qkb.256.1579194339123;
 Thu, 16 Jan 2020 09:05:39 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007523a60576e80a47@google.com> <CACT4Y+b3AmVQMjPNsPHOXRZS4tNYb6Z9h5-c=1ZwZk0VR-5J5Q@mail.gmail.com>
 <20180928070042.GF3439@hirez.programming.kicks-ass.net> <CACT4Y+YFmSmXjs5EMNRPvsR-mLYeAYKypBppYq_M_boTi8a9uQ@mail.gmail.com>
 <CACT4Y+ZBYYUiJejNbPcZWS+aHehvkgKkTKm0gvuviXGGcirJ5g@mail.gmail.com>
 <CACT4Y+bTGp1J9Wn=93LUObdTcWPo2JrChYKF-1v6aXmtvoQgPQ@mail.gmail.com>
 <CAM_iQpVtcNFeEtW15z_nZoyC1Q-_pCq+UfZ4vYBB3Lb2CMm4Mg@mail.gmail.com>
 <CACT4Y+YuM55YUT37jwRP163J7ha25cN03sZ5WqTUPkz3e43Ggw@mail.gmail.com> <CAMArcTXq=nV5kNSdWPgvpMmYXuet9gxZgmxO2JJJ7_T3vLRoRg@mail.gmail.com>
In-Reply-To: <CAMArcTXq=nV5kNSdWPgvpMmYXuet9gxZgmxO2JJJ7_T3vLRoRg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Jan 2020 18:05:26 +0100
Message-ID: <CACT4Y+Y5+wma84Gofcm86KvOKw2niybPBTwz8iHzYW-ndFHH8g@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAINS too low!
To:     Taehee Yoo <ap420073@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
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

On Thu, Jan 16, 2020 at 4:33 PM Taehee Yoo <ap420073@gmail.com> wrote:
>
> On Thu, 16 Jan 2020 at 14:25, Dmitry Vyukov <dvyukov@google.com> wrote:
> >
>
> Hi Dmitry!
>
> > On Wed, Jan 15, 2020 at 10:53 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > > +Taehee, Cong,
> > > >
> > > > In the other thread Taehee mentioned the creation of dynamic keys for
> > > > net devices that was added recently and that they are subject to some
> > > > limits.
> > > > syzkaller creates lots of net devices for isolation (several dozens
> > > > per test process, but then these can be created and destroyed
> > > > periodically). I wonder if it's the root cause of the lockdep limits
> > > > problems?
> > >
> > > Very possibly. In current code base, there are 4 lockdep keys
> > > per netdev:
> > >
> > >         struct lock_class_key   qdisc_tx_busylock_key;
> > >         struct lock_class_key   qdisc_running_key;
> > >         struct lock_class_key   qdisc_xmit_lock_key;
> > >         struct lock_class_key   addr_list_lock_key;
> > >
> > > so the number of lockdep keys is at least 4x number of network
> > > devices.
> >
> > And these are not freed/reused, right? So with dynamic keys LOCKDEP
> > inherently can't handle prolonged running, only O(1) work?
>
> When netdev interface is removed, these dynamic keys are removed.
> But if so many netdev interfaces are existing concurrently
> (more than 2000), lockdep will stop because of a lack of keys.
> In addition, as far as I know, freeing dynamic lockdep key routine is
> slower than creating a new dynamic lockdep key. If there are so many
> netdev interface add/delete operations, for a while, there may be no
> available lockdep key. At this moment, lockdep will stop.
>
> Thank you
> Taehee Yoo


This issues mostly stalled all syzbot testing by now, these LOCKDEP
bugs are the only bugs that are being detected...

2020/01/16 15:30:47 vm-2: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
2020/01/16 15:38:28 vm-3: crash: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
2020/01/16 15:39:55 vm-0: crash: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
2020/01/16 15:41:19 vm-6: crash: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
2020/01/16 15:41:35 vm-1: crash: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
2020/01/16 15:51:16 vm-2: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
2020/01/16 15:57:52 vm-4: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
2020/01/16 16:00:57 vm-6: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
2020/01/16 16:36:35 vm-1: crash: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
2020/01/16 16:37:04 vm-3: crash: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
