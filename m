Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFC2C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8000B214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lAxDWi1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgCCHzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:55:54 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33283 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbgCCHzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:55:54 -0500
Received: by mail-lf1-f68.google.com with SMTP id c20so1906212lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 23:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1lPF8zw0bXFqFlQLFPStlm5FHoYNBwBPM18zyUiNjIA=;
        b=lAxDWi1+pqP/9qDvQilXYNucTAvjaes6a1BWSvxMFNN+3Lf1LQdW3q2rHh4Y6D21+I
         2fflpfjG4j7t97ZZFhfV9Xzx55jJpeApk/0VsIIe/0y0zr/bOym4XSiRcK+Gjew3eaxX
         AQ8rdWEQTkLQLJgtr3kYIHLac4tAILLe247A4xLz+511vTnO+ciLDqpkiELvyvVsLLvs
         nNU1DSD3EyigBRd9aToPtgI4Tt+IMAdxFvmHi8mVgzyWrdouZlFZnN3b09IKGddGScyh
         Y9gGQWtdXmdBQ5CCPS0XVqsKtr9hVcbhUKl0UqGQs6uReu3GM0BOxcgF8B2dP7MpOuW2
         WniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1lPF8zw0bXFqFlQLFPStlm5FHoYNBwBPM18zyUiNjIA=;
        b=uNVhpLEsHVWSDrofksbeJYwRodmReo4jnDnm6IfKjZKWR+2lZKr/DNrZ1VaPnl4yZ2
         7K33j71B2qk3Xuz2QN66pCFcIPIl0KGHzBp83mvMRrsNsYEmFctKJqu7MiS+aswpTGdf
         AQqc0lWkvSph7qXN55LBv9yC0PCpf/beuLVp5cCanheBiNw0BxrTjaYX/tbaEnNZ9euM
         ygHaeIunoj1zXyJYgubdEHG8AewgpkoY/MlvnMKnwwW03TXEt6mNcxcCms9cAhAlVOfS
         dedfL8GcAL6g7fTzl8AyU/g04o8l8HNVAp1Zlvnz6C20/bJwXxfYyoYcf+90A+ZkxexP
         SdAw==
X-Gm-Message-State: ANhLgQ03Y65uWcpvgn1e1+IBG9qC2PhqqgYGicyO5dIIoBmVu7adW1v7
        SHSs7Ugdnbxc7vm9m81lWu5iBKtSe3Wg0uBC6g23CA==
X-Google-Smtp-Source: ADFU+vswLyz0rxpKgGKU1DFmKvHyDEx2iMLX3GZz/9lBIcgjX7HlFXOcBjEw7BdA1lv9hIxS0xiYUIKMbbOGHBVRnX8=
X-Received: by 2002:a19:230d:: with SMTP id j13mr1964235lfj.189.1583222151895;
 Mon, 02 Mar 2020 23:55:51 -0800 (PST)
MIME-Version: 1.0
References: <ace7327f-0fd6-4f36-39ae-a8d7d1c7f06b@de.ibm.com>
 <afacbbd1-3d6b-c537-34e2-5b455e1c2267@de.ibm.com> <CAKfTPtBikHzpHY-NdRJFfOFxx+S3=4Y0aPM5s0jpHs40+9BaGA@mail.gmail.com>
 <b073a50e-4b86-56db-3fbd-6869b2716b34@de.ibm.com> <1a607a98-f12a-77bd-2062-c3e599614331@de.ibm.com>
 <CAKfTPtBZ2X8i6zMgrA1gNJmwoSnyRc76yXmLZEwboJmF-R9QVg@mail.gmail.com>
 <b664f050-72d6-a483-be0a-8504f687f225@de.ibm.com> <20200228163545.GA18662@vingu-book>
 <be45b190-d96c-1893-3ef0-f574eb595256@de.ibm.com> <49a2ebb7-c80b-9e2b-4482-7f9ff938417d@de.ibm.com>
 <ad0f263a-6837-e793-5761-fda3264fd8ad@de.ibm.com>
In-Reply-To: <ad0f263a-6837-e793-5761-fda3264fd8ad@de.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 3 Mar 2020 08:55:40 +0100
Message-ID: <CAKfTPtCX4padfJm8aLrP9+b5KVgp-ff76=teu7MzMZJBYrc-7w@mail.gmail.com>
Subject: Re: 5.6-rc3: WARNING: CPU: 48 PID: 17435 at kernel/sched/fair.c:380 enqueue_task_fair+0x328/0x440
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 at 08:37, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
>
> On 02.03.20 19:17, Christian Borntraeger wrote:
> > On 02.03.20 12:16, Christian Borntraeger wrote:
> >>
> >>
> >> On 28.02.20 17:35, Vincent Guittot wrote:
> >>> Le vendredi 28 f=C3=A9vr. 2020 =C3=A0 16:42:27 (+0100), Christian Bor=
ntraeger a =C3=A9crit :
> >>>>
> >>>>
> >>>> On 28.02.20 16:37, Vincent Guittot wrote:
> >>>>> On Fri, 28 Feb 2020 at 16:08, Christian Borntraeger
> >>>>> <borntraeger@de.ibm.com> wrote:
> >>>>>>
> >>>>>> Also happened with 5.4:
> >>>>>> Seems that I just happen to have an interesting test workload/syst=
em size interaction
> >>>>>> on a newly installed system that triggers this.
> >>>>>
> >>>>> you will probably go back to 5.1 which is the version where we put
> >>>>> back the deletion of unused cfs_rq from the list which can trigger =
the
> >>>>> warning:
> >>>>> commit 039ae8bcf7a5 : (Fix O(nr_cgroups) in the load balancing path=
)
> >>>>>
> >>>>> AFAICT, we haven't changed this since
> >>>>
> >>>> So you do know what is the problem? If not is there any debug option=
 or
> >>>> patch that I could apply to give you more information?
> >>>
> >>> No I don't know what is happening. Your test probably goes through an=
 unexpected path
> >>>
> >>> Would it be difficult for me to reproduce your test env ?
> >>
> >> Not sure. Its a 32CPU (SMT2 -> 64) host. I have about 10 KVM guests ru=
nning doing different
> >> things.
> >>
> >>>
> >>> There is an optimization in the code which could generate problem if =
assumption is not
> >>> true. Could you try the patch below ?
> >>>
> >>> ---
> >>>  kernel/sched/fair.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index 3c8a379c357e..beb773c23e7d 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -4035,8 +4035,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sc=
hed_entity *se, int flags)
> >>>             __enqueue_entity(cfs_rq, se);
> >>>     se->on_rq =3D 1;
> >>>
> >>> +   list_add_leaf_cfs_rq(cfs_rq);
> >>>     if (cfs_rq->nr_running =3D=3D 1) {
> >>> -           list_add_leaf_cfs_rq(cfs_rq);
> >>>             check_enqueue_throttle(cfs_rq);
> >>>     }
> >>>  }
> >>
> >> Now running for 3 hours. I have not seen the issue yet. I can tell tom=
orrow if this fixes
> >> the issue.
> >
> >
> > Still running fine. I can tell for sure tomorrow, but I have the impres=
sion that this makes the
> > WARN_ON go away.
>
> So I guess this change "fixed" the issue. If you want me to test addition=
al patches, let me know.

Thanks for the test. For now, I don't have any other patch to test. I
have to look more deeply how the situation happens.
I will let you know if I have other patch to test

>
