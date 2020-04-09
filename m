Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DB3C2BA80
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 00:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D2E20857
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 00:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7QPMSWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgDIAuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 20:50:14 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:40653 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgDIAuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 20:50:13 -0400
Received: by mail-qk1-f174.google.com with SMTP id z15so2375032qki.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 17:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dwHTRqaMeWKQo8pkhWDyrO1F8nXatpOEGoXaxkOIkmU=;
        b=c7QPMSWDbvHOzo+rhOTS20BvUCOnK2azDS3qnqhjIzVz9DAJGz2DI3vlwiVXZ7xcy3
         mVTwPI8smCSzFCE+fCkvWY7A4Wp6jLYsBJlPB+rjpJ1Uv3ibayAAJXRYXqDo7PnoMypY
         WBq6HWvY0UkxGmMZV8xxAGkyBdK7WXfR/aOKVo4xAeWJ6qQrgqd2ntYeCwQwxIWMkTgs
         ZAqUmlKd91+mIi+323AsTl7XTrJKn1TZqP4ngYUcQSq3DxYt3CLb3Pz3NSbfP4AqliYA
         CpwwUUs+NNqHUrK6aJGCxIQzX+FfBS+lTWv0MJQje7iofPbId4LcDN32PKVutOv87flp
         /6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dwHTRqaMeWKQo8pkhWDyrO1F8nXatpOEGoXaxkOIkmU=;
        b=cQL/Pj2DEobi9hWhltcvxJgGOPqsmL86B5DTb98kkiASSfut5kBCsgttVi3bct3qcP
         hml1KYEHnXyD/Ks05CyZXmZ3V1cWbfUN8m04pLTVo5NVxauCuBX1tAC4Q9l1aP0vPP+w
         Sk77GV6MSHZNC4AK5SyJYzVRGLA4zfCgcCPsqr2CkPvfYDRZsnQS3bw+QMJHF6Fmubss
         ZXHATTls18QxKDEmFOgtBcGJqrBfWfOseS0uz8em23bs03+rL8cLfEJGGsE9+pnVWlNW
         OxfcGTaBazPoMighVEy5lGAaYENuS5pIGJ0A4Y8JX+nL2X+7zCeVebdD66ajZ84NYOiE
         Ug7A==
X-Gm-Message-State: AGi0PuatVewCL7b3PMie/+TjcaER601XSWrCQa+PmITHW1HydDY/mjTq
        7Hfx0AuaBB315zFJIou2QoEhWVQGis0wTKt/EjM=
X-Google-Smtp-Source: APiQypJSLvSklAC0eMTd7Nr5ng00zmc1uWSo//7Ut+5AUnGvo8poiYZ3BvibGxMP9Fs+g/yOEF7x5z9vB4+cAodUGes=
X-Received: by 2002:a37:af86:: with SMTP id y128mr10649195qke.429.1586393412482;
 Wed, 08 Apr 2020 17:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com> <f8b9b387-df30-d960-4833-ce6e7974a633@suse.cz>
In-Reply-To: <f8b9b387-df30-d960-4833-ce6e7974a633@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 9 Apr 2020 09:50:01 +0900
Message-ID: <CAAmzW4OsxZV-xRtPqXUVAoP+dM6SQSaw1E1EE+0Fw2fS1Z9K9A@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] workingset protection/detection on the anonymous
 LRU list
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 4=EC=9B=94 9=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 1:55, Vl=
astimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 4/3/20 7:40 AM, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > Hello,
> >
> > This patchset implements workingset protection and detection on
> > the anonymous LRU list.
>
> Hi!

Hi!

