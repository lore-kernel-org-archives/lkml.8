Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644EDC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC08208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mSmK2PVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgCEMO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:14:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43307 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgCEMO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:14:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id e3so5794583lja.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 04:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dvOACA2qA7Wk8cqyEKSAZZNi/UrbzCV70BGLSxwyfok=;
        b=mSmK2PVwz8WeSsmz0k7oaCaiBqT4Z2PlkQFszUcMdAlIGIPup1hrQJ+VkxJAOhL8Oh
         R4sPigDF1Edk880uOPF/XWka4NvO2RsbmubeVX+mKOi6n4Oxo4MaIYoCvMCwKe6XFoCV
         228haYKCqWUvFGkbELlont1GaDpSl0iACQklJOOBnzyTW4+GLSAzaY00izAkg7lLWICo
         1xcOxji3ndBXYNZ+qPwZ1+erRQjCEQDFB+hyxmNWroh2IJ5wqKZUtGj5dTu1+k+9yPXt
         RtPiRu7Es4ajl42yo4oL3XDIljUsiXzuYKgvnSkyeyGPfBOxP7+IswveXhTfbMb4x4zM
         ET6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dvOACA2qA7Wk8cqyEKSAZZNi/UrbzCV70BGLSxwyfok=;
        b=Gem1dI9CI6oxb6NEYE+D/r0oOJuMgGYd9omWp9d+FRPUwC1YqgcR1YSgms+Q+CkcAY
         E5Jm32z0Pd9N77OcS92CJAWCYNaAkAFD63CmfvRJ7UO/RkuhpytOvhoyANNSkSQ/5Y3D
         SRgHLoQpV0FPbKFd0STIJWyBqHngbVwNbDHdx4pLYsXhpOKvQvExvFrm0IUe+ndop8Cw
         gRN6Y/wP2/hhJM4OtgkiIvuOXZtdwpXYRVU1Sa6xXiVngakfA1FrGvvBTxizrcrKl0od
         SemQzj76Fip5GWucg1U9rELDJb2QfRAD3ZIezWBB4BH4Wawrecuf0oZrtFGdlHqRdWU1
         s8zQ==
X-Gm-Message-State: ANhLgQ1yzycpodQY3Dih4fTbVyuAKzy9kB0hBXTtCwXHfRRzqOwgKuPM
        3gbrNmve4z/Ibx5cfQ5Pjpb4zU7gMoD+NAyM7iYCPA==
X-Google-Smtp-Source: ADFU+vuqKbgYpW+0m1FvlDsqrRshcy8pYlWo/bbYFd+bwC8mP2gK8grHJIPtx5ytv4lQD9pTj5uokf9tLjD72+MAgCg=
X-Received: by 2002:a2e:5850:: with SMTP id x16mr4857956ljd.209.1583410493306;
 Thu, 05 Mar 2020 04:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20200228163545.GA18662@vingu-book> <be45b190-d96c-1893-3ef0-f574eb595256@de.ibm.com>
 <49a2ebb7-c80b-9e2b-4482-7f9ff938417d@de.ibm.com> <ad0f263a-6837-e793-5761-fda3264fd8ad@de.ibm.com>
 <CAKfTPtCX4padfJm8aLrP9+b5KVgp-ff76=teu7MzMZJBYrc-7w@mail.gmail.com>
 <CAKfTPtD9b6o=B6jkbWNjfAw9e1UjT9Z07vxdsVfikEQdeCtfPw@mail.gmail.com>
 <2108173c-beaa-6b84-1bc3-8f575fb95954@de.ibm.com> <7be92e79-731b-220d-b187-d38bde80ad16@arm.com>
 <805cbe05-2424-7d74-5e11-37712c189eb6@de.ibm.com> <f28bc5ac-87fa-2494-29db-ff7d98b7372a@de.ibm.com>
 <20200305093003.GA32088@vingu-book> <15252de5-9a2d-19ae-607a-594ee88d1ba1@de.ibm.com>
In-Reply-To: <15252de5-9a2d-19ae-607a-594ee88d1ba1@de.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 5 Mar 2020 13:14:41 +0100
Message-ID: <CAKfTPtDxE32RrTusYTBUcwYoJFvadLLaMUp7gOsXdj_zQcaWdA@mail.gmail.com>
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

