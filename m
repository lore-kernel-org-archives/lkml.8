Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B7BC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384E320684
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VL3BZ24m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgIBQlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgIBQlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:41:03 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4FCC061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 09:41:02 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w8so5563080ilj.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 09:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=be0fkBg5ElLxu/a+Oag6Gn7VN7vYuyP2CSyc9Hs838g=;
        b=VL3BZ24mU/87UGXDz9kWzW56TwM9CS+CdCdgliDLR+ral0B9rJWnX/W4uFdQsKt4or
         WXvG3BpWVxCctnmZsbfN0hFBVdnT2AO7Gh3etXKcrRz/TgMiJ/ZHC5f+Xr8RbDcO56mH
         Yr/icsuHXhzLlGcJDLKcDdo4TbyHgl7OQW/nlHRUClEbrYXDKvQQUYakVpsqEQqDQaje
         rwYVfrdLmyySB7yhYbrV6N2L3hVaj+sp3LHsDxkvMa9tKfv8Ex5HHCBoe1oSQL5b6VAA
         7OZLz/LrwZByNecckP+KsgcOdVLDLves9GOGDd7psz0/mvzNSr6+XFp0d5Ju4WtrxFhv
         q9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=be0fkBg5ElLxu/a+Oag6Gn7VN7vYuyP2CSyc9Hs838g=;
        b=qg2s9uGO8aHc7z7ri8s5HaLXMKtS8PFDtLnbWgYKC440jCxx+ax1znxq9Xl3d25jAj
         a61+RERcG2oLli5Ac9o1CGg6vLDpfYy3n1DgdUIcw2INm7rTooJffefQsVKqNzh5HSVr
         CY/DaRNFcnyWmByd0cNloGT2XZMqRNFLXDabFNOB2avZdLrnH38zcNSBMDQNaC+2Qpo5
         6LNHDGmqgZqYcEiFZWczAlK15fdyydDtV7LZCCQJ0usZfExnR378I4NAw/+qv7u6TiwY
         CnYuzZ8RqCP10guZZ6Rj1/46MP6sFcuXqm4FYNYC34zDeS8+ruIbospUq2KiD8ehjIm0
         KnzQ==
X-Gm-Message-State: AOAM531l76dU4XWEqe0odfnh1c980Q7eKJC072hrzIvZHBfgvvI2J4FO
        8bLdMnr+mdXfJyREepp+1xEO5vIWTkzcPxD8g4u2rw==
X-Google-Smtp-Source: ABdhPJzZnBL0AuXm1caoH9heuNdH36VGsXc2BZS4cFJzfnTGuYHfq3Ycau4E0vHRm8S5ZWn1z0+9wSnkeA8w9ss1SiA=
X-Received: by 2002:a92:1597:: with SMTP id 23mr4191081ilv.58.1599064861900;
 Wed, 02 Sep 2020 09:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <1593182819-30747-1-git-send-email-deesin@codeaurora.org>
 <20200706180437.GB614737@xps15> <5ce032b8-6b26-d0a7-f92d-f8487d810f0c@codeaurora.org>
In-Reply-To: <5ce032b8-6b26-d0a7-f92d-f8487d810f0c@codeaurora.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 2 Sep 2020 10:40:51 -0600
Message-ID: <CANLsYkxMrKdC8BAeskpM=Wqd=SDXc4GK1J=ATf_EUnGpoAdjTw@mail.gmail.com>
Subject: Re: [PATCH V5 0/4] Signaling api support in glink/rpmsg clients
To:     Deepak Kumar Singh <deesin@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chris Lew <clew@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 at 10:30, Deepak Kumar Singh <deesin@codeaurora.org> wrote:
>
>
> On 7/6/2020 11:34 PM, Mathieu Poirier wrote:
> > Hi Deepak,
> >
> > On Fri, Jun 26, 2020 at 08:16:55PM +0530, Deepak Kumar Singh wrote:
> >> Change from version 5
> >> [V5,4/4] rpmsg: char: Add signal callback and POLLPRI support
> >> Updated for sparse warning. Replaced POLLPRI => EPOLLPRI to fix
> >> warning.
> >>
> >> Change from version 4
> >> I am taking over these patches from aneela@codeaurora.org
> >> Fixed all the trivial review comments.
> >>
> >> Signal conversion to and from native signal as done in patch V4,2/4
> >> is intentional.
> >>
> >> Arun Kumar Neelakantam (3):
> >>    rpmsg: glink: Add support to handle signals command
> >>    rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
> >>    rpmsg: char: Add signal callback and POLLPRI support
> >>
> >> Deepak Kumar Singh (1):
> >>    rpmsg: core: Add signal API support
> > I'm confused here - V5 (or what I think it is) was sent out on June 24th without
> > a cover letter.  This set has a cover letter but it is labeled V5.  So is this
> > the cover letter that should have been sent out on the 24th and the content
> > herein relevent to that set?  Or is it accurate and the label on the cover
> > letter of this set is wrong and should have been V6?
> >
> > I have little confidence in both sets and as such won't be reviewing them.
> > Please send a new revision that is properly labeled.
> >
> > Thanks,
> > Mathieu
> >
> Mistakenly i forgot to update label for cover letter to V6.
>
> I have uploaded patch set V7 with updated cover letter.

Thank you for doing that - I have added your set to my list of patches
to review.  Note that I have a fair amount of patches to go over
lately and as such getting to yours will take some time.

Regards,
Mathieu

>
> There is no change in patches.
>
> >>   drivers/rpmsg/qcom_glink_native.c | 125 ++++++++++++++++++++++++++++++++++++++
> >>   drivers/rpmsg/rpmsg_char.c        |  76 ++++++++++++++++++++++-
> >>   drivers/rpmsg/rpmsg_core.c        |  40 ++++++++++++
> >>   drivers/rpmsg/rpmsg_internal.h    |   5 ++
> >>   include/linux/rpmsg.h             |  27 ++++++++
> >>   5 files changed, 270 insertions(+), 3 deletions(-)
> >>
> >> --
> >> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> >> a Linux Foundation Collaborative Project
> >>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
>
