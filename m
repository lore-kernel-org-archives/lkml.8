Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81C9C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94ABD20739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9UvVz1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgGPMhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgGPMhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:37:39 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29078C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 05:37:39 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s9so6916750ljm.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 05:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FnNUxYhFyuPQjKzE8y9GdlPHRlRogzze8BallsxYE/I=;
        b=g9UvVz1IghO8CDvr3aZ9mIYL/QzzwbZV0qKv5oxbeoa0mNux2Qp5PUNbBhhqg87xDd
         g6uoRA+wpRauJwHJxurVHR6uRsRZoau5jJIntD4/0xNdi+scGE34EIByS7TEvCk9RhfG
         8eF/1YbT8ZAXnOViaBofAayfledvBFnRliY+XTt/G63C6fPIC8hJHu9k42vEce050vpI
         1AXTKj6eGXmAKJXavjCgCVeqXb3DbXroIIQ1FkT9ag7ISugc6JO/hByHXZ4nZJ2zLQFZ
         +tMhU6nqFLtRaBS4uWTVFDlkcUKHMjqBkFGJMARYBPSraKo9S2TSkd6ZURodPY5jTiYN
         oK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FnNUxYhFyuPQjKzE8y9GdlPHRlRogzze8BallsxYE/I=;
        b=Q/H5JyG4T21X0FcnwurLMVtGxkNHo5CRls25UUtCMxAtnYD9n07QCMKWG2u5E0+vT7
         OQybpEcq53u9/P7THNDJTQSlRC2nKY8rUAr7mo9ebJFKFbIvAfaRdrEdBvVre5/UnqYQ
         HGMYxler++LbL0JiIGOI3euZ7A2YpqUo90cC27Qrei3bc5UpmX1n1+qCyWDDBDWhnC8k
         h26RY/fwaU+BrC8+dVok+Iv19giylFD6SdUIOz+Hza6NTtoYfY9mEBdZrfz68R2/QdLf
         UjHQcALuJwZ2xLyW+SAJGG2zIFi2KjUQTK7jNYYRjTpsqbObanrfXecHRsbt7DGJuNPY
         G6XA==
X-Gm-Message-State: AOAM530G9FW2fjdG3n4aSoSb5t/NaEBR3IlXzbvyB6CcUGmI9Hisnexx
        6ljdXl4BleZqXb/8SA6fnN2bc2bbDPDoXGaGbyJt6g==
X-Google-Smtp-Source: ABdhPJybAk/I23kj8/SY0qnJoUwGC9fYwenCCoXPb03yQn3fxzX9qPOPGUgzqfmQkszNRbJ6Y8gHbdedlO5cJ+meHhk=
X-Received: by 2002:a2e:9a4d:: with SMTP id k13mr2024973ljj.283.1594903057547;
 Thu, 16 Jul 2020 05:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200630160736.1196697-1-mans0n@gorani.run> <20200630160934.1197066-1-mans0n@gorani.run>
In-Reply-To: <20200630160934.1197066-1-mans0n@gorani.run>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 14:37:27 +0200
Message-ID: <CACRpkdYxej2rfdiTVPZ-PR4BMNih-hbiBrE4MB6pbtzOCo9pFA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: gpio: Add bindings for NXP PCA9570
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 6:10 PM Sungbo Eo <mans0n@gorani.run> wrote:

> This patch adds device tree bindings for the NXP PCA9570,
> a 4-bit I2C GPO expander.
>
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> ---
> v3:

This v3 patch applied, thanks!

Yours,
Linus Walleij
