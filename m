Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE0DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B22320809
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OHZTyDw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgG1IUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgG1IUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:20:53 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596AEC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:20:53 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t6so7230592ljk.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HIQ5RtYMfFI+H7x8RDkaUeKWb3yF02QogFEmqjJTRQ4=;
        b=OHZTyDw3HJ8WOeuBhN+CzaxQQxiiuqbtfgB+RG/0OuulIDrXsUgGPg3j4VkJiPRSea
         oN+y+EK88R3MUlLbaSe6fG5O/eEgE87eos5PwAhIQ5TsNkhmcRR5IeXDgIk3wXu5hzBn
         TDW2F0HI9FmWPGNGG11dUorKGj/px+vz5J21mNrwjN4XWKAJ2ce7zbKGT7zoj+/H/qzV
         6ueaRD/xn6UuplQRgC7a6ZMMrLZZ096a7qzBPfwhkx4jLqJbvMi5+zDhWDWvoDOD6zBQ
         II/biUYt8LlrcmTMeNANqVZM1G+OzbRMOEAnAgmkaFB43x9llVuS5/zJHZ2I6oazmKhK
         uoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HIQ5RtYMfFI+H7x8RDkaUeKWb3yF02QogFEmqjJTRQ4=;
        b=JUJeHNNf9SCbu/FRCQlLFtUGI/xzY+KScqQvzqxaPZAzQm5dWwG9YtsC29YKtqryZY
         RZWQY3VGj7Oo1JUvQgyEs2uyw1Xi+s2G9xjartSmEEixIsT9C2IAgbMI5ZF68AiHHdvl
         MmmJN3uBFwiPCBOMpHDVgun/2hsmEHU2hwU3ZUViVNBm985HnXfQMSonEC1c0sT6P9u3
         oRaguxpDsdfiyBDvZpOTyagTOGnMSg0TDbrtfiFPXtnROdErYld1Ra7dAyfKXr3NeIM4
         qlSQ8hQV3bsEvoDbJlEePJy34LLjYUOew0dJMu43fFbZOIWx/40n39HnMMpJ6CMkr1Hm
         omzQ==
X-Gm-Message-State: AOAM531dAMZY1QP9iTEf4m/y6sH1g7qAKEXL6refu+eozrpgu0sDQoRm
        5LC0AzmJMA2EmmIxxFjxgSPgeLFQ5Eh9At+NMHjtgA==
X-Google-Smtp-Source: ABdhPJxO+CGw7ygWgvu6yceY2CDngQOoDTtutC1EvO9o8y+oLDTzQAs+Bay1PvMuRM431rG23KjX0Xl15Cw6otKstvU=
X-Received: by 2002:a2e:810a:: with SMTP id d10mr11537402ljg.144.1595924451850;
 Tue, 28 Jul 2020 01:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <d15827a3-d0c8-e231-9f61-8507b3d7be3a@infradead.org>
In-Reply-To: <d15827a3-d0c8-e231-9f61-8507b3d7be3a@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jul 2020 10:20:41 +0200
Message-ID: <CACRpkdbpEWap7bo1TOpDzX_t_mpisxhhiUuiQqNT+0rdFFAt+Q@mail.gmail.com>
Subject: Re: [PATCH -mmotm] pinctrl: mediatek: fix build for tristate changes
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sean Wang <sean.wang@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 7:55 AM Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
>
> Export mtk_is_virt_gpio() for the case when
> CONFIG_PINCTRL_MTK=y
> CONFIG_PINCTRL_MTK_V2=y
> CONFIG_PINCTRL_MTK_MOORE=y
> CONFIG_PINCTRL_MTK_PARIS=m
>
> to fix this build error:
>
> ERROR: modpost: "mtk_is_virt_gpio" [drivers/pinctrl/mediatek/pinctrl-paris.ko] undefined!
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sean Wang <sean.wang@kernel.org>
> Cc: linux-mediatek@lists.infradead.org

Good catch!

Thanks Randy, patch applied.

Yours,
Linus Walleij
