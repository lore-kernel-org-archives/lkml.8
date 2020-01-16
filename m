Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E17C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BA32075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qk6nnIvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgAPNbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:31:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36603 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgAPNbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:31:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so19181162wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 05:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=92j60HxqCEoOKu+L2rR0tiLdjI3nwfWARg8KDYeQ1Hc=;
        b=qk6nnIvTtbXj8z3WH8gRV5cDnpDpuGi+k9gfNf1M5gPU/SGXQeF/OouzDTCtsNTspO
         jyP6vddeW+PKwwlJcW1RP21/2yahoHU1oy+mijDa2/YmNpFjQnN+Nw5ZVbe0AWOQ8MSL
         HBq+5c4mm6oTtx2gT0pdFAPlhYfXLZEfvcZosCXRs5amTmpo77tfKqiIsleJOfsQjgga
         N44KBEzn3cxNeeG/4wciOEzUQeA0kvBvBXm4m5SY6lBEh9Z2QmrSoJhbikrjDyvbLnCJ
         IBP5kISG7AL6GQlWy1nJ2oOGDn6FNgcRO4ZaczOg9Ptv6lg4qvqOhbD6ZkzIKeekalBk
         w7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=92j60HxqCEoOKu+L2rR0tiLdjI3nwfWARg8KDYeQ1Hc=;
        b=UMAIbyxT3d8hK8SDlgVi5U5pQ9Sh10onCulUSLJFlejyRQopbERhCGsBFw0QybACWX
         R6iplsip7rjPdF32/cmXKo0T6M7TCvA5/B/KSpUGxCt00aDfarowJgfm14OTG/DlMObg
         YpZ2hXckL3mDhh1idgsLn/fTF/CU2u//t4tbEKDqVIqTCc0vHSPY0t6vKJ2N37nxCFeU
         ItYGhkrkGU1R8tzUdU8NX5yoB8/dhHAnp0vrqKL+YWo4Adb40Bt7RWly1VrlvfUS5HpK
         fPFMmQ/Su7hQB44RXMyiEtr0d+6JsCR9Yh4pbd1kl+PJtBFdtTEfmy5tz5XkCmN6SF28
         A5aQ==
X-Gm-Message-State: APjAAAUVcNRrQ0XPGrQxgVlAY5ygP8uGrMUg+/wrqTmRytz0XRwNd8zU
        0XNSaMmOeZBJvnKwu7s1Xaje3g==
X-Google-Smtp-Source: APXvYqwlMDSGPaX00R2t+Jwt5d47l+TNIJ+hn5XsewXTyhaLBWjnyKNucc5zVRNV2/RZ5WqI12aE5g==
X-Received: by 2002:a5d:608a:: with SMTP id w10mr3190596wrt.136.1579181506919;
        Thu, 16 Jan 2020 05:31:46 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id s3sm4550461wmh.25.2020.01.16.05.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:31:46 -0800 (PST)
Date:   Thu, 16 Jan 2020 13:32:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: atmel-usart: add
 microchip,sam9x60-{usart, dbgu}
Message-ID: <20200116133204.GP325@dell>
References: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
 <1578997397-23165-6-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1578997397-23165-6-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020, Claudiu Beznea wrote:

> Add microchip,sam9x60-usart and add microchip,sam9x60-dbgu to DT
> bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-usart.txt | 1 +
>  1 file changed, 1 insertion(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
