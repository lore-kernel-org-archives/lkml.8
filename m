Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E74C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0609C206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I7PLcuk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbgF2TX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732234AbgF2TWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:22:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22C1C02A569
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 06:25:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so15392522wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zUEJkh5HHxVcYkydyDedgROg8kiF7ZTbhK+enqqtuzI=;
        b=I7PLcuk/NyfRTBDPzUHE5RTErXEBuYX5DVcAzkSE7wPRYhjM8vuGJxxS9ej05E/Bm5
         pfOPk2nwxVNerwaCGroT6e/7x7DyAtr5AS9p30EFl0FjeW/axT06t4M4I1NQVZOLfss5
         kHJpu/dOS6vz2BrQOnXcFzp2PflpVG7raeIMOVpA4m/x8bpPxoxip+4iNYKBnz07ERhb
         DEi56ZS9zJicNlF4bC1pXDaKuG8SwbU48R6jsYUJAivX7YGO/596ld84p2fwxMLcW7qg
         RH9X5bWbU6gLSCid1vmkx9/nrp1DvZnJWoT2tx/OTJlcjVRIpmaLefhbq/+HczJZZoQj
         z5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zUEJkh5HHxVcYkydyDedgROg8kiF7ZTbhK+enqqtuzI=;
        b=jxOTNi/X3tDirD/2Px7dXD+F/T+xSYwq/Nxo/1+ndYni68GXzHcQMHTmcUrIeWEBdQ
         3SEp3O+Fd75EsR3kJB99wwJqEMQF1E1etXAfI3aGED7V6bVn9Bh3StRdT3s1UoKQTZoP
         IgUOgWdHdI2vgWKSE3/hqsMBZGSe2b2wUsDo42JCG6dNLGkCjp1g21tQQC8FlhEuDQXh
         kEdvZfyT5ZPe8vUx9J4/D6/4sBMhBlkPJRITb+fVPx2fzWhy+g9W98yyb0MFqb2YFbHi
         aCOY9+ePUvJEqauYK8aiEm+8dtL0gP/0K+3XW+U2HcRNEs+Qv4FKnsyqZPiKOVQctkSS
         Tw0Q==
X-Gm-Message-State: AOAM533MGMf6C6rcb96iYBcnOXKyD6iU2afAsDLDQqr90i9O4p+0BmVc
        pbB5YYSirlGpbjUT9WnHsTDtUg==
X-Google-Smtp-Source: ABdhPJw2RBOaOy5Q3WIZr7vVnxJYhhctpyTg/SYgmN3r9pNAxEnEbAtMxeOwkfhFlEEdm1Pl23RCPQ==
X-Received: by 2002:a1c:9802:: with SMTP id a2mr15856350wme.64.1593437109494;
        Mon, 29 Jun 2020 06:25:09 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x14sm48402443wrt.60.2020.06.29.06.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 06:25:08 -0700 (PDT)
Date:   Mon, 29 Jun 2020 14:25:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH 2/5] mfd: lm3533-ctrlbank: Cap BRIGHTNESS_MAX to 127
 since API uses u8 as carrier
Message-ID: <20200629132506.GJ177734@dell>
References: <20200629123215.1014747-1-lee.jones@linaro.org>
 <20200629123215.1014747-3-lee.jones@linaro.org>
 <20200629125102.GT3334@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200629125102.GT3334@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020, Johan Hovold wrote:

> On Mon, Jun 29, 2020 at 01:32:12PM +0100, Lee Jones wrote:
> > Since its conception in 2012 brightness has been artificially capped
> > at 127 since the variable carrying the value is u8.  We could go to
> > the trouble of changing the whole API (crossing 3 different subsystems),
> > but clearly this hasn't bothered anyone in the best part of a decade.
> > 
> > Simply, cap BRIGHTNESS_MAX to 127 instead (for now at least).
> 
> Hmm. This patch is clearly broken and would contrary to the claim be
> introducing an artificial cap at half brightness. u8 can hold the max
> brightness value 255 just fine.

Yes, of course it can.  Senior moment on my account.

> > Fixes the following W=1 warning(s):
> > 
> >  drivers/mfd/lm3533-ctrlbank.c: In function ‘lm3533_ctrlbank_set_brightness’:
> >  drivers/mfd/lm3533-ctrlbank.c:98:10: warning: comparison is always false due to limited range of data type [-Wtype-limits]
> >  98 | if (val > LM3533_##_NAME##_MAX) | ^
> >  drivers/mfd/lm3533-ctrlbank.c:125:1: note: in expansion of macro ‘lm3533_ctrlbank_set’
> >  125 | lm3533_ctrlbank_set(brightness, BRIGHTNESS);
> >  | ^~~~~~~~~~~~~~~~~~~
> 
> This warning is benign. The same macro is used to defined two function
> where in one case the max value coincides with U8_MAX so that the sanity
> check becomes redundant.

A benign warning, as most W=1 warnings are, is still a warning.

So how do you propose we fix it?

Is 255 a valid and used brightness level?

If so, how do you feel about:

  /* Avoid 'always false' check '(u8) > 255' */
  if (LM3533_##_NAME##_MAX != 0xff && val > LM3533_##_NAME##_MAX)
          return -EINVAL;        

> > Cc: Johan Hovold <jhovold@gmail.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/lm3533-ctrlbank.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/lm3533-ctrlbank.c b/drivers/mfd/lm3533-ctrlbank.c
> > index 34fba06ec7057..348ce67453092 100644
> > --- a/drivers/mfd/lm3533-ctrlbank.c
> > +++ b/drivers/mfd/lm3533-ctrlbank.c
> > @@ -17,7 +17,7 @@
> >  #define LM3533_MAX_CURRENT_MAX		29800
> >  #define LM3533_MAX_CURRENT_STEP		800
> >  
> > -#define LM3533_BRIGHTNESS_MAX		255
> > +#define LM3533_BRIGHTNESS_MAX		127  /* Capped by API - could be up to 255 */
> >  #define LM3533_PWM_MAX			0x3f
> >  
> >  #define LM3533_REG_PWM_BASE		0x14
> 
> Johan

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
