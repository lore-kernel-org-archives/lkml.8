Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECB7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01544206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6XrIxVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgEVLg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 07:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbgEVLgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 07:36:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E2DC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 04:36:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w7so9796276wre.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 04:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YkS66D2KhkTc0tni03HYE1pCRExjRVUOWUe/sJDevcs=;
        b=M6XrIxVgb8uYfB176RSMrC1sFz6rbgMwue9IYGt/vMFZYsfM6p/8Xu9H+xsbMMjlpP
         xGqK/kfSn0nddjxLr6T7fJgnx+ectzyDE868o692ejDlORVWc0DgobHlRl2YPTShqN33
         OfFWLcQ1Y6iMvtvtypwmEZ51g8CHJUFrSMOtmKgct1VkhAnt0EcsuyI9rXEDcMJY1Djv
         V2vmBJlJC9iuGklE7HP7c43uN/yc78xNFpwbhphI1JZHf2XsxVjyTOmANmXAGAv+EatC
         lB3U7C16Rz826nzASqU/4VBZeevPAGjvKyXjwbl30MADYk0AXn610D0mk0F72fNU7EVz
         Sp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YkS66D2KhkTc0tni03HYE1pCRExjRVUOWUe/sJDevcs=;
        b=iPPLSAVipF70kX1lET6+WhqJOvTAWdTECYfqk5Vpiel3ZLV0iCXbjpH6984GuDo3hz
         5w3WBMZk6DzY08aTgm5fJhsS/fZuX6isvk0hiCErS+wU/lEM3WnZShAbvjJ6E8DnlDSD
         HAZtn7sOPchQVKyNnI9eHkSoAkZtQw0p5flsnQDstIbFGdyIjCGHsoBVWc5vBIUSjHA9
         8luWuZTHllTwzTuLP0pbgpIE90188Sffa0nm5GkoPHg/x3zSPsAYPfsNRU232VnUC7dK
         L2XXTFzARq7Vu8JW3HvZed/QlXbQht8blcGkhWEvC9gzyA3qjV5uhjM9Jk/+1a/V/cbp
         f2Ug==
X-Gm-Message-State: AOAM530OEt/UTzWflGms2M1c9f26ru5Xw+rjYoJl9VojTcM5+GQapDRd
        U4WNjK64Cv0/CXXCiA5VAaxU2CvjOVU=
X-Google-Smtp-Source: ABdhPJxjmPXvu1EAeGjbB1jrtmPWiPeyizL42yVZjRotWf4CVdZl1yAS43G53ln91j5+2H/rVinGKA==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr1508180wrm.75.1590147383664;
        Fri, 22 May 2020 04:36:23 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id u7sm8944121wmm.8.2020.05.22.04.36.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2020 04:36:22 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fix some issues about NVMEM
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
References: <1590133861-25515-1-git-send-email-yangtiezhu@loongson.cn>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f1891be1-ec77-2f73-cbd2-59f92fe66495@linaro.org>
Date:   Fri, 22 May 2020 12:36:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1590133861-25515-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/05/2020 08:50, Tiezhu Yang wrote:
> This patch series is based on the latest Linus' tree.
> 
> Tiezhu Yang (2):
>    nvmem: sprd: Fix return value of sprd_efuse_probe()
>    MAINTAINERS: Add git tree for NVMEM FRAMEWORK
> 
>   MAINTAINERS                | 1 +
>   drivers/nvmem/sprd-efuse.c | 4 ++--
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
Thanks Applied!

--srini
