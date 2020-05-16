Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5131C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 20:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A89206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 20:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HTrLGCcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgEPU3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 16:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726422AbgEPU3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 16:29:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB0EC05BD09
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 13:29:07 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id z15so5247698pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 13:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SdBLRP65Ocj9233FayPxmRnKz5JpCqqs+uVfKTWKdAE=;
        b=HTrLGCcUAunZh86I5B0lD97wRgaG7rIxkyJKmnt8RdxkceTWSMzdiYi6p444j8xl1H
         +jjopNHSDIGw+T3JXarjhcmVmNE++hNxyPIr3aQfCY6iGLJALTNRK33qlHHwZbPVlWJq
         MwUeoNnCloXm0R+c4chY0DiSZfgaw/qgeA6xLDryvYYvGBGMt8ehLwcbO7sR3u23KhjX
         BuW0iGgS/bkJeOOZyV9auFiRCOkr34I6ZRutrIywKsMEnGscmf54PWfa4cL/fsOAPd6u
         TgDUfa3AXEmH6I3NOoSlXWui2vCh1V0VVVFxqIp41ws47fJij5D18e/hwoRCalI8Ex20
         huRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SdBLRP65Ocj9233FayPxmRnKz5JpCqqs+uVfKTWKdAE=;
        b=qJ+edraPVLSlv8Da/lIY72HxNYWxysxnpjStqE0/to5DHt0LfEmJzOc9JetFI/RbKa
         /91DCmMcjhWZyTjR1vYH8tSM6KmXgcvWNLxGW2q8IEhk4AfZM6SdxxacOjHDICYE9N/0
         pp2dhU15mV+vzOOrRghAsCbgI8RCp6s7oQXDZSErha1ytZrU0ADgwYgkMfzEQaj5DQFZ
         nPnsEVMVLORPQUJyW22VAJWWnxwrrIxnZyZMudRXVvrFO3rEVAc9eGZs1CbIOrpcLQMw
         5c0rivc49QIL1P0vH1C9oWc+yZGJOmb8FicVx9DYRXQYxXwdMRaNhYYHJzr5L1O2skI3
         BYrQ==
X-Gm-Message-State: AOAM5312HCo9UsAU/gQjJctsg0V+1hyYe6V3MJfb/6gld0r97L1B2Bzc
        upxT7MVMbdYfV0v1cXbJsq7YCHLojs0=
X-Google-Smtp-Source: ABdhPJxre/hOwbSb74nUSAAqja4UBRpAJupgdssAxISUSWAqUNwMUQJXJfd7fu1XrnnJxvFoM1mScg==
X-Received: by 2002:a17:90a:a591:: with SMTP id b17mr10705933pjq.90.1589660946169;
        Sat, 16 May 2020 13:29:06 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:41fd:9201:9a30:5f75? ([2605:e000:100e:8c61:41fd:9201:9a30:5f75])
        by smtp.gmail.com with ESMTPSA id q9sm4718613pff.62.2020.05.16.13.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 13:29:05 -0700 (PDT)
Subject: Re: [PATCH] drivers: block: use set_current_state macro
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200507071211.15709-1-vulab@iscas.ac.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3d94f908-b3c6-12ce-24b2-47c5e481a1d4@kernel.dk>
Date:   Sat, 16 May 2020 14:29:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507071211.15709-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/20 1:12 AM, Xu Wang wrote:
> Use set_current_state macro instead of current->state = TASK_RUNNING.

Applied, thanks.

-- 
Jens Axboe

