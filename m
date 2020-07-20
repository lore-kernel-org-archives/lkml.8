Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07BDC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1EAB22B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="heDejIMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgGTNjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgGTNjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:39:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF3CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:39:07 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id j11so20263681ljo.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZUWsa00iYf7K4HBHvDEC7hUnyTTw9NrXYfUvdxiJpg=;
        b=heDejIMJKRXAtiwM4h6NQUEF4C8R+h9OzJFFP+tx2PpKbFI2hUWSzTXkRZ5BekWopZ
         kkmHaTiWp+56nihbet+WZkRgccJ+WY102U7/bX1toov424jnra2iCMxgAaLdXldEDN9m
         /M8CrZMGUnAdq3bLWETEuv7OnckZaZ7GNi/Zuv2LR76FQP+GkPBC7iWl1Isv1tTs42FF
         a+kNCmhUgNF5Ky1orT1rf+r2/pdGrZr1F8A4yIGvL3Hjqp/vvU3qdtlqbklKCbpDSO4/
         /GttKdlO6SXUGc+AMPh+wpuKfytoLCdVR9ceEA9QCUEUVTGf+BvfnCLlMrY8DbFi+EID
         sVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZUWsa00iYf7K4HBHvDEC7hUnyTTw9NrXYfUvdxiJpg=;
        b=s4ZXbir4E2DbldnM6i1RL/ogPzJ0laoMCWaeO5dOFIfWQEBakWnOrA2kIOcYVSh+bI
         cotNBgcCHX5GHvJzLAjfV3x3jyI7+lRllYGN0nVegz6y0O9WCFPY0WdZz/+Q2LTnRUUW
         gOIoNggPnQwiHv0iJMd5KKw7+w0wCwtBn+QmUFpEFAFifkukdz6Cc3/qOIWeZL+/hny2
         a9HXUbcY4CjQiKMfBlKs6EdiwEmrzYkBb7UKlLfMAWEaqV+yNL+el+2+Ii7PN1FgmSL+
         6qQUfWgQbG67EWiiQJ8YZzPd1LN22b39GB/r9KgO4R6r0zgYnM3HL0PVd1ljiRO40e2i
         BP4A==
X-Gm-Message-State: AOAM532ub8ShpjNMuA3B40QqtNSnvgfkjo17SK0Cf3KnOyu7JtX4j75F
        TG9b/msekW5AMUB6SgCzLtdsKJVkrLiw5CaXIn+zsQ==
X-Google-Smtp-Source: ABdhPJzHGab0xEgyMQVlieVYjfPMYKbHimCOGtZ21uJ+KasO8fWcs9EFajtwAK+p4doX0sdbOccThgfvXySb191nTxI=
X-Received: by 2002:a05:651c:1291:: with SMTP id 17mr11205367ljc.286.1595252345768;
 Mon, 20 Jul 2020 06:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200716212213.GA17623@embeddedor>
In-Reply-To: <20200716212213.GA17623@embeddedor>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Jul 2020 15:38:54 +0200
Message-ID: <CACRpkdaBuvbtswYczwsSx9-YOLODs5x8YvWSB4bpMbXpvoPLrA@mail.gmail.com>
Subject: Re: [PATCH][next] pinctrl: qcom: spmi-gpio: Use fallthrough pseudo-keyword
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:16 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:

> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1].
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Patch applied, I don't see any controversy here.

Yours,
Linus Walleij
