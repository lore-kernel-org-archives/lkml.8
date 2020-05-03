Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F330C47257
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 07:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D45B2078E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 07:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L/Khb9Wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgECHxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 03:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726884AbgECHxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 03:53:08 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BD2C061A0C
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 00:53:07 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l25so4661887pgc.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 00:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=ldpXdu9wYcJl6tutqoAvH09RnanV7SWXIgtXP1Sfuoc=;
        b=L/Khb9Wky21XmwJo/DL8Q9JkLt/J6PBECd2JEVqz2moAu5l9e0/qSeqUeMmYHOtMTq
         VS8g0MZ/Xu/2GYn7ztNbhY+hLCveQ9aJUWcYaC4xjyKhSzAXRKvBNgLPQiBn9jKbVcbg
         6sByq9qYKzTNW+OAComF8MKbCzkUAvqRLUJw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=ldpXdu9wYcJl6tutqoAvH09RnanV7SWXIgtXP1Sfuoc=;
        b=nETSgEnJ4+pPiWJE8yPczXlMA+bJjLHO7GCO+twS7jni4AA7mTYdUJOMgStealQNKL
         LjvmWg0RAx093lk2SXAA8z33pka0iX2+4VJBxP5Gx0egCITDlgO+BZfuAux8XDoSnhsy
         MTHQhvqepPPYk7IrGMynHJw/8lCpcB+5QbM7izBqyqkCMRr9J7Q4gkI0MwR4LHS+CD+b
         zPPeb2nO06qkqinomqB/1dYwLb4gGFodlmzPzZOgFrkD55VbXe0OcsSY7pBpadqkdtH1
         yiS/g6NfBUPkaPeKzAC+FOtS3wlo2a7J964arc6Jl4nN9D2fEhpDJb62j1H7f0CWTKDD
         osCw==
X-Gm-Message-State: AGi0PuZ6zEqGGj8oHRshFNGlHKu6Kh3kiKI1hjKpR839KBrmqMaVzhFH
        LfHH3FOxwh39GTUbwZ1/PobP5A==
X-Google-Smtp-Source: APiQypIoEWlcADaqg/kWvVCnzwRszaN6EYULaM8oFqBYjbXts2j4JYT5pxcegrCsrGfewc0Ov7o+zg==
X-Received: by 2002:a63:4e64:: with SMTP id o36mr11993398pgl.167.1588492387053;
        Sun, 03 May 2020 00:53:07 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c80sm5909156pfb.82.2020.05.03.00.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 00:53:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1588314617-4556-1-git-send-email-mkshah@codeaurora.org>
References: <1588314617-4556-1-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH] pinctrl: qcom: Add affinity callbacks to msmgpio IRQ chip
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, dianders@chromium.org,
        rnayak@codeaurora.org, ilina@codeaurora.org, lsrao@codeaurora.org,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>, maz@kernel.org
To:     Maulik Shah <mkshah@codeaurora.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Date:   Sun, 03 May 2020 00:53:05 -0700
Message-ID: <158849238505.11125.459527469872237748@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-04-30 23:30:17)
> From: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
>=20
> Wakeup capable GPIO IRQs routed via PDC are not being migrated when a CPU
> is hotplugged. Add affinity callbacks to msmgpio IRQ chip to update the
> affinity of wakeup capable IRQs.
>=20
> Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> [mkshah: updated commit text and minor code fixes]
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
