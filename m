Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF89C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A230C21532
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF9+qSlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgIIIcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgIIIcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:32:24 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3352BC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 01:32:23 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e23so1603206otk.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MsQRJbIjqWwVO8tBA19OtnBJtI7NFv3wFSz6AT6T1T4=;
        b=ZF9+qSlWcgqllAmZUgXL8tWH5tzsfyFvou4SpISOE/bzcWPT05V0wXRXKy1G/OdjzY
         iq4d0VBF4apqKbTYByp6JxlmawORc85JWt5rNTP4Fm70fxCx65UG4HDcDwLn0uPv1edy
         dmoJgsGCbsw5A2vJbhtOfd+mM7lXmjiyoi+krIql/mlmIRyCYVVcMJOJrSf+kertfZTe
         OkwHXywqCUygRocCLPVukFqRxg39iTclFTSoxyjEYvf0oJW0uPCK31uk6NP453nBlbIX
         hlEQT4UhLkZW2+SrV38ttTyoYfBDUTye+nSoEp8Sl4Zz5zdfLnwdaCpr7bpPCQ/WAmNO
         617Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MsQRJbIjqWwVO8tBA19OtnBJtI7NFv3wFSz6AT6T1T4=;
        b=DhVBgvJU7xXVVR+KR38H0tc2pcDV721Lz1ZIgJB77XKcuPBfYwJQuZe/Rq9Q7bqrO2
         xcxR3srdDOjgUJGtuOPmLSlkmbrxzNm317MU3cfzGLTDWDhf/kA0ODDeYeBCcfBC+IE/
         98x+wX6a057+WSTq0uTm89hMH4qkMvPM83OuO7W1jbmJx0Seq76bQXZGhaWo3GZPTYF6
         RpUc/LRdXa7CgLQhUoYupv5jkN0UGO6eSgfnBRtfCd+Mo5+Bh04Hx7mhYtMCmlBNRHIt
         WlRnygoL2EpwraxuyqTrelZsotvSfAzFRn+efcRRQFCtOI6ONlEcMgOn51GeSa2NDK0D
         HR+w==
X-Gm-Message-State: AOAM531dFSDH2hp1aJFBe1seNHOhr1WDK9obvl2vIez94+vUtGkn11kN
        KDBgZpUpd8uQ16pW7YRV51vBjJP3DtR/Mf28+X6Xt/pQYXs=
X-Google-Smtp-Source: ABdhPJy2hWR2wiLXYvL1x4Ny57QcTFLih5nQS6dtXwHqOOx7DOAT7kayhPBk250D+xHPnIVtJ88ggQ2fJzQuewlHvT8=
X-Received: by 2002:a05:6830:1f4f:: with SMTP id u15mr2080838oth.215.1599640341507;
 Wed, 09 Sep 2020 01:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <1595601083-10183-1-git-send-email-qianjun.kernel@gmail.com>
 <87sgddaru7.fsf@nanos.tec.linutronix.de> <CAKc596+vF4eYa4h55P2cssQbRKqBV_-9c_v35SXVMdonP3HBHA@mail.gmail.com>
 <87v9i6a53n.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87v9i6a53n.fsf@nanos.tec.linutronix.de>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Wed, 9 Sep 2020 16:32:10 +0800
Message-ID: <CAKc596+=k1kBffQfd=tPJGTtG_NinwSyqOXpCaPr1m8Xy3CG1g@mail.gmail.com>
Subject: Re: [PATCH V4] Softirq:avoid large sched delay from the pending softirqs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     peterz@infradead.org, will@kernel.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2020=E5=B9=B47=E6=9C=8829=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:16=E5=86=99=E9=81=93=EF=BC=9A
>
> Qian,
>
> jun qian <qianjun.kernel@gmail.com> writes:
> > On Mon, Jul 27, 2020 at 11:41 PM Thomas Gleixner <tglx@linutronix.de> w=
rote:
> >> > +                     or_softirq_pending(pending << (vec_nr + 1));
> >>
> >> To or the value interrupts need to be disabled because otherwise you c=
an
> >> lose a bit when an interrupt happens in the middle of the RMW operatio=
n
> >> and raises a softirq which is not in @pending and not in the per CPU
> >> local softirq pending storage.
> >>
> > I can't understand the problem described above, could you explain in
> > detail.
>
> Oring a value to a memory location is a Read Modify Write (RMW)
> operation.
>
>         x |=3D a;
>
> translates to pseudo code:
>
>         R1 =3D  x      // Load content of memory location x into register=
 R1
>         R1 |=3D a      // Or value a on R1
>         x =3D R1       // Write back result
>
> So assume:
>
>    x =3D 0
>    a =3D 1
>
>    R1 =3D x  --> R1 =3D=3D 0
>    R1 |=3D a --> R1 =3D=3D 1
>
> interrupt sets bit 1 in x       --> x =3D=3D 0x02
>
>    x =3D R1  --> x =3D=3D 1
>
> So you lost the set bit 1, right? Not really what you want.
>
> >> There is another problem. Assume bit 0 and 1 are pending when the
> >> processing starts. Now it breaks out after bit 0 has been handled and
> >> stores back bit 1 as pending. Before ksoftirqd runs bit 0 gets raised
> >> again. ksoftirqd runs and handles bit 0, which takes more than the
> >> timeout. As a result the bit 0 processing can starve all other softirq=
s.
> >>
> > May I use a percpu val to record the order of processing softirq, by th=
e order
> > val, when it is in ksoftirqd we can process the pending softirq in orde=
r. In the
> > scenario you described above, before ksoftirqd runs, bit 0 gets raised =
again,
> > ksoftirqd runs and handles bit 1 by the percpu val. just like a ring.
>
> Yes, you need something to save information about the not-processed
> bits. Keeping track of which bit to process next works, but whether
> that's going to result in efficient and simple code is a different
> question.
>
> Thanks,
>
>         tglx
>

Hi  Thomas, I am so sorry,   For personal reasons, the modification of
this patch was delayed, I will submit the next modified version in
these two days, sorry again
