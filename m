Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03150C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D0C20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WP7q3Sui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBESIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 13:08:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42866 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbgBESIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:08:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so2148992lfl.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 10:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xxM2KM7SFU0OuxVauJZTx1kXhl4JXfEt7TGRJvg/kq4=;
        b=WP7q3SuitLJAbKGWLEGzBmTKDcmmUlPnu/WjZqrW3AduihyetE/g/gczvYpfzautL6
         18mEc2wQE2TWpn0PWNlNcERY3LsWVlL/rX6rAqCMX+/x9U55YT9RwSnLBHIaK7t5IRl+
         RRgU60ChxJtJzE81ltKegxet7Bbww509GWpFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxM2KM7SFU0OuxVauJZTx1kXhl4JXfEt7TGRJvg/kq4=;
        b=ah+5mWeWJMjnKVnxudtSDgjJ+UVRJkDgCL2oE4PvFlzfEUVLEwJSUqn6oGEXDBNfjS
         MpWUpkNNkJpYaY1l+X6Bg42JqINC5GobF81C6RJ/0ta4VxzSJ24iQy93zmCYWwojWxID
         GsQLK//xkq/1b2wERpmowvv9JXVBwGrZUegb9nKMhJ4Zvz6VHCtYF8DnyLbhhIEWvAho
         9KAKWSl6o8LERpO3p8nLIRHh8pAsaKwDUYkUQTXpdce+04BxjJgil2EnmIyc74155PEC
         iskdPr3xZiISLQeIWU4xbBMLR8UTFvBRooM9hoCmNa746h0e7SLbaW0bxelm6Br/g5uP
         tZEA==
X-Gm-Message-State: APjAAAWv5h2ZvHdzVhLDmk51omq3+Jl3s2duYpjo3C77EkSihLfM2WX7
        frz3PMIOE7Z+04SLk1G+0G9ztW6Wr2s=
X-Google-Smtp-Source: APXvYqxtrXKfQPnsGYDli9C7dvEX2PSuMY4D6rYCXxiRaM0D5j5Th0jMxCQgXfQgiIkvcvut6JXVIw==
X-Received: by 2002:ac2:5dc8:: with SMTP id x8mr18074156lfq.217.1580926087996;
        Wed, 05 Feb 2020 10:08:07 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t9sm108037lfl.51.2020.02.05.10.08.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 10:08:07 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 9so2143569lfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 10:08:06 -0800 (PST)
X-Received: by 2002:a19:c205:: with SMTP id l5mr18197762lfc.159.1580926086038;
 Wed, 05 Feb 2020 10:08:06 -0800 (PST)
MIME-Version: 1.0
References: <1580796831-18996-1-git-send-email-mkshah@codeaurora.org>
 <1580796831-18996-2-git-send-email-mkshah@codeaurora.org> <CAE=gft6DCqmX8=cHWXNeOjSTuRHL23t7+b_GZOrvUJAPfhVD8A@mail.gmail.com>
 <d95de83d-fbda-5ebf-1b87-126c19f4d604@codeaurora.org>
In-Reply-To: <d95de83d-fbda-5ebf-1b87-126c19f4d604@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 5 Feb 2020 10:07:29 -0800
X-Gmail-Original-Message-ID: <CAE=gft7ESnpS8bYg4hmoAUtsuLiyek1D-AYEL+LWUKe=KubAJw@mail.gmail.com>
Message-ID: <CAE=gft7ESnpS8bYg4hmoAUtsuLiyek1D-AYEL+LWUKe=KubAJw@mail.gmail.com>
Subject: Re: [PATCH 1/3] soc: qcom: rpmh: Update dirty flag only when data changes
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 8:14 PM Maulik Shah <mkshah@codeaurora.org> wrote:
>
>
> On 2/5/2020 6:05 AM, Evan Green wrote:
> > On Mon, Feb 3, 2020 at 10:14 PM Maulik Shah <mkshah@codeaurora.org> wrote:
> >> Currently rpmh ctrlr dirty flag is set for all cases regardless
> >> of data is really changed or not.
> >>
> >> Add changes to update it when data is updated to new values.
> >>
> >> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> >> ---
> >>   drivers/soc/qcom/rpmh.c | 15 +++++++++++----
> >>   1 file changed, 11 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> >> index 035091f..c3d6f00 100644
> >> --- a/drivers/soc/qcom/rpmh.c
> >> +++ b/drivers/soc/qcom/rpmh.c
> >> @@ -139,20 +139,27 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
> >>   existing:
> >>          switch (state) {
> >>          case RPMH_ACTIVE_ONLY_STATE:
> >> -               if (req->sleep_val != UINT_MAX)
> >> +               if (req->sleep_val != UINT_MAX) {
> >>                          req->wake_val = cmd->data;
> >> +                       ctrlr->dirty = true;
> >> +               }
> > Don't you need to set dirty = true for ACTIVE_ONLY state always? The
> > conditional is just saying "if nobody set a sleep vote, then maintain
> > this vote when we wake back up".
>
> The ACTIVE_ONLY vote is cached as wake_val to be apply when wakeup happens.
>
> In case value didn't change,wake_val is still same as older value and
> there is no need to mark the entire cache as dirty.
>

Ah, I see it now. We don't actually cache active_only votes anywhere,
since they're one time requests. The sleep/wake votes seem to be the
only thing that gets cached.

I was thinking it might be safer to also set dirty = true just after
list_add_tail, since in the non-existing case this is a new batch that
RPMh has never seen before and should always be written. But I suppose
your checks here should cover that case, since sleep_val and wake_val
are initialized to UINT_MAX. If you think the code might evolve, it
might still be nice to add it.

While I'm looking at that, why do we have this needless INIT_LIST_HEAD?
        INIT_LIST_HEAD(&req->list);
        list_add_tail(&req->list, &ctrlr->cache);

-Evan

> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
