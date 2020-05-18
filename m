Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC73C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98F32067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cEeYQ8sM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgERIRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 04:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgERIR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:17:29 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F65C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 01:17:29 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w10so8849291ljo.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 01:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KgB5iCRiDY1xUpzvcmt2qA5qOxhIvxFlroLwQSWXKVk=;
        b=cEeYQ8sMtfIcnqhDnaBX58ozf3oJI5XHFUC7g3rtIUDyqFXqr/s6o9QnE2+uFP1k/J
         LILQgdSPbgh22hGw180ItVeDUD7AU7RWmUS7tnKBpMk9U4t2JKNxq2pw8DY0Dr0glxoc
         9h935pnTmgCgvB8iSgullSwo71ZCKnR3oJERR89JnjUG0THbBdRQXx1WxsyFErA0JpzB
         b4NIVLEPTvVtsFQqcbTuJ4CrynyFpmf8ZXHARe3MZX3xlqHCX9g+ZlZpXgYibNMcuvu5
         SuKbidv7OF9jh3VrmN4uc7XV48TL9pRc4TJevPeF2eMsNSiYx4LoZTRVZTp2C4Vyh1/N
         SVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KgB5iCRiDY1xUpzvcmt2qA5qOxhIvxFlroLwQSWXKVk=;
        b=j9WcxaQztwTby+TAqYa5goTmx67d8/lrBJy6bhaiAeKVI0YHk46wTcrqEQHEQ/PFM2
         FHvem90IPzbtgQrHL69JcYY91FYdN7BoSVBheS+NEDhQjv6Jc7nlzzrhqxUr+ivbrY/l
         +/eEEad5rsBSolI4G4Uk4aOmL6K5q8qajyQB1M2JkdffgZSUwdodtmfB2zdJxTx8qFaZ
         V1X6KqiUMuLin1CqMMKiBa9ajCJHLXVjuR+mHcBIzvfIoTFeGq7uEv8GM+GmgHVY7seV
         0DHqZUELuT/YD3VSZRrcKsKm9aalZckM9UBccRiDYQMAFaR87sfzN7hYB+/FOec0Kwvc
         0U5A==
X-Gm-Message-State: AOAM530sgw74zTTnRBNiDvaM9AEbZsv6QTf3kgpivCMXrs3qMkrqLWPu
        KupVt6nq7ElbYRYkBPLPjl10BuAUHqZ3B+h6FjPuzQ==
X-Google-Smtp-Source: ABdhPJwh1h7WOq2+DVADM4reEeAZtZ0+Bi37spSD7MX9/2PvrGxVJ5a7SXExxc9Et8QUQoYjFbtIPHqiLPfc0Ni3lug=
X-Received: by 2002:a2e:b609:: with SMTP id r9mr9513452ljn.125.1589789846527;
 Mon, 18 May 2020 01:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200511145257.22970-1-geert+renesas@glider.be>
In-Reply-To: <20200511145257.22970-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 May 2020 10:17:15 +0200
Message-ID: <CACRpkdaz34Bc_EzcXKMEVCCCUt82_c2+t4X6YSLW2b59oi+9gA@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] gpio: Add GPIO Aggregator
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Alexander Graf <graf@amazon.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Reid <preid@electromag.com.au>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

I have queued this v7 patch set in an immutable branch for testing and also
merged to my "devel" branch for testing.

If all goes well it also hits linux-next soon.

Yours,
Linus Walleij
