Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A131DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AFBE208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PpcMp6z0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgIJW4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIJW4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 18:56:50 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D724AC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 15:56:49 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x14so7577579oic.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 15:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2NDnGAYyaiWbTVVt3qIqOBgyLmtaJBXAa8jclQOHEI=;
        b=PpcMp6z0WjujTy9v6LFo87bHlcmtFD9BhxCTh5vwkEYxcNGtKxm6Le+6WK3M3fyls0
         YZPjLgOexOb74fEnFQYJNAnFz6n96Q/JpujRhI2K9oHIDHvDJjp0PcPSlRSD36YsVp1K
         /7NQX3ZNIlu4MOi1k6IKVfZqz0kPsiwMhW2amKWRWjG210ceyHApHTY4DEwT8NyeP5G0
         B3trw01wLPM6kXTWq8wla2ERqv+Z327xbTglH5a+vxAZ7OPruKtYNAccc/D4U9bPd6rC
         NVdqL6cT/kntQBXUYJYCbr40reULvNmoS2jBNQex+zSlFSxkOeblLuZk6mmqs2yVMMBo
         cBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2NDnGAYyaiWbTVVt3qIqOBgyLmtaJBXAa8jclQOHEI=;
        b=mYn+TlXQMHoyTEx2h1pPPSYZCpFefWr2ifcX2mutH5RWhogX7//HV+Vv7J0l3DQBzZ
         If6lyHstH/hEXqyn6Np2U9vPQCFIG4M+bM+KPI1SCNpLKLl/toqo3731orHsxjZDAMeG
         v5XzlrUqa1QnUVCpAFBdevxne3NaP0dd8vISxVJcKF4GPb9o6FmS4DV8arkwjz+M9Yif
         c9yfVHk/wXG60vAc/KI1eGYxzPngUxTVpaU7K8oJ6Hkyz8O0aojcqn5oiv8OF01xKiDX
         JNZVBOGcojxBc5pZCnlBa4F2Y05cmq1I105pqxiEV7Bcr330V2AmGKZefL6LKe37lf04
         CJnQ==
X-Gm-Message-State: AOAM531yIb1OS9KOit3cwun1wJfCyYV7KMoJQa1k6ivXbKnW6byPYVwd
        x0jR3t2XQy/5OiQjS85bH6nWcQjgkx4sxJiIsKac7g==
X-Google-Smtp-Source: ABdhPJxnGAvmNMVx3acHPlZF4Rm6WnepSIlFzFBQ06ZpRZx2DZqOEv4RG+mSRfbwXJEELPBvFhkUL1VGumWX5pvvyBM=
X-Received: by 2002:aca:913:: with SMTP id 19mr1392259oij.169.1599778609267;
 Thu, 10 Sep 2020 15:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
In-Reply-To: <20200904155513.282067-1-bjorn.andersson@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 10 Sep 2020 15:56:38 -0700
Message-ID: <CALAqxLU6pUFZuB=TXA8_Oke0njKHnrJagXkT2nQ4ZB7vAnJXOQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] iommu/arm-smmu: Support maintaining bootloader mappings
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 8:56 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> Based on previous attempts and discussions this is the latest attempt at
> inheriting stream mappings set up by the bootloader, for e.g. boot splash or
> efifb.
>
> Per Will's request this builds on the work by Jordan and Rob for the Adreno
> SMMU support. It applies cleanly ontop of v16 of their series, which can be
> found at
> https://lore.kernel.org/linux-arm-msm/20200901164707.2645413-1-robdclark@gmail.com/
>

Apologies, I just found this today. I've pulled your patches and Rob's
into my own tree here:
  https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/db845c-mainline-WIP

And they all work fine on the db845c.

So for your whole series:
Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
