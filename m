Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A661CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77BCB20760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bvYAdsPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgFJJzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJJy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:54:59 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CF4C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:54:58 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 9so1673246ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x3zJYnC4xPTLUvpdLo3hJwVKdm6pQi65dX2AKRAnoeU=;
        b=bvYAdsPRtcgtKGb3QnS8DYfgeu9iZZ+3d2bED2t8THtIt6RXgj3rz6bJ0WI05t7K47
         +S2m2gtlLbauUSYPZl432zrDFRlIBRN2mPTRZgZDiXnJNOSYx4dZAXcyf2SSaaUokmrx
         qVB2HZbK17hqs4ANJ7RnqHLEaM7R175Avt5uOuhEsndixOsScfNf8E6yth0csDjL4++i
         11C+CaDkudPtzHu2RUUIqkccZzBAv+hx+fUpQTfFTIjk8GRHt2BknPV2aPnw55VrtjKi
         BxJJMY/+jFPOQCFmUxcecRWR1wsGxP/jiYvWMPeMx3abSq8ULRS6glsS4+oC4Nrlsum/
         9Yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3zJYnC4xPTLUvpdLo3hJwVKdm6pQi65dX2AKRAnoeU=;
        b=FHFjNOVNbq9oozmWHM++ojzYC5mZRA+GjexjY9i/x3IdHZ7E8UDZ+iYdP9dOWMRHz7
         kA6qYYyg1kyRg23/k1r8DHZzo3SKrcWcvdApOcTB+CQMCyh+2Y+QQ2ifwlnx6eilAmT6
         fIf2s0Ht2KZAWQmja7egcp+Z+R0CV2DUUE/wwE4kyEkjCpqxVknjyjDh2Y74fF/FiW2h
         seIG8/5xIPBHSY90xjZ0Pn/wkX57lLnajrbp1V+6pvbD1TZ8h/OChtqML76kKWXpkxub
         0UdGxJQJCGRc5k14r4/aq0P24bky96wRwln102D7soVdJd7vcLjyzgHFTTTP6ro8bZzF
         XXWA==
X-Gm-Message-State: AOAM532XXnWCv34TdfROsBZz0xYa5SdhV2k7tmgcrrxralcnzPLoHi4X
        2G5mNW38fgB6Icj9QxhgckP4FpKOvSkP+1D2CPfzgg==
X-Google-Smtp-Source: ABdhPJyaZm9bWv1+tQfyTESsLtLgh1gwb2LxItCKaISMEvf2pjgPzCFpj8OL4bZ3WpufhOyscllUPZAmRJY1WJJKSVo=
X-Received: by 2002:a2e:350a:: with SMTP id z10mr1288366ljz.104.1591782897430;
 Wed, 10 Jun 2020 02:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200605224403.181015-1-sebastian.reichel@collabora.com> <20200605224403.181015-6-sebastian.reichel@collabora.com>
In-Reply-To: <20200605224403.181015-6-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 11:54:46 +0200
Message-ID: <CACRpkdabXvC2z3TEzChQb4MAOuFEZXQ_wN63mdSGTQh1YHxaHA@mail.gmail.com>
Subject: Re: [PATCHv2 5/6] ARM: sa1100: Use GPIO descriptor for gpio-charger
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@collabora.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 6, 2020 at 12:44 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> Provide AC detect GPIO via gpiod table instead of
> legacy platform data so that legacy GPIO support
> can be removed from the driver.
>
> Due to lack of hardware this has only been compile
> tested.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
