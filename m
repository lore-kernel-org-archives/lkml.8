Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82095C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3A920728
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p609hwBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgAOMpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:45:43 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44913 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbgAOMpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:45:43 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so12584449lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 04:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zw7fLVZlBWPnFhNuSoVVujGBuN87u3KYLlAHzC+pN0M=;
        b=p609hwBlIti1BDsa7AwFn6dgioFQ0T7bs0x5a9KD1WrN+GkE0lBl0ys22xowzPOQR7
         V3lR5+PDDQjvesDRY7vNcrJl8xPPyG9qkeKXPvq9oVzBZ3FUI64ahWTx+NwqkpTi6l/2
         GXCAV+iOUL1CkpVjVjNKo9rtmIKvr+aLjKD79JbVXlAZvE9IfzPkiuQUdBZbMuDZS/K9
         W/81pW8YAKB/Bcu2v5tKncJV9mNNWW2hjlQ0IlP1kgKmNRp1JEmSrpGp4mOIpabiaTVq
         vL5bFI31WSMmy9zFuO/najdCeBAdjCD8+E/Odh79W28kiLQT22RzQxGGD1U4Er2g8AvD
         PB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zw7fLVZlBWPnFhNuSoVVujGBuN87u3KYLlAHzC+pN0M=;
        b=NsI/A2Dgsfl65YBgJOYUWs1ssKu2vnEHaxaz43LET3PwH7CUNQNxPhtWqbDhTHfFc1
         o81cfthRzpcP3BGsPh3Ky5QxDZq1W424g//K6R8dCPOHIu/LKexBcerIqwtGSlOaiR9v
         lRw6SeVs6Vc49rmRL/fM4GFAsdN+WASn8wtfPmZEnONI7opXqIcUN7eyzx8Kiz4I2D/B
         +Mv8gfmTcoizluYl1YnA9zsYYspQiNG3t/u0itNEA5fzQ+rbd7cqfciguLeH7rnr/V7Q
         WNlyApfIyfKGAWZI4udE/FDhOhrKMKGkgobK7fGEreG865+kJb2lHlZff6H15qMDp2eN
         Q82Q==
X-Gm-Message-State: APjAAAWyWJFRZEn5KxN8uGQe3wA7hGZddhXRqoi+04vrTKJ4MEIQq5yC
        t2vgkLMuD7Dm7bmlU2+XRYwn86d/TayJWEmH/rfozw==
X-Google-Smtp-Source: APXvYqwSaA74Wo0u94HIU5oNVPlQJPvUFTlEtrMxfPTAIykGqb3bFAFJMktSIsrWP4Hs5KTLmEsFohek2rxDoppQqCo=
X-Received: by 2002:a19:5513:: with SMTP id n19mr4407533lfe.205.1579092339536;
 Wed, 15 Jan 2020 04:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20200112143312.66048-1-sachinagarwal@sachins-MacBook-2.local>
In-Reply-To: <20200112143312.66048-1-sachinagarwal@sachins-MacBook-2.local>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jan 2020 13:45:28 +0100
Message-ID: <CACRpkdZGkPgB7wh3bKeeu+rD4_YnXLM9aLFt-wKti2YkU7yVqQ@mail.gmail.com>
Subject: Re: [PATCH] GPIO: vx855: fixed a typo
To:     sachin agarwal <asachin591@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2020 at 3:33 PM sachin agarwal <asachin591@gmail.com> wrote:

> From: Sachin agarwal <asachin591@gmail.com>
>
> we had written "betwee" rather than "between".
>
> Signed-off-by: Sachin agarwal <asachin591@gmail.com>

Patch applied.

Yours,
Linus Walleij
