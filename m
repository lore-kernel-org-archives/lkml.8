Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7DBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B84022B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ldq66E58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgHEUZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgHEUZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:25:43 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA32FC061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 13:25:42 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id q72so2794562vkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 13:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NeLZEQ55IXSBwyK2UtcYBYdp7h3NvOqG3j88PCLKXdE=;
        b=ldq66E588YQ2N2pcWRS0g7hqu2I61ObMKOqxKEQpKmUkiMb1rk5TLMnU+N5U1dEd70
         ULvtiu9eFIosjAgCa3rwlD4dYGk2ZWh+iYydq0m5hfNWZB5g8//uQA0AeXXZtnh26n0h
         nP+M6nQ+9eNipJt0FwYaO/LiVpyjl2JF22Dp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NeLZEQ55IXSBwyK2UtcYBYdp7h3NvOqG3j88PCLKXdE=;
        b=a5AVSsL4vvJK8WxmPsrNIRQ6yJoA5ojH12/Lt+LpoSZjw5j0NTXKWJqKc3TQGsGrLx
         KNzJ/SRedgoa5dwt/bUPbCS5POOsvOzYOWKwyzyQv2+oN+KdgN+ymxEvFRSXqljE2JIY
         cHR/0IrCOtHy3WEqEkkaAL3oFkGu38hIhgrGKY1Mq0yYymGMZb2AmSvo1XWZWVwPSQZ4
         vHCSk7ZO5nTpC4RGbnXQGh0nhoR/1N8kVcTq5pLbeE8E+q2LJuO8jTWo+iCpr188rkO7
         QVvEHHfcuKwgv8GHJsfDOOue84POeqttaXruBRxZ96RlshYUEuTjSpd+gol2KNCo5sDS
         8ovQ==
X-Gm-Message-State: AOAM531LPBF09LzBCeUNOnClMOWH7r60quF2EbLnTr2ONiCasJ2ovRl9
        GlkrCdxig/V8pa8aehY0fN+/jAZlWgQ=
X-Google-Smtp-Source: ABdhPJy8oRN0qzPJ8GbF7TEtuBmvjQDftv+La8Ly+UmUsgmCBv6bsXhctYK7Hx5Nh5yOhYVvQ94UOg==
X-Received: by 2002:a1f:93c1:: with SMTP id v184mr4075426vkd.62.1596659140797;
        Wed, 05 Aug 2020 13:25:40 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id u82sm498013vsc.1.2020.08.05.13.25.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 13:25:39 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id r197so5628165vkf.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 13:25:39 -0700 (PDT)
X-Received: by 2002:a1f:8c09:: with SMTP id o9mr4278840vkd.28.1596659139113;
 Wed, 05 Aug 2020 13:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200805091141.1.I86b3faaecb0d82997b599b1300f879606c71e116@changeid>
 <20200805091141.2.If847565ed7568448c67804f3735d5f8a61eda560@changeid> <159664848938.1360974.193633020977562116@swboyd.mtv.corp.google.com>
In-Reply-To: <159664848938.1360974.193633020977562116@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 5 Aug 2020 13:25:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V9K17Un9bPnUvieNO_6tpThPVqdk92_KcQxpOtMTYDxg@mail.gmail.com>
Message-ID: <CAD=FV=V9K17Un9bPnUvieNO_6tpThPVqdk92_KcQxpOtMTYDxg@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: qcom: aoss: qmp_send() can't handle
 interruptions so stop pretending
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 5, 2020 at 10:28 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2020-08-05 09:16:11)
> > The function qmp_send() called wait_event_interruptible_timeout() to
> > wait for its interrupt.  However, this function did not check for
> > -ERESTARTSYS and assumed that any non-zero return value meant that the
> > event happened.
> >
> > While we could try to figure out how to handle interruptions by
> > figuring out how to cancel and/or undo our transfer in a race-free way
> > and then communicating this status back to all of our callers, that
> > seems like a whole lot of complexity.  As I understand it the transfer
> > should happen rather quickly and if we're really hitting the 1 second
> > timeout we're in deep doggy doodoo anyway.  Let's just use the
> > non-interruptible version of the function and call it good enough.
> >
> > Found by code inspection.  No known test cases expose the problem
> > described here.
> >
> > Fixes: 2209481409b7 ("soc: qcom: Add AOSS QMP driver")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
>
> I would put this first in the series as it's an obvious bug fix.

I guess I thought of it the other way.  This is a less serious problem
(no known way to tickle it) and so deserved to be 2nd.  I'm happy to
flip it as needed, though.  It would also be trivially easy to flip
when applying.


> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Thanks!

-Doug
