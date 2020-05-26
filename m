Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B314EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E75420899
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jrdqXp9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgEZMcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 08:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgEZMcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 08:32:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FA2C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 05:32:30 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c71so2945889wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 05:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vCPx6qkjkE87GQ9zi7thXK76HafQnhLa7mqK8w32S30=;
        b=jrdqXp9lUpIatzfYVL+cQoa4ruiktjr8CSsE9h+7UL1IiwRuzXFynNx5aC/qF7JDFa
         yyaeKeUNvHnC7/qVjyO6aoXPVNeeZnNIrSVBccy6AMLyV8slMgVi++ys2abbzRjv9BvT
         etiaY3eBReqaPJUX9038zKU8jhcANuTP/YYKmc+yRvJYOTNwk1vuCxTyvI+3nZL0zaH+
         8mMdKQZ0oOzrun9ioR9EeHyP8bPZpmG0C8DeTYwdj6YEP3qsFcWiuymGjdUw0XXpkKXx
         5/YOoe4kJW3/WotL2f2gGmzcwmYWHgt6rIo3Fd8RyKdXYdNxNXDDVlQRu6GiQqh1WOTo
         sGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vCPx6qkjkE87GQ9zi7thXK76HafQnhLa7mqK8w32S30=;
        b=PLIPssFlX7n20u1dBLgYCYAN15ZBqz1DZMsobrDLeda8Owgohw05dpB69d/T7zFsIO
         E6PUuGnTqbMCbEyTMATsUrncwLHbMICfR8uLpGGHYAxB24I87iDX/IH9jYA+d/Sr5JVX
         xU02GP1kAoqSOpuAzcZ/DtgUEVEDR3/z22Th1d0+O6uxKt2MQaotIKpZEPGXXdoQL1nN
         giyYVYLec5eM/+5j4lcvQf09nQFPGIkWYRWrbtC/3vCCwN5N+iq8jY8QmESjkvTARb1B
         AXuw5l1RLy5Y1+pc3JeE4dqpG4wql3K3O3Ad2zcD3jnkC0RfR9ZVEQWCAesXB7Eh0t6Q
         dDkg==
X-Gm-Message-State: AOAM531FakKB+aINz0H+dlwf27S2EldwRrL/I+ytS5I+1s4LFNQUm1lq
        vHfXEMYv/rY0lN3situVSMilmrKWxD0=
X-Google-Smtp-Source: ABdhPJwEhE6qT7i0uQZ+ESmFPmcPpC2XBvQ2DEcOeE/E0+JCU4q+/iukwgyZQFnboBg2ZmQxIGbtxA==
X-Received: by 2002:a1c:1f85:: with SMTP id f127mr863428wmf.163.1590496349257;
        Tue, 26 May 2020 05:32:29 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:20c0:f1c8:831b:d98f? ([2a01:e34:ed2f:f020:20c0:f1c8:831b:d98f])
        by smtp.googlemail.com with ESMTPSA id d13sm20821509wmb.39.2020.05.26.05.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 05:32:28 -0700 (PDT)
Subject: Re: [PATCH v4] thermal: qoriq: Update the settings for TMUv2
To:     Yuantian Tang <andy.tang@nxp.com>, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200526060212.4118-1-andy.tang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <62609db2-52e6-3982-7241-8b812e024c34@linaro.org>
Date:   Tue, 26 May 2020 14:32:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200526060212.4118-1-andy.tang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2020 08:02, Yuantian Tang wrote:
> For TMU v2, TMSAR registers need to be set properly to get the
> accurate temperature values.
> Also the temperature read needs to be converted to degree Celsius
> since it is in degrees Kelvin.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>

Applied, thanks!




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
