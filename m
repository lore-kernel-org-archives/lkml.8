Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002B3C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F7820721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EoXWpACO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390439AbgDCJYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:24:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34924 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCJYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:24:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id i19so6925294wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 02:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ph0bQEVivKyrvCsvpNnxX3VcyLljQN3rvtdW4PjpUYA=;
        b=EoXWpACO8GQp2HUQGe3WqRlEX5JDF6cZ9WJh0dLk9SDe3WZuHSaOylvqe1T14fLlxB
         VdiXx2NpE8iEkt4PZjnQUyIuSgMY+OdPPhxF5RCHdoRKdfW6a9NkxiYvs9a/JaDrKSMP
         rDhgpqLiSXc/PR4Cdsib/Zs387vHMa7H0ghH5FJ1dwkjlOCWW7GwjHVlfAr1NPXHuka9
         h/txEFfr3eiDPPShk8/0MmJjRfTqBK60nz+XcURzsjg+jV+pbLMZB+oe5nfd4PVbmVRc
         kY2JCouPNTuCm+toiscRxFb5dxUj8O7dKHiXp3brrUs+9gw+sq2RPBMJDSIdMbD/bRhe
         jkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ph0bQEVivKyrvCsvpNnxX3VcyLljQN3rvtdW4PjpUYA=;
        b=NgxXASdeyUBleWOBgdbwSyF428OuS3e31tdoZYzRukt+tkN21FUHeWvGcTb1Jd+FH4
         AZe68x5+qpXXtVUusQp0Llyggmak+UmStZFbCpegIhrvBLOgdNtUfp0xKGDzjjFLKkn/
         VEm3ga20k5QkiztI2cBtLYMSyDLJqwcR3kJbKLsQaecVOF2LzEVnPpFh3CZY0fhjWDgs
         lT1DQOERKtzJjXFks0Qyc58k6a9nc83uxqeElmrcnWJbLFkKkIY36a4WO+fx9Vdy1EHi
         ZpXfDDzkxytktzjavrl5rXz0RAn2nqlZp7/ih/87U+ceFrppXFjNRwoZbcBX1CWk3WFu
         WxsA==
X-Gm-Message-State: AGi0Pub4cK6J98tLDjSi0w687ey5YUWW3lNUGukjmnGl2FHwNwsfCZ1r
        6r5+GiG/WIhBCcPIdHXKx/dTbw==
X-Google-Smtp-Source: APiQypLvGETVEYJaT3z4N1aZZa3xAbJ+hJj/+OR8FGSF7k5T+vXXpk+pwvvdN3Bo9pTqT2FFg5XIJA==
X-Received: by 2002:a1c:e203:: with SMTP id z3mr7923246wmg.71.1585905868318;
        Fri, 03 Apr 2020 02:24:28 -0700 (PDT)
Received: from dell ([2.27.35.179])
        by smtp.gmail.com with ESMTPSA id w7sm11297056wrr.60.2020.04.03.02.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 02:24:27 -0700 (PDT)
Date:   Fri, 3 Apr 2020 10:25:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Tang Bin <tangbin@cmss.chinamobile.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: asic3: Delete redundant variable definition
Message-ID: <20200403092521.GD30614@dell>
References: <b2a0e5f6-1f07-a7bd-2f3c-c95119efe635@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2a0e5f6-1f07-a7bd-2f3c-c95119efe635@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Apr 2020, Markus Elfring wrote:

> > In this function, 'ret' is always assigned, even if 'pdata->leds'
> > don't carry out,
> 
> I notice possibilities again to improve such a commit message.
> 
> 
> > it has already been assigned a value in the above code, including '0',
> 
> The variable assignment will eventually be performed only in if branches.
> 
> 
> > so it's redundant.
> 
> I suggest to reconsider this interpretation of the source code here.
> Would you like to move the mentioned statement into an else branch
> at the end?

Why wasn't this sent 'in reply to'?  Something wrong with your mailer?

Now this messages is orphaned.  Floating about in my inbox on its own.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
