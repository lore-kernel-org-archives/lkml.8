Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D084C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7CD21D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599754948;
	bh=cFm01d5A2xJtuwGGnkI+tpSI9gpBQSqULzzvO5shbnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SbaVVRUQV9ky3yHn/lGLxjp8yGTu4EouQjIesUqaxEJSdMQGzGy1cfUshBrP0ZOvo
	 TdGtP0ciUWNlyloegeLw94rAJQLg//CyWzOW+5kM1pGKorpB1Z2KGGKEAYHQusYXKT
	 9P2ywF4U5JTqd5rJ1Jg6cJmAglOraoUBlN9cP6Ho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgIJQWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:22:22 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:38337 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgIJQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:14:12 -0400
Received: by mail-ej1-f67.google.com with SMTP id i22so9558589eja.5;
        Thu, 10 Sep 2020 09:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UlWeBO5XXsVkxeqCqR5Hh1T/dXmevbm+y0dv6NWqW5E=;
        b=LpPNVk86sMy2KDgrWnb7UxCte0zXxhgIWlrxXDr5bFMXeXiS/0qgotYWAUdV7FtpdX
         EStLLainBAqcdYUIDwe/2NPTVQc8sFavT5UM8Du3ttRgOR33LSkMW1A2Dt8VrmSXmK2g
         jQAoIKlmXtx3b5FpoG+Bj5Dv4y7xDsrJy6+AK209K4ZcgUOQk++rv9GukQmIWr3u0z3B
         V4GuY598sz9B3A2zOHK97EDdPvfwH41L6YCRCnJZMvyzkuaIP/itKRnsq4IlZ9oadzkg
         1CoE+h49w4UIABbnxxI+qz607I+nqHRPaGPzV2wPoRgoHRfEWKaSHcgtQeT0ub6/Yh3+
         Wnaw==
X-Gm-Message-State: AOAM5320MZwQn0zC5VRCnTeiaLZpuYRyO8T/RE7bys2y1lmo6yprBk+r
        bax5CGrzxSXCPQXUc5MqYPs=
X-Google-Smtp-Source: ABdhPJwIIQ8dJ5uLZ10q13CyfyBK+itpFUo2QKO7vjp47zYPGf4bkS+d38Lcvwn5F7hpQoBbFA1R6A==
X-Received: by 2002:a17:906:69c1:: with SMTP id g1mr9261970ejs.285.1599754450515;
        Thu, 10 Sep 2020 09:14:10 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id f13sm7520054ejb.81.2020.09.10.09.14.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Sep 2020 09:14:09 -0700 (PDT)
Date:   Thu, 10 Sep 2020 18:14:06 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-nfc@lists.01.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 9/9] arm64: defconfig: Enable Samsung S3FWRN5 NFC
 driver
Message-ID: <20200910161406.GA6491@kozik-lap>
References: <20200906153654.2925-1-krzk@kernel.org>
 <20200906153654.2925-10-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200906153654.2925-10-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 06, 2020 at 05:36:54PM +0200, Krzysztof Kozlowski wrote:
> Enable the Samsung S3FWRN5 NFC driver present in Exynos5433-based
> TM2/TM2E boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/configs/defconfig | 3 +++

Applied.

Best regards,
Krzysztof

