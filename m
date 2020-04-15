Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3113BC2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E29720768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZISFk0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895460AbgDOJYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895392AbgDOJYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:24:19 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46324C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:24:19 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x25so16560554wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=25hsR70J4xkR7QjWib9TX4C/RIJl6X5HgsLKdDMfcIM=;
        b=MZISFk0+SGdYrIGleUjYyNyFlKlBZtpvcsFKyJMVxKBrgMGYtPYkcBrS4bRdkEp/7t
         IW0OdNkkEzJjOHq32c8nyyFfVBOA0CWrvJjsIloNh7+9VO5CUroLlbNB3EdfC+VubzHW
         RKiPdet4ElIC56WiuMenvtixe2coFc0mPjdD569+2OT9S+0GbYhuHmAMDdAJ2/wquaHH
         afuwBSmcYlb9MymeQAxl6jMcXisGmnphb0nXiXzgHpPoKvx7ynmkS1jh5aDHDA3xUcag
         t1mwgvkRTAPwn/Ml63NOIpJfKAurHTPzOMenfettsfMf8meyF+86UE6hMxa9KMhNgPe7
         /dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=25hsR70J4xkR7QjWib9TX4C/RIJl6X5HgsLKdDMfcIM=;
        b=YiAZF7zPxAH9hlDXKURqJY+OQaMAB3Crje/X9iuy9mTw/hU1BTLfcEmnnnvWsXkxhj
         wRLCIQQl9ZQ4xwCmTjNh3SBjlDgJynl55qlf2KUpL4V04ILl0vj1hm9ZRc+yIcu6RWqP
         +9chlSsx22B6pKTBNvr6KOrPbpe54prcbe+59Pl1GLN69iUyheY81l8r+VroPG5uV4gR
         LvbG8BYgFfEYVsGlJB3liNXcsK5uFfufje1xmVjALTWaQGaj30f/BEzk08eOmwrbAOqt
         x+W6Q4i+oF4kMLN8XMQHi19uedLUOyMTTD07OdETgcFe65S8U19z0/EnazWtxpvXHcwc
         dQIQ==
X-Gm-Message-State: AGi0PubHHC9v/za6JEZCKVKl/58ATBWnbvRO/8VvLF4PX0SejfUp8rkm
        QRlqh2uZEYlWK3tcvc62yUG7RA==
X-Google-Smtp-Source: APiQypI1L9Xj03pMeY/s2kTnKETE0bYjImrIZAgEBCHLd+qOzGsuktY5U9KyEtfeFWAbhU8Q4g0UeA==
X-Received: by 2002:a7b:c10d:: with SMTP id w13mr4131241wmi.78.1586942657950;
        Wed, 15 Apr 2020 02:24:17 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id e1sm12258399wrc.12.2020.04.15.02.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:24:17 -0700 (PDT)
Date:   Wed, 15 Apr 2020 10:25:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Alexander Graf <graf@amazon.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Reid <preid@electromag.com.au>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: Re: [PATCH v6 3/8] mfd: sm501: Use GPIO_LOOKUP_IDX() helper macro
Message-ID: <20200415092517.GF2167633@dell>
References: <20200324135328.5796-1-geert+renesas@glider.be>
 <20200324135653.6676-1-geert+renesas@glider.be>
 <20200324135653.6676-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200324135653.6676-3-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020, Geert Uytterhoeven wrote:

> i801_add_mux() fills in the GPIO lookup table by manually populating an
> array of gpiod_lookup structures.  Use the existing GPIO_LOOKUP_IDX()
> helper macro instead, to relax a dependency on the gpiod_lookup
> structure's member names.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
> While this patch is a dependency for "[PATCH v6 4/8] gpiolib: Add
> support for GPIO lookup by line name", it can be applied independently.
> But an Acked-by would be nice, too.
> 
> Cover letter and full series at
> https://lore.kernel.org/r/20200324135328.5796-1-geert+renesas@glider.be/
> 
> v6:
>   - New.
> ---
>  drivers/mfd/sm501.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
