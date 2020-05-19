Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF52C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B399E20709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tuHZnLrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgESGsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 02:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgESGsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 02:48:17 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A74C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 23:48:16 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z6so1487927ljm.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 23:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WsAbqI29raOKmaDZfzjwRCgLNeDp8dAj/rKR6c3lLhM=;
        b=tuHZnLrABgGUIvnnLmYJt3ZG2g313FM2F48OHFYb9BTOD95F6kXtuV01EGVKlYM8a5
         J9pubY/erz1bGwNuDcCt9AHO32hvzOKxal6lbrpIHokmHaXUYTWuymjz//iJAlmoED3k
         0J+horHcMIcVSn9is7eHpgmMMQnSJYOoc6g8v7L8iA0wXwNiX7v72JblBSCXMXzE+U9j
         aY3sgZZML/R5BZTRTbXVssNN39bAYPP87ciVQMsukfx2+gxCinuoIhgeKH8LliSNh8Vy
         tmPZSh+FrHIJ9lCyddYCVUR6x8oDW3ovx7rMRsNFQm+eGwfp2d1V5S2ZV4tSPDg8qzvX
         BkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsAbqI29raOKmaDZfzjwRCgLNeDp8dAj/rKR6c3lLhM=;
        b=CbwF+Ra/+rcqI+mkBGmxSTCFJqFuN20wEowk3SSnvTdTuoopM2hH6c1WVlKDLCmYzk
         DvvOcI0QHzRV5kO70gkOQ8mAiML8JQVdsV/r79xLzIHog+LID6HdLyODQaOnZraptWb7
         sF7G5FSyNEEc+pCK5BnZzWSsQI/uPAZElh26rMrcDw5SPKsM5Aa/VsSxaVpdbXUHkz8a
         IAnWZ6HRn/KL0IlSLDeJ/+sAMs2XsQslT9gOnnbLlOZHLwGo1IOErOUZuh4PYcKF4i5R
         UEMaxNfXnZyvFd36BZCdqUv2Gh3hKtb4qF8zgDSTG9flPPGHCLPrtOzEJQj5NW4jQzvb
         8flA==
X-Gm-Message-State: AOAM533Hs96ye2DWQ2/CdBFnu/Pjy+Dr+08XjOELbQszU1+H6Aj0XMfY
        1jIhEbXoq0+gDdIs8ZWP26wuRmd8ytQ9jvGB1beTEA==
X-Google-Smtp-Source: ABdhPJw0NjDCoXpLPMqsNAxi9sVRj6FK14oxPqb/GSvWHxxxbkhsVgnm03D1EwJ3jx+RIMYeGCIHEy6X/IXdyEruNZQ=
X-Received: by 2002:a2e:9907:: with SMTP id v7mr3773551lji.0.1589870895203;
 Mon, 18 May 2020 23:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200516124857.75004-1-lecopzer@gmail.com> <CAFA6WYNwp+_ENiS8QDao5+RXyt5ofJZyq6c5CKG_d0CNEmBNYg@mail.gmail.com>
 <CANr2M19unLW8n0P2DiOYEZ=GZcaD-L2ygPht_5HNtNZ6e4h6xQ@mail.gmail.com>
 <20200518104524.GA1224@C02TD0UTHF1T.local> <a9002b5e-aec5-b6e0-7174-87b93351d60c@arm.com>
 <CAFA6WYPKD0Kkn5yQiKZQkM+tT0iW4oPnndegD-iau9EwB5DYog@mail.gmail.com> <20200518141946.GA3164@C02TD0UTHF1T.local>
In-Reply-To: <20200518141946.GA3164@C02TD0UTHF1T.local>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 19 May 2020 12:18:04 +0530
Message-ID: <CAFA6WYP7QhcQZrWua7NOqaqOO8Zd8QeWpHr4_QbDZFgjQ+Qung@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: perf: Add support for Perf NMI interrupts
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Lecopzer Chen <lecopzer@gmail.com>,
        julien.thierry.kdev@gmail.com,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 at 19:49, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, May 18, 2020 at 07:39:23PM +0530, Sumit Garg wrote:
> > On Mon, 18 May 2020 at 16:47, Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> > > On 5/18/20 11:45 AM, Mark Rutland wrote:
> > > > On Mon, May 18, 2020 at 02:26:00PM +0800, Lecopzer Chen wrote:
> > > >> HI Sumit,
> > > >>
> > > >> Thanks for your information.
> > > >>
> > > >> I've already implemented IPI (same as you did [1], little difference
> > > >> in detail), hardlockup detector and perf in last year(2019) for
> > > >> debuggability.
> > > >> And now we tend to upstream to reduce kernel maintaining effort.
> > > >> I'm glad if someone in ARM can do this work :)
> > > >>
> > > >> Hi Julien,
> > > >>
> > > >> Does any Arm maintainers can proceed this action?
> > > > Alexandru (Cc'd) has been rebasing and reworking Julien's patches, which
> > > > is my preferred approach.
> > > >
> > > > I understand that's not quite ready for posting since he's investigating
> > > > some of the nastier subtleties (e.g. mutual exclusion with the NMI), but
> > > > maybe we can put the work-in-progress patches somewhere in the mean
> > > > time.
> > > >
> > > > Alexandru, do you have an idea of what needs to be done, and/or when you
> > > > expect you could post that?
> > >
> > > I'm currently working on rebasing the patches on top of 5.7-rc5, when I have
> > > something usable I'll post a link (should be a couple of days). After that I will
> > > address the review comments, and I plan to do a thorough testing because I'm not
> > > 100% confident that some of the assumptions around the locks that were removed are
> > > correct. My guess is this will take a few weeks.
> > >
> >
> > Thanks Mark, Alex for the status updates on perf NMI feature.
> >
> > Alex,
> >
> > As the hard-lockup detection patch [1] has a dependency on perf NMI
> > patch-set, I will rebase and test hard-lockup detector when you have
> > got a working tree. But due to the dependency, I think patch [1]
> > should be accepted along with perf NMI patch-set. So would you be open
> > to include this patch as part of your series?
> >
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2020-May/732227.html
>
> While it depends on the perf NMI bits, I don't think it makes sense to
> tie that into the series given it's trying to achieve something very
> different.
>
> I think that should be reposted separately once the perf NMI bits are in
> shape.

Okay, fair enough. Will keep it as a separate patch then.

-Sumit

>
> Thanks,
> Mark.
