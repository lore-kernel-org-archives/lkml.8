Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00AEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B860A2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467069;
	bh=Xfg/VWgfHvBZT2u1jL5vFLwfIURl6AyYpqUrOdGk4Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PYrAaI2jHZ4fLtkoZbQopf/gpiNcY0Wnu/RtJyBSgCA8W/le+AjTiSw1rC8ydhgK1
	 GDws/SFVl4JrDklAcuBXD1buDvIfMUEmJqgjpaFQ6VzqAy349uCFU6jg7klSoyn33k
	 nf3mZr+Ehvvb8W5qNIaeA9oBVgWLvp2wYTQUIhV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388577AbgF2Vo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgF2Shq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:46 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E03EC02A543
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:51:06 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so17868005ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0LrwryG62eUyl2zqUjhBe++Y1D3GieTqe72DllAUzwU=;
        b=C4qFFP+7RH7Vcxx5ZjN3j2bJnxL+r4+3jiGYt84pPaqsosTIEJNDj/UU0eZii3GXma
         cZORP/L6e9NWAxNzlnX1cXOZbs/tDB32wYTaPaypAsMWNciOmzzVliM6jGL69iE0XLw8
         H7gWBR/D0VhNTeuoQ8RlK5mGwYRUQ92NVqW22fm4T5jWKWVeLebVn3arK9cQjpnSL7+r
         OeVfSiEcs16F6Tvbk5tL6tR9/ctWHGJtXU7mdqNXtapWOMXtRh8P7eZ4unM84LlCHZ5+
         xz3tdLsHZj8zn/eDmLeyqodKDp2raRSH5Ddxs73WA/xBjuP7rFHvZckPtr0xnb9JBPJa
         AJBg==
X-Gm-Message-State: AOAM532yQ+KFB0uyqTqCbYRK5aVcBQCdFLjoXzfh8v6XaESPhR9BxKmo
        CELdGshcp1Jh4ei6r++76Q2sLwl2vkM=
X-Google-Smtp-Source: ABdhPJy1Oa+sFlJzr/Lrmq06b2ZzNN4W8IFLJhckyKTLVnMrowOCwFnL7cGHxQlWRfjiLHud6wIsow==
X-Received: by 2002:a2e:3316:: with SMTP id d22mr1714816ljc.18.1593435064220;
        Mon, 29 Jun 2020 05:51:04 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id l1sm2212934ljc.65.2020.06.29.05.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:51:03 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jptFW-0006wJ-Se; Mon, 29 Jun 2020 14:51:03 +0200
Date:   Mon, 29 Jun 2020 14:51:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH 2/5] mfd: lm3533-ctrlbank: Cap BRIGHTNESS_MAX to 127
 since API uses u8 as carrier
Message-ID: <20200629125102.GT3334@localhost>
References: <20200629123215.1014747-1-lee.jones@linaro.org>
 <20200629123215.1014747-3-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200629123215.1014747-3-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 01:32:12PM +0100, Lee Jones wrote:
> Since its conception in 2012 brightness has been artificially capped
> at 127 since the variable carrying the value is u8.  We could go to
> the trouble of changing the whole API (crossing 3 different subsystems),
> but clearly this hasn't bothered anyone in the best part of a decade.
> 
> Simply, cap BRIGHTNESS_MAX to 127 instead (for now at least).

Hmm. This patch is clearly broken and would contrary to the claim be
introducing an artificial cap at half brightness. u8 can hold the max
brightness value 255 just fine.

> Fixes the following W=1 warning(s):
> 
>  drivers/mfd/lm3533-ctrlbank.c: In function ‘lm3533_ctrlbank_set_brightness’:
>  drivers/mfd/lm3533-ctrlbank.c:98:10: warning: comparison is always false due to limited range of data type [-Wtype-limits]
>  98 | if (val > LM3533_##_NAME##_MAX) | ^
>  drivers/mfd/lm3533-ctrlbank.c:125:1: note: in expansion of macro ‘lm3533_ctrlbank_set’
>  125 | lm3533_ctrlbank_set(brightness, BRIGHTNESS);
>  | ^~~~~~~~~~~~~~~~~~~

This warning is benign. The same macro is used to defined two function
where in one case the max value coincides with U8_MAX so that the sanity
check becomes redundant.

> Cc: Johan Hovold <jhovold@gmail.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/lm3533-ctrlbank.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/lm3533-ctrlbank.c b/drivers/mfd/lm3533-ctrlbank.c
> index 34fba06ec7057..348ce67453092 100644
> --- a/drivers/mfd/lm3533-ctrlbank.c
> +++ b/drivers/mfd/lm3533-ctrlbank.c
> @@ -17,7 +17,7 @@
>  #define LM3533_MAX_CURRENT_MAX		29800
>  #define LM3533_MAX_CURRENT_STEP		800
>  
> -#define LM3533_BRIGHTNESS_MAX		255
> +#define LM3533_BRIGHTNESS_MAX		127  /* Capped by API - could be up to 255 */
>  #define LM3533_PWM_MAX			0x3f
>  
>  #define LM3533_REG_PWM_BASE		0x14

Johan
