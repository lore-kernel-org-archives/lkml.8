Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCE6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F6BD206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N+kSkmDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgHLNwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgHLNwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:52:22 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804DBC061386
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 06:52:22 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id x2so514857vkd.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8InXO4IHlwCJ/3LHKr2wC5cvoqCeqc4wxbX8rXjUiPg=;
        b=N+kSkmDigJZm9bdYj2CCq6cRuTJusMts4MyrYLhaepzh1SFeONS44pX8HelNsXmkpt
         Sar1XiJvk4yffabWSLuwN6z7snQ+dFjiNxSHvBEnAwmsfgNATsdM1HHNgVZ0t9hUvslm
         ipOuT2PSmwUT1HfAGS8oOlizyFM9mh0PMN6DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8InXO4IHlwCJ/3LHKr2wC5cvoqCeqc4wxbX8rXjUiPg=;
        b=TIX0IF1qq4ZHsUjPnZuQiKwMVLqi99+2Jt688yYk8KmBSW8zuhtn6n5kNR27rY6XR0
         Gq0fdU0Amt/dPDO08rFcvP/8IYM6tfbp05L3d/52BEi5n6h38w2hKEvq6h8p1kl8bB72
         bH4fDksTxjYtYqrWKqtr+VsAd5G2NmFp5oOft5N+/nQWcVl+OfAfxxfgtq5SWSEot888
         fkwiegL/c3jTNyQYSLqW7HeRViyGJTD0VdKvELyAZPs7nZHO7YRlhRWzCm7b0t7/QhrM
         zs+jYgofyC08Q9FKRPlGl+fa2qN0q/4ZukWO4RbYi/VlrgOcnWMOXsrpGV/FifshhI//
         B14Q==
X-Gm-Message-State: AOAM531+gaQLOcnju1/OSjrHE/RanukGodz3MZsOgR36TFovfZayKeee
        dporX78mallmzK1eiaU7KyLaG2KFOOA=
X-Google-Smtp-Source: ABdhPJy5BptEkOvYBit6HD/fbMGCJIeyOSfISXeAQtSy4Gm9N2d9OacTYiQN0OG+s0eqThh1FldHsw==
X-Received: by 2002:a1f:bdcd:: with SMTP id n196mr18488890vkf.10.1597240339254;
        Wed, 12 Aug 2020 06:52:19 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 81sm319013vky.52.2020.08.12.06.52.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 06:52:17 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id d20so614539ual.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 06:52:17 -0700 (PDT)
X-Received: by 2002:ab0:3114:: with SMTP id e20mr27858800ual.104.1597240337098;
 Wed, 12 Aug 2020 06:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200215021232.1149-1-mdtipton@codeaurora.org> <158378825407.66766.14135857856613969751@swboyd.mtv.corp.google.com>
In-Reply-To: <158378825407.66766.14135857856613969751@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 12 Aug 2020 06:52:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WsD7w9oqbUUKJwWSRsfZ9qTLy9KyNp8i+BShi7S-R92w@mail.gmail.com>
Message-ID: <CAD=FV=WsD7w9oqbUUKJwWSRsfZ9qTLy9KyNp8i+BShi7S-R92w@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: clk-rpmh: Wait for completion when enabling clocks
To:     Stephen Boyd <sboyd@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     Mike Tipton <mdtipton@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 9, 2020 at 2:11 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Mike Tipton (2020-02-14 18:12:32)
> > The current implementation always uses rpmh_write_async, which doesn't
> > wait for completion. That's fine for disable requests since there's no
> > immediate need for the clocks and they can be disabled in the
> > background. However, for enable requests we need to ensure the clocks
> > are actually enabled before returning to the client. Otherwise, clients
> > can end up accessing their HW before the necessary clocks are enabled,
> > which can lead to bus errors.
> >
> > Use the synchronous version of this API (rpmh_write) for enable requests
> > in the active set to ensure completion.
> >
> > Completion isn't required for sleep/wake sets, since they don't take
> > effect until after we enter sleep. All rpmh requests are automatically
> > flushed prior to entering sleep.
> >
> > Fixes: 9c7e47025a6b ("clk: qcom: clk-rpmh: Add QCOM RPMh clock driver")
> > Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> > ---
>
> Applied to clk-next but I squashed in some changes to make it easier for
> me to read.

This landed upstream as commit dad4e7fda4bd ("clk: qcom: clk-rpmh:
Wait for completion when enabling clocks") but seemed to have missed
stable.  Can stable pick it up?  It has a Fixes tag so presumably it
should be easy to track down where it needs to go.

Thanks!

-Doug