On Thu, 5 Mar 2020 at 12:29, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
> On 05.03.20 10:30, Vincent Guittot wrote:
> > Le mercredi 04 mars 2020 =C3=A0 20:59:33 (+0100), Christian Borntraeger=
 a =C3=A9crit :
> >>
> >> On 04.03.20 20:38, Christian Borntraeger wrote:
> >>>
> >>>
> >>> On 04.03.20 20:19, Dietmar Eggemann wrote:
> >>>>> I just realized that this system has something special. Some month =
ago I created 2 slices
> >>>>> $ head /etc/systemd/system/*.slice
> >>>>> =3D=3D> /etc/systemd/system/machine-production.slice <=3D=3D
> >>>>> [Unit]
> >>>>> Description=3DVM production
> >>>>> Before=3Dslices.target
> >>>>> Wants=3Dmachine.slice
> >>>>> [Slice]
> >>>>> CPUQuota=3D2000%
> >>>>> CPUWeight=3D1000
> >>>>>
> >>>>> =3D=3D> /etc/systemd/system/machine-test.slice <=3D=3D
> >>>>> [Unit]
> >>>>> Description=3DVM production
> >>>>> Before=3Dslices.target
> >>>>> Wants=3Dmachine.slice
> >>>>> [Slice]
> >>>>> CPUQuota=3D300%
> >>>>> CPUWeight=3D100
> >>>>>
> >>>>>
> >>>>> And the guests are then put into these slices. that also means that=
 this test will never use more than the 2300%.
> >>>>> No matter how much CPUs the system has.
> >>>>
> >>>> If you could run this debug patch on top of your un-patched kernel, =
it would tell us which task (in the enqueue case)
> >>>> and which taskgroup is causing that.
> >>>>
> >>>> You could then further dump the appropriate taskgroup directory unde=
r the cpu cgroup mountpoint
> >>>> (to see e.g. the CFS bandwidth data).
> >>>>
> >>>> I expect more than one hit since assert_list_leaf_cfs_rq() uses SCHE=
D_WARN_ON, hence WARN_ONCE.
> >>>
> >>> That was quick. FWIW, I messed up dumping the cgroup mountpoint (sinc=
e I restarted my guests after this happened).
> >>> Will retry. See the dmesg attached.
> >>
> >> New occurence (with just one extra debug line)
> >
> > Could you try to add the patch below on top of dietmar's one so we will=
 have the status of
> > each level of the hierarchy ?
> > The 1st level seems ok but something wrong happens while walking the hi=
erarchy
>
> It seems to speed up the issue when I do a compile job in parallel on the=
 host:
>
> Do you also need the sysfs tree?

No that's enough to understand the problem

All child cfs are removed from the list when a cfs is throttled which
means that the first 3 cfs have been removed when
machine.slice/machine-test.slice has been throttled.
But there are added back when we enqueue a task to make sure to go
through the full tree which has probably already happened to

[   87.428277] CPU1
path=3D/machine.slice/machine-test.slice/machine-qemu\x2d14\x2dtest11.
on_list=3D1 nr_running=3D1 throttled=3D0 p=3D[CPU 2/KVM 2621]
The group entity has been removed from the leaf list when parent has
been throttled but will not be added because nr_running > 1 [
87.428285] CPU1
path=3D/machine.slice/machine-test.slice/machine-qemu\x2d14\x2dtest11.
on_list=3D0 nr_running=3D3 throttled=3D0 p=3D[CPU 2/KVM 2621]
This one has been removed when throttled but already added back
because of a previous enqueue_task [   87.428288] CPU1
path=3D/machine.slice/machine-test.slice on_list=3D1 nr_running=3D1
throttled=3D1 p=3D[CPU 2/KVM 2621]
This one has also been added during a previous enqueue_task on the
throttled child above [   87.428291] CPU1 path=3D/machine.slice
on_list=3D1 nr_running=3D0 throttled=3D0 p=3D[CPU 2/KVM 2621]
[   87.428301] CPU1 path=3D/ on_list=3D1 nr_running=3D1 throttled=3D0 p=3D[=
CPU 2/KVM 2621]

After we added the 1st cgroup, we don't add other cfs to finish the
full hierarchy
