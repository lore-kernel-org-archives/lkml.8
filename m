Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDCEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F7C2186A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J5MKLGjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgFQUYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQUYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:24:51 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACCCC061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:24:51 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a45so2628819pje.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Oi8WdEL0xHPWSjEuRn/3DpBy4qY4ecDATBbe5otJXBE=;
        b=J5MKLGjXGUT07r4aFv5ozaZuu3kZvZznC8PH0oHKeVzwG4W7Sa5yT0nuHpVqc/yDGr
         EpYlaHHELjEmVUclc9MW/pBhcdy5ZfMfADf6QXsfUlXnphGBrNvgWoHmfSM/D7wydIJD
         DxHhTS3nbziS/wq5ocHsECn/Sk9PC9wTRmhqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Oi8WdEL0xHPWSjEuRn/3DpBy4qY4ecDATBbe5otJXBE=;
        b=heRXhWfzaDaZSa4dCpK9COLSvGa9SDiZO/By6RtqGMFhrT82K0YDB9vWYBhlXqJWeg
         ga794dWVyCCSLstyRPFEDOqPFpZ3jUBIaXMGD4F0ltdwcMCsyD711dJLxFnDAcWvQ2ie
         NdQH7B+CeFSB7CqjL8AaQ+XthADvkodA2P5CYFbs8z55LuSxh9BAygx+ks0qk1Fp69d0
         qkV1CoV4gEfNRddVbolvzFNKq3pGPAKUzOQJQheBzsry5CYeNbSx1jZ5jLgLf8IaPOlU
         XX4UZbwKHJ9feyANsKoYYi472cGNds7gGex5bHmlYYPCaSpgZzQ+8ntrsq0E31/BQgX5
         GhdA==
X-Gm-Message-State: AOAM532Gz8cwp7JHMqSlZO37MqMEqAVOYP1SOqSX76yz4AVjsMr9DscC
        ZFC4KT1gCOIrLSUhhlVWOJ1wGw==
X-Google-Smtp-Source: ABdhPJyZmGniT2GeQsnfQbcp1rjOQ22uxwwhX/RB7fTaW7sfeOWTkRvWtF86/hVCPycnzfrvFiY5Uw==
X-Received: by 2002:a17:90a:fa8f:: with SMTP id cu15mr811773pjb.9.1592425490882;
        Wed, 17 Jun 2020 13:24:50 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b24sm637675pfo.112.2020.06.17.13.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:24:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200616034044.v3.1.Ic50cccdf27d42420a63485082f8b5bf86ed1a2b6@changeid>
References: <20200616104050.84764-1-dianders@chromium.org> <20200616034044.v3.1.Ic50cccdf27d42420a63485082f8b5bf86ed1a2b6@changeid>
Subject: Re: [PATCH v3 1/5] spi: spi-geni-qcom: No need for irqsave variant of spinlock calls
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Date:   Wed, 17 Jun 2020 13:24:49 -0700
Message-ID: <159242548959.62212.17168767504846192201@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-06-16 03:40:46)
> The driver locks its locks in two places.
>=20
> In the first usage of the lock the function doing the locking already
> has a sleeping call and thus we know we can't be called from interrupt
> context.  That means we can use the "spin_lock_irq" variant of the
> function.
>=20
> In the second usage of the lock the function is the interrupt handler
> and we know interrupt handlers are called with interrupts disabled.
> That means we can use the "spin_lock" variant of the function.
>=20
> This patch is expected to be a no-op and is just a cleanup / slight
> optimization.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
