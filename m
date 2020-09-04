Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A245EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7478520658
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftfZAHug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgIDJZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgIDJZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:25:33 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FBDC061244;
        Fri,  4 Sep 2020 02:25:32 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r13so7188235ljm.0;
        Fri, 04 Sep 2020 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RCJmz8PLP7hXKfBzjCeWIiTbbCJYi+VO2+xNjQI3lSU=;
        b=ftfZAHugz2CGL895C3fv4NA4l/doePgchmsZ1Xsjt2y/1+zGTQjwnz4xSizJUtyeJQ
         Mk2IJYpJai0+qqW51hYzP3pgmdx084oUl0uwKvD7Bxvt+ANiui2eebCTyNm6Z2A5EhUw
         5Tb32WEODUjHvjxiL54fM/R3l52bLzQeOKE0tFjAVC//uahR7g0rQNjwZSGA8TfudfNO
         3XDd62x7lusGFOPt8Y5B9Ng8pHl8RtB+kM1FKhQ7+X8bCg8ZWuyFPgUuBdR9rE7HtpdB
         TWOGiE8AcJKx/K7tQblkGipxSwy8jQ/gBOag0yqpDxmK+6QHIhd7hHQuztHhQ0XMS0UQ
         OuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RCJmz8PLP7hXKfBzjCeWIiTbbCJYi+VO2+xNjQI3lSU=;
        b=Q1flLK8w9jR/VCd5ucbXDaYfKYz+MfvRJY128Lr9iCBICYj14E+OoYRoJxRSldI63T
         vsg9mzBJEsnY1npbu2XhALp97bYRvSeDcToRVSQeBhiX+90uUEkJ4g2EMa46jnh7sn80
         NGPrwh4vRm5gxHKXy18o4KcxVLqRCq2OJFf5j9+DlmW0LglJJaFykmCeiT+2J7MrY02F
         S8WvIiFwYVpPo8P7k6vhFacpAhA+7gnxH5uu9NqbfCtHr4jrq4tklMY932ixY49Fq4bH
         H7I0J3ccPURu8qSo2whsWxpQxPBXCRyTT3nNN9DoGNcY5WUZmPAHExEBZvwS2sG5g9Vw
         eVNg==
X-Gm-Message-State: AOAM530WO7JXjbZoNaEbT8VIJL45Ytz+D1E+0ol1ZvlMGMRXm4itx+I8
        UADqi0DZx3ePoBFrF2BJV/wHH42IRsQ=
X-Google-Smtp-Source: ABdhPJxjILUUcRrw5CkbbO/HIjRh4yEWY0HDqYXVLLlHym2nQUUrrkOu9eMNqL5VKFhKjRvRvc9YGw==
X-Received: by 2002:a2e:b52c:: with SMTP id z12mr3152562ljm.437.1599211530961;
        Fri, 04 Sep 2020 02:25:30 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id 15sm205394lfl.38.2020.09.04.02.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 02:25:30 -0700 (PDT)
Subject: Re: [PATCH RESEND v3] iommu/tegra-smmu: Add missing locks around
 mapping operations
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200814162252.31965-1-digetx@gmail.com>
 <20200904090519.GF6714@8bytes.org>
 <9f7b042e-db46-dd5b-acb8-9b1e8213fa62@gmail.com>
Message-ID: <bdfb799d-65c5-fb04-68a3-5884d1c31d2c@gmail.com>
Date:   Fri, 4 Sep 2020 12:25:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9f7b042e-db46-dd5b-acb8-9b1e8213fa62@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.09.2020 12:19, Dmitry Osipenko пишет:
> 04.09.2020 12:05, Joerg Roedel пишет:
>> On Fri, Aug 14, 2020 at 07:22:52PM +0300, Dmitry Osipenko wrote:
>>> The mapping operations of the Tegra SMMU driver are subjected to a race
>>> condition issues because SMMU Address Space isn't allocated and freed
>>> atomically, while it should be. This patch makes the mapping operations
>>> atomic, it fixes an accidentally released Host1x Address Space problem
>>> which happens while running multiple graphics tests in parallel on
>>> Tegra30, i.e. by having multiple threads racing with each other in the
>>> Host1x's submission and completion code paths, performing IOVA mappings
>>> and unmappings in parallel.
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>
>> Thierry, does this change look good to you?
>>
> 
> Hello Joerg and Thierry,
> 
> Please take into account that there is a v5 now that I sent out a day
> ago, it's more optimized version and supports both atomic and non-atomic
> GFP flags for the mapping operation.
> 

https://patchwork.ozlabs.org/project/linux-tegra/patch/20200901203730.27865-1-digetx@gmail.com/
