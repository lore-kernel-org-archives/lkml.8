Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C17C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D7620773
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GtNFZSwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbgFRVws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbgFRVws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 17:52:48 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D294DC0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:52:46 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id s192so1824975vkh.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ew2PN/4JsZ1wOw/upw7XfR2Cn0MqAYGwSv+ArwTNfmg=;
        b=GtNFZSwLjEFMtYwi0oRZBt+nZLXjddEbJRtWA3O3P8yrVdh+hvhXAdHuvsPbpWO8ii
         fsmwrUcikBj2TG5ojkCPeDiL3xc/s/V4bO+dGxXHxeRVhRsVyZQYCRDJxzgKi/eUdOZp
         RqD7kWnJQgaLxxyMkLKR8Yju/2pQXlPg+7ivc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ew2PN/4JsZ1wOw/upw7XfR2Cn0MqAYGwSv+ArwTNfmg=;
        b=CBizPAd8PM57fOhWMGTzKiwt/wnQtb6CB7VOWw4bcOp310J/xh32I8saZthnQ5po5H
         Y5kNjlXpKgCz0ab5cQoEhWWxI2D0C34YQNPedJrR7X600BF1nZHw2UMxMqr7bmjy57Na
         9huPgTnJd8MT8W6OXv39RQG9NWyU6bsIcvJmkh5BIQEoH6f74Ht/fXX6ao0U25ruOJ5Z
         rQkIeWRKHGMluvPXEl+iU4Jmg9SA6TVhHPKxc4dFYOwh9PkwnP0Sad6ueZzFrP2WCMu9
         EbmhMklj9fDdoDBPUlZCb4Jby6AxZqQ5FoWcBNNnkp19exHVVq0xd4xkap7K19Dv6rBQ
         Bb+w==
X-Gm-Message-State: AOAM531svmG829YYUOCLfoxSn9V3vTqRE2FR1NjsLZmy53XaAftff4Oy
        6fY0xiTEF8SvhzdBkCPLJAHfxoiyjzg=
X-Google-Smtp-Source: ABdhPJwR8neTnyUxIiMI1RF2tJlcV81VofkzMKnkNYNlm+J9VqXauppoIpKeiWhHTn/ie1eAsTXpew==
X-Received: by 2002:a05:6122:302:: with SMTP id c2mr5243685vko.42.1592517165651;
        Thu, 18 Jun 2020 14:52:45 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id v26sm492176vsa.10.2020.06.18.14.52.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 14:52:44 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id c9so2496423uao.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:52:44 -0700 (PDT)
X-Received: by 2002:ab0:29c1:: with SMTP id i1mr451761uaq.120.1592517164088;
 Thu, 18 Jun 2020 14:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200528074530.1.Ib86e5b406fe7d16575ae1bb276d650faa144b63c@changeid>
In-Reply-To: <20200528074530.1.Ib86e5b406fe7d16575ae1bb276d650faa144b63c@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Jun 2020 14:52:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W9=cWZpW10ecG9_DmpWCEVhJ9C_AzbP4fTqdPQFZPhZw@mail.gmail.com>
Message-ID: <CAD=FV=W9=cWZpW10ecG9_DmpWCEVhJ9C_AzbP4fTqdPQFZPhZw@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Don't use ktime for timeout in write_tcs_reg_sync()
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn and Andy,

On Thu, May 28, 2020 at 7:48 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> The write_tcs_reg_sync() may be called after timekeeping is suspended
> so it's not OK to use ktime.  The readl_poll_timeout_atomic() macro
> implicitly uses ktime.  This was causing a warning at suspend time.
>
> Change to just loop 1000000 times with a delay of 1 us between loops.
> This may give a timeout of more than 1 second but never less and is
> safe even if timekeeping is suspended.
>
> NOTE: I don't have any actual evidence that we need to loop here.
> It's possibly that all we really need to do is just read the value
> back to ensure that the pipes are cleaned and the looping/comparing is
> totally not needed.  I never saw the loop being needed in my tests.
> However, the loop shouldn't hurt.
>
> Fixes: 91160150aba0 ("soc: qcom: rpmh-rsc: Timeout after 1 second in write_tcs_reg_sync()")
> Reported-by: Maulik Shah <mkshah@codeaurora.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/soc/qcom/rpmh-rsc.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

Is it a good time to land this change now that -rc1 has come out?
It'd be nice to get this resolved.

Thanks!

-Doug