> > I did another test to show the performance effect of this patchset.
> >
> > - ebizzy (with modified random function)
> > ebizzy is the test program that main thread allocates lots of memory an=
d
> > child threads access them randomly during the given times. Swap-in/out
> > will happen if allocated memory is larger than the system memory.
> >
> > The random function that represents the zipf distribution is used to
> > make hot/cold memory. Hot/cold ratio is controlled by the parameter. If
> > the parameter is high, hot memory is accessed much larger than cold one=
.
> > If the parameter is low, the number of access on each memory would be
> > similar. I uses various parameters in order to show the effect of
> > patchset on various hot/cold ratio workload.
> >
> > My test setup is a virtual machine with 8 cpus and 1024MB memory.
> >
> > Result format is as following.
> >
> > Parameter 0.1 ... 1.3
> > Allocated memory size
> > Throughput for base (larger is better)
> > Throughput for patchset (larger is better)
> > Improvement (larger is better)
> >
> >
> > * single thread
> >
> >      0.1      0.3      0.5      0.7      0.9      1.1      1.3
> > <512M>
> >   7009.0   7372.0   7774.0   8523.0   9569.0  10724.0  11936.0
> >   6973.0   7342.0   7745.0   8576.0   9441.0  10730.0  12033.0
> >    -0.01     -0.0     -0.0     0.01    -0.01      0.0     0.01
> > <768M>
> >    915.0   1039.0   1275.0   1687.0   2328.0   3486.0   5445.0
> >    920.0   1037.0   1238.0   1689.0   2384.0   3638.0   5381.0
> >     0.01     -0.0    -0.03      0.0     0.02     0.04    -0.01
> > <1024M>
> >    425.0    471.0    539.0    753.0   1183.0   2130.0   3839.0
> >    414.0    468.0    553.0    770.0   1242.0   2187.0   3932.0
> >    -0.03    -0.01     0.03     0.02     0.05     0.03     0.02
> > <1280M>
> >    320.0    346.0    410.0    556.0    871.0   1654.0   3298.0
> >    316.0    346.0    411.0    550.0    892.0   1652.0   3293.0
> >    -0.01      0.0      0.0    -0.01     0.02     -0.0     -0.0
> > <1536M>
> >    273.0    290.0    341.0    458.0    733.0   1381.0   2925.0
> >    271.0    293.0    344.0    462.0    740.0   1398.0   2969.0
> >    -0.01     0.01     0.01     0.01     0.01     0.01     0.02
> > <2048M>
> >     77.0     79.0     95.0    147.0    276.0    690.0   1816.0
> >     91.0     94.0    115.0    170.0    321.0    770.0   2018.0
> >     0.18     0.19     0.21     0.16     0.16     0.12     0.11
> >
> >
> > * multi thread (8)
> >
> >      0.1      0.3      0.5      0.7      0.9      1.1      1.3
> > <512M>
> >  29083.0  29648.0  30145.0  31668.0  33964.0  38414.0  43707.0
> >  29238.0  29701.0  30301.0  31328.0  33809.0  37991.0  43667.0
> >     0.01      0.0     0.01    -0.01     -0.0    -0.01     -0.0
> > <768M>
> >   3332.0   3699.0   4673.0   5830.0   8307.0  12969.0  17665.0
> >   3579.0   3992.0   4432.0   6111.0   8699.0  12604.0  18061.0
> >     0.07     0.08    -0.05     0.05     0.05    -0.03     0.02
> > <1024M>
> >   1921.0   2141.0   2484.0   3296.0   5391.0   8227.0  14574.0
> >   1989.0   2155.0   2609.0   3565.0   5463.0   8170.0  15642.0
> >     0.04     0.01     0.05     0.08     0.01    -0.01     0.07
> > <1280M>
> >   1524.0   1625.0   1931.0   2581.0   4155.0   6959.0  12443.0
> >   1560.0   1707.0   2016.0   2714.0   4262.0   7518.0  13910.0
> >     0.02     0.05     0.04     0.05     0.03     0.08     0.12
> > <1536M>
> >   1303.0   1399.0   1550.0   2137.0   3469.0   6712.0  12944.0
> >   1356.0   1465.0   1701.0   2237.0   3583.0   6830.0  13580.0
> >     0.04     0.05      0.1     0.05     0.03     0.02     0.05
> > <2048M>
> >    172.0    184.0    215.0    289.0    514.0   1318.0   4153.0
> >    175.0    190.0    225.0    329.0    606.0   1585.0   5170.0
> >     0.02     0.03     0.05     0.14     0.18      0.2     0.24
> >
> > As we can see, as allocated memory grows, patched kernel get the better
> > result. Maximum improvement is 21% for the single thread test and
> > 24% for the multi thread test.
>
> So, these results seem to be identical since v1. After the various change=
s up to
> v5, should  the benchmark be redone? And was that with a full patchset or
> patches 1+2?

