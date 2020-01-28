Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6988C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C56D2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jy6LgqTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgA1Qh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:37:27 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45371 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgA1Qh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:37:27 -0500
Received: by mail-ua1-f66.google.com with SMTP id 59so5021148uap.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 08:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdBTmzXhmHeC2y+w5bp3Tmr7OlXTeRKWIpwTGn8ME1U=;
        b=Jy6LgqTmfR3UQAL/nf0tfINNueuVMCNCsDnr62JvGnqxaaSO6eh3MGvzb2gsmFEIh9
         v8t62XCbAvdWKGGuypZ0FLwOEZ78/yTzMfyma+7Mhjly532URlcehmPWG8YJYOtWvU7+
         LRsSBxPVZR7oanCNXskMFWyNcGIxQQbm+e0KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdBTmzXhmHeC2y+w5bp3Tmr7OlXTeRKWIpwTGn8ME1U=;
        b=NvmBvI8oxNpce84Yp1Vb9cC31D8qmqasZLXSUgSnrS86c4IrAytiqqILx+3hPpVpRw
         v62aycvgf964VLZcg4ujkDKvJwvY2hsNmx7erfyUpiUAzCRQavLM7e8BGdPhO7b/labV
         w6VBqDWqRU6XOW/UyWRqKGa5mn/au342kYcpBfhUJU8KmMP335Jist5CtP48LMScwGCC
         Pr/iRr04fGYdwGE7SZpu/1+6jakI3im/MDAw42RaEbbP+2nwDAiF4R7JAi3XYXtmrk3Q
         vUTR72GUCVVM4IW2jruIMUD1KHT/ZzGWNJLBMenk6g4o/h5f+6s6IFFRo3P75eFlXTRV
         GIbQ==
X-Gm-Message-State: APjAAAWhwwQzXwA0JqFddUX86vKBOiFOlJ8nr8GwMMuTRtKjBLxqxDGv
        FKONSE3NMhv2Tizu9qsXgto4VNRDzBQ=
X-Google-Smtp-Source: APXvYqzHXXXsjybvB0kI0budLgR3EooXvAS58tHh+OQ9uNlsD2diKDZUvNYH+xj2Su4TW6HlRNsIRA==
X-Received: by 2002:ab0:740e:: with SMTP id r14mr13848833uap.104.1580229446115;
        Tue, 28 Jan 2020 08:37:26 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id b15sm4100935vsl.32.2020.01.28.08.37.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 08:37:24 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id t12so8462483vso.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 08:37:23 -0800 (PST)
X-Received: by 2002:a67:fbcb:: with SMTP id o11mr14305246vsr.109.1580229443406;
 Tue, 28 Jan 2020 08:37:23 -0800 (PST)
MIME-Version: 1.0
References: <20200124224225.22547-1-dianders@chromium.org> <20200124144154.v2.7.I3bf44e33f4dc7ecca10a50dbccb7dc082894fa59@changeid>
 <6e585554-d0bd-39d7-2150-e7968dd51fb3@codeaurora.org>
In-Reply-To: <6e585554-d0bd-39d7-2150-e7968dd51fb3@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Jan 2020 08:37:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XpUN0_LRnNc6B-wY3J1f_f23iJussyD-+d8Q-Rjd28zA@mail.gmail.com>
Message-ID: <CAD=FV=XpUN0_LRnNc6B-wY3J1f_f23iJussyD-+d8Q-Rjd28zA@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] clk: qcom: Fix sc7180 gpucc parent data
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Harigovindan P <harigovi@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>, kalyan_t@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 27, 2020 at 9:55 PM Taniya Das <tdas@codeaurora.org> wrote:
>
> Hi Doug,
>
> Thanks for your patch. But as mentioned earlier we really want to avoid
> updating the auto generated code.

As per my reply [1], I think you need to update your auto-generation
tools to generate the code that results from my patch.  The existing
code either requires using global clock names to match or requires to
pass clocks in the dts that aren't documented in the bindings.  That
needs to be fixed and my patch fixes it.

[1] https://lore.kernel.org/r/CAD=FV=XFFCPj8S7-WPjPLFe=iygpkYiyMqbneY0DMXsMz+j73w@mail.gmail.com

-Doug
