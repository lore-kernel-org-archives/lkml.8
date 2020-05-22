Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03127C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4AED20738
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ir6xPMv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgEVQte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgEVQtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:49:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17974C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:49:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w7so10753131wre.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CHmt5En+DFO/DuBHKWsIxBf0v+xGme/FyBgyiiEFXXs=;
        b=Ir6xPMv9mrnspy3tVQXUJZtsY3vGrInCmlHrvQktRVS8HdjNwmhztgnzWKN3kEEQNK
         45gbMbWW89VWRfHJS71ORURcXjtguVKtmsZg3vjQZaulCx++nEKPBPO3UJ7tHi/x32n3
         xePjXyNVu80hEp1ibwJ8/J/+t7/NEP1h6lMd5MDasnAeJx5Bz3KXdK8gZZCnW8iUMav/
         ENqNO4J2RYDWboR535xH9HSh2nHAk10pRpPlVo6JK1mJ6IJ9KStSIwl6hJ+qi+Ao7f16
         3DfSqE7ZI8qoR1aYsed6kqOOredsgU6sjf8yaIa3VAYC5Tsv31TnzinHTVYDa5bBhSG4
         WMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CHmt5En+DFO/DuBHKWsIxBf0v+xGme/FyBgyiiEFXXs=;
        b=hyfIaCXpxAWEg370l14vfmoagUWUmPGFEiqthRDqkDxBeDwHMkmrtZQnqaAcD/RSgo
         aWlHT4C8yjgum3wap0Vd9nnoTwOsVyVvWaBu+gVk0bS4s74nKpyY8/UO452Zq3zTPbCi
         i069zm4VNZGcj0ozgQx6wg/WyfhBw1Nq3bWGUxMnEYu/whz/hnnVqCmNqBX24FxJwdvq
         PeZdUKu/b9yiy2vy8YLYdBgmShV+mk0kFLIpyhpbNEIW2nuVfQlWVQAIH2olyBYeFMq/
         rNV1mYHFhF0a1NV7KYYrXt1qdaKGPILtGSGCuPbl/V7wtoq+5Bqklz1IdD3pJPGm2N6B
         htDg==
X-Gm-Message-State: AOAM5309awsrnP4etX6pYtkESr1rA4bgvvPZIvoNy3I3ywMwpi2+c0JW
        rqyDy5gyXzLHQMNERb2ujcbYyw==
X-Google-Smtp-Source: ABdhPJyq1cxtEc5HKwBxuhAsQAlPiFMzVMQB8y7RX31DLlCEjUdWW54j7m4nsSoZhC+Ye3nryhPyXQ==
X-Received: by 2002:adf:9f48:: with SMTP id f8mr4094993wrg.228.1590166171626;
        Fri, 22 May 2020 09:49:31 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a82f:eaec:3c49:875a? ([2a01:e34:ed2f:f020:a82f:eaec:3c49:875a])
        by smtp.googlemail.com with ESMTPSA id p1sm1549793wrx.44.2020.05.22.09.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 09:49:31 -0700 (PDT)
Subject: Re: [PATCH 00/14] thermal core include cleanups
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
References: <cover.1589199124.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2c065bae-06a5-e63c-4e01-be62dabe8890@linaro.org>
Date:   Fri, 22 May 2020 18:49:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1589199124.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2020 14:24, Amit Kucheria wrote:
> I noticed some remnants from when thermal core could be modular. While
> cleaning that up, I fixed up the includes to be sorted alphabetically and
> included export.h in files that were using EXPORT_SYMBOL* or THIS_MODULE
> while at the same time removing inclusion of module.h from core files.
> 
> Finally, the names of the source files for the governors and core have some
> inconsistencies and the last couple of patches rename them.
> 
> Build and boot tested on some ARM boards.

Series applied, thanks !

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
