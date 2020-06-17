Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159DFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8CAF20FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmwYkf8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgFQVjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgFQVjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:39:35 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86D3C06174E;
        Wed, 17 Jun 2020 14:39:35 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jz3so1600062pjb.0;
        Wed, 17 Jun 2020 14:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rLvBGjiO+L3wUJwmseM5JxfmJEyzpxUO8YmO65Td4oc=;
        b=CmwYkf8AEsp0zIcYic3FHDk2QqCd3RwkLH0UnvSHyICn2Ad2q+hF9SH2ORd/yNl6s3
         ZT/M2d6xzBzUtAmCU+OgLV/HIkIqJXsbUGPmD51AMcp8jTnx1/Zhqb/a/6zpU4A1GabR
         yo6P55EPKhbfefcvRXfu+y3IsBrjGa5IKLYv3q0ID13USatYvqNaieO8ub5+X3t6PsO+
         rSzrrI2RlHniSG08RmBO1DX/gxosK4Kqkcqmo0NDxNhAzf+5JP0rLIstSJK06tcOKm4h
         NZsNJq5dh7VWAO6bDXza4RQGeZDonVwI27aUX7C0tYT5uaT+p7q0Y3a58ozefA6cvNi9
         B3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rLvBGjiO+L3wUJwmseM5JxfmJEyzpxUO8YmO65Td4oc=;
        b=rE8Q6xhLskHDkKxdx2jo4RGjbOeye19y1HDVqzG0m6PM9zHMwavyTyV3CDwmz0czZb
         daWaOKNVVYa2P4i61da92Bqs/CsNGf1KNISB0qt4qGpMeei+h6CIJuCBcu6PgzCIl5Be
         FH8a4sAFC+k2+aJJjHwx/BmY+o/Z9rf0+0EMkpJuauLYHssIiEWFfi0dB2Sg+K541QJL
         B+KrYrIRBlxqokzmOTnBeI1Ln7X73LRLXWB+VHivN5MSE4+lX+0h9nLdj9awiQUpxfEz
         SIXZJQK978lUexKLTjtxKCsGVonnKl1QoXFGwI6ajoxX+g/k+EaW6PEn/S9g1eJbUUZ2
         9Fpg==
X-Gm-Message-State: AOAM5328R0oafBT+ieUIHgZ529HCpove34gA4magGmg3ZlGIfeoqTEzo
        cQngjXAF2pY1EwvyQxxw9QI+hBJI
X-Google-Smtp-Source: ABdhPJy3b4v8K4VFeWwtC/1UQfJbYMEh0TRO2v4ppeU3sOMOh5f7pqjt9dp5gfEn27JISvSVTMx//A==
X-Received: by 2002:a17:90a:fe88:: with SMTP id co8mr960302pjb.209.1592429974942;
        Wed, 17 Jun 2020 14:39:34 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a12sm431101pjw.35.2020.06.17.14.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 14:39:34 -0700 (PDT)
Subject: Re: [PATCH 3/8] mips: bmips: add BCM6328 clock definitions
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        julia.lawall@lip6.fr, jonas.gorski@gmail.com, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20200615090231.2932696-1-noltari@gmail.com>
 <20200615090231.2932696-4-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8d3d8a53-02f6-b780-b380-b07e275a1b27@gmail.com>
Date:   Wed, 17 Jun 2020 14:39:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615090231.2932696-4-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2020 2:02 AM, Álvaro Fernández Rojas wrote:
> Add header with BCM6328 definitions in order to be able to include it from
> device tree files.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
