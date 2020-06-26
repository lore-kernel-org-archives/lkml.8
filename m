Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8FCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B666D20B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c4KyRcxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgFZVwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgFZVwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:52:04 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F63BC03E97B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:52:03 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id g14so3498826ual.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=riZ5KZW8CnykJm5xJns3L+VFLhknSVFyzPeTPn61H9E=;
        b=c4KyRcxKQ8HHOw9yC6I3ScWIYuHciIrlf0+XT0VzOXz6siBITRjttc97VYU4pGtrcW
         QpZj0LQbq2BKoMXRc5i/2YcGBxHA9sydrxQMLbqm6/eU15jtxLRkteDj9x6Bi1nlvOrK
         YApd5NYLX10WeZu/BvqXLcywGJnEOZovFjXMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=riZ5KZW8CnykJm5xJns3L+VFLhknSVFyzPeTPn61H9E=;
        b=ne0Xi4y8lyA3m988VUw9ai1YCUfrkYW7iMXQ1FBHykraKZbwCVLweAaFjVYfF5/X5h
         P2/xM/Sg8OBy5fQDRf4iZha/SrPu0YmVnT8agOWlPZ/7P3ZyIi/N/7PeUx9zrPp8ssi2
         A/vIrblESjFoY9yeAuG8yGpE2dqM1OSJjTtYesosfE5izgKwQLqKf1PSBM9hmgsCCSHg
         Few2A4xasN0EC28KunJSJqv4AyIdvX0lP3km+SXE912yn8VmzB8nR05eaLzRlxUX7zRo
         Z7jligStvPu6Jntf7rpMUuOvbPmuvjZPu9A/BnrkY6Ultx9qqcQEafgULJsztoMJ2nyo
         hVtA==
X-Gm-Message-State: AOAM532wQj+cJFhVre91PQoU2uZV3VvTxNKufwNWYKyGxS9WKg8aHPiF
        AqQeKsxSL9gMHTL+ohKsC+/Y8u81EU4=
X-Google-Smtp-Source: ABdhPJwnPEpaUoGwsw5Z03L6vgRhMnscc6JMP4LNkQ4aoDFox9ICLPNyGrcsxEEBwaMQHRHnA8+Xsg==
X-Received: by 2002:ab0:614a:: with SMTP id w10mr4072412uan.35.1593208322126;
        Fri, 26 Jun 2020 14:52:02 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id o73sm4349511vke.5.2020.06.26.14.52.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 14:52:01 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id d64so2538671vke.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:52:00 -0700 (PDT)
X-Received: by 2002:a1f:eec1:: with SMTP id m184mr3812706vkh.34.1593208320514;
 Fri, 26 Jun 2020 14:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <1593194502-13164-1-git-send-email-pillair@codeaurora.org> <1593194502-13164-3-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1593194502-13164-3-git-send-email-pillair@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 26 Jun 2020 14:51:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V1C2Lu31n8xQ8HPf21fNo_Da2SLtZAeStFBEou9+geEA@mail.gmail.com>
Message-ID: <CAD=FV=V1C2Lu31n8xQ8HPf21fNo_Da2SLtZAeStFBEou9+geEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ath10k: Add support for chain1 regulator supply voting
To:     Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 26, 2020 at 11:02 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
> Add support to vote for chain-1 voltage regulator
> in WCN3990.
>
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
>
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/snoc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index 645ed5f..407a074 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -45,6 +45,7 @@ static const char * const ath10k_regulators[] = {
>         "vdd-1.8-xo",
>         "vdd-1.3-rfa",
>         "vdd-3.3-ch0",
> +       "vdd-3.3-ch1",

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...with the slight nit that ${SUBJECT} and description should probably
call it "chan1" and not "chain1".  Presumably the maintainer can fix
when applying.

-Doug
