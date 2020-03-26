Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B58DC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAAC20B80
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3+XMO4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgCZJUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:20:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43159 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgCZJUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:20:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id m11so875945wrx.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 02:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XiFCSIEFbCtqD4+HIYFwBoWm8BPO7pJ1HJRJcTm4S98=;
        b=h3+XMO4b1m3gWVXbv756Fxbc4CvIBdECygkaD4INk1GOYA5GEKpLWfnhqt8WIMaq1A
         6JTMUUa0Mjqg2W7WTRjYoClo8Xn03jPlyxK4GkQP6NRQ84+oSjjb9XWmjHlgIF7X06aQ
         Moujtz1baHzCi/hx7u0ON1iV8jhWwswC6IVlHzHUqM4SV61RnHJM2X3jSCeMF2RjWmf0
         9rS9WDukmZBTYtOjTEZU9WfDONk1lgWeWuhb6tlivVKu3edZ8dYdn3f/MNZe1J1oLN6q
         Rqo5bCl7JT50OJnlF6p46hgcboQ38j6kf8Th6B0Fji6WlIk+pA8Mve0snY/tltO/cA6t
         7D1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XiFCSIEFbCtqD4+HIYFwBoWm8BPO7pJ1HJRJcTm4S98=;
        b=rk3NbIpQgGlP9hqZ235hzb2HBxbdrGW9COzcGAO0F6bQZPFLTCZ8ayWY9YDZhH64+A
         gb0OnEcxpj53GNuqjLf5sDkPp1vnSeOXNWpL6T6cOOjN/chTfs3SLbFWA6EWs4xTLSTv
         W8ZYTE/ELnGifWgYAbqei5t0R8+8NJACchvtBYkMeMxz9eceAnEO3BGtrEH19OeUv5ac
         g/mW+6lOqECjPI1MER03pXEaZSzgaZXc7XE3LdszuHYM7Oab1rU08LgKw9C4m9bqPOiu
         b6UhHxSFRIX79Tn+N/JuorjpS9X80ng77N0pwa6dJb0eUwY8eOaSqqIBtSPItaxIvqk2
         jBzg==
X-Gm-Message-State: ANhLgQ1N4OEAbDAP75YLS87AaAgLmMkDKcKIEwc5BDec7URe9m4Y7QIU
        63JRAVvFDxe3cvOoCtyjGWNTog==
X-Google-Smtp-Source: ADFU+vtL5ZXVm9XL43jJOUQKaE0UOa87H6ANr1gFusr26vHNsN1W8MzjEBq1RtpaNlMx0KNWkHMqOg==
X-Received: by 2002:a5d:460f:: with SMTP id t15mr8204254wrq.413.1585214443280;
        Thu, 26 Mar 2020 02:20:43 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id w66sm2690193wma.38.2020.03.26.02.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 02:20:42 -0700 (PDT)
Date:   Thu, 26 Mar 2020 09:21:32 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] mfd: intel-lpss: Fix Intel Elkhart Lake LPSS I2C input
 clock
Message-ID: <20200326092132.GB603801@dell>
References: <20200316143224.234432-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200316143224.234432-1-jarkko.nikula@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Mar 2020, Jarkko Nikula wrote:

> Intel Elkhart Lake LPSS I2C has 100 MHz input clock instead of 133 MHz
> that was our preliminary information. This will result slower I2C bus
> clock when driver calculates its timing parameters in case ACPI tables
> don't provide them.
> 
> Slower I2C bus clock is allowed but let's fix this to match with
> reality.
> 
> While at it, keep the same default I2C device properties as Intel
> Broxton since it is not known do they need any update.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> For normal development cycle.
> ---
>  drivers/mfd/intel-lpss-pci.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
