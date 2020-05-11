Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D336C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332EC20720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589224445;
	bh=C+efllGB64LlwO0bZELxETxfugAhOvgex2PuihJOBXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0ZkZBlOzgPqazOpd297s5QAMK7BWWAyrc1dJx6+KPRX4eFXoZgi6/3boNasraWMQ7
	 Wowe9SuuVP3eBZZKXENNplOZMg905ePIsyL6ab+aBFUvznzuat2fEM293xVmuoK9Dg
	 JQ2sGvuOOnoQ6bV7sl21ik0aIhJOtGnGdafgNcjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbgEKTOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:14:04 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47089 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbgEKTOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:14:04 -0400
Received: by mail-ot1-f66.google.com with SMTP id z25so8467655otq.13;
        Mon, 11 May 2020 12:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wNn4fc0E16EiaSAUNCtewx4D1R6LPFSQyRyI9dTz69o=;
        b=kLa58h1FzZDx0o0GzIqUQC3jknf8VYw21i3k1/rOfFDo1RHT4MbYxTPb1XTI+ACYQI
         tMQONOZ5g/NvS15jv8UUAmWFqn929FbPjkMYGNy1PhWGqQI15CXT40n6O3kaAMTwY3TJ
         +e6MbWtmW6CzTh51WvaOCo5Xy2/qMO6V7nkibsL4FvdJpmWS7dAd55Si78lhCj4AWMqB
         +BH7yenS9Y9o01/hhiCa6saK4fMlJJlJTuFRo2Hq6WEJCZ2qy3h0Luiv2ofYeEo9H5N1
         lGpu9mn+i/DZVgdajix9do4x9ns1/pfTxkaEoNcaSVp9TGZFFbZGxT60QQiyMQL3ecRw
         w30w==
X-Gm-Message-State: AGi0PuawZzopREUgQxlIhA7+GLblln44SsvvmmokEHxUG7MFeZJDN5Hr
        tK06GlrTPPnKMBOfkm5bNKh1mPA=
X-Google-Smtp-Source: APiQypKnRs/hqEpuVQwu5GZFBmNaww0uawtrQmdDEhSWNWNikthbPZn7Zu4Lnqg3pmdycZ5aKUE5ug==
X-Received: by 2002:a05:6830:20d8:: with SMTP id z24mr14338525otq.74.1589224442995;
        Mon, 11 May 2020 12:14:02 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a22sm2852977otf.42.2020.05.11.12.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:14:02 -0700 (PDT)
Received: (nullmailer pid 27182 invoked by uid 1000);
        Mon, 11 May 2020 19:14:00 -0000
Date:   Mon, 11 May 2020 14:14:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: at24: add microchip,24lc[0-9]+ to the
 compatible pattern
Message-ID: <20200511191400.GA27107@bogus>
References: <20200422141836.1964676-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422141836.1964676-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 23:18:36 +0900, Masahiro Yamada wrote:
> arch/arm/boot/dts/uniphier-ref-daughter.dtsi has
> 
>   compatible = "microchip,24lc128", "atmel,24c128";
> 
> and 'make ARCH=arm dtbs_check' warns this:
> 
>   eeprom@50: compatible: ['microchip,24lc128', 'atmel,24c128'] is not valid under any of the given schemas (Possible causes of the failure)
> 
> Microchip 24LC128 is the device used on this board, and I see it in
> https://www.microchip.com/wwwproducts/en/24LC128
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  Documentation/devicetree/bindings/eeprom/at24.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
