Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F47DC47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1AE620661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcIp0AXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgD3Q7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725844AbgD3Q7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:59:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3671C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:59:12 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s20so2453745plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hwGqgGwwB9mPVayN4b5su/w3uXsvH2gdunBCVAd4MCg=;
        b=hcIp0AXr/ZahEGNIzMgMbqmcUHyN341Pn5LtLgQpx7OK27r1oAAghfky5DimHYafmH
         kcDT5Wqj0OJODdzRZmYYNxLq5sI4IzLwjIV5AXLJy1AIPm8fvI0R3EWFYvTHnRpDjO6J
         hry61LHgTMo0qKRZdakZaEVfPM7dHeH0VSO2DCKiHbdgIli9wZs9Rl4Z6DLZMKP/iUn3
         ONZ2A6aHS5VbbLu4Vvbi1mqH47kOxcRu5nhxc83x5oeqtp+6JKCoycw9EkQRXbWUQZzF
         DtYs8tqJsU60huyDrJTU8xejaqv6mNvvivQcpy//9UpAtqMFIHGroNsuX/jVo8U3jb+6
         Plhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hwGqgGwwB9mPVayN4b5su/w3uXsvH2gdunBCVAd4MCg=;
        b=laHUa3UJgPeIidqd6SInWf0LzJA89W/owgCrts0qw7nrV/Y6JfeIHNORLjv5ChcQ2y
         T+6e9j2pyJ55kaeEqtkkpmqVZ8Ql497sTnEE+mC6dtjMk0KXOMkLkkxZ1YLzeFqn0fYS
         6H6selZ1qviwp7yEsyJxQ8ajYz2pNFaj9mL0WfylXFd34zIfbT92q8DQqAfu6V3hM8YJ
         o/OJY8A0dzljaV3tRl1qfEKbQYvSW3P4/dTE3LcgPYbYuoijnwD1NFVq5UhmQUR3cEAk
         bzT9nXa6jIClwRSZ8+CCqYwzE63syRKZbxSXbwIaYnpGqIea0wrlZh/vqG2qD5oPIywp
         u8fA==
X-Gm-Message-State: AGi0PuaVS0FHvtEJHZKLphqCYfzCMcR3ImuoOXAaJw6+lfxZBmlySYdi
        N9ueOeXqpMXkxZRgTpQsOxb53q57ESfn
X-Google-Smtp-Source: APiQypKkaJ21qAK4MkGOn2i+edwZ7cTLUiWJudrLtgR66MlWkb370GPdVgGz5Yz96qpk6BFCe/+9lg==
X-Received: by 2002:a17:90a:2606:: with SMTP id l6mr3704884pje.188.1588265952448;
        Thu, 30 Apr 2020 09:59:12 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6081:946c:419e:a71:7237:1613])
        by smtp.gmail.com with ESMTPSA id x4sm293207pfj.76.2020.04.30.09.59.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Apr 2020 09:59:11 -0700 (PDT)
Date:   Thu, 30 Apr 2020 22:29:06 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] bus: mhi: core: Fix typo in comment
Message-ID: <20200430165906.GG9449@Mani-XPS-13-9360>
References: <1588003153-13139-1-git-send-email-jhugo@codeaurora.org>
 <1588003153-13139-5-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588003153-13139-5-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 09:59:11AM -0600, Jeffrey Hugo wrote:
> There is a typo - "runtimet" should be "runtime".  Fix it.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  include/linux/mhi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index 225a03a..effa172 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -339,7 +339,7 @@ struct mhi_controller_config {
>   * @wake_put: CB function to de-assert device wake (optional)
>   * @wake_toggle: CB function to assert and de-assert device wake (optional)
>   * @runtime_get: CB function to controller runtime resume (required)
> - * @runtimet_put: CB function to decrement pm usage (required)
> + * @runtime_put: CB function to decrement pm usage (required)
>   * @map_single: CB function to create TRE buffer
>   * @unmap_single: CB function to destroy TRE buffer
>   * @read_reg: Read a MHI register via the physical link (required)
> -- 
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
