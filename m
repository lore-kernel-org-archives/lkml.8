Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F70C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 02:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5804720774
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 02:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="nCRjBy6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgGICW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgGICW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 22:22:26 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224ECC08C5CE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 19:22:26 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id r8so682212oij.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 19:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DRE+AnxDTPA67RRsyblsDnMJP7GCjkB5PLB0tWpdoQE=;
        b=nCRjBy6rCZO4tPcusHqvk8I+q8WHCq+AFq8rirKjSah3x23m7XVXGu+vNcFW92y9y7
         xEhpHOfRp6MpBnynd88ykJtbWvcflOLOnsyQWNTRsMqI1CaqRtcF0EnByTqUhJ8sQ8NQ
         o25Hd8Nz0k8StgQqM7qU9DzS36rrlze9fWOx6SKlUeKXvI5a0kTfjChPAzqA7AvGciKv
         GV1xFmOHR6xgXdIVx1mk8jQIyTZIwiphkIwY+k0YJaOlWcUgURjjdHKT4iQhbD0KnWJZ
         wqySEbUIeroyGlYU2KpcCkrPrhgA6L+7SFD12PLRIs1M8dz3Eyb+x19TnUz1EyYzSgpZ
         pAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DRE+AnxDTPA67RRsyblsDnMJP7GCjkB5PLB0tWpdoQE=;
        b=DIpvUKf5gxKYbOWmkxgkcnBCJZAR2g2Mmdxfp9cAH9dj1QmpiEivUdRKLb8tmZcCGW
         Iv5pKw8kIoM60g8lha22kadnpcVqVhf7Uuwd3Ot3BEznEvS+jdrqQ59qfuVmIp+s6fW2
         MIh408pDKomPKsHI58WVr18pgGnogORtkrj3jh8tQE+d5PlsL6IRx7kVT15F+y3b+laj
         7kpr9Hl8iNj5hHLyu0gYohrnVLe3krBGr4HEp7An+jXrxnPs987BQmtrDDNDc+Qn8VE7
         A27NlwArqxwqaQVbH8LGukAlSuQWlN2bbupGYQ5z9G7Gt6wkVAMnLhxqNaKJM5Tfv+oY
         5yNg==
X-Gm-Message-State: AOAM5303IL4di56JvURv3xYwJFhw5gzYTax1uEpg7AY6UVOzIG6o3WLY
        te6kzr0EGsXZyn2+aW7GANBmTQ==
X-Google-Smtp-Source: ABdhPJzZ3KYDuqCl2pBVz6ZKWW75HF5fDGCk1N4x5FT6TuFs7kUO2+NXH3DohJjIcwdkm+vq6Qbhew==
X-Received: by 2002:aca:3307:: with SMTP id z7mr6660836oiz.171.1594261345319;
        Wed, 08 Jul 2020 19:22:25 -0700 (PDT)
Received: from Steevs-MBP.hackershack.net (cpe-173-175-113-3.satx.res.rr.com. [173.175.113.3])
        by smtp.gmail.com with ESMTPSA id r19sm290459otn.28.2020.07.08.19.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 19:22:24 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845: Add cpu OPP tables
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, saravanak@google.com,
        dianders@chromium.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, robdclark@chromium.org
References: <20200702204643.25785-1-sibis@codeaurora.org>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <a61c5656-e21f-f071-1149-a3357fe2684e@kali.org>
Date:   Wed, 8 Jul 2020 21:22:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200702204643.25785-1-sibis@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/2/20 3:46 PM, Sibi Sankar wrote:
> Add OPP tables required to scale DDR/L3 per freq-domain on SDM845 SoCs.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---


Hi Sibi,


Bjorn asked me to give this patch a whirl, and I have to say, I like it
but I'm not sure if I'm missing a dependency somewhere...


In 5.8.0-rc4, I'm seeing a couple probe defers

[    0.131341] cpu cpu0: _allocate_opp_table: Error finding interconnect
paths: -517

[    0.132694] cpu cpu4: _allocate_opp_table: Error finding interconnect
paths: -517

And then a bit later on,

[    0.625837] cpu cpu0: failed to get clock: -2


If these aren't anything to worry about, you can throw my Tested-by on

Tested-by: Steev Klimaszewski <steev@kali.org>

