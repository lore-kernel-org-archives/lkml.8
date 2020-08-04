Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AF2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D48622B40
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKGudFuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgHDIDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgHDIDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:03:30 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A96C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 01:03:29 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id 88so36443825wrh.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 01:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lTWJ7gUCdoYUMpCmakbmpJnB2wh5StLRShmo1wJgTcU=;
        b=XKGudFuNmqY3dVCyNtfAUCD2YM+3erxnt1etVDnxdn9YM44VZ3blVXMkM69ZOwrcTP
         2J5XiyHtqN0xMjUEyutaDjvfKzoXkp547sIjwFClhvNZtGVSQdXmZgnT36NFmq/sMw8C
         1cBdOZ+9GIB9UpeisRpDxIWkd2mqNJfnMHlnXUJR7xr9flmTqZNbYl3aEDlPa3B05Qyr
         f+mmw5dnbyW8UB3hQucvb4b3gFQc2MRVuEItwZXoMtNSPJhO6stnv+afmk0pJkz68/Ez
         GHsS8GfDHHg57EZ2TWtxwKX8lN08o+MZkOz8KlhEMLrtLr0shp6isDaI7o2z0wHUyB0e
         BEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lTWJ7gUCdoYUMpCmakbmpJnB2wh5StLRShmo1wJgTcU=;
        b=ayYAb5ckWQjJBwc7c5oOu39p6vIJfQMca/k7rkfW3rhLzOpRU8GabnGTkV0cliEyMd
         gzoNv8qd1jHc4MkPTjnTeS61m1nZl8O7UJCSqACS1kV9h0hhATvGXMuhPm83wnsMa+9J
         2ZCyadiS+lZ0QOIqyKYBkdk0uS2MlZEHlO/NaSgcrfAZHhxpuNMQ8M8waUQn9Exy0+cJ
         tjnSegVeB57lcatk5zC/ZxutCnzqo/RruqC70+qosGrmGpX8Mprl0lY6kGTZFTi9w2iN
         wSOc7smQTUNuU6jFNGqcHy8o/eCZEKRDNiS1V+P2aw00R6DJJX/CnPZn+uafgbGGNTln
         SxCQ==
X-Gm-Message-State: AOAM530ZxvjmofiRkxvP1uL2CsQrmsbZ0WZYMz+bCi9btBb+GwBuuccv
        f2TGva1INQXyl0hHTZ7fP1fckw==
X-Google-Smtp-Source: ABdhPJwh8pL7es2JVKKP8i4Y1bD+JgPv01swIBrnvKBJSnhRR9Qcj32oYQyYGZAZw2KkTj0nxENWWA==
X-Received: by 2002:a5d:5086:: with SMTP id a6mr18346090wrt.304.1596528208089;
        Tue, 04 Aug 2020 01:03:28 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:4d35:b6a4:4754:61f2? ([2a01:e34:ed2f:f020:4d35:b6a4:4754:61f2])
        by smtp.googlemail.com with ESMTPSA id z7sm3451793wmk.6.2020.08.04.01.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 01:03:27 -0700 (PDT)
Subject: Re: [GIT PULL] thermal for v5.9-rc1
To:     Zhang Rui <rui.zhang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Colin King <colin.king@canonical.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Henry Yen <henry.yen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>
References: <0b3dd92e-0aa0-6f23-fcef-178f2bf6a1c1@linaro.org>
 <CAHk-=whbPwsdPom8pcJyo7P5KRRjDef_6ZEMbavJy=qArVoqVw@mail.gmail.com>
 <91e715f73a3e9197d4a5f597c7b303284db11ac9.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <559ed41c-5975-2008-566b-6733ea403241@linaro.org>
Date:   Tue, 4 Aug 2020 10:03:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <91e715f73a3e9197d4a5f597c7b303284db11ac9.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2020 08:32, Zhang Rui wrote:

[ ... ]

> There must be something wrong here, Daniel and I are following a strict
> process to make sure that we don't lose any history.
> 
> For this PR, I'm not quite sure what happened, he probably did
> something by mistake when generating it.

Yes, I did something wrong, not sure yet what happened. I'll investigate
before sending a new PR.

Sorry for that.

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
