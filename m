Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122F4C54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C79206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FPbM6YGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgDTICQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgDTICP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:02:15 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6F5C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:02:14 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id u12so3253854uau.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGNbQJnwncFtmSfnnq7BG7mTK5kM8GPjPL8s7er/Oug=;
        b=FPbM6YGm0+2v+a7dfLD2r1xsPIdoZzsB3WLcQQpt+iiMZ0ZPr6E+Xmah4VeCnoBVwM
         1XI9tGVqd+amR+wTuvVcSje66GPeBZyjeGx2riOIZ5WnA0cCWkSXlmOFJdYy3+7LumtF
         LXINRU0UpApdf0FihchJuJxe9kxYFW70+mWB6Od3Fk7CyKmTnue8LmsJWXLJ87jKt7pH
         zhpqlZ7rQaVen8QMRXBN5XO7XD2vZOggFT3VHz80jzrnbGum40+ZXcX+aR8JsRCbvWl/
         NTVTFHylhWw+j9qoGVrOVHACsQIgRAs2mxa48rsE1VTGzlzxfi5LNYP/TNrD0oFSu+Mr
         Qqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGNbQJnwncFtmSfnnq7BG7mTK5kM8GPjPL8s7er/Oug=;
        b=j9dZodIaSfC7QyOTwzBWp75jnVKmV14GpN11MzKltRhct3ZvOMWBRyr8Nq6rbacxOV
         sMKFlgH8w2YIu0446PxnfE5WC+Bz5fyo4ZuY/9LLjZwNoL4E2IvQIGABeLeNHis5dtYa
         LRv9mlI0uWWjM/h4bHppYebMkxJsP8+biL/i1GdIr9noAyspIAeotCLtfiAKNVPZqkD1
         bi6vkwuGMnEbQc64nXd98jlHdIQFGooSWTr1bBj4Ld8QRJOf+tWcu//GF1kDIBkHM7Nd
         o+GZIBW7a6cuwqwybzUy1UfofvZE1n9bqkIUZQB9+VeHoYMxSllLvhfYoytGaXH3IkIn
         6MOA==
X-Gm-Message-State: AGi0PuY0xSVz4ENDbR36IR3hcU3hIGXm9Yct1EQgmDs1AOShOLeGNijo
        6PK3HHLZHmLIuNYILEkAQCkz8/iCv35WcMvrlCe7wQ==
X-Google-Smtp-Source: APiQypLaYCzytAomXpGw0KpBtvlb+IMYlHUaXnefkBr/mv0cHGOaEE/8DDORc8fTsMLcsoUj78yspHZlXLsrfKD9OfU=
X-Received: by 2002:ab0:6588:: with SMTP id v8mr6202526uam.100.1587369734116;
 Mon, 20 Apr 2020 01:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <1587363626-20413-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1587363626-20413-1-git-send-email-vbadigan@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Apr 2020 10:01:38 +0200
Message-ID: <CAPDyKFoOq3djNJzEppPwSUUfKYh2vrkcr3LmDEbfwPRa=Asphg@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] Minor fixes to sdhci-msm
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 at 08:20, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> Enable a couple of CAPS that qcom sd host controller supports.
> Set a quirk for enabling support for auto cmd12.
> And enable adma length mismatch error interrupt.
>
> --
> V1: https://lore.kernel.org/linux-arm-msm/1586706808-27337-1-git-send-email-vbadigan@codeaurora.org
> Changes since V1:
>         Squashed two caps related patches and appiled stable tag.
>
> Veerabhadrarao Badiganti (3):
>   mmc: sdhci-msm: Enable host capabilities pertains to R1b response
>   mmc: sdhci-msm: Set SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 quirk
>   mmc: sdhci-msm: Enable ADMA length mismatch error interrupt
>
>  drivers/mmc/host/sdhci-msm.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>

First patch applied for fixes, the other two for next, thanks!
Kind regards
Uffe
