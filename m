Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F58C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE31206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iI4wNU1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgHXJev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgHXJeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:34:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32519C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 02:34:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id p17so2283716wrj.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 02:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oQFrC1o3Nda9YLxSbgopWEOdNnQxrkWudyF2nTbVXVU=;
        b=iI4wNU1gyMDP3WOfbrMsV5PNzotxiKE+bg3HG4dL4ZNpFQ5QXR1VjF7EaZVhqM5pbR
         /apqB/5NXnbQO/3QcPmJa2ymAJrRdh3q+VNx0a0WUjVrqorgAvwGbIygf/nWdu0FJnlR
         2VF43WNvEHWPrUMPWGcStgXCXrQu0Wt4FMh6t/B7KsM4x98lcwZjW40VVfETqRVT7u+B
         YNLoQECf0W2p2wXdHaMUWqr7ZK7KKqGr2dI98GzCd0Gk03gAkK+va2bB9KNnzETyhrA4
         SKMppU9b3ulLFxpyUTLBv1CO7H+HQ/8rLi1gdJkfeb+dDWshGrYd+KTB+cB2lMYgNSoL
         4qeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQFrC1o3Nda9YLxSbgopWEOdNnQxrkWudyF2nTbVXVU=;
        b=eZavSEE9WycvU4wP5q63FQiUJJQlCk+erFXy9xpMCPr/TECFLrJGnjoioDo0pSrBNw
         5dJ84x+8nCuEOlGJ+8i3qQJ+H261UsY9x8WWvpxqiE+bOA9BTZ7LCjbR6Tybr8D6CvdT
         9/nK3JjF+u3oRDn0NYXtpXDR3IDqUjR4mDpynZ1dOZKOlDlUtr99jQQDARdE/+udA0iT
         uEPlYImhCk0AXFBTU3NnCD82qF39zvoxKVyZ3KuaXJkey2ZNHjdys8vpjaIEPDzPIxba
         O7X/7+OB6n8ujR3CmvA3KnWXpp6stcM7I8fSIkAA26rNh0zhDPuUevBP9t/0OjZqqwkH
         sc/A==
X-Gm-Message-State: AOAM532CyjUrsLGIkHIFSVHk1Y2wlUOJ/tDQvxA58C4j2FT+Cg6kKtcn
        RZ+85qRMRwDhV+ICYoR/YYwNfnQf06adUw==
X-Google-Smtp-Source: ABdhPJzfp+hZthOM0E1QMoXJyd50y7e6J2eC0nSOR2g0GL2084Jm9DgaEpMukZ1glzmBjUeTo56zoQ==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr5231552wru.95.1598261663543;
        Mon, 24 Aug 2020 02:34:23 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0? ([2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0])
        by smtp.googlemail.com with ESMTPSA id y17sm5682961wma.17.2020.08.24.02.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 02:34:23 -0700 (PDT)
Subject: Re: [PATCH v2] thermal: core: Fix use-after-free in
 thermal_zone_device_unregister()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200817235854.26816-1-digetx@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <84ecfc78-bbe7-b4e0-a815-46b6225eca09@linaro.org>
Date:   Mon, 24 Aug 2020 11:34:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817235854.26816-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2020 01:58, Dmitry Osipenko wrote:
> The user-after-free bug in thermal_zone_device_unregister() is reported by
> KASAN. It happens because struct thermal_zone_device is released during of
> device_unregister() invocation, and hence the "tz" variable shouldn't be
> touched by thermal_notify_tz_delete(tz->id).
> 
> Fixes: 55cdf0a283b8 ("thermal: core: Add notifications call in the framework")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Applied, thanks !


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
