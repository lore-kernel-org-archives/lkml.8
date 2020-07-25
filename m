Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EEBC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 09:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F6D2064C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 09:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQbQ8gmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgGYJIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 05:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgGYJIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 05:08:50 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13E4C0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 02:08:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a14so10304467wra.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 02:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DyMBL+yC5aIhYRGcaqnJysyITwH53U1Ro41N0CgRvhs=;
        b=WQbQ8gmkRDWDzzP1+7raI6cxoeLmKTadrBGLHChz9qVlYLI7uTps1l2/Qh4MafNLx9
         FjFKFCtt1FFiy9A0CcZZChIQ1/uLdrD3lya9doFjD3bpuk7Pmj81Im5Eo7VD6kxetqhN
         Iv1mFQW9nntPe3o4zYxKy+6vihdYkEyyyXG3nVzupo9vjOiyQAJXDU7heVH4Xofvglo3
         VLIxFOPVdGiD6uj1gt1ylQIU4VygZZrbW+krWA6bufIx/jwTHb6kPvdSgGsr5fXKrY54
         oNcNZY4pbNESzRKHoC8Jy/XX2Zqgtla4BfadkHQLw7og4mdbU6nuVn1sci5w3o1q+t/p
         DnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DyMBL+yC5aIhYRGcaqnJysyITwH53U1Ro41N0CgRvhs=;
        b=YV8+ZaT3q6mqXE9LwEoHjrfLVGJROijTnLx1DpJnUK6MJRU3B+DSKgQpeFjpQVcrE8
         RtiWQrPA1NYAlEBkhXv6ukLq6JrHrSd1JjiCiVj/gYB7Miu8HSwvBYBeO7fU1U2A/w16
         Hkt+rlWZQ400YwoooSZeJFC1W95BRBnNEl8NG1iisdjYOKjQLfg0/dfCifGRByt6K3CT
         yaN9WkooCRvjZ5JHsijLr+ia4sBwhCTAnveLVmA3Imm947MiGqTW2p/vc36mc46IRf8e
         Xq50CzH2/v/BwFc2g7vBobBe2lh5W6eUu7ej0+7bZqn+tBDRJucZVY6ORNIC9b2cgeWj
         siTg==
X-Gm-Message-State: AOAM5323CEN5ibup48PZJT3Zyt36Z9aFLULxCJHFtkOn2DfJ6tdn3nKB
        G8HNtyHDctxmeGS8kYg4x7Q=
X-Google-Smtp-Source: ABdhPJwVxo79mPawJutmkPpxtYQ7dWDmm+5ZOr7of7YeMdOgECyD7PzQD5HyqrFAkmML4Rd/2dhmAQ==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr11659409wrr.353.1595668125165;
        Sat, 25 Jul 2020 02:08:45 -0700 (PDT)
Received: from [192.168.1.145] (94-39-209-155.adsl-ull.clienti.tiscali.it. [94.39.209.155])
        by smtp.gmail.com with ESMTPSA id n12sm3831238wrg.77.2020.07.25.02.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2020 02:08:44 -0700 (PDT)
Subject: Re: [PATCH 5/5] drm: rockchip: use overlay windows as such
To:     Alex Bee <knaerzche@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20200718200323.3559-1-knaerzche@gmail.com>
 <20200718200323.3559-6-knaerzche@gmail.com>
From:   Paolo Sabatino <paolo.sabatino@gmail.com>
Message-ID: <3a420557-8f49-02bf-e5d8-94c69534b2ca@gmail.com>
Date:   Sat, 25 Jul 2020 11:08:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200718200323.3559-6-knaerzche@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it-IT
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/20 22:03, Alex Bee wrote:
>   static const int rk3188_vop_intrs[] = {
> @@ -980,7 +980,7 @@ static const struct vop_win_data rk3228_vop_win_data[] = {
>   	{ .base = 0x00, .phy = &rk3288_win01_data,
>   	  .type = DRM_PLANE_TYPE_PRIMARY },
>   	{ .base = 0x40, .phy = &rk3288_win01_data,
> -	  .type = DRM_PLANE_TYPE_CURSOR },
> +	  .type = DRM_PLANE_TYPE_OVERLAY },
>   };
>   
>   static const struct vop_data rk3228_vop = {

Tried on several rk322x boards, it worked fine.

Tested-by: Paolo Sabatino <paolo.sabatino@gmail.com>