It was done with a full patchset. I think that these results would not
be changed
even on v5 since it is improvement from the concept of this patchset and
implementation detail doesn't much matter. However, I will redo.

> > * EXPERIMENT
> > I made a test program to imitates above scenario and confirmed that
> > problem exists. Then, I checked that this patchset fixes it.
> >
> > My test setup is a virtual machine with 8 cpus and 6100MB memory. But,
> > the amount of the memory that the test program can use is about 280 MB.
> > This is because the system uses large ram-backed swap and large ramdisk
> > to capture the trace.
> >
> > Test scenario is like as below.
> >
> > 1. allocate cold memory (512MB)
> > 2. allocate hot-1 memory (96MB)
> > 3. activate hot-1 memory (96MB)
> > 4. allocate another hot-2 memory (96MB)
> > 5. access cold memory (128MB)
> > 6. access hot-2 memory (96MB)
> > 7. repeat 5, 6
> >
> > Since hot-1 memory (96MB) is on the active list, the inactive list can
> > contains roughly 190MB pages. hot-2 memory's re-access interval
> > (96+128 MB) is more 190MB, so it cannot be promoted without workingset
> > detection and swap-in/out happens repeatedly. With this patchset,
> > workingset detection works and promotion happens. Therefore, swap-in/ou=
t
> > occurs less.
> >
> > Here is the result. (average of 5 runs)
> >
> > type swap-in swap-out
> > base 863240 989945
> > patch 681565 809273
> >
> > As we can see, patched kernel do less swap-in/out.
>
> Same comment, also v1 has this note:

I had tested this scenario on every version of the patchset and found the s=
ame
trend.

> > Note that, this result is gotten from v5.1. Although workingset detecti=
on
> > works on v5.1, it doesn't work well on v5.5. It looks like that recent
> > code change on workingset.c is the reason of this problem. I will
> > track it soon.
> What was the problem then, assuming it's fixed? Maybe I just missed it
> mentioned. Can results now be gathered on 5.6?

It was fixed on v2. Change log on v2 "fix a critical bug that uses out of i=
ndex
lru list in workingset_refault()" is for this problem. I should note
that clearly.

> In general, this patchset seems to be doing the right thing. I haven't re=
viewed
> the code yet, but hope to do so soon. But inevitably, with any changes in=
 this
> area there will be workloads that will suffer instead of benefit. That ca=
n be
> because we are actually doing a wrong thing, or there's a bug in the code=
, or
> the workloads happen to benefit from the current behavior even if it's no=
t the
> generally optimal one. And I'm afraid only testing on a variety of worklo=
ads can
> show that. You mentioned somewhere that your production workloads benefit=
? Can
> it be quantified more? Could e.g. Johannes test this a bit at Facebook, o=
r

I cannot share the detail of the test for my production (smart TV)
workload. Roughly,
it is repeat of various action and app (channel change, volume change,
youtube, etc.)
on smart TV and it is memory stress test. Result after the workload is:

base
pswpin 328211
pswpout 304015

patched
pswpin 261884
pswpout 276062

So, improvement on pswpin and pswpout is roughly 20% and 9%, respectively.

> it be quantified more? Could e.g. Johannes test this a bit at Facebook, o=
r
> somebody at Google?

It's really helpful if someone else could test this on their workload.

Thanks.
