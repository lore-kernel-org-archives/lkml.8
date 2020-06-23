Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D411C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72CD620675
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyWrRyvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbgFWBVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 21:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731572AbgFWBVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 21:21:18 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4E7C061573;
        Mon, 22 Jun 2020 18:21:16 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t85so8422822ili.5;
        Mon, 22 Jun 2020 18:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KhdGsndwHFxm5Fp3MmCQGP1IyrRRJHSC/HQA9VsGSeg=;
        b=NyWrRyvlVt7C8BfTJYfvuvXPl8iLEwICqLIhEcVj2RVnhMnxArqfgIknGPbxUTwWao
         iDHZ0YssBrCUnjki6osEE308QUMvFzhYPxpyzIS0PEI2Fgs+WGvt37viTne1VhL+PSHJ
         FBRFjZxonJ36JMmI0guwKY2JAdW9j2FiONX/DGy4QeYxi4R8Ta128W2fOk0RQqexwT+d
         ncO/M1lNiKWo3IzH/t8AHAVnK/hBHrIWDBhdEy69CaQygtWOdyWTxA58po/8IV1m+NVL
         0DxdfqaRgybeUH21Veep3GQWAx999zHQoA0V7uE0C9K0Tpm/qGJ/Hljql+egFTy/UTH2
         g2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KhdGsndwHFxm5Fp3MmCQGP1IyrRRJHSC/HQA9VsGSeg=;
        b=ZAlG/NjCTKPG1dZBcDflK17UmHErlyAdewZdFq9Rbk/gtm7rxKmygOeHqlEvoZSNzZ
         e3iGFfOLgEmc2yQ/BIozhwMv4vAT9pCVHzZ5WfyDTWQMadxn123JwVx5nEW8vF7NbXCj
         pWSp5G6Dx1tEQ6x2scT0r5Pq6ze8Fgt/nZShnGblbrfeBjQmPv09/nbMkEgneBxfvDLD
         lmOtWGcAOYIz2lQMNR6RCuMMr+pBvT4VoJM+hWNpfnpwaNKCl2lqgPblQhU5V4ZR0wDG
         YWuCcGCVfVR44/sJOCLqEB7Jwhhb3oiWN/gDXl51gA/Q1zJILvRAbLr5DiZjcmsIHkt9
         CBmA==
X-Gm-Message-State: AOAM530yiGGsenkpCv9LcUC/T5PbP+Lezp0w7ri4wNgwFIb6w36MbFYC
        jhUuEqPfn+dG7TZRfUwm2TN1pxm6x6iCcIf4k5XO8A==
X-Google-Smtp-Source: ABdhPJwUOYKyHRh+39pF9jFUDmuhLJaJg8Qk3hT27V1809kQadXBeResMx7Xf1RVRNeIGp8WoPZW4qIZTV2fZo2T8/Y=
X-Received: by 2002:a92:849c:: with SMTP id y28mr4696835ilk.33.1592875275542;
 Mon, 22 Jun 2020 18:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200622220048.717073-1-bjorn.andersson@linaro.org>
In-Reply-To: <20200622220048.717073-1-bjorn.andersson@linaro.org>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Mon, 22 Jun 2020 19:21:04 -0600
Message-ID: <CAOCk7Noj5E19PPtSV34wnAyQG4qE-5NC3vbQW9egTUJNpm3+6g@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm SM8250 pinctrl driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 4:03 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The SM8250 pinctrl driver provides pin configuration, pin muxing and
> GPIO pin control for many pins on the SM8250 SoC.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Looks sane to me.

Reviewed-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
