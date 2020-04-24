Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB338C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 880452098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e13dIJUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgDXRL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgDXRL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:11:58 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECE2C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:11:58 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id i22so10187726uak.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qpkl+qNwwY4WAWznVbHpk6dXXW1O6q1xf3B4ddtrOiY=;
        b=e13dIJUXiJ0D1CzVmUa5XR1DCgFtYc/vR94tal4DUJHTqNtqNAQXVnKbTKJUjexX/d
         bx10TBGZR1HkRAoeIfpdPEik3DNZMTSc9Cmwlg6escc325VWZfjF8eFvuZNPV/1Pd2JH
         nUOI1P9Jdou4oVcaF5PYZLkZXv0/bJg2tWlgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qpkl+qNwwY4WAWznVbHpk6dXXW1O6q1xf3B4ddtrOiY=;
        b=BSCCAqOha1+Y6mtD2ve1PUZGSvYOwZ2m2xXUcvZVaMzqFwNSVMffHe3W+sbgpi/Gvx
         6TBgifqGbpOURjvdEOqHBFTnBKwjVA3R+airZYLRkzChrh5daMckjhFM9o9XEKEt1hQa
         nr365h78+YRrDHLWLI9KcuCBbJ8r76eJbf0aI++AQJlS/Pk10cRPaRobX2Syrg8mBbi8
         RQeCw+BQMXt9HRcHMYUQsFBR62vKx19SLQPeB1UxsuTP6s3b2MUNGv6r853MYNE6tklA
         44IBliSoEvaNagJcZAoF7t5BC6UdF//tft+dGsPzRBskRHDD7E3O1xuf2GWL93KK3BLA
         MnLg==
X-Gm-Message-State: AGi0PuaOD0ZemnrapmBg3ePWOAaHYPChSIYZKWTCvyf82sl/8M7zCrKG
        UTGyP5y8/bjWwASyq5PjvqFzRbHfAaE=
X-Google-Smtp-Source: APiQypLXH6WUnKx8GwKVDOmml69FGAptGilLivTB3uwvycCxKPeit3BAOYotHiNikECJ9HN1ltbr3Q==
X-Received: by 2002:a67:1a06:: with SMTP id a6mr6368091vsa.72.1587748316942;
        Fri, 24 Apr 2020 10:11:56 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id t67sm1713285vkc.39.2020.04.24.10.11.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 10:11:55 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a7so2278655uak.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:11:55 -0700 (PDT)
X-Received: by 2002:a67:3293:: with SMTP id y141mr8719886vsy.54.1587748315110;
 Fri, 24 Apr 2020 10:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200424045414.133381-1-swboyd@chromium.org> <20200424045414.133381-4-swboyd@chromium.org>
In-Reply-To: <20200424045414.133381-4-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Apr 2020 10:11:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UYNKOtTHQO7v5ad4KgDV-SzbSnqy9G3vFkSZmWmW=NMg@mail.gmail.com>
Message-ID: <CAD=FV=UYNKOtTHQO7v5ad4KgDV-SzbSnqy9G3vFkSZmWmW=NMg@mail.gmail.com>
Subject: Re: [PATCH 3/3] soc: qcom: rpmh-rsc: Fold WARN_ON() into if condition
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 23, 2020 at 9:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Move the WARN_ON() into the if condition so the compiler can see that
> the branch is unlikely() and possibly optimize it better.
>
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/soc/qcom/rpmh-rsc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
