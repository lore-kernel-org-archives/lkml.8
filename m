Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97424C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 07:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4BF20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 07:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZEwp7zsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgEKHlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 03:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgEKHlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 03:41:25 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3761C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 00:41:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g14so6135656wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 00:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hseT4o3e+iJvKvlfPpNLzXEPteR4GO6bBd3Kzf2HHZM=;
        b=ZEwp7zsvc6V/NaIZ350pitGQRs0EMYP8K6a8+IIsELLZ5AAzsHB965S9ZDCWNaBym7
         5XimvrLLj3O6IYOPThMbNl+vsJeoxSHtkg9a7L7brMoaPPIE+obGgZRFUILa5sHqPCaj
         /jQ7/bLYVucXsb/mw/GQMCjzy0T/LtXC2C4n6QYiKkAz2Cdk7nEYEX3O/u9fqwMKRz/t
         3Kxr/WZw5aFxC+9CmrXKhv9AguMA/PVIGdSWh8lG7dOZ4fHttZW9BdpR2NjP6bP1Wlij
         TcZENsfPqxRIXZ0PsT5O3xTRsqA4+zpH2SRfzop9QS8dU00cSN8SS7ts7PHaWglWD9wu
         BMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hseT4o3e+iJvKvlfPpNLzXEPteR4GO6bBd3Kzf2HHZM=;
        b=H30rz91TQN0/MhI881U6HDZ7e+6hrqgMQYy/p271zzXwyxgWk84o2EeZOFKLeULCLS
         UqsRcZexBdqFWy3dMlxUK9TMjdFVODtH8rJI9WI2bJGDi/1yr2GMlfMHRLMwt0hXQiIw
         f+US85nwBLSFmIQ3xVkVTWeNzwg0T/pRKen7ED0TB/k8qI2hk/39nqZfsJ5FkYJacP30
         ybl7fwbD6SqkYda3WKxhfK64ERxec7LPTbVwHViQ8NZQDvVYqi9RLIkqEYBUBnRY/mf3
         rE3SK77sTeQ8fZCBhvxyR9+bipSD+VHqrkQjN2k2wrjO+/HiR4ozaYyZSIEeUraBqURy
         Immw==
X-Gm-Message-State: AGi0PuYLxqRIgzfnBkSgB6u2c4AblNxrRmxScB/yW6pDzaQwV/EvdQl4
        GP4P2DSDGsXuAw/++HZkav2yLA==
X-Google-Smtp-Source: APiQypKV+Y/OjUeg8G20v03d/FoUTGa1xDhXfJWs1qQga0pjoK9gYLJRg52leg1oMHXQf3UY3BC8EQ==
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr30057659wmh.39.1589182882327;
        Mon, 11 May 2020 00:41:22 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id y70sm26799304wmc.36.2020.05.11.00.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 00:41:21 -0700 (PDT)
Date:   Mon, 11 May 2020 08:41:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: max77620: Use single-byte writes on MAX77620
Message-ID: <20200511074120.GB3548@dell>
References: <20200417170913.2552327-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200417170913.2552327-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020, Thierry Reding wrote:

> From: Thierry Reding <treding@nvidia.com>
> 
> The MAX77620 doesn't support bulk writes, so make sure the regmap code
> breaks bulk writes into multiple single-byte writes.
> 
> Note that this is mostly cosmetic because currently only the RTC sub-
> driver uses bulk writes and the RTC driver ends up using a different
> regmap on the MAX77620 anyway. However, it seems like a good idea to
> make this change now in order to avoid running into issues if bulk
> writes are ever used by other sub-drivers sometime down the road.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mfd/max77620.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
