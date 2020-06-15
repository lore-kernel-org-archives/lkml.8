Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4065FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BDD52078A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5Q4JjF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbgFOQcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbgFOQcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:32:16 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD16C061A0E;
        Mon, 15 Jun 2020 09:32:16 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d27so5354290lfq.5;
        Mon, 15 Jun 2020 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fMk2WCiKFI7HDNUd7jyJvNehAsaSBC9pPNifu9uuF5E=;
        b=e5Q4JjF9w+dM6qvdisFCw4sw574hVWyf3FxAuI24lHOW0+Ub5IUR90+zuw7eG1Q2Vs
         hbeyrdLAnUTx8Da0wb02cCcEJi6w69J1s4QG7/jkLBCDBG1JTxVk5vGjMZBuM6kHkFx/
         xNeulklIAuTMicpF1E0ZMT07sjoR9IW1n2hF/fAG1GZ45/6Xa4Vc65YTNlUpwV2XpybO
         gIdibt2xwWLkPD7Fdmd7WSGBtTXT6SlMztlfQBwYuckX0NDc9YYnirK8Svh3XDBHmmm3
         iXZ1nEL9KCkJvK3oW9IyovqyWILjMW2pkHrlgnq/r5WR3ATVMNPPoXipM/aXlCXZhrn+
         wqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fMk2WCiKFI7HDNUd7jyJvNehAsaSBC9pPNifu9uuF5E=;
        b=TyNERCYH3wPTdA/s63hccScDXUuvNhMSi23OSndFnJEAeROxnHRyq9Ijv0yrUPXnM0
         +wLNubcjixL8osooxDWMYCOvy1jEl+cVGi6cbc9ET7nBYB/I2dUGhrfg+Q6JEB7f7rKb
         GHUDrV6azmtqEXWc6szdi8ppAnav1I5y8drjdF06R3gE7756Klot8AhFLs8NdCO6Ywnp
         3HP2tsPQW0XZAEBoypniMH8kFSlhsesHP8uDhJ5nUMgTF6V2EF/F3uqmBJtI1RzcB83K
         gNuNjov6KjGJXzkkScAxMFGeIfqnlxbLSakAQXJvZbmKcetEN9V4DrgDoZE98ydscxLG
         hAKw==
X-Gm-Message-State: AOAM530EQP4CfmulrHCSLEoClYmGixlm/8e10JJO0iBTPb0BquAshsmA
        A+cZYQS/I0YUdcwGT1j5RqSEiwXI
X-Google-Smtp-Source: ABdhPJz+g/xw+V5R8UknOJ0K9sfrwk4Ecr0W8o/gGvlvEGKkiqDGbUonmPvCse3iEffPw5EH41jd3g==
X-Received: by 2002:ac2:5cd1:: with SMTP id f17mr13196552lfq.4.1592238734394;
        Mon, 15 Jun 2020 09:32:14 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id k1sm4662630lja.27.2020.06.15.09.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 09:32:13 -0700 (PDT)
Subject: Re: [PATCH v2] iommu/tegra-smmu: Add missing locks around mapping
 operations
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200525195437.14341-1-digetx@gmail.com>
Message-ID: <efe29e0d-5dbe-f6fa-2c4c-f8248c9aad29@gmail.com>
Date:   Mon, 15 Jun 2020 19:32:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525195437.14341-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.05.2020 22:54, Dmitry Osipenko пишет:
> The mapping operations of the Tegra SMMU driver are subjected to a race
> condition issues because SMMU Address Space isn't allocated and freed
> atomically, while it should be. This patch makes the mapping operations
> atomic, it fixes an accidentally released Host1x Address Space problem
> which happens while running multiple graphics tests in parallel on
> Tegra30, i.e. by having multiple threads racing with each other in the
> Host1x's submission and completion code paths, performing IOVA mappings
> and unmappings in parallel.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v2: - Now using mutex instead of spinlock.
> 
>     - The _locked postfix is replaced with the underscores prefix.
> 

Hello Thierry and Joerg!

Guys, are you okay with the v2 variant? Will be great if we could fix
the issue ASAP since it's quite unpleasant. Thanks in advance!
