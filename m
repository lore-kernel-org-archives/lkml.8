Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286E4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB3E8204EA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdtWK/yZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgFJLUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgFJLUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:20:30 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DE2C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:20:30 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n23so1967409ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UA+t1x4Dga/tMDaCbSxJN+1nIvqIM3JZf6UcWWk8kmo=;
        b=gdtWK/yZABe0lUpJ9U8mFFE3Vs9yTGzaV1EhCsTzgd6NW5ObciUND4+CGf6z+1Mhql
         ejC5k2E9P7hIBYCtO7+zwlizHH/ra6rBpu/f2+mYyopLdcKVMfCNqFFeXvYBktYpZrOw
         55IjwAx8lXD4cI+nBbGNO6z1BBPSXX1bg0/VY2B+E02NbGWCtvboe9shxa7jw+9mvPM+
         cBgrsVEHN6uDCmEsOYGB1y/Qt4xwKGNWApiJCZWnRJTNZll8OoHtA1bd8qapY0N2DADZ
         gl6sHho/qt+wg5HvTpnAoaxJS/qjNIaMKtc1jI1hoa2K6cdjVOmJeUVS4s+yQDSFPHDX
         dcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UA+t1x4Dga/tMDaCbSxJN+1nIvqIM3JZf6UcWWk8kmo=;
        b=eChMvJ0oGFP0QB7uhddb9jeS9W9WhOpCFN3vHA6oY+ZnQGl481+75EV+/qprMnfn2N
         iph/dE6rScyzkr5ugNYbot6s3PYoDcZg4p1zdvNkvPufKH45KGsBACAl18PT+8BL5YfT
         yXbLwt2S9Av0UeYNHix0JMh1Hl3IpMicYKvEhw+RpH3LZjNibfH6sQ9vZrUj4j6ToIdK
         0Jvj/LZAEjme1FKO9qNZpC6nIWU6rogBr3j+Q9aUposxaoq6K7LmB9+96wUeqwgMBiV1
         pbY5GejwYmwLkHwovfhjL/Ga4essp/VndJUlDuNiQZzBuhsag/3YtInkYx/f+sGdZHV0
         o4lg==
X-Gm-Message-State: AOAM532esI1XnSU7HlWS6fT2HWlOszo1ISYeE+fAsQ5wlkaLE571iXNd
        CmKEIyYbj9vVv/NNEaHxEx1q5qMMtGfpLHp7cmJyGZYa
X-Google-Smtp-Source: ABdhPJy6Tchl7ysZwtNi/eEjUPSPNVDD0sa3t6qjCUJamnzcansK7rEyXEHMuknf3B1HTdYvZcf8nmN0ZGLtKe6NFvQ=
X-Received: by 2002:a2e:350a:: with SMTP id z10mr1473467ljz.104.1591788028702;
 Wed, 10 Jun 2020 04:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <1591613742-1768-1-git-send-email-sivaprak@codeaurora.org>
In-Reply-To: <1591613742-1768-1-git-send-email-sivaprak@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 13:20:17 +0200
Message-ID: <CACRpkda7DEr7H4FzP95L_GYeigg1upGd+A0Yx+b4u+MD-mJVCg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: ipq6018 Add missing pins in qpic pin group
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Rajkumar Ayyasamy <arajkuma@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 12:55 PM Sivaprakash Murugesan
<sivaprak@codeaurora.org> wrote:

> The patch adds missing qpic data pins to qpic pingroup. These pins are
> necessary for the qpic nand to work.
>
> Fixes: ef1ea54 (pinctrl: qcom: Add ipq6018 pinctrl driver)
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>

Patch applied for fixes unless someone has objections it goes in after v5.8-rc1.

Yours,
Linus Walleij
