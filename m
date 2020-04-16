Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75268C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510BF206D6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mFdfZi8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408063AbgDPGeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407932AbgDPGec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:34:32 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D412AC061A10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 23:34:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a25so3485101wrd.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 23:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0zaVLvpq9xyTb6tnL5lflzeTc3OD1xVdDRy9b/kylC4=;
        b=mFdfZi8VBTlwLtP0JTgvvick+7svv6vG9/rG7kqJVdsx7j4WTAwfHqs6HIWFQomHeJ
         QRxfjpa18BSA4VXbHmcIUmuDtse9X/hdmh/XQiyJ7jEfV081PEJ9tosvNZ+odwiT5hxG
         fAuY4M7K7YRoqM3JJSExPdZ/FXUazHY4EY9pPLCpFSHR47L1O64WI4C5aFBHEZ1Bbbzk
         VyRiPRQ9GjOSEu5CKBTWAW/RasKWbr1bdS4jRAqXs0BovImMBsKywoXudzx+lrdfJqOr
         c4YxSwYJ7+crMFX9rHyCdduz7Zz4FRn76B6VprKnWQ/mwxNDcnFGS+A3ZiWZ4x0P/8LK
         xXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0zaVLvpq9xyTb6tnL5lflzeTc3OD1xVdDRy9b/kylC4=;
        b=iXMH6xsgi8EtbXuWapcs2F24DuABlYWbQKn2BkPXXdMfXiICIcYSHLWH1nOZLTCIRv
         nLSM1fZSFw3wFALaDEAeUJTfJHGTwgU7zfTzaNZYgEF3XnpXiTuqharum5tf9nNF0pCw
         aFank9UOR0kW7OOD2jwitJdVbKxb/b8rIp0RCWqF9nY4tUJyawnFonK5xze+vSDIm4vy
         1/sktATU7G22lamlokike/f9s4BurdzLR7n1NRkbala+Zvi3VbK1LZYU4i7M9azuf8OI
         bAo33jOlZO4Y2koj94uOGnx667GOQShqKL2kskHmJ2Ys3e4ZhUmUTKMvYQDI1Pp0H3yC
         xxpw==
X-Gm-Message-State: AGi0PuZMOfopqxalK3IrxKdCJ1wO17eib2Wo1/RsLOCy2WT2t/ff+RC8
        SYfmFCmUwUgTHHKl6jiiXUmzUg==
X-Google-Smtp-Source: APiQypJEpTtqeTr9o0OHWVCd4YNULVp1q0q9U2Soz/KtkpNaaDcqmR9MRis2lZmNki6Q0+MIaix0pA==
X-Received: by 2002:a5d:5392:: with SMTP id d18mr12081099wrv.278.1587018870349;
        Wed, 15 Apr 2020 23:34:30 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id 5sm2419784wmg.34.2020.04.15.23.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 23:34:29 -0700 (PDT)
Date:   Thu, 16 Apr 2020 07:35:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     fabrice.gasnier@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/6] dt-bindings: mfd: Document STM32 low power timer
 bindings
Message-ID: <20200416063519.GN2167633@dell>
References: <20200401083909.18886-1-benjamin.gaignard@st.com>
 <20200401083909.18886-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200401083909.18886-2-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Apr 2020, Benjamin Gaignard wrote:

> Add a subnode to STM low power timer bindings to support timer driver
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> version 6:
> - only use one interrupt
> 
> version 5:
> - the previous has been acked-by Rob but since I have docummented
>   interrupts and interrupt-names properties I haven't applied it here.
> 
> version 4:
> - change compatible and subnode names
> - document wakeup-source property
> 
>  .../devicetree/bindings/mfd/st,stm32-lptimer.yaml   | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
