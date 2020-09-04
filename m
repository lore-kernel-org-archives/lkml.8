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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D853C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506462073B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLj2zny+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgIDDuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgIDDuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:50:03 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1ADC061244;
        Thu,  3 Sep 2020 20:50:02 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id n3so4610287pjq.1;
        Thu, 03 Sep 2020 20:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jyE5p+Uqsr/GNKcB4LBi0aiywESJTlFxnQEw8rSJKYs=;
        b=qLj2zny+rGviwUam1TIs1T8gP7D3vegYaED5OJKQVavIKrOjZAX+yTgmJc5PH6u/V6
         Tu6noP4FAl7SyJL6lCNbkTahEUwwIzs+1rfSblUTZfert6/GBmLiHfgEzRlovSp/74vk
         GJ8qHFnjYY7K9ShizgVs9Qozs2mPkZ7GEig1YA4ElqmB6fNFhVlMtEsi+dEICv3LADBh
         rE8DefFWIQ8aEQEzonHAl5IcmrZTlnm0llvLEpJC3iuApClCSV9ZCTFVX0vH/bVXPLUm
         /aoi+GK/epxqugIeedb7bKgvhgAf3sCbcfbviPf1XCto6wvOiLrukRCul4PPArxG8Htf
         zJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jyE5p+Uqsr/GNKcB4LBi0aiywESJTlFxnQEw8rSJKYs=;
        b=g4HtbJMS/tF1QkK532oMLTxlE9IPWI6N+i9Vl9UrMYsC9/fZK7uwFCfA++eXT+bp/u
         +YN9Z/Fe4HnaFhXEIS5fkulBoswEjt3dB7y3mp8lb0wLx3uRzywojyn5h522vgc7rXN6
         eApSYUK3hlNbthycqsr0onqTIQ7HPqxjTAhLSfKzFI0JYEav7SriBD5Kk6iJs4nTUnxc
         G4WXM2IE30mgawyIVVB02QOzsb7xLlych4FQIKmaWGdHKb3X5uuTHzL/Ns6K3FYgYios
         pkJvhykSTO57X/7eyV2+33WX90SC5ix3d/aCwXa8XN675EhwL5VaELgFkE1+Y3X/Amf1
         yvhQ==
X-Gm-Message-State: AOAM530x2zf1vP6e6qpI+sxAQHBzL4+h1xBqpB9u3LedTHBGAUrcdJC/
        K2KZf6DmhtFa4IdBu0S0cgc=
X-Google-Smtp-Source: ABdhPJwHeIqKdWPmMEr1F4vHgjldqftNT5wDioCnMzggiZeFz84xh2dMQ7CNaQLEpqj40Nr/SelQ/g==
X-Received: by 2002:a17:90a:d515:: with SMTP id t21mr5900627pju.149.1599191402499;
        Thu, 03 Sep 2020 20:50:02 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id i14sm3769331pjy.24.2020.09.03.20.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 20:50:01 -0700 (PDT)
Subject: Re: [PATCH v2 04/11] usb: gadget: bdc: fix warning of embedded
 function name
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
 <1597923046-12535-4-git-send-email-chunfeng.yun@mediatek.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4c77d18f-96d4-d7d1-84d9-73657ca912a8@gmail.com>
Date:   Thu, 3 Sep 2020 20:49:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <1597923046-12535-4-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/2020 4:30 AM, Chunfeng Yun wrote:
> Use '"%s...", __func__' to replace embedded function name
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

-- 
Florian
