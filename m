Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C71C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A155A21D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G11PTYYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633252AbgDPL2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506212AbgDPLQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:16:43 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A60C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:16:43 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r24so7401764ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMyype6pheH6p2B+meThOWdIwkgayOziZmviW73TOhc=;
        b=G11PTYYbg1ocBkCFQdd0WZXWBNANuFHYcy3Q0hhd1bv4erB3jLCmyws8c3lC3wfILN
         aEjQAMcNSSjZZ6VYLsP3RjLmeeQ38obVAOp2FdH9Hlkb8BMxpeq3nwMChdscaoxLphO8
         18kcnImbDmf2F/hY8mCF7NtGP/QOU7TJwbMgnElSglmUjALRd4is/kaKoJKq40iCMbPA
         C1QwlcoOo3YW/zqzVF6bz/vrgujFNn9QGK85RYjnFtqO4MxCkihbN9IwBEIKIAYnum09
         8ZZmTfW3LKVQrk/WFYzTTBtn+gbVGGOmr1fFaDOez9a9KTwK5u0sO836VbnhsXxjs2/u
         li7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMyype6pheH6p2B+meThOWdIwkgayOziZmviW73TOhc=;
        b=gbVWXKJ5ell7uWm4vejKsA/0itM5eLmZhQtlFJk2RCpnH4VVHeRcKunSTrIRysYXkx
         i8nmk09YWoNbkkJa50rRQNz5OvmmCR+mjT09+gjbwfNjhcGDhfMA//lrl3A5wSzRVtRb
         wSUGr2ouUuvTOTL+gcgnwtpAezrFXA6kvjr/Yr6lnPRAg8LBEq7uMdxcBAX15DHiuEJN
         +EatWW7RQZqWFG2dulnqQV4bgAR7Kkf7MbN0MskNpt4cg2SH42YSAJBSSzGH53BjhLWo
         svHvr7jKcp+PvW71/BIzQBcI3cOW1nS7M7b0LeWMHEsg9bWkm4amO2AeTHbr3/Juok8c
         7LXg==
X-Gm-Message-State: AGi0PuZw52fiGvxoawZAcmtduanP+pSG3Q8FN78kUhhEPIk5tEG7a/Lb
        2H5x7/PZQmX+RpqL0MH94JAFrPBZwOL5kBFpbaG0TA==
X-Google-Smtp-Source: APiQypJtQonKD3jh+va1+KhfBd6fpkD1BkWgrhEcoubjUXb3Sm75zbBsDipOQ9OsoADIUiMNpnQEpKxU7Wdf1AH6W6s=
X-Received: by 2002:a05:651c:23b:: with SMTP id z27mr5910865ljn.125.1587035801960;
 Thu, 16 Apr 2020 04:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200414003726.25347-1-ansuelsmth@gmail.com>
In-Reply-To: <20200414003726.25347-1-ansuelsmth@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 13:16:30 +0200
Message-ID: <CACRpkdY-t5GPdUg4uf-1W6VXBcgSL5MSPe46Aj93hPSdWDbwCw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: fix wrong write in update_dual_edge
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 2:37 AM Ansuel Smith <ansuelsmth@gmail.com> wrote:

> Fix a typo in the readl/writel accessor conversion where val is used
> instead of pol changing the behavior of the original code.
>
> Fixes: 6c73698904aa pinctrl: qcom: Introduce readl/writel accessors
>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

Patch applied for fixes and tagged for stable with Bjorn's ACK.

Yours,
Linus Walleij
