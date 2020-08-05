Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56506C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 04:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE2922CB3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 04:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jw3p35b0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgHEEzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 00:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgHEEzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 00:55:35 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01566C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 21:55:35 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id j7so3566153vkk.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 21:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95VAJwuWsnt7rqYXS/THJIeTIBqbDOLU5i5b+6qdQ+U=;
        b=Jw3p35b0ClW4Z3+m+3tlqz09EukutWPByGwtY0y89xZlkmMeL8HYM2dl2rTnzQ+AD+
         LQ8fOVrDTiOqy+aNlBORRWWlRTMbUC9rtHXpDHCtMKtorYEWmtfq76DF1sHXgfzFsLer
         moqhLdLms2P9haKIW0uUrHVgLLe1uiaaX5DhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95VAJwuWsnt7rqYXS/THJIeTIBqbDOLU5i5b+6qdQ+U=;
        b=FYYwcr9IdSsStTHbd/K5E886gPQB7FQwNRjDnguVbV4BwzU5k/iOixCOzDTDTgMhCq
         zqeUvZTeSThFcWzJB5KG69zTjkNx3w5vL3GrIT+xve8syyYyOMy3nwkdDnybzrzAqp8Q
         iIFAi/ELVQafMIdlDsi0eszZ3QDBcfAsmAKxRmbNiEpvmXFQ59kBnQ56wv82vpJLRI0r
         wsbKj0WmyOPUMiy+si6QVBSDTIVC1xX5QZ4EZdTkt3WNNEdM0y32FK6nBnWNEpO7SQX4
         YhvL5BiM6+qme7itVb6jUv2jb7jAVikpCyilNYRNWdjUdWfILijRJb0VwLrUK8akRd4S
         LrqQ==
X-Gm-Message-State: AOAM533CGsl2NfrJFXC073CfUWY+sfbADNeO1V/DDzp4NXr82xUzD236
        RDP1S/P8WL3eGbyy5tAxf+wq/5Z7i5E=
X-Google-Smtp-Source: ABdhPJy4XL4wBRA8E7mpEw3Fvd7O7DAlvT8xovQNIApALA/16XcaRHphCqabUCWAV16VWBV+XloyKA==
X-Received: by 2002:a1f:5986:: with SMTP id n128mr1106775vkb.93.1596603333916;
        Tue, 04 Aug 2020 21:55:33 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id y17sm185378vky.49.2020.08.04.21.55.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 21:55:32 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id g20so9089424uan.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 21:55:32 -0700 (PDT)
X-Received: by 2002:ab0:44e5:: with SMTP id n92mr846587uan.121.1596603332244;
 Tue, 04 Aug 2020 21:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200804070837.1084024-1-swboyd@chromium.org>
In-Reply-To: <20200804070837.1084024-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Aug 2020 21:55:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WafrkdkwnLofw_S9TYXQ9kQT_ZrMEGGzGnmKA17ypEPQ@mail.gmail.com>
Message-ID: <CAD=FV=WafrkdkwnLofw_S9TYXQ9kQT_ZrMEGGzGnmKA17ypEPQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: Avoid grabbing regulator lock during suspend/resume
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 4, 2020 at 12:08 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> I see it takes about 5us per regulator to grab the lock, check that this
> regulator isn't going to do anything for suspend, and then release the
> lock. When that is combined with PMICs that have dozens of regulators we
> get into a state where we spend a few miliseconds doing a bunch of
> locking operations synchronously to figure out that there's nothing to
> do. Let's reorganize the code here a bit so that we don't grab the lock
> until we're actually going to do something so that suspend is a little
> faster.
>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/regulator/core.c | 75 +++++++++++++++++++++++++++-------------
>  1 file changed, 51 insertions(+), 24 deletions(-)

Looks good to me.  Agree that getting a pointer to the relevant
"struct regulator_state" and checking whether some details about it
and our ops should be safe to do without a lock.  Patch looks clean
and correct.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
