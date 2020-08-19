Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB98C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8758E207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597860850;
	bh=QYBuIuEm2ugvBD7nOVhqIOoABVuY8EssjEfLEHT6Y2o=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=TLuop41K9SMNW6mhbO1rcOoEbPXukwBmE74CQ0UHopP7HLVtbE6Bs0DQpieGtJAxH
	 7eJPvtCkS/icVqkUnHYFQfmN6tkFfoCz+z+7rfEN4WxVFzz1FxyOAW5VpuzEQe8Bgb
	 Zl0L3Jkif52c3tvrUNx+yfww/RqkNbRRaD3ZRPnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgHSSOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:14:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42672 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSSOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:14:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id df16so18892817edb.9;
        Wed, 19 Aug 2020 11:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TUMql2k18FTxjS/+xzZXm3YL9WZCKUoPkdoTZwrxrK8=;
        b=Xte9k78t/JlQPcbVz8+Uu3VT/a5SDqF6g7nTtQppEj4Zn+kt7VyIBgGP1J3QRCzhpb
         8lhfnJ2pAUW9kOtMOYA928zW0rQu0vbRmyRf7CXiCCuWb0BHtB8dVDC2cMH07zzKDifT
         uOVU89FIgdOvaAs+8E/iIiIuj1rzHm5ap0IFpNtS/Byh35GTdzIL4DrJR9Q48ULRNxjT
         0XwoOFMoTStaDy4aXu5XTh8PgqJ8uCT7GKQddpLZEP+4kv37GqMVVaVlWuQIxzeztg47
         Z4lc7MUk7lLhiILbDSp/A/2E4ANHnLI0Kv3zuc1lLMzW0cfu40agwQ0vmvRaFH4ihlDh
         lNOQ==
X-Gm-Message-State: AOAM531wuejfYUwH8ienyS/xD44nu9ejHJkXvkagM6ANHrOsCDhXAp0e
        i5QRL2FUqSZ7Xz3gMOJjuis=
X-Google-Smtp-Source: ABdhPJzm9IKPaPX6c5msiAAQTSoc8HBbQJ1lELbzrQFuIrCSQOQG4wOpSWFZZFYs6II6k/SaJfvFlg==
X-Received: by 2002:a50:ee92:: with SMTP id f18mr26020037edr.80.1597860845273;
        Wed, 19 Aug 2020 11:14:05 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id qk30sm19144565ejb.125.2020.08.19.11.14.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 11:14:04 -0700 (PDT)
Date:   Wed, 19 Aug 2020 20:14:02 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3] ARM: s3c24xx: drop s3c-camif setup platform code
Message-ID: <20200819181402.GB394@kozik-lap>
References: <20200817164836.4613-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200817164836.4613-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 06:48:36PM +0200, Krzysztof Kozlowski wrote:
> The s3c-camif driver setup platform code does not have any users so it
> can be safely removed.
> 
> Along with the code W=1 compile warnings go away:
> 
>     arch/arm/mach-s3c24xx/setup-camif.c:28:5: warning: no previous prototype for 's3c_camif_gpio_get' [-Wmissing-prototypes]
>     arch/arm/mach-s3c24xx/setup-camif.c:56:6: warning: no previous prototype for 's3c_camif_gpio_put' [-Wmissing-prototypes]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---

Applied to samsung-soc for S3C cleanup.

Best regards,
Krzysztof

