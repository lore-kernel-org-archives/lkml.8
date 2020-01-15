Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CC2C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3582064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579119499;
	bh=3JwOuqlpbcZev7CBGp3mv1rS1ZvhivhF/mQO8GzP09I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VVD8LxSEhZFgKAJhllPgY/2bLGSD4Yx0BA5Js7ihzAVL6D61ljL2NgC0Kip2wEFBV
	 CxXkzYK6oFsKwkm6+htpW8Y1HZF6n6nNq5mb4osTSd3xXIwHmde4Jy/ho6T83e0LGu
	 j/mcaF2GyCLDr9CQ3D9U+udkX+J5+Fwo8p3K6Ioo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgAOUSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:18:18 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46407 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOUSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:18:18 -0500
Received: by mail-oi1-f195.google.com with SMTP id 13so16667480oij.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 12:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=15O0u5i/rLLeI7Psjs2fWQ8eJ8azzo914oeadZHzrto=;
        b=OXrAKkozsDJCdUa00GDXLUJtmVm63lRzfQSmILcZYbGwfeqjW4w0NRXzbol7xKDTVj
         uMeI8Mh/Nn9H8eLhrfpURsxKvTYtJC+l3VBiMba6uM8BQarOank4/CzkRi8B7tcH4ils
         +oYeLUIYTt2CWv16u5SRFouAFi7znVK9sNRWBlpTxCrf7SFnHMm8MeC048HfzlE0NV7d
         hX3YjB/656aDWHANIxYGh4fVQLPmgFAbEsWHDlsfy9l+3QDqTQHbS7GpNjI0QhgnAPnq
         A9qLlOi3aPOWyoZLZcDOEKO3n/44C5Hbawyqf06fut3HicgDlrLmPNt/CAr71/X5Y9vH
         yg2Q==
X-Gm-Message-State: APjAAAXolyv1btJfpTS5efUB3WM9s2kNtx1q7wRHKYSqxQt/BNIniR7n
        SS4U7IVBoWkWQm4hhV86y8aAL1s=
X-Google-Smtp-Source: APXvYqxXry2j2Cb3sM+kvc46HsaCP1ml4u8fuBaBf20IoMb45q5GNAlDIu26wxtA0T49tB2QtQnkkA==
X-Received: by 2002:aca:ad11:: with SMTP id w17mr1355281oie.85.1579119497200;
        Wed, 15 Jan 2020 12:18:17 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u33sm6896014otb.49.2020.01.15.12.18.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 12:18:16 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22061a
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 14:18:14 -0600
Date:   Wed, 15 Jan 2020 14:18:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH v6 2/4] dt-bindings: power: add Amlogic secure power
 domains bindings
Message-ID: <20200115201814.GA28654@bogus>
References: <1579087831-94965-1-git-send-email-jianxin.pan@amlogic.com>
 <1579087831-94965-3-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579087831-94965-3-git-send-email-jianxin.pan@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2020 19:30:29 +0800, Jianxin Pan wrote:
> Add the bindings for the Amlogic Secure power domains, controlling the
> secure power domains.
> 
> The bindings targets the Amlogic A1 and C1 compatible SoCs, in which the
> power domain registers are in secure world.
> 
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  .../bindings/power/amlogic,meson-sec-pwrc.yaml     | 40 ++++++++++++++++++++++
>  include/dt-bindings/power/meson-a1-power.h         | 32 +++++++++++++++++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>  create mode 100644 include/dt-bindings/power/meson-a1-power.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
