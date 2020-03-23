Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBBCC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAC32074D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c1CQI6r5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgCWQcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:32:54 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40361 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbgCWQcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:32:54 -0400
Received: by mail-vs1-f66.google.com with SMTP id d18so1248418vso.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vX/pTxX5leUKI//FHes+EDjkWAmuKn+xAlsAhXDay5w=;
        b=c1CQI6r5AyGrK7N+JP44nrKbQ0k3r8F5dz6wSdikRKRG8IBAr591tkZHPW4rL5sQ0K
         FEIOrHYN/ryK4FWkhbMYudP9qub+iU9PP6IqV2AufntwMh0sDIrw8OhzUhO9h7+AEtcU
         bntwsCZo8mATCRdmMgeNj+YyBFYL6wTejiX5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vX/pTxX5leUKI//FHes+EDjkWAmuKn+xAlsAhXDay5w=;
        b=hpNhPbG0qvldmdzQ2QTvE3wyYjlgcTAjEQ4C4Wn5JC3gSVa5KJm930pxTNvH2JoIBW
         7qWUAUh097+BjTIg0Ajs97gifQRxFLiTzUfMnBuTWcFNBiYQZ+rq034Kc/of5ZGThTKj
         4cbyGmxpY3ej8hgodh4T/SJ2rZT0XKgmUb348lhBxIRLK4EJzGBymCUMSm8JouL4p3xV
         XxsTavdZPrWppypjxWzPb9FxzyIzgvHggsq33/zNy9hyk8qqwNhpSz2PFhRzyYs8hk7M
         GerzedlCsiIWLoPB0x44WoCgE6lNcPsnM/HPAXVP4h4Lj0VZq0ywRAlIYjYQq8kvMcNV
         OyMw==
X-Gm-Message-State: ANhLgQ0TThTcuAurzDPn7ZxHblP2NzpSoWex9PWPIpIUWz/8ATW8BWDF
        lg5Nqma1DlxDVjYFQqX+EF64TpeDg/I=
X-Google-Smtp-Source: ADFU+vsTtut0T4gavvN+5iJ/9j4jQjdxqH5aY6nj6Is4GvfVT0VqURj1danseX2TqRYBlVrBXV0ZdA==
X-Received: by 2002:a67:2c16:: with SMTP id s22mr16201078vss.86.1584981172927;
        Mon, 23 Mar 2020 09:32:52 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id l184sm7743965vke.21.2020.03.23.09.32.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 09:32:51 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a6so352216uao.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:32:51 -0700 (PDT)
X-Received: by 2002:ab0:604f:: with SMTP id o15mr8911387ual.120.1584981170619;
 Mon, 23 Mar 2020 09:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200317133653.v2.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
 <20200323110756.GD26299@kadam>
In-Reply-To: <20200323110756.GD26299@kadam>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 23 Mar 2020 09:32:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WcnAtA2WRoC-+R2yKC1OCsDOEDMXu5jKveOARhw4gmOg@mail.gmail.com>
Message-ID: <CAD=FV=WcnAtA2WRoC-+R2yKC1OCsDOEDMXu5jKveOARhw4gmOg@mail.gmail.com>
Subject: Re: [PATCH v2] spi: spi-geni-qcom: Speculative fix of "nobody cared"
 about interrupt
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, kbuild-all@lists.01.org,
        Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 23, 2020 at 4:08 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> 561de45f72bd5f Girish Mahadevan 2018-10-03  327                 ret = get_spi_clk_cfg(xfer->speed_hz, mas, &idx, &div);
> 561de45f72bd5f Girish Mahadevan 2018-10-03  328                 if (ret) {
> 561de45f72bd5f Girish Mahadevan 2018-10-03  329                         dev_err(mas->dev, "Err setting clks:%d\n", ret);
> 561de45f72bd5f Girish Mahadevan 2018-10-03  330                         return;
>
> Needs to drop the lock before returning.

Oops, thanks for catching.  I will wait before spinning a v3 until
there is some clarity about whether folks want to do something more
like Stephen suggested or whether I should continue with my strategy.
At the moment I'm still in favor of keeping w/ my strategy and seeing
if I can reduce the amount of time with interrupts disabled in
setup_fifo_xfer(), maybe just grabbing the lock around the start of
the transfer to keep the state machine in sync with the kickoff...

-Doug
