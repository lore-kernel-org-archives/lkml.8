Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6111C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC3B20874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2QMa9mJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgEROJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgEROJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:09:37 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092B5C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:09:37 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 202so8159070lfe.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r8Fwvj385+rZthmes99dyyXiDRtusauDWjrcjPTkVIQ=;
        b=F2QMa9mJxrIKimCA7Q5ZfubjznKBsA7f0nfks8awACd7hK/vcUCj6hjmt2qJ17F+b0
         UGFXGrjSKOCu02+IoRLCkop65mrJlKxmshoUusFqcmJ1cWlmos/hGfUjdPfzecRI5GGi
         SEAuLrOV85LhPsyCck0BhmXapD8MR1yNmJiKiNl4UyMHmvy3Etc6h55chByUuMMJQHhN
         FGTp8rdFDeLGsJ8fLfSdZvNjk68UMkethcJCsSlKt56kbDx5qVsZW5u/HRp/FUJpErTk
         QUzTy9SzYfXOsN4CYh2DZXMUHc0408RjiFGTDSVUPF+qbTZ7T3lHSO7E5ofXrhqYSKkq
         dU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r8Fwvj385+rZthmes99dyyXiDRtusauDWjrcjPTkVIQ=;
        b=ByCDncE6XrNSBz4WTrO5JyHWZsTyOWPjRA0kGRveCBHkPzNhq9Vq6yI4+R82h7r/U/
         GqJ/IXnfGUR4z+AUNoauQMEN0KRj/8SpIU+Tvc/fuvBEMapI3Dd0UGg+9obIObEHVkf0
         RmIHaDD9eCWC6S8+LBK2xWT1eix0wy4vuqHP4/okKf37pgzMIv6g860fXOhOQh2UIChp
         R4AJ3HzvTdotIwO31NV6TRUoe+LgH/A20TKoIIB7SbgGi66F9WNcSg/PXRdxMVzjGgaX
         uA1pzBjmirDA3+jS7ppKkSxLft1KuCi1xhlW/iZm9akk/3IbrrR0+ia0tY/JGnp1ZhAd
         CU7Q==
X-Gm-Message-State: AOAM530AbI3iwwRgZOzoSu6/4u13A2typKAMpdrT6Xb9KU7b3qdBT+Wc
        Xitg5ebp7u2i9E5GxEW5WIYaBbLUM7Kq++UrwzHeFg==
X-Google-Smtp-Source: ABdhPJxaU/28ih1lWO9bOiruMyZb65zJycNFCHUMy1FjCxuedpr83mM7nX8WqBmPxCK+ng09CR5WSBD6F25zMT8+1ns=
X-Received: by 2002:ac2:5473:: with SMTP id e19mr7455830lfn.21.1589810975316;
 Mon, 18 May 2020 07:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200516124857.75004-1-lecopzer@gmail.com> <CAFA6WYNwp+_ENiS8QDao5+RXyt5ofJZyq6c5CKG_d0CNEmBNYg@mail.gmail.com>
 <CANr2M19unLW8n0P2DiOYEZ=GZcaD-L2ygPht_5HNtNZ6e4h6xQ@mail.gmail.com>
 <20200518104524.GA1224@C02TD0UTHF1T.local> <a9002b5e-aec5-b6e0-7174-87b93351d60c@arm.com>
