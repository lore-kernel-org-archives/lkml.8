Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71749C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E140207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/1h9zyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgAONnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 08:43:41 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38672 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbgAONnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:43:41 -0500
Received: by mail-lf1-f65.google.com with SMTP id r14so12742261lfm.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 05:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WvJ5Z2/T47boGkRXpaAdhYTTXCERv6l9eGQZW9r3OWc=;
        b=u/1h9zyZVZCZ/6ksq1jbCZZKjRZ63wlH2fdCVMcRZcXO70PEfEV2gJRYoZdyeFRmkh
         2KUZwgBgfWwTGeEgxBz7cRPYeXaaoGAlViUmc6Vpp6QWpEwDamCjSNVhn3KthgVs+esX
         tboPn2fe718uW6PcV5wx0WY2cDhCZQ71FFPAZ8c6aJ58NcgOj0aN8k5Rh6kGitDYPLjc
         3ZDCnRLLB/ewgkphzVhq+k6/B12KxjkCdN1lb8TW4LYuwH38xMmweWhBe0zNne0vpgC8
         alJ0vMCC2Vj6mEuBpwnuuiNxUHjvV8RauPDRSTXtwkZ3QS4J6s4uo19+oeAcfkyzjqvG
         YduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WvJ5Z2/T47boGkRXpaAdhYTTXCERv6l9eGQZW9r3OWc=;
        b=JZ1OpVfrn3cxslky5hDXQMB2MUAltLjtXo7o+XhHyjscMrUWink9Hga97/7D3aXT5+
         hkg6zoiNBeSLeSXqjRRIQbMoW+7NAvotOLPjfkpXs8l75WdQYlmKASmF9mbesAtpMI+N
         p9Gs0FuFt+TxBvKMD5PIocllICkXntZWETnWhO6w4lw6Fu8ebLQGwZLhvqXIOKEcUhZg
         EMvn3tPyT+louHuqsJ/bOr/FO4sTzu1m1Wr9fAMRdq6qqjx/KgQn7rcP24Oon2HfVETv
         B/tQTU5Pn3IJ831u0W+ksxC2Hcwgvq0tUy8jBI9PGFvmzwm7qkoDsX7laXT49c+8K8e0
         V+ng==
X-Gm-Message-State: APjAAAVGtienrEjXt09TQRH+a0oYjT+qjBwYrrNKYeFrqtECg3wd+oS/
        JFQGtk+JrHTr8/bv5gD0XBuZtIfUVfZnbZysa/3vkw==
X-Google-Smtp-Source: APXvYqyeqzw7+mkef4toWLPOG9ScY8IGBiGsqM8QFNp+MnRkQwffusMdPKSsMsfAreTyonArF9swtJ+riGPcqc9f8uk=
X-Received: by 2002:ac2:465e:: with SMTP id s30mr4899362lfo.134.1579095818725;
 Wed, 15 Jan 2020 05:43:38 -0800 (PST)
MIME-Version: 1.0
References: <20200107130844.20763-1-srinivas.kandagatla@linaro.org> <20200107130844.20763-3-srinivas.kandagatla@linaro.org>
In-Reply-To: <20200107130844.20763-3-srinivas.kandagatla@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jan 2020 14:43:27 +0100
Message-ID: <CACRpkdaFfNDuUkChNeVcrL2TUJ3Qc62Fk7nfa0qnK5eh2YYPhA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] gpio: wcd934x: Add support to wcd934x gpio controller
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        spapothi@codeaurora.org, bgoswami@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 2:09 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> This patch adds support to wcd934x gpio block found in
> WCD9340/WC9341 Audio codecs.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Patch applied. (I applied the bindings earlier.)

Yours,
Linus Walleij
