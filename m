Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2816CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE39520692
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T8mPr/gR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgDIOsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:48:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36887 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgDIOsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:48:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so12257143wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HYmlK0W0gB1RNgMfwFCbFrXo9v4YOOiFd6qMt5ytL4Y=;
        b=T8mPr/gRVyyDK3eA20QB/OWR11cvu1aKOQGFpAGtT7qvjvjd3kRBGP+N3F/uPwc1JO
         YiXlAWc8X1tUVkM14LyQepIvSrI/giiZN1pvDw3dcd2RJ39x5q4cRwNCQ2kE87cIVmD1
         hW5IYGk5/dVBK4gXZ9vUtLSwOVyeJS6Rl4ptgfO5odfSpQCSzAZs1H1Bok4HMIHxncao
         C/R3d7sf4TbUgvtMzdIFcOW0kEtlohr60MMaxEy/BmvF5Z2KDfodOJLbya+M5b8Nqnwy
         bREop1HN9f0vHUly9ta9NjU9oQ2uTAaH5Q+fQgcIalYD3aPovNKS9t9Euj/6ZJK38vCW
         vmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HYmlK0W0gB1RNgMfwFCbFrXo9v4YOOiFd6qMt5ytL4Y=;
        b=YN49xLJSMMAV7fjcTgE8Z+7lpisA4hwHWied84HLnSLBuc1gAZvQyZW56P/ALEE4Kc
         PI4GCFaTqPuODB60Qr1lwCiQqBIUSFW00aO5Ook1dxXLMP8HJDB4f5lDd0GFg6ahPz9p
         Yid/IzJkbFkJH14DQGYJvuXLaUvUL+yuY63tuMgizyLSBOM34MoOEt0pDlQzcS1gJ8B0
         l83x5wBcV2nTEcvWotPkdxu9rSEuMSucWfLvJBAyK2pUPuZgj51Mz2EvpWbzv0rOsln7
         CdxxUeWn+AzyM6lgK/xDKw+i0iTX4rJbsW0RNSUK7xem1yLDEKRA9h8mccCMN0LRnEE3
         103Q==
X-Gm-Message-State: AGi0Puazsy3hmV2A2YAm0OArVrkBY3CbjoI+WoVkVt4aNTAk8Qt4IniZ
        gMYCQznXPsIP7EcOmP4XbFDWFA==
X-Google-Smtp-Source: APiQypJmJuYQlk8+ou0FMKHdNWId62VqEgmm0EGHTfau2iXTN5VxEVLxkXuova3ZZbnKrt83shczJw==
X-Received: by 2002:a5d:4f08:: with SMTP id c8mr15115888wru.27.1586443682154;
        Thu, 09 Apr 2020 07:48:02 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:4e:2ab3:ef46:7bda? ([2a01:e34:ed2f:f020:4e:2ab3:ef46:7bda])
        by smtp.googlemail.com with ESMTPSA id q9sm22696791wrp.61.2020.04.09.07.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 07:48:01 -0700 (PDT)
Subject: Re: [PATCH] clocksource: davinci: axe a pointless __GFP_NOFAIL
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200409101226.15432-1-christophe.jaillet@wanadoo.fr>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e1ea1f7b-d5f6-d6bf-52da-32f2d3de7793@linaro.org>
Date:   Thu, 9 Apr 2020 16:48:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200409101226.15432-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2020 12:12, Christophe JAILLET wrote:
> There is no need to specify __GFP_NOFAIL when allocating memory here, so
> axe it.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied, thanks
-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