In-Reply-To: <a9002b5e-aec5-b6e0-7174-87b93351d60c@arm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 18 May 2020 19:39:23 +0530
Message-ID: <CAFA6WYPKD0Kkn5yQiKZQkM+tT0iW4oPnndegD-iau9EwB5DYog@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: perf: Add support for Perf NMI interrupts
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Lecopzer Chen <lecopzer@gmail.com>, julien.thierry.kdev@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Mon, 18 May 2020 at 16:47, Alexandru Elisei <alexandru.elisei@arm.com> w=
rote:
>
> Hi,
>
> On 5/18/20 11:45 AM, Mark Rutland wrote:
> > Hi all,
> >
> > On Mon, May 18, 2020 at 02:26:00PM +0800, Lecopzer Chen wrote:
> >> HI Sumit,
> >>
> >> Thanks for your information.
> >>
> >> I've already implemented IPI (same as you did [1], little difference
> >> in detail), hardlockup detector and perf in last year(2019) for
> >> debuggability.
> >> And now we tend to upstream to reduce kernel maintaining effort.
> >> I'm glad if someone in ARM can do this work :)
> >>
> >> Hi Julien,
> >>
> >> Does any Arm maintainers can proceed this action?
> > Alexandru (Cc'd) has been rebasing and reworking Julien's patches, whic=
h
> > is my preferred approach.
> >
> > I understand that's not quite ready for posting since he's investigatin=
g
> > some of the nastier subtleties (e.g. mutual exclusion with the NMI), bu=
t
> > maybe we can put the work-in-progress patches somewhere in the mean
> > time.
> >
> > Alexandru, do you have an idea of what needs to be done, and/or when yo=
u
> > expect you could post that?
>
> I'm currently working on rebasing the patches on top of 5.7-rc5, when I h=
ave
> something usable I'll post a link (should be a couple of days). After tha=
t I will
> address the review comments, and I plan to do a thorough testing because =
I'm not
> 100% confident that some of the assumptions around the locks that were re=
moved are
> correct. My guess is this will take a few weeks.
>

Thanks Mark, Alex for the status updates on perf NMI feature.

Alex,

As the hard-lockup detection patch [1] has a dependency on perf NMI
patch-set, I will rebase and test hard-lockup detector when you have
got a working tree. But due to the dependency, I think patch [1]
should be accepted along with perf NMI patch-set. So would you be open
to include this patch as part of your series?

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2020-May/732227.h=
tml

-Sumit

> Thanks,
> Alex
> >
> > Thanks,
> > Mark.
> >
> >> This is really useful in debugging.
> >> Thank you!!
> >>
> >>
> >>
> >> [1] https://lkml.org/lkml/2020/4/24/328
> >>
> >>
> >> Lecopzer
> >>
> >> Sumit Garg <sumit.garg@linaro.org> =E6=96=BC 2020=E5=B9=B45=E6=9C=8818=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:46=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >>> + Julien
> >>>
> >>> Hi Lecopzer,
> >>>
> >>> On Sat, 16 May 2020 at 18:20, Lecopzer Chen <lecopzer@gmail.com> wrot=
e:
> >>>> These series implement Perf NMI funxtionality and depends on
> >>>> Pseudo NMI [1] which has been upstreamed.
> >>>>
> >>>> In arm64 with GICv3, Pseudo NMI was implemented for NMI-like interru=
ts.
> >>>> That can be extended to Perf NMI which is the prerequisite for hard-=
lockup
> >>>> detector which had already a standard interface inside Linux.
> >>>>
> >>>> Thus the first step we need to implement perf NMI interface and make=
 sure
> >>>> it works fine.
> >>>>
> >>> This is something that is already implemented via Julien's patch-set
> >>> [1]. Its v4 has been floating since July, 2019 and I couldn't find an=
y
> >>> major blocking comments but not sure why things haven't progressed
> >>> further.
> >>>
> >>> Maybe Julien or Arm maintainers can provide updates on existing
> >>> patch-set [1] and how we should proceed further with this interesting
> >>> feature.
> >>>
> >>> And regarding hard-lockup detection, I have been able to enable it
> >>> based on perf NMI events using Julien's perf patch-set [1]. Have a
> >>> look at the patch here [2].
> >>>
> >>> [1] https://patchwork.kernel.org/cover/11047407/
> >>> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2020-May/73=
2227.html
> >>>
> >>> -Sumit
> >>>
> >>>> Perf NMI has been test by dd if=3D/dev/urandom of=3D/dev/null like t=
he link [2]
> >>>> did.
> >>>>
> >>>> [1] https://lkml.org/lkml/2019/1/31/535
> >>>> [2] https://www.linaro.org/blog/debugging-arm-kernels-using-nmifiq
> >>>>
> >>>>
> >>>> Lecopzer Chen (3):
> >>>>   arm_pmu: Add support for perf NMI interrupts registration
> >>>>   arm64: perf: Support NMI context for perf event ISR
> >>>>   arm64: Kconfig: Add support for the Perf NMI
> >>>>
> >>>>  arch/arm64/Kconfig             | 10 +++++++
> >>>>  arch/arm64/kernel/perf_event.c | 36 ++++++++++++++++++------
> >>>>  drivers/perf/arm_pmu.c         | 51 ++++++++++++++++++++++++++++++-=
---
> >>>>  include/linux/perf/arm_pmu.h   |  6 ++++
> >>>>  4 files changed, 88 insertions(+), 15 deletions(-)
> >>>>
> >>>> --
> >>>> 2.25.1
> >>>>
> >>>>
> >>>> _______________________________________________
> >>>> linux-arm-kernel mailing list
> >>>> linux-arm-kernel@lists.infradead.org
> >>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
