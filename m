Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F803C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FE1207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzwI7l0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgAPNaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:30:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45390 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgAPNaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:30:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so19120220wrj.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 05:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UfygWLCc88sFrmjAuQP4lnVDVkzEeKEKCExMy7Eq/+8=;
        b=GzwI7l0KxNdLEBhVPtsxp6NDNF6oyDOZU/V1cwJ/m/uu9sEBp3vZ4ldtrZCVb0ERBh
         iwbaZcugXTP0mWMv0dOgFqPd2JJiutwJq1+ULTbIISzgEO/4qp4ZzOKYtKqCq4rX/pDT
         j2wq96/cmQJ+N1RP+PeoobUfHteJ3tzlsWm8sU/tN3JgyMN0WdafquZ09iYvNFjOEDTI
         VDrel4eAie8eeD5mEWObhoerl5i3eSPhzwbyrBv2ALLazHOM/hA2e4mwDjCWrjfvoKd+
         0bL0t1uwtt6rjXCT1BsjScS1CF9qYglzBjWw7WvogsfuPUNh65yLlpyEOQHvmbI1OwKB
         +/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UfygWLCc88sFrmjAuQP4lnVDVkzEeKEKCExMy7Eq/+8=;
        b=pZUTodrF7e7wyQE6smcKkAQ1RIjb/6Nd1OqBk4NcuJeqkuXjvRjDp7iw6ZDVqlmctI
         HxKvgVVtD3n7cqlXHlx+2BKBTqYDAdgYQ8q2YBbpGxRamKRKy/YHZcV/mr5TWrRn9KXy
         K2A0Nr5J5Oz6CiSIC3g5JckoOe+SdaNfs1SIYfJ+7KKFMeFObdrtPp+PLh2i6Buv/nFC
         1vUZv7E5z7sM6oj/BymQhAuviWL3eG1hU6MpCt/KzZGj7qrJImaauuk9tM4x4NvEbZ0f
         r2GfONEPyzxwBSJvoQeFTtjCQpApA2383rC69FknS7noEfeWliEf7kyWQat7zm2CsfsO
         bgRA==
X-Gm-Message-State: APjAAAUYV9L7lHIgUDnOqucvQccg3zDY0J9wiK3OpFTPu9h4BhwrQUC6
        ueDkiA1Pk2z/tFH/S3GXSu0WHw==
X-Google-Smtp-Source: APXvYqw4hOwN4dRzgFi88DWzyqE+AMTjtps6H/4gHqLpM7K+d0RkUbAC5kLjdkPW3SYP8MBp9FZ5wg==
X-Received: by 2002:adf:ca07:: with SMTP id o7mr3449919wrh.49.1579181406897;
        Thu, 16 Jan 2020 05:30:06 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id q3sm4354613wmc.47.2020.01.16.05.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:30:06 -0800 (PST)
Date:   Thu, 16 Jan 2020 13:30:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 2/7] dt-bindings: atmel-tcb: add microchip,sam9x60-tcb
Message-ID: <20200116133025.GN325@dell>
References: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
 <1578997397-23165-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1578997397-23165-3-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020, Claudiu Beznea wrote:

> Add microchip,sam9x60-tcb to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-tcb.txt | 1 +
>  1 file changed, 1 insertion(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
