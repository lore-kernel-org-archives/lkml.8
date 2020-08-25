Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C019C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8FF2068E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SCvq4FUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgHYKOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbgHYKOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:14:11 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5957DC0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 03:14:10 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m34so6485023pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 03:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=NK/rGdFzl/ZJ0ikUSNHqbk5FsBpl+Htmp3bLWdAh3jY=;
        b=SCvq4FUNygb0mPDOTL9HsmV1XyflsHOwL6MGLFxggA22jrk3r0cUnTgiCypWwgft1T
         yZx8mVaFF/HA1b+iKbCRANmRux23s0+GG3gfMuBKEX/JZLD2VjmzCXc2/PTSFamz0VKQ
         w/f24Tt+ZBLC1s0+2dt24P5IOI3cswYZh/3XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=NK/rGdFzl/ZJ0ikUSNHqbk5FsBpl+Htmp3bLWdAh3jY=;
        b=Nf46gxgbpXtqGyP9V651+ASNwjAWF4YUB5GwFl8lLNbUTbGUZ2gjpEle/scNepXqjf
         nKwZkrKHvRSJW/4AMGqSi6N3vxEoHLKf0ep+x4jlftKJovyMsQzL/G+Pvrzzb916DT0u
         ufw/XZoitvBJq9ctEqzW/jmJPLMRRFxA6KZEm7d5pMQYpDD1IPZh2bYqiy983yWrfABU
         LSGQrEoip4G7khyxLBsAG0YcjgBl8BoAK5GQK7Wac7FUKhZ1ylYDhzivSZ3omRNY7RuV
         S1bpUyVOdaciRa8CtAosuQWtAE0344EzVUZ5n7vtUIuj93CJaNhfW2zUXCSsGnMMwn9F
         UcRQ==
X-Gm-Message-State: AOAM533PtzsfGOJI1YMyx8kgdV/grhXyZ6wfJD/NdUU5P+m2XPJwlhOb
        l4qw6/aj5VEGP1McDGjNjKu+SOLZe+T+wQ==
X-Google-Smtp-Source: ABdhPJxRam8z3NFVm74MYbnfL8FAHtSGolerCZEMwDw8/bzH96h2YpXlmD1E8BATCSSWhjkeXP8j8w==
X-Received: by 2002:a65:498f:: with SMTP id r15mr6392116pgs.410.1598350450231;
        Tue, 25 Aug 2020 03:14:10 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id x13sm6165505pfr.69.2020.08.25.03.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 03:14:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1598113021-4149-7-git-send-email-mkshah@codeaurora.org>
References: <1598113021-4149-1-git-send-email-mkshah@codeaurora.org> <1598113021-4149-7-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v5 6/6] irqchip: qcom-pdc: Reset PDC interrupts during init
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, agross@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, linus.walleij@linaro.org, maz@kernel.org,
        mka@chromium.org
Date:   Tue, 25 Aug 2020 03:14:08 -0700
Message-ID: <159835044855.334488.7962570422326622972@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-08-22 09:17:01)
> Kexec can directly boot into a new kernel without going to complete
> reboot. This can leave the previous kernel's configuration for PDC
> interrupts as is.
>=20
> Clear previous kernel's configuration during init by setting interrupts
> in enable bank to zero. The IRQs specified in qcom,pdc-ranges property
> are the only ones that can be used by the new kernel so clear only those
> IRQs. The remaining ones may be in use by a different kernel and should
> not be set by new kernel.

Presumably they're not in use anymore if the kernel has been kexeced and
replaced this one?

>=20
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
