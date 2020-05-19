Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DD7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93AEA20829
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZZrY/6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgESXZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 19:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgESXZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 19:25:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298A8C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:25:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id w64so1002045wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qxIrWzKndId5M02rldluZtVI7y5X3L/VGh+mHmelStw=;
        b=bZZrY/6tnWofgWh1MVFkN2oZF55QFsh6vsmWfPfWynoox7tKL3JPfxFjowkszeHgPx
         1JVy3ftg9oXLAPKDUz8BulIDv4k5i2acYWPg3e/Nn68uarVz3TxdSIZkSOBrSxhw+CfS
         9ZL02L9Fb8mqZWxt5DbkYgNo5beZkAPW853nWPV53ATfqgrfSXlfwEKdjcHbTnn0uNQ2
         HklkmdipI/ikgP6Z8bD5VsxYA9ZlTlwT+37fCvqDWwXcPnYZY0LoCWHOu6SsI4OHJ4wd
         3Cw95kgQ1AeHVIGYjWGB4jsw5ccBVlGOlvfl/P27ncyY07XQ9CWRavUrQU9zdVIPGMUg
         se1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qxIrWzKndId5M02rldluZtVI7y5X3L/VGh+mHmelStw=;
        b=RNa3LH5qZ69gTsvzNOQSeru5ff6eD/1PY6xB4X1nkOzbYqz4uB1FfcbpkS+DZuPY9U
         qKRymJ+VfaQ85/X4pEV0RTAeFisG/Ibfcfc0VyfA3ej6j/0GTVXemfSwPz4FMt8bQ5DL
         ednzGrFdXEc1Foend4oKPCX1evxsOKnY/o7TBGvk8J1dY3hIA5elHej6Vvq6VyZqzUCm
         54gZrquMw948bw29rvDFDvJmPqhX4vsCvbhwpBKv98LUPcnvdJJOmKZuKn5PHcTOvuLk
         cShzDZSb4OzwIrZvZgMTXSouxn5/4PHbkzMXuYBD+bUo5xA56GNfhVNFmSC82JE5O3WI
         9wbQ==
X-Gm-Message-State: AOAM531S7Uzz/vJDj1PK3GEus45GurCpQkkz1ENAcBcQwBdqsELJLTaa
        Iz8vjSK5mGEFmYOocxQW0GojUASfyIc=
X-Google-Smtp-Source: ABdhPJwVz5iNSn8vvVkwnZdoEnwfRvCEGJGZnX/iunolwoitoPT3eaDCdu53wzgC5+x5WDnoxG6miw==
X-Received: by 2002:a1c:7d02:: with SMTP id y2mr267408wmc.92.1589930749374;
        Tue, 19 May 2020 16:25:49 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e504:4297:986:ffb0? ([2a01:e34:ed2f:f020:e504:4297:986:ffb0])
        by smtp.googlemail.com with ESMTPSA id v19sm898944wml.43.2020.05.19.16.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 16:25:48 -0700 (PDT)
Subject: Re: [PATCH][next] clocksource/drivers/timer-ti-dm: fix spelling
 mistake "detectt" -> "detect"
To:     Colin King <colin.king@canonical.com>,
        Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200519224428.6195-1-colin.king@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <61864ba7-e3f3-8156-d133-9baa5f9138bc@linaro.org>
Date:   Wed, 20 May 2020 01:25:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519224428.6195-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2020 00:44, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a pr_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
