Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE32C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 788B9206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="As8qfrI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgHKTcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgHKTcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:32:06 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C29BC061788
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 12:32:06 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m8so8164127pfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=tA1M4j2w8ikxzsm8TqiavbfeCWghKEktBcvPRuyYdeI=;
        b=As8qfrI4fsdQlw1YluH7CQP9RPdnbLLarMDBpBfPLtdJM6Zz9+5A7xoQef2NTzfUE/
         +C1+3eziTtpdJnqzivpXYwXCBLOe3YSljJNFih8WyxQrvWp6asRkc6RZ6Bw0jOsnQh2g
         pMc19VgG5f7Jp9oK3lDGsOeZmBremTkgYbNvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=tA1M4j2w8ikxzsm8TqiavbfeCWghKEktBcvPRuyYdeI=;
        b=FD5BZljBE0S2zUNNoG3Mlk+jBtKSqgETiLT7k/Oa2IpTT61vNVmk7h0dmS0c5jJNn+
         QCdkKI3Xb36AKz7ocOCd7WvMciuiqmxib7AXrPqlYOyRa9DHOeOgmFNk4FCgWsT4xLkF
         CQYeayD+mafTOdBcEKZGBY+eHxIsljhN28MWTf1yLl9cyNA0Fot7HPVZcPZZWNPiGNlj
         bHdHMzZxMUSIaV4atzGlTxVzhhEmtvZVpvzh6C65KzGuaSGR2NVxDXd88VPE1XMozqE1
         nZU+u34HtRBsX/tSecJtY4tK3DOI5T1hl3eoqUTkD3tv1wSO5r66UYH3pKlQlXEmnB53
         2gww==
X-Gm-Message-State: AOAM532Y3X1Xzkr9HvZSkY7eGQ7H2KnKw1kTuvcPyOFGsNIfujRBtmAY
        DKSubyw0fCAC9xQOohwi/T3ORpNI0Ic=
X-Google-Smtp-Source: ABdhPJxLgsyPl3Dbi+HYEp5MXKHxD/EOIrbVN3IARmbEfeFc7gN7kF/USAK2IJ9ZzHp+dLVfg9OamA==
X-Received: by 2002:a63:a50e:: with SMTP id n14mr2037903pgf.234.1597174325609;
        Tue, 11 Aug 2020 12:32:05 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id j8sm18852860pfh.90.2020.08.11.12.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 12:32:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1597058460-16211-2-git-send-email-mkshah@codeaurora.org>
References: <1597058460-16211-1-git-send-email-mkshah@codeaurora.org> <1597058460-16211-2-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v4 1/7] pinctrl: qcom: Add msmgpio irqchip flags
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, agross@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, linus.walleij@linaro.org, maz@kernel.org,
        mka@chromium.org
Date:   Tue, 11 Aug 2020 12:32:03 -0700
Message-ID: <159717432398.1360974.1005323166939228511@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can the subject be more specific? "pinctrl: qcom: Set IRQCHIP_SET_TYPE_MASK=
ED flag"?

Quoting Maulik Shah (2020-08-10 04:20:54)
> Add irqchip specific flags for msmgpio irqchip to mask non wakeirqs
> during suspend and mask before setting irq type.
>=20
> Masking before changing type should make sure any spurious interrupt
> is not detected during this operation.
>=20
> Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
