Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29802C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF85206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVzJkCiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgD1Mtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726620AbgD1Mtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:49:50 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0A5C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 05:49:50 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m2so16759668lfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 05:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UL/TVs62faF1qHVs/iiuWvqOrsmLsKHyIOog76Ui4vY=;
        b=VVzJkCiuPUgRSo5KUL+WQU5C4r/qwXnkA0/rH3dMnEHBm1e4tgddRH1V/HnB6F5iGK
         6ib22DEAlDbVPG7vXaKfYvHPpXUXg82m/Jl5PNK6yT1oufMeKGeZFqkHKGUG+OQes4IP
         agBRex/tDRgpxy4wUHqJpz1gj+GMHf093SEeP83nm1BXRcMi6+dHfhlG0KcAGHG5r7A/
         wTcuVPeQX1gFZ1n/iZb2/PqbErlG8zUwuEvEKct2LiiC99fi947KLNDpuypP+2ZWrz0m
         NLqhkYR/CKdvqtvHlxp7gVzsJ5fRCBYFmBwEjITSas4Z3RbVgfHXBUykZr4mT9O7fFTd
         7M/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UL/TVs62faF1qHVs/iiuWvqOrsmLsKHyIOog76Ui4vY=;
        b=CFTp3Z8PJ5Xevv8DGJjQGw6OSs167DjmqXwxD/VHuw33y474yOQSlkC7sWF+FSapLJ
         3qBLuJrXkrYpRQ7B9kSIGzkkRpJE2riM9BIYdbK/hSrj8lZnATOdBkz5fDYMxKghOLxW
         tazvqolKuOwXdDyAKd03JbrUz0m4dhU2edcKetKalUnGhB3SbAiGCXKrWL7629lgy1YV
         7xyjtBg2Tm5PEVeuRQxdXCOukr/X8ff6pnEcRmTXkVZp/MisRhXhsTEVw1jVbOpemP8s
         CvmB/ExfVUw1/rz1ssXCYIWWu37ViL6mA8j9IcTCVtXFz+QRjSAIGSRu1xcQmG5RqzHW
         vmbQ==
X-Gm-Message-State: AGi0PuZBQDXE7UdbstK2gmhrRyEobEkSjuCkjEetQrodIf2ML2+b5nul
        lU10Q07mEQdFtktAFsD+oiunjHeDHg0EqA+xAQ8RNw==
X-Google-Smtp-Source: APiQypJYIQJ85qOD1cwJ8t3Ko6n/QlAkuFT5C5YrkLuzUTtDUSKQTsPmMdAaXkYcqBPYL//zz5+kD6YQtD4IfGvW0B4=
X-Received: by 2002:a05:6512:685:: with SMTP id t5mr19029129lfe.47.1588078188674;
 Tue, 28 Apr 2020 05:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200422072513.8352-1-amelie.delaunay@st.com>
In-Reply-To: <20200422072513.8352-1-amelie.delaunay@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Apr 2020 14:49:37 +0200
Message-ID: <CACRpkdaG8PPA13gMXMS62Fow7De5vDaG=gZ+HAEx6yhpOH0sTw@mail.gmail.com>
Subject: Re: [PATCH 1/1] pinctrl: stmfx: stmfx_pinconf_set doesn't require to
 get direction anymore
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 9:26 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> Pin direction is not used to set pin configuration.
>
> Fixes: a502b343ebd0 ("pinctrl: stmfx: update pinconf settings")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

Patch applied.

Yours,
Linus Walleij
