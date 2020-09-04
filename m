Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB50C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C79820578
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbjN+uEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgIDDuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgIDDug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:50:36 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6B0C061244;
        Thu,  3 Sep 2020 20:50:33 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o16so2560735pjr.2;
        Thu, 03 Sep 2020 20:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oGNQEfbxD8L5+SKSkkpDVif8jO0EN+U/H3irjTsQ9AQ=;
        b=mbjN+uEu++65CWBVV2hmlNl+LzuAG+m+6L+gb9C+kFoMGM4Mw6Wy5bcNxEokxIvjwD
         f/CQDACSSR3mXrh2guPvfjg0wDifTcQ7DJegok0SYGEQ//wjeBpJWWg/qqVLK2sW20ET
         t8F9DgpViSDWBdpi6gc1c8dQ3w4VA+IQPkCT5n2B/EELZj+Tr4K2tgE7OCyUpGKA98LL
         THH6UXD0G0uetveQRdASqZcU8dTFWGJK05B9F0Ki8mUAGBfNyy7ZoIbrSN/pAiOkkuEh
         F7WCrX1pb1y4H6ZSns47dL0tUlHqlAgZu3gWxK0N4mi131qJjIbPVA9iiTyLRgfIOmHy
         QNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oGNQEfbxD8L5+SKSkkpDVif8jO0EN+U/H3irjTsQ9AQ=;
        b=MwK86mSB9EBmSe/fFn92jnSW1p/7dTTIaCqajP2SKGvjG3rSpv818wSTzHxr8lilqT
         BbOAen5k7eWiluVE0B4KbZx8TDtyS4D6OB8TCH1y/W5Tv7mTDJAFVzIVtn5sZAWHUaUp
         fSi/OR8XuzP/s5NwfLd6+eY1bI1U0yOn2KL1FjAqW7uW3c5QxZWCPefv1MqzJGE2KgKF
         4hTtao8PNlZENTrqu6cxvfly5z8VHJl3HPhaUW+4MYh1KP1lR2C4ESv+gNYyZKOhfpKz
         96iPXI7p62tq6EsWjUMtKrCaSk17UIJJWUOEXa5raLHd2lbAdH4tluiNN32P6Xfngqqx
         Vw7w==
X-Gm-Message-State: AOAM530NbZnkZv8ab1Q/21rSZOM5uW1ZMBeHocBfC5ZZ5GAgfLvzzHS0
        9BLpfhSsyuDS2bc/Tu9+vYs=
X-Google-Smtp-Source: ABdhPJwRWIRQ4ZdJNLBEGGSskavPO2i9NUEJZrYx3XIkmS429bGh55xkL4u3gCEe5YKhQLGC0HGqzA==
X-Received: by 2002:a17:90a:5304:: with SMTP id x4mr5949896pjh.16.1599191433468;
        Thu, 03 Sep 2020 20:50:33 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z1sm3771483pjn.34.2020.09.03.20.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 20:50:32 -0700 (PDT)
Subject: Re: [PATCH v2 06/11] usb: gadget: bdc: add identifier name for
 function declaraion
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Peter Chen <peter.chen@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
 <1597923046-12535-6-git-send-email-chunfeng.yun@mediatek.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0c2122aa-9b77-559c-06e6-4caed58b2053@gmail.com>
Date:   Thu, 3 Sep 2020 20:50:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <1597923046-12535-6-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/2020 4:30 AM, Chunfeng Yun wrote:
> This is used to avoid the warning of function arguments, e.g.
>    WARNING:FUNCTION_ARGUMENTS: function definition argument 'u32'
>    should also have an identifier name
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
