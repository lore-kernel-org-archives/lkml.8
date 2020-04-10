Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAE9C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4CD20A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IQaN9Kus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDJOxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:53:07 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:42735 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgDJOxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:53:07 -0400
Received: by mail-vk1-f193.google.com with SMTP id q7so586995vkb.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sXbs2eSo2cip0Bhx0gise5pTsMBWhGiPepQWudlrrKs=;
        b=IQaN9KussGunjaHK0pdxgBSCx4RVNoghmD135k0hs2w75kdaoTKcoRE1PJ5lbo93ww
         lGQAaiETFOrzVMXrOQGyjT5Xw7dQCwQsxq8RN1dcYWo8GLAEt4ygV3NHbzzeGeRNmO1k
         cewZcsSAJHMTeay1xQEeMe5Po0m1DEfvIB4yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sXbs2eSo2cip0Bhx0gise5pTsMBWhGiPepQWudlrrKs=;
        b=NV3UO6YnD8vmFeoDrH/pv1rBUNh8uY5zFw6ROPD8ADn8aD22LsmBEVNz9CmALNewpK
         9Ym8s/NYNKDONyTt7Zapuf2XCUge9LP13AHPuVW5Xi/k7eQWQzQJHezcylpvwI83+k1d
         h7VXpIvKDvScvam0LpK7VztfdWB7hc7Cc1XyRFnbmi7X+WArxPiNCZ/LstXjStR1bBYD
         +Chkbrgpm/g3BzlD2M4QLBN5IESkiahHGoIWyMRIgUMgRPM0Q8rafeVkB2NameS0uVdR
         dKBLYxy7JQ4JJhvz65scfM0C3P/h0TLez3u4ubKXV/tSHFdBjQV6LRp4PKQ8zEQFcrCZ
         cf1g==
X-Gm-Message-State: AGi0Pua5kxm3JjM1Ru6bEKGRz6jewIRFmYtaMwYfnJbNP7FBRyr2f9m4
        Ea5KWlsvHh4t4yl4mEb7IrkCsLGlxec=
X-Google-Smtp-Source: APiQypK9JMBATydL8WY1CIqhjA8T1J/7LPsPOBcyRLKS4mhZMNYgMv5CQ++1X9P3BwaF/K0mHg8jUA==
X-Received: by 2002:a1f:3a0a:: with SMTP id h10mr3632417vka.43.1586530385804;
        Fri, 10 Apr 2020 07:53:05 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id w1sm657101vkm.45.2020.04.10.07.53.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 07:53:04 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id c7so686423uap.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 07:53:04 -0700 (PDT)
X-Received: by 2002:a9f:27ca:: with SMTP id b68mr1030762uab.8.1586530383958;
 Fri, 10 Apr 2020 07:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <1586154741-8293-1-git-send-email-mkshah@codeaurora.org>
 <1586154741-8293-5-git-send-email-mkshah@codeaurora.org> <158649213142.77611.5740203322498170248@swboyd.mtv.corp.google.com>
In-Reply-To: <158649213142.77611.5740203322498170248@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Apr 2020 07:52:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UkiR+xLeowOT+H3ZKNCesf84AJi6mHiHNpJ2P9-DiXaQ@mail.gmail.com>
Message-ID: <CAD=FV=UkiR+xLeowOT+H3ZKNCesf84AJi6mHiHNpJ2P9-DiXaQ@mail.gmail.com>
Subject: Re: [PATCH v16 4/6] soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Maulik Shah <mkshah@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 9, 2020 at 9:15 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> >  int rpmh_flush(struct rpmh_ctrlr *ctrlr)
>
> This function name keeps throwing me off. Can we please call it
> something like rpmh_configure_tcs_sleep_wake()? The word "flush" seems
> to imply there's some sort of cache going on, but that's not really the
> case. We're programming a couple TCS FIFOs so that they can be used
> across deep CPU sleep states.

I'm hoping this rename can be deferred until Maulik's series and my
cleanup series land.  While I agree that rpmh_flush() is a bit of a
confusing name, it's not a new name and renaming it midway through
when there are a bunch of patches in-flight is going to be a hassle.

Assuming others agree, my thought is that Maulik will do one more v17
spin with small nits fixed up, then his series can land early next
week when (presumably) -rc1 comes out.  If my current cleanup doesn't
apply cleanly (or if Bjorn/Andy don't want to fix the two nits in
commit messages when applying) I can repost my series and that can
land in short order.  Once those land:

* Maulik can post this rpmh_flush() rename atop.

* I can post the patch to remove the "pm_lock" that was introduced in
this series.  A preview at <https://crrev.com/c/2142823>.

* Maulik can post some of the cleanups that Maulik wanted to do in
rpmh.c with regards to __fill_rpmh_msg()

...assuming those are not controversial perhaps they can be reviewed
quickly and land quickly?  I suppose I can always dream...


-Doug
