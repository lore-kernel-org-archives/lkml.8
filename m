Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D84C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB80206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gssi.it header.i=@gssi.it header.b="LdmIYf3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCLKA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:00:58 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:51349 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLKA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:00:58 -0400
Received: by mail-wm1-f50.google.com with SMTP id a132so5372102wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 03:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gssi.it; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T0cHVlh0IotE0wQx3kxPQ2qR9ahWTST/WVB/i9Hm1yI=;
        b=LdmIYf3A52Uh+odbZvOG9MlZ4esDXhA0ZFK2tFTgPTyzQJMxLOVT3VVF/MIUs41dg+
         bvP/ve4tOJhTqyJemQowyP0pVOPYVk/wQ3uZ/LvKANTl8Ei0Z1B6W1YT3t0OG0WvApcn
         alpKXP2Wn4g48HM+SVbc07nrMN0YUFrVa/cx4JhDFZPT4WCaQvS+JiqVUtPScOTPVoPK
         VTRq+atiTMBOME2eJGeh3UKQ9i2CVgZ/vAkAFqUVtvShu4Nm1/sfqSYH6HNSB6XKccEe
         JPzOtM3xMkIiC7Rn/HWNb5I8fN/Xqtg8e01B8VzKsXDs1u1NYYC84OdTRmAO87Q3HM/B
         jnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T0cHVlh0IotE0wQx3kxPQ2qR9ahWTST/WVB/i9Hm1yI=;
        b=udwUemxZIYVBEbjaVGoWoBCpnhEnBq6fUGBq39nsHNuimkQ+6QXOt1DIJYLLxckL3u
         +X9D+2URk9WtfZTMm8H4AquB/qQI7vK9KPenrwPFL7ulFT+rbEfLwW8BGFP+FHEptN0Z
         h+7QFyzIkwaiiON4R2AEnxCXQ2Zq4vYQJ66xViG1ODc7x3F3W4jy8AAyoT/namH48lL1
         JcvlYLzcRw55iCV2LEIy0VSuXJ/5+dU1lmT43Kzk/lJqBdcMOwX5TKnBK2oSSVSWjPC7
         1tTdh6L/J6nOKejYWCQwDRj+DOePtKL8BQjInZOw+JzR6+LF8xEVRusNpZhJMrqrGOQz
         SKtg==
X-Gm-Message-State: ANhLgQ3obDMwyRjRxR9IeKUL1Ut39m77DLpJNdu41f9x07aio4WNCyQj
        4PbaqSouae3w1IwPUR4WqivGPQ==
X-Google-Smtp-Source: ADFU+vs1qTTVdmaCl/G4tsIpDvgdWvB+wR4+bttsjzxd5O2Evhb5BhnA0pqT0cdgu6TofEyIERZV8A==
X-Received: by 2002:a05:600c:21d1:: with SMTP id x17mr641793wmj.94.1584007256206;
        Thu, 12 Mar 2020 03:00:56 -0700 (PDT)
Received: from [10.55.3.148] ([173.38.220.54])
        by smtp.gmail.com with ESMTPSA id 9sm11812756wmo.38.2020.03.12.03.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 03:00:55 -0700 (PDT)
Subject: Re: [net] seg6: fix SRv6 L2 tunnels to use IANA-assigned protocol
 number
To:     David Miller <davem@davemloft.net>, paolo.lungaroni@cnit.it
Cc:     kuba@kernel.org, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrea.mayer@uniroma2.it
References: <20200311165406.22044-1-paolo.lungaroni@cnit.it>
 <20200311.235031.754217366237670514.davem@davemloft.net>
From:   Ahmed Abdelsalam <ahmed.abdelsalam@gssi.it>
Message-ID: <596e8f0a-9aec-a18a-e6e1-4aab1092457b@gssi.it>
Date:   Thu, 12 Mar 2020 11:00:53 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311.235031.754217366237670514.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2020 07:50, David Miller wrote:
> But this is that classic case where we add a protocol element to the
> tree before the official number is assigned.
> 
> Then the number is assigned and if we change it then everything using
> the original number is no longer interoperable.

David, Is there a way to port this patch to previous releases ?
This would be really great and helpful.
