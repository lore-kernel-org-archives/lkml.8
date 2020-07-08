Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E288C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0EA20786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f8+Arc7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgGHPYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbgGHPYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:24:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941B1C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 08:24:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so3666650wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 08:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fAMDttktLNm65/wtDUXVk462N86zqjpRDjFGxdYbu50=;
        b=f8+Arc7rJ2DfVyTdbbbLpv27Kcrhid0WoXzvqJdG8s43yrm7sLcs/o19Ywml+1yPgI
         wCaoSuCxam/gTKcTD3vHy4FA00JgdM49Gmw2Pfl7A3Fcv/r67gPImsmX0BGL3/fQ8Rmq
         XjGwVSN0Pf0O9kksUxZr1LlQ8vA7ZTzXbkgHiWap9K9a9DH1R3jEbLZeHthbMS1RO5Oq
         ds/H86jJTV4rmxrlVrT0qvAcQSmsRnVgx107x+FhhQO6oToPmYE6iJRnjxrXR5maSBDd
         gR94QP18BZGx1SJYnvzdYPTqrkf+8iWoxB3+MlZquWZYEDVc5GZdzsFPz3+/B52B0kW2
         COrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fAMDttktLNm65/wtDUXVk462N86zqjpRDjFGxdYbu50=;
        b=dSHu/TCkj9ppzpPdmnaUHU9erfcyCXU4fiy11kZkav3r3CoN5LD+YShtjOGBTjYIBK
         vpKo7bq2ih4dr++4LJ8SBVTpmE/Qsc78i2vgRKttXD0R7QwrEJnjpj5NTGIJ9VtofXYU
         WSpD5asmuNTfszCpdtt1Y5FikQYwgHiyfRlsU4Lt6y5GcXnl54YWbFgjEMPsJJy6cyk6
         HVnu6UaLLYK9SPYFSq8VOpj8ZR5XLw5xniqJZOppo1pII4NaaG3s49kuTzfvH8sqTbvH
         sJ29sn+4BE983RZlvhcM/fvf8/4Qp9XJDIJZ8szCEgX5Pi0wZ9Jau0Jl8Rc9ouxDANGx
         qoLw==
X-Gm-Message-State: AOAM5326BpS6AZiE2iaimUTAnNl/tsunsfWfGfG70tCOPKxWMOIJprBb
        Siz8P8UM5kyPpW18eLJUznc9Mw==
X-Google-Smtp-Source: ABdhPJw/r3+t2K7aS1cKCKbzuHi+yWjnHnjOWYjedwLDxDngF8Gh/yz8+05gMSropxdp6GCb8jV2pw==
X-Received: by 2002:a1c:4846:: with SMTP id v67mr10437789wma.175.1594221879388;
        Wed, 08 Jul 2020 08:24:39 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id w128sm176395wmb.19.2020.07.08.08.24.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 08:24:38 -0700 (PDT)
Subject: Re: [PATCH 00/11] ASoC: qdsp6: add gapless compressed audio support
To:     Mark Brown <broonie@kernel.org>
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200708133244.GP4655@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3c922807-52c7-ab87-01aa-58fb6f718b2e@linaro.org>
Date:   Wed, 8 Jul 2020 16:24:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200708133244.GP4655@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/07/2020 14:32, Mark Brown wrote:
> On Tue, Jul 07, 2020 at 05:36:30PM +0100, Srinivas Kandagatla wrote:
> 
>> Along with this there are few trivial changes which I thought are necessary!
> 
> It's better to split stuff like this out of the series, or put it near
> the start after any fixes if other things depend on it.  That way it can
> progress without getting caught up with the rest of the series and the
> series gets smaller and more focused.
> 
Thanks, I will split the cleanup stuff and send it as separate set!

--srini
