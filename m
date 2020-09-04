Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EC8C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2A320770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZN8SVwAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgIDJUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbgIDJUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:20:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55A2C061244;
        Fri,  4 Sep 2020 02:19:58 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w3so7104020ljo.5;
        Fri, 04 Sep 2020 02:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uratX28Mxl9/lGwuq+H8AvPcnvgdYTTOzgJnH3Evmiw=;
        b=ZN8SVwAzwCv5aAkw942KG/DUK4ZVxzqxD87UFYHEc5IrQY1Ubn27Pxai6GFj70e2e4
         kV3FSfVF1dohd9a2vKW10yzxOgPjPRnGQ0C21K14Otx1VoqyybKqDvqxjLsVbJXV2R8q
         Z2XW7nChKYavnxy8h/vUJ5SDA42YFhyA57mvHGRT92veSyUrRVO/HCOpqkM1RWoamuen
         TO/19TfRngmIx1S0vQ8Cs1Ii2Ox03FUmO5uWGJUo1qu0g9eoDbwd/2CP1Vii8qMew5/l
         u8AazwA9Gm1h5U3ZxtnaWBdM64vPNoYJ+aOvgYxf/6o37Tv2bLpEMQWlC2fhr4ZQA1m2
         /rJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uratX28Mxl9/lGwuq+H8AvPcnvgdYTTOzgJnH3Evmiw=;
        b=mM0Oxpbo2B4q6u2OvLw2/Hj6UaTI9Tiqn1gyONquITQxknizCDcTXn/hf5gdeomtyI
         UoOVSPQYtbfesLDfbjVWObkvQ08VREH0MemykjMRbcthfyLGojYFot+RNwEKHx9YWxhM
         CV+azL1Oq3au0adF9iqe2uuGhX8Ml6PkCW1mvhTQ47ekczFw5EwVAGr1ayUlH9j3xoNc
         zpY2XmRW/vYIhQUskFCxgX+6KTZrTLB4kUYPr2QLbGmGOcnMcY5DTF0HweGTM1bIRcNw
         8vWOQkvU+QGAsRBSL8E4KXJl9HVFDgOgISAYzTAkFdq7kY5UvzhxHSXVtPC6d9cBIAjY
         N+KQ==
X-Gm-Message-State: AOAM532v3zFxVWxBOsA+pM6jng5fk2fzr7B+u/SkC8hXDUFoMscL/2nI
        4VTn2PVbndtadGLQtHnscOxGI5qaJsY=
X-Google-Smtp-Source: ABdhPJxcqOpdnKHFFAnaqeTyqOU+SdC4HwFZQfHee7jyhxo2CLcFF9WkZLkuU7g3cZ/cdIRs+aVvZg==
X-Received: by 2002:a2e:b008:: with SMTP id y8mr3023302ljk.421.1599211196950;
        Fri, 04 Sep 2020 02:19:56 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id 201sm1158663ljf.75.2020.09.04.02.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 02:19:56 -0700 (PDT)
Subject: Re: [PATCH RESEND v3] iommu/tegra-smmu: Add missing locks around
 mapping operations
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200814162252.31965-1-digetx@gmail.com>
 <20200904090519.GF6714@8bytes.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9f7b042e-db46-dd5b-acb8-9b1e8213fa62@gmail.com>
Date:   Fri, 4 Sep 2020 12:19:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904090519.GF6714@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.09.2020 12:05, Joerg Roedel пишет:
> On Fri, Aug 14, 2020 at 07:22:52PM +0300, Dmitry Osipenko wrote:
>> The mapping operations of the Tegra SMMU driver are subjected to a race
>> condition issues because SMMU Address Space isn't allocated and freed
>> atomically, while it should be. This patch makes the mapping operations
>> atomic, it fixes an accidentally released Host1x Address Space problem
>> which happens while running multiple graphics tests in parallel on
>> Tegra30, i.e. by having multiple threads racing with each other in the
>> Host1x's submission and completion code paths, performing IOVA mappings
>> and unmappings in parallel.
>>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Thierry, does this change look good to you?
> 

Hello Joerg and Thierry,

Please take into account that there is a v5 now that I sent out a day
ago, it's more optimized version and supports both atomic and non-atomic
GFP flags for the mapping operation.
