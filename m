Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C4FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 283AA20781
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kY++gC7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgF2XUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgF2XUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:20:39 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB69C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:20:39 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d10so7695505pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=4oysdzb7v6IjFtwys8EcTgUxYFXoq8Z+j+gWVwzv1dQ=;
        b=kY++gC7/oVtoEI3QWyNnXuXoEXxAEA2nTU3YlmgvY/0mf+SMZpD2fFQnAa4f+xvpK3
         6Rc7yfFh4ZaIdSv+Fk5yqUo51V/aIDEqOw9AKCw6TkIhCbcXMqo0LruxuuFOmfn1nKnU
         05Bs2EYZafI2+O/3itmbrK3qJAnoB6PwKPwPvBseg3b5vEa2pE/KP0CAH55y7Uc8mNsa
         2jbBI+8Y5FvY0uE3lAGLw1Q88cz+e8Fg4yd8WUDpgnMljs6qzpAj/um78EbpbMTbbjFG
         Lsz5Y8VAkYatWEY/Ypy4bNc2JhrI2ahqojPFsCJK44xUvdvY+/m/UaoGV1QV7FFR+Xdw
         V6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4oysdzb7v6IjFtwys8EcTgUxYFXoq8Z+j+gWVwzv1dQ=;
        b=ghlXmsIQvP6V5o0EWq3q6tN7Hqjr7f20ld+ADp9i8+N1ziBzKzidrQ3C2f5YrcmcGX
         XHIimRTlLGtGEU+8IOMCV6ioGiBtl+WoafmzrJzRkv8xEXo/ly2zhViP98geKL8ZAR3g
         W1sE+5CjKDB4wEmzlzozmQIgj2ULKkT8lykF7gk1LlzEDxxhrUgNrdtQow9fPoRKkLBr
         q8dIKtFr6V7XJueGs2+5sMU6HGvURIxGn6cnF882zgwuT6r9sxUloOGGPBpLEnaaSVsl
         mS5l2nfchMYVyPu7dkG/mdQT5m4JqqBDtPkLozqcHURc6bIRbLgUC5x8uZlAfbkwIoPX
         7eCQ==
X-Gm-Message-State: AOAM531N241hGSWGj1THD1qYW7fImv+362HskDukboAlAa7j87tMhzec
        GDHrgqxx0BpDAPQkYZDqiCws8w==
X-Google-Smtp-Source: ABdhPJxQTf8wjO/mn2ucKqdyXqqCoF0Y4f+jAWeV0yB3xAAop7UcdKgo12tstmYn+/zmxK8nmZRSdQ==
X-Received: by 2002:a17:902:be06:: with SMTP id r6mr15673490pls.310.1593472838955;
        Mon, 29 Jun 2020 16:20:38 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id z11sm634202pfg.169.2020.06.29.16.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 16:20:38 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soc: amlogic: meson-gx-socinfo: Fix S905X3 and S905D3 ID's
In-Reply-To: <8757c066-2590-ff24-ebcc-2a9508fd9968@baylibre.com>
References: <20200609081318.28023-1-christianshewitt@gmail.com> <8757c066-2590-ff24-ebcc-2a9508fd9968@baylibre.com>
Date:   Mon, 29 Jun 2020 16:20:37 -0700
Message-ID: <7hv9j9jw6y.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 09/06/2020 10:13, Christian Hewitt wrote:
>> Correct the SoC revision and package bits/mask values for S905D3/X3 to detect
>> a wider range of observed SoC IDs, and tweak sort order for A311D/S922X.
>> 
>> S905X3 05 0000 0101  (SEI610 initial devices)
>> S905X3 10 0001 0000  (ODROID-C4 and recent Android boxes)
>> S905X3 50 0101 0000  (SEI610 later revisions)
>> S905D3 04 0000 0100  (VIM3L devices in kernelci)
>> S905D3 b0 1011 0000  (VIM3L initial production)
>> 
>> Fixes commit c9cc9bec36d0 ("soc: amlogic: meson-gx-socinfo: Add SM1 and S905X3 IDs")
>> Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>>  drivers/soc/amlogic/meson-gx-socinfo.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
>> index 01fc0d20a70d..6f54bd832c8b 100644
>> --- a/drivers/soc/amlogic/meson-gx-socinfo.c
>> +++ b/drivers/soc/amlogic/meson-gx-socinfo.c
>> @@ -66,10 +66,12 @@ static const struct meson_gx_package_id {
>>  	{ "A113D", 0x25, 0x22, 0xff },
>>  	{ "S905D2", 0x28, 0x10, 0xf0 },
>>  	{ "S905X2", 0x28, 0x40, 0xf0 },
>> -	{ "S922X", 0x29, 0x40, 0xf0 },
>>  	{ "A311D", 0x29, 0x10, 0xf0 },
>> -	{ "S905X3", 0x2b, 0x5, 0xf },
>> -	{ "S905D3", 0x2b, 0xb0, 0xf0 },
>> +	{ "S922X", 0x29, 0x40, 0xf0 },
>> +	{ "S905D3", 0x2b, 0x4, 0xf5 },
>> +	{ "S905X3", 0x2b, 0x5, 0xf5 },
>> +	{ "S905X3", 0x2b, 0x10, 0x3f },
>> +	{ "S905D3", 0x2b, 0x30, 0x3f },
>>  	{ "A113L", 0x2c, 0x0, 0xf8 },
>>  };
>>  
>> 
>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Queued as a fix for v5.8,

Thanks,

Kevin
