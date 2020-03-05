Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA7FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3DA208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gfpHB4Pa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgCENCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:02:16 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45798 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgCENCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 08:02:16 -0500
Received: by mail-lf1-f68.google.com with SMTP id b13so4522833lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 05:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2x6+MoadlElr365H2n+YddEAoMX2QtKHRPzvUVDkSac=;
        b=gfpHB4Pa8PMnunBOdkMXeI2iqZ3t8xrU7t8z6L8QvMo+U4kGS8znkm2+sWpkclh4wW
         UA90jcf41v847+Y1NYCjkEhpQR05w7ar8LfpTQKdO1pqrVZO7olYlEjqJFJ6w3jO1+Xi
         W+Ry1qeZNG+kLQrZ0HXdC79qRYamVj75dM22pPx0ymGAMf15SziwgeFGfYbxRyO65gZj
         OY5YNWBR9WkUyr0hFhjp3B7ezxfrvUp2dmxKrJiYbIjn7pEzTUQmI+IqOzldTBp++5Ia
         MOYVbGphQWugWsoB4GCY/NipbvWW68wSdll+AMvLqY1GML2PVrn4j+UFRsh6MSb6kaJQ
         4g2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2x6+MoadlElr365H2n+YddEAoMX2QtKHRPzvUVDkSac=;
        b=mVyX5oZMO5zOPu+H5qddkZQzVL/YI5OQoetCwOMA6pZv761kHwK0aKH+qca3inMn73
         jOH6AY9wam1Wso7KcG6zXh5rarFBQNAtVnohwHS5MruFaU77Nfk+7YTr+q4b4cjhun42
         DE1VjQinwkTAq3flgbVmL++uVBLLcoGcqB2gw4CSU3N6OxKZtbZIJuNe5yKIIHtSPhUT
         s+ej4OuODI7i61GDs8x+eI1/3LNhiBzLUM15/EMNBRtawNBjCuS6PFpbuFB0Z/hFlYqa
         +Az6Eb79TD13ZEEz5O524cETXYKKV3ptBKHE2yG1vsC2zHnwXx3bkXoXskm4gDWL0DaD
         vGmw==
X-Gm-Message-State: ANhLgQ33BAK5IAlL1qsy+FVgkXPNxPBKK4DYmxASFIJ09geuYHxDoBxF
        YmscArchx1pYRhL8Qx6Lqna8fodGJsifk7Owhu4cIw==
X-Google-Smtp-Source: ADFU+vuaaFCne2fVLT2qGBdzf4erMVQgxpte8DADJlSxtJQQDPDjC2L2B/HRxoYHIx0wmf4iufhLLzkIQvOwzBEj1fQ=
X-Received: by 2002:ac2:4d10:: with SMTP id r16mr1174795lfi.149.1583413332014;
 Thu, 05 Mar 2020 05:02:12 -0800 (PST)
MIME-Version: 1.0
References: <ad0f263a-6837-e793-5761-fda3264fd8ad@de.ibm.com>
 <CAKfTPtCX4padfJm8aLrP9+b5KVgp-ff76=teu7MzMZJBYrc-7w@mail.gmail.com>
 <CAKfTPtD9b6o=B6jkbWNjfAw9e1UjT9Z07vxdsVfikEQdeCtfPw@mail.gmail.com>
 <2108173c-beaa-6b84-1bc3-8f575fb95954@de.ibm.com> <7be92e79-731b-220d-b187-d38bde80ad16@arm.com>
 <805cbe05-2424-7d74-5e11-37712c189eb6@de.ibm.com> <f28bc5ac-87fa-2494-29db-ff7d98b7372a@de.ibm.com>
 <20200305093003.GA32088@vingu-book> <15252de5-9a2d-19ae-607a-594ee88d1ba1@de.ibm.com>
 <ef1be100-2c6a-bcff-69a2-25878589a111@arm.com> <20200305123351.GB32088@vingu-book>
 <a2d6cf51-6d8a-6db3-bdc9-8614e9746349@de.ibm.com>
