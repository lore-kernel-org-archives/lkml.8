Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55783C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC2820760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im5l+vpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGHHtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGHHtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:49:50 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAC3C08C5DC;
        Wed,  8 Jul 2020 00:49:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q7so39771244ljm.1;
        Wed, 08 Jul 2020 00:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FUTB6Gj5NIh2r6okp5YAqa694OkQrnNvKWiwMgZTNfY=;
        b=im5l+vpBXfSW+5v/TNVzMl36mq15su47KPUzHMFSTBTMSApucZOiueGMRS7z/iEmzy
         WPdWdBsI/N8fEjYnyT/gjixkdrxPo/6sMR0qyt0GMvkPSUDOzq8ehzinKFyipyYV1IOz
         DQChFnxdM5IY8rhgklEjnGnkMIeB5YNjeNMhllJ+l3Jp30DYGUkOE8aZLRBbOwUK9eB0
         1x6V51vtvYk0EwwpwhHQMOVD2P2d0tA9mCCWSMyIXBMkvLSb4Kz9V/uLFz/6yZDyhwk0
         NRDzDrFtfmZYctLbG17z74M189pyg2lwAQF3NBcC85oYJUEEnvMhxmGeh1cz54vJY0wb
         WKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FUTB6Gj5NIh2r6okp5YAqa694OkQrnNvKWiwMgZTNfY=;
        b=I6R8K4Xx9XNreBLNw7A3SKW4Qc17lBgAvm/FBT8GysKPsnTqjzCD8xcOQQz32efLMG
         h5wEvs+TcImVVlxRvE8lpN2Z/AC0CCD0dI+EOaKAwlqMwv6AOBhvR/Ogp/SjK3NxUHUK
         ILS7zyhAMfBSRDCUz53TwYeP5Ynrg1MXmZLApU4VYlGICmRWZ1b6QaQouu9Yk9XLR3kP
         /PvZMAewC0PEAxwUUFt3O1gW3Uu6/zj/Ji2/FieSbg9cvwQS+vqGclYHKrlz49eNQ6Z4
         VEfVAYV/q+HMzt0pDyFCmmrkRey/jb8CXmp86eTaUPX1ncUs9kGHVanbvEziiMRuzffL
         FUqw==
X-Gm-Message-State: AOAM533vG0y6oRSPCzc9bRLH9ooWOovCc6JD8RbXyGGFTEk4sIhJtEDI
        QnCjDQV8Y/T28+sXcT+sNVNYjpp2
X-Google-Smtp-Source: ABdhPJx6G982NPkYWEBvtVzULmONwk412bm0ahtXQBXpo7eh8PZW0660IfxNiznHIoCWlVzi6KmTuQ==
X-Received: by 2002:a2e:9dc6:: with SMTP id x6mr25059652ljj.94.1594194588695;
        Wed, 08 Jul 2020 00:49:48 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-105.pppoe.mtu-net.ru. [91.79.162.105])
        by smtp.googlemail.com with ESMTPSA id o1sm10129343lfi.92.2020.07.08.00.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 00:49:48 -0700 (PDT)
Subject: Re: [PATCH v2] clk: tegra: pll: Improve PLLM enable-state detection
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200708074628.18173-1-digetx@gmail.com>
Message-ID: <e9579336-cb9f-c266-cc6f-5ea877539db2@gmail.com>
Date:   Wed, 8 Jul 2020 10:49:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200708074628.18173-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.07.2020 10:46, Dmitry Osipenko пишет:
> -	return val & PLL_BASE_ENABLE ? 1 : 0;
> +	return val & PLL_BASE_ENABLE;

This was unintended change that caught my eve only after sending out the
email, woops :) Please let me make a v3 shortly.
