Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF8AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261E52070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3xPJZtp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgERG0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgERG0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:26:14 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5681C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 23:26:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nu7so2110601pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 23:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sqEbuUUC6vd4Sa66d08NNo4B0txnWr9aDhBTPjvmYJ8=;
        b=X3xPJZtpZ+1rw0mFFaFkJlO44v9hlmZCh+zJeg9JgWkvvtlZOPOXfPTsK01TqHRmgr
         oLDaaMSe5J/NidcHTI+itTPoh7TsAZJ8xd1iMI/5nltzxBJzppACR5SdjJtxw56JwHOw
         o03MowbtjoB6XR0HlELcpQFaI4lE3F51CCdp7GsHRTzIkA9AbO83juZNwf7dyJUCZ6XE
         8tLUzs9bkvSuBs1PbvkDXilxaEDWIU8TN4tCfSKuYG/RzOUCBWw64ffJSU+Ev3OuqusW
         OBGzjpi33ZJCL4CBKM1hQ6CQApI7CgYKkJqn35zU2xE0cW0x574QIJ+lmAVo4IiUKn8A
         QSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sqEbuUUC6vd4Sa66d08NNo4B0txnWr9aDhBTPjvmYJ8=;
        b=Kasm97qA8JUh/mLIUyNio1iDfTzTlM6DS5TMGcuXtfYZPpT1flQwu2S2Y3Vn+QJD/4
         bDO6cwxuuYqgiby1+x5aQsS+uEKlT4PBo9G7uvQmGp2718sKGVrHJKDPVyhT1DneSrlu
         1LaS19zNquPsdOxk3mMuLWUhlKhR63q8/w4/J29i7A/ImeAEXTHb49BhXxb8CG32qxfG
         o2A6b1vGuetMwk4l2RJNGEf6HirkALRYBLczChQSi/RBT497oj5dYX+MU4bzGdE5tdYb
         Bvh8cKgxZV04sKQXPHFXwXM+nJNRMLFIAX6gRs/A0/QOjwLBsjr5sGjGfa6/4iprXC/5
         Q2vQ==
X-Gm-Message-State: AOAM532ZFHn0/sOX7dWxn6wihe1zJSf/sjTm9V8I+RBwmkxIZePVWuZI
        KfEofspOfx6lzZYCb5RAHDlBXfdVGNujyHEIrB8=
X-Google-Smtp-Source: ABdhPJzYBVm9s1yrTK8/5YWe8NEHNxv4hskZUXZjYG1F24Mm5WP6B5+11QjZuwKa0CwSkFe2FsaUj0X2L8ft4fkWmjo=
X-Received: by 2002:a17:902:b088:: with SMTP id p8mr15507720plr.123.1589783173163;
 Sun, 17 May 2020 23:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200516124857.75004-1-lecopzer@gmail.com> <CAFA6WYNwp+_ENiS8QDao5+RXyt5ofJZyq6c5CKG_d0CNEmBNYg@mail.gmail.com>
In-Reply-To: <CAFA6WYNwp+_ENiS8QDao5+RXyt5ofJZyq6c5CKG_d0CNEmBNYg@mail.gmail.com>
From:   Lecopzer Chen <lecopzer@gmail.com>
Date:   Mon, 18 May 2020 14:26:00 +0800
Message-ID: <CANr2M19unLW8n0P2DiOYEZ=GZcaD-L2ygPht_5HNtNZ6e4h6xQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: perf: Add support for Perf NMI interrupts
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     julien.thierry.kdev@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jian-Lin Chen <lecopzer.chen@mediatek.com>,
        alexander.shishkin@linux.intel.com,
        Catalin Marinas <catalin.marinas@arm.com>, jolsa@redhat.com,
        acme@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        mingo@redhat.com, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, namhyung@kernel.org,
        Will Deacon <will@kernel.org>, yj.chiang@mediatek.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Sumit,

Thanks for your information.

I've already implemented IPI (same as you did [1], little difference
in detail), hardlockup detector and perf in last year(2019) for
debuggability.
And now we tend to upstream to reduce kernel maintaining effort.
I'm glad if someone in ARM can do this work :)

Hi Julien,

Does any Arm maintainers can proceed this action?
This is really useful in debugging.
Thank you!!



[1] https://lkml.org/lkml/2020/4/24/328


Lecopzer

Sumit Garg <sumit.garg@linaro.org> =E6=96=BC 2020=E5=B9=B45=E6=9C=8818=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:46=E5=AF=AB=E9=81=93=EF=BC=9A
>
> + Julien
>
> Hi Lecopzer,
>
> On Sat, 16 May 2020 at 18:20, Lecopzer Chen <lecopzer@gmail.com> wrote:
> >
> > These series implement Perf NMI funxtionality and depends on
> > Pseudo NMI [1] which has been upstreamed.
> >
> > In arm64 with GICv3, Pseudo NMI was implemented for NMI-like interruts.
> > That can be extended to Perf NMI which is the prerequisite for hard-loc=
kup
> > detector which had already a standard interface inside Linux.
> >
> > Thus the first step we need to implement perf NMI interface and make su=
re
> > it works fine.
> >
>
> This is something that is already implemented via Julien's patch-set
> [1]. Its v4 has been floating since July, 2019 and I couldn't find any
> major blocking comments but not sure why things haven't progressed
> further.
>
> Maybe Julien or Arm maintainers can provide updates on existing
> patch-set [1] and how we should proceed further with this interesting
> feature.
>
> And regarding hard-lockup detection, I have been able to enable it
> based on perf NMI events using Julien's perf patch-set [1]. Have a
> look at the patch here [2].
>
> [1] https://patchwork.kernel.org/cover/11047407/
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2020-May/732227=
.html
>
> -Sumit
>
> > Perf NMI has been test by dd if=3D/dev/urandom of=3D/dev/null like the =
link [2]
> > did.
> >
> > [1] https://lkml.org/lkml/2019/1/31/535
> > [2] https://www.linaro.org/blog/debugging-arm-kernels-using-nmifiq
> >
> >
> > Lecopzer Chen (3):
> >   arm_pmu: Add support for perf NMI interrupts registration
> >   arm64: perf: Support NMI context for perf event ISR
> >   arm64: Kconfig: Add support for the Perf NMI
> >
> >  arch/arm64/Kconfig             | 10 +++++++
> >  arch/arm64/kernel/perf_event.c | 36 ++++++++++++++++++------
> >  drivers/perf/arm_pmu.c         | 51 ++++++++++++++++++++++++++++++----
> >  include/linux/perf/arm_pmu.h   |  6 ++++
> >  4 files changed, 88 insertions(+), 15 deletions(-)
> >
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