In-Reply-To: <a2d6cf51-6d8a-6db3-bdc9-8614e9746349@de.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 5 Mar 2020 14:02:00 +0100
Message-ID: <CAKfTPtBpY+KCJU7KR+Z=cq6L7cy3uWqaFT1PpKjmDj_2Wy+48A@mail.gmail.com>
Subject: Re: 5.6-rc3: WARNING: CPU: 48 PID: 17435 at kernel/sched/fair.c:380 enqueue_task_fair+0x328/0x440
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 at 13:49, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
>
> On 05.03.20 13:33, Vincent Guittot wrote:
> > Le jeudi 05 mars 2020 =C3=A0 13:12:39 (+0100), Dietmar Eggemann a =C3=
=A9crit :
> >> On 05/03/2020 12:28, Christian Borntraeger wrote:
> >>>
> >>> On 05.03.20 10:30, Vincent Guittot wrote:
> >>>> Le mercredi 04 mars 2020 =C3=A0 20:59:33 (+0100), Christian Borntrae=
ger a =C3=A9crit :
> >>>>>
> >>>>> On 04.03.20 20:38, Christian Borntraeger wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 04.03.20 20:19, Dietmar Eggemann wrote:
> >>
> >> [...]
> >>
> >>> It seems to speed up the issue when I do a compile job in parallel on=
 the host:
> >>>
> >>> Do you also need the sysfs tree?
> >>
> >> [   87.932552] CPU23 path=3D/machine.slice/machine-test.slice/machine-=
qemu\x2d18\x2dtest10. on_list=3D1 nr_running=3D1 throttled=3D0 p=3D[CPU 2/K=
VM 2662]
> >> [   87.932559] CPU23 path=3D/machine.slice/machine-test.slice/machine-=
qemu\x2d18\x2dtest10. on_list=3D0 nr_running=3D3 throttled=3D0 p=3D[CPU 2/K=
VM 2662]
> >> [   87.932562] CPU23 path=3D/machine.slice/machine-test.slice on_list=
=3D1 nr_running=3D1 throttled=3D1 p=3D[CPU 2/KVM 2662]
> >> [   87.932564] CPU23 path=3D/machine.slice on_list=3D1 nr_running=3D0 =
throttled=3D0 p=3D[CPU 2/KVM 2662]
> >> [   87.932566] CPU23 path=3D/ on_list=3D1 nr_running=3D1 throttled=3D0=
 p=3D[CPU 2/KVM 2662]
> >> [   87.951872] CPU23 path=3D/ on_list=3D1 nr_running=3D2 throttled=3D0=
 p=3D[ksoftirqd/23 126]
> >> [   87.987528] CPU23 path=3D/user.slice on_list=3D1 nr_running=3D2 thr=
ottled=3D0 p=3D[as 6737]
> >> [   87.987533] CPU23 path=3D/ on_list=3D1 nr_running=3D1 throttled=3D0=
 p=3D[as 6737]
> >>
> >> Arrh, looks like 'char path[64]' is too small to hold 'machine.slice/m=
achine-test.slice/machine-qemu\x2d18\x2dtest10.scope/vcpuX' !
> >>                                                                       =
                                              ^
> >> But I guess that the 'on_list=3D0' for 'machine-qemu\x2d18\x2dtest10.s=
cope' could be the missing hint?
> >
> > yes the if (cfs_bandwidth_used()) at the end of enqueue_task_fair is no=
t enough
> > to ensure that all cfs will be added back. It will "work" for the 1st e=
nqueue
> > because the throttled cfs will be added and will reset tmp_alone_branch=
 but not
> > for the next one
> >
> > Compare to the previous proposed fix, we can optimize it a bit with:
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 9ccde775e02e..3b19e508641d 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4035,10 +4035,16 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sc=
hed_entity *se, int flags)
> >                 __enqueue_entity(cfs_rq, se);
> >         se->on_rq =3D 1;
> >
> > -       if (cfs_rq->nr_running =3D=3D 1) {
> > +       /*
> > +        * When bandwidth control is enabled, cfs might have been remov=
ed because of
> > +        * a parent been throttled but cfs->nr_running > 1. Try to add =
it
> > +        * unconditionnally.
> > +        */
> > +       if (cfs_rq->nr_running =3D=3D 1 || cfs_bandwidth_used())
>
> This needs a forward declaration for cfs_bandwidth_used, but with that it=
 compiles fine
> and its seems to work fine so far. Will keep it running for while.

ok. Thanks

>
> >                 list_add_leaf_cfs_rq(cfs_rq);
> > +
> > +       if (cfs_rq->nr_running =3D=3D 1)
> >                 check_enqueue_throttle(cfs_rq);
> > -       }
> >  }
> >
> >  static void __clear_buddies_last(struct sched_entity *se)
>
