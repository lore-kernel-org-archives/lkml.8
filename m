Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C90C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 00:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724B720757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 00:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QzNPLo5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDIAKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 20:10:15 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36388 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgDIAKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 20:10:15 -0400
Received: by mail-vs1-f65.google.com with SMTP id 184so5898342vsu.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 17:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B6pS9OgAcPsD6CSPKpIIvHEG5zqVSzQLTTYkVt8jyck=;
        b=QzNPLo5RL3lO4TmcYcF4V23HmCtH6zvc/crCSse2osUeXKghPrIz35H3jROp57Pjgn
         bNzydnCYuDad7TyqCSU8b4kqNffY3kKjr7V85Po1uBZTiSt9EqlzUwi3Ra7nIr2/HtKy
         U+Y0d1OkSTzwAv2urvP556j42eGzCmag+ojsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B6pS9OgAcPsD6CSPKpIIvHEG5zqVSzQLTTYkVt8jyck=;
        b=N/A8s9VaJscnH0N41TkmoA7+wNfL0iPGaUeq0HfsPxqLq176d5L3whWx2bXtB8/aSP
         Og8chIUmJq8s/2HCx4wejHRyTHVBb+uGvVIjwDNQ0cM/RScq4avs8/CM/4KXq95AgsgF
         3aCh/VaedSAMZBZ6aSzL5RKVZy6JDpzzN/brUW/urmrCGXvnkeniz2BEtYuL5LFiU3MA
         o65QZNqgLasIlIPv4GR1M/4Q+Nu8YjtFHRYtBymilCz+leJwqlIUMr5+bXPSwwvqSDuB
         ElDesCLHXsZ2hzYquugnk2tt0xyub965BVEzk/uq5wjTpBn5HUyEDRyD69C7fWFQ6W6i
         6LnQ==
X-Gm-Message-State: AGi0PuYbd52bUr7DK4yJOTANAcRX2v+guCyc3BDsm/o17ec09wzFaEFe
        T5wTg3rnnnZtZTTLGxfVKlNxxQYX0Vc=
X-Google-Smtp-Source: APiQypKJekb7wML7baI7rjx0gIln2lOUGDaGe1BYA+x1B39L81gWZyIOV+I3hIZK2C3UZp8NgyQZ8g==
X-Received: by 2002:a67:320f:: with SMTP id y15mr8798396vsy.157.1586391014611;
        Wed, 08 Apr 2020 17:10:14 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id d83sm6829264vka.34.2020.04.08.17.10.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 17:10:13 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id g24so3327813uan.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 17:10:12 -0700 (PDT)
X-Received: by 2002:ab0:2389:: with SMTP id b9mr7355490uan.120.1586391012513;
 Wed, 08 Apr 2020 17:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200407235024.260460-1-dianders@chromium.org>
 <20200407164915.v3.8.I8e187cdfb7a31f5bb7724f1f937f2862ee464a35@changeid> <b61a5b31-d614-93f2-7fdd-ec372fba3080@codeaurora.org>
In-Reply-To: <b61a5b31-d614-93f2-7fdd-ec372fba3080@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Apr 2020 17:10:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XQbtrkK1u6jTuc-pP4fUx0av3eMYznSkUSC2io7BGmmg@mail.gmail.com>
Message-ID: <CAD=FV=XQbtrkK1u6jTuc-pP4fUx0av3eMYznSkUSC2io7BGmmg@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] drivers: qcom: rpmh-rsc: Don't double-check rpmh
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 8, 2020 at 5:24 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Hi,
>
> In rpmh.c, rpmh_write_async() and rpmh_write_batch() uses
> __fill_rpmh_msg() which already checks for below payload conditions.
>
> so i am ok to remove duplicate checks from rpmh-rsc.c
>
> can you please add payload at the end of subject.
>
> drivers: qcom: rpmh-rsc: Don't double-check rpmh payload
>
> Other than this.
>
> Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
> Tested-by: Maulik Shah <mkshah@codeaurora.org>

Thanks!  Bjorn / Andy: if you want me to spin my series I'm happy to.
I'm also happy to just let you fix this nit in the commit message and
the other one Maulik had when applying.  Just let me know.


> Note:
>
> rpmh_write() is not using __fill_rpmh_msg() and have replica as below,
> probably since it was declares message on stack instead of using malloc()
>
>          if (!cmd || !n || n > MAX_RPMH_PAYLOAD)
>                  return -EINVAL;
>
>          memcpy(rpm_msg.cmd, cmd, n * sizeof(*cmd));
>          rpm_msg.msg.num_cmds = n;
>
> Making a note to remove above if check and start using __fill_rpmh_msg()
> here as well to do memcpy() and num_cmds initilization.
>
> Although it may end up writing msg.state and msg.cmd twice (once during
> defining msg on stack and then during fill rpmh msg) but it should be ok.
>
> Below two lines from __rpmh_write() can be removed as well.
>
>          rpm_msg->msg.state = state;
>
> DEFINE_RPMH_MSG_ONSTACK() and __fill_rpmh_msg() seems taking care of
> initializing msg.state already, so we should be good.
>
> if you are spinning a new version and want to include above change as
> well, i am ok.
>
> if not, i can push separate patch to update this as well once my series
> to invoke rpmh_flush() gets picked up.

I'd sorta be inclined to wait and do this later just because it seems
like we've got enough changes stacked together right now...

-Doug
