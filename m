Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53588C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 312F4207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxAohx9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgEZRMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbgEZRMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:12:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40D3C03E96D;
        Tue, 26 May 2020 10:12:16 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w20so5325538pga.6;
        Tue, 26 May 2020 10:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ho7FU3ifEX8XPJe0lmPA5CqqH3tgY5tKKq8ZqWK1gzs=;
        b=CxAohx9znrbRh/5kV4baxqcFl9WY4vzkMxODt1KRO0lXM+a6LPKMzOK3fwZiHch9bX
         KsMSYkF5fWA+R8EzSb/+OEsFcr+gr7PtBZXj0Uo8/mBYKvIbyfZqlb7/Du5YCg/8XYmH
         bFd+MPIWdtyMpweXb3SGns6pxXCQMfeTDw2dUiD599rOMKM+gwNMUxD7lkSuPTP887gu
         mg0njXABg9Rg965Q2jVDI1MbO+aLeIMhk+rsIPyBscBPIT/mL+LWTsVqIe1CS493mpn1
         2HNP00kaCrW3aoLgpmLgPQfuOcN1EsA1IgtZ8adodx0l5ZKpN40tPXzSer5HTTf5UiZD
         Jegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ho7FU3ifEX8XPJe0lmPA5CqqH3tgY5tKKq8ZqWK1gzs=;
        b=QZQcrA6ncrUcufeX72eFLlqYFMA7LTYMNWKSBYZc1EYKpdInSYFoemZCqAMuoKkK5T
         cyQzG/pVf50Hxan9My6/gUT6ygfNMwks7hLrvicscc3Ldq3dTIf63MZq8oHhdX4QzWiT
         0jso0ceMHW5B0zWGNGgStT0r6tKzwSPQ0MBEsQ9RPhfybA/TtZEeynmjNDHTQTo/m1y7
         WhHsUWnbYrlZM63n+3oU7L9O6PG8J+PS3Eb7S00h9nnc7sMvrTf8UDhEYQMZ1cJ7NT9r
         ojnHWC7qaLSejUk8nWSDEbbP+4f4sZ27qDkt2HwTYR2XjdvAQ7k7bFqWE3MAjIlqfNFq
         PxDg==
X-Gm-Message-State: AOAM531MjFP6SZWdoHfgt6ITRH9+drHNjlfc6aOPlyPMOAx0k45A/Fwa
        KNiyuLRuq5efFKFB4Xx7u4U=
X-Google-Smtp-Source: ABdhPJyA/Swe+pEkp5GPCI/CJqCUpwcOH4mcSOuoazj2oBlQ84Ld2Y9S+vZjAxFxcd+nmqgyEE8FMg==
X-Received: by 2002:a63:c311:: with SMTP id c17mr2018126pgd.103.1590513136296;
        Tue, 26 May 2020 10:12:16 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d18sm62797pjv.34.2020.05.26.10.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 10:12:15 -0700 (PDT)
Subject: Re: [PATCH net-next v1] net: phy: at803x: add cable diagnostics
 support for ATH9331 and ATH8032
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
References: <20200526100823.2331-1-o.rempel@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <73922886-54d6-e119-28e4-b6e4d3cdd31c@gmail.com>
Date:   Tue, 26 May 2020 10:12:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200526100823.2331-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/2020 3:08 AM, Oleksij Rempel wrote:
> Add support for Atheros 100Bast-T PHYs. The only difference seems to be
> the ability to test 2 pares instead of 4 and the lack of 1000Bast-T
> specific register.
> 
> Only ATH9331 was tested with this patch.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

If you fix the typos reported by Andrew:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

thanks!
-- 
Florian
