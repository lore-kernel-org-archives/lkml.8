Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C13C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1ECC207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mgOrXJYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgFZUbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZUbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:31:34 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13531C03E979;
        Fri, 26 Jun 2020 13:31:34 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n24so10597901ejd.0;
        Fri, 26 Jun 2020 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GHskhK5zJYDmbrTDrhLsCeFDGpbooMe1GlCaRqXte2c=;
        b=mgOrXJYknIP41R6HpllvCjRTYl8geQlQG1XCOfdcqDUyoH/ViuScQo+rOpl3apvTyp
         Iy3tGV1Pl+z9gn5wLmJsR5Z8/2wmsBISF63UU82+G1qxkzfg8iEMw8kmKAJ9h0Bn8+wc
         US5Pw3A/gtlN8np8Sdzt32rJSE00QCljY53f8XGDl9qhvlKAmGrXpydxBjQZNM+Aw25d
         fOD3BzBDwqnlCuESSETovlzXhlHC1+nP5L012hGQGlgMKBD02NYj630P9Tz9sfpmirnF
         yvENJS9pqNMO0Dw1qxM+0yjudtRqfb0UIIxheifVXW0o300Th4g0/Wx3qf4HUVLc2hz4
         hISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GHskhK5zJYDmbrTDrhLsCeFDGpbooMe1GlCaRqXte2c=;
        b=tYodHoBns5AbnChhnqF+y3D5QIQIW2GYmOcYL2dja0geyvx969d9Q7TXElxzKWhJgu
         Sydxw9hwhi/CXxldPpUFrpQfqCzAIYeEHrXBgRpTpuYt8HJ46qds26CPEk/DkQuMFVLL
         RutjWVrMYAT9qkv13YG1mc4i0szCG19XjAMak/N65SWaMJwdQU7oUJOpGyE4pUf71Z5S
         NnsDdhM07nB+ziRgY1CoX73tzCRAbVY+iHzrc433HR/n4rHjoCyau84ufIzH55n2RXzG
         OnLoICb3i1LjbAIIZ3YwhZA3lvBJ6rUlYIDnDipvYDvWAjZJFqNxJ8Y6vLOaFT1vYKRC
         ZZ9g==
X-Gm-Message-State: AOAM532a9zfGEwLd/j/i25pkDAMV2p6HqvBBLLeZlFkwM5SL3pUH0Cm+
        MfqUMImHwsrxhcO9gY4c/8RQ0jOUIE3VBYKGgl7wk6nd
X-Google-Smtp-Source: ABdhPJx5ZIx7dwJXxETKotyYevsiB5MFzMoyXAVoKNNps4L45zbMI4CMKkdQs99fhN4iRy0pnR2HoLfzr1r89Wss2GQ=
X-Received: by 2002:a17:906:35cd:: with SMTP id p13mr4178063ejb.172.1593203492761;
 Fri, 26 Jun 2020 13:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200626080626.4080-1-krzk@kernel.org>
In-Reply-To: <20200626080626.4080-1-krzk@kernel.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 26 Jun 2020 22:31:22 +0200
Message-ID: <CAFBinCCKm44c2k2w2R1MG2f7OFytpk0DOShuxNKDbFoiPreTTg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: meson: Align L2 cache-controller nodename with dtschema
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

thank you for this patch!

On Fri, Jun 26, 2020 at 1:59 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Fix dtschema validator warnings like:
>      l2-cache-controller@c4200000: $nodename:0:
>          'l2-cache-controller@c4200000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin
