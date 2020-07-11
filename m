Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03240C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 21:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B262077D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 21:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXthr0xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgGKVLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 17:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgGKVLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 17:11:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E794C08E6DC
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 14:11:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e8so10411360ljb.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 14:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hG5d4MXKH7j0YNeql3XedgUwA1S+hEFx8UFAusowRpQ=;
        b=dXthr0xg2XCQr65fG0RuhCL5iGIPi6+nsbmgiARFHbGL/Uf99W7FHXpins4+smK3oF
         SFZmDcxc2/w/y3N1xYxVegkxHeSq1ZYEtGk75cap3MamCnrhYMawKCxHTNulHFKjfxfk
         +tfF1aUGFmC1OG+EAsNulGF3Xo/n7r/jsWUp3DCdLP8LHfZfruyiZZ54/T6yRf+wdB3A
         1FvI0tUfXAxjNb3MTyOhfhe09ygOEDK2uxGqcAhIHcj7EP771rr08bSPhvyv8E5yH0aC
         O2J+AcruPCugrhoevCMBpiiwQlrao1hH++RpqOb/Pv4ffC4DNQKk4EFR0tD5R2oxMMvg
         3qAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hG5d4MXKH7j0YNeql3XedgUwA1S+hEFx8UFAusowRpQ=;
        b=LiWs95whHmg8E6U3tit9i8GjrGfFdo7jXV7UsDApkhyK/EXam7q/dOrBh1wCHlBVX4
         x8oOgod9uUAEI00mxMRtai3PimxI+wpENXim1T1AaotiQI0r50ucLPu2ZVTgSd+x9eoG
         sENdDyYCcQ0oorQdCZGr6etCmvX5C/lkwPeIXP5pspArNwLtzz1AvZDBDEu7ygRQyIvf
         WfibjUIRyGDRfXaG9MpT6BUWpo3J3EIUSsDle8lclBv5zRQrtN2mFQYggumAXJB1HQ0H
         54sBJEvWeHBOSqtCqWmx3O6+a/tczvkAi9VoOBDdOphGO6jro5COKn449cGX6Vzv3Wvo
         cG3A==
X-Gm-Message-State: AOAM532Tc1IIkd8b+ymtbvKyM1HHGlaxcYgTyNXSYaNo6NNkZvlyQMgW
        tRB0JHKFo2Des8hugzHdNDeQmYLr6L+pB5l+Kt12SA==
X-Google-Smtp-Source: ABdhPJykUdIN42EDfkU5cG71+oDSmBrVADO8NS9vM4JO9vrSCCvxVJAsXra7VIel2SQ5Kgi8SMViUfehC/nyjHr2+30=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr27378268lji.338.1594501895501;
 Sat, 11 Jul 2020 14:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <1594107588-17055-1-git-send-email-kathirav@codeaurora.org>
In-Reply-To: <1594107588-17055-1-git-send-email-kathirav@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 11 Jul 2020 23:11:24 +0200
Message-ID: <CACRpkdbZWrpqtQKZeX96-MtvwR4ak9E9hF43fURpZ50MVtWwig@mail.gmail.com>
Subject: Re: [PATCH V2] pinctrl: qcom: ipq8074: route gpio interrupts to APPS
To:     Kathiravan T <kathirav@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        srichara@codeaurora.org,
        Rajkumar Ayyasamy <arajkuma@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 9:40 AM Kathiravan T <kathirav@codeaurora.org> wrote:

> set target proc as APPS to route the gpio interrupts to APPS
>
> Co-developed-by: Rajkumar Ayyasamy <arajkuma@codeaurora.org>
> Signed-off-by: Rajkumar Ayyasamy <arajkuma@codeaurora.org>
> Signed-off-by: Kathiravan T <kathirav@codeaurora.org>

Patch applied.

Yours,
Linus Walleij
