Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A065C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483C02073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1RvLKNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgGUKRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGUKRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:17:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F7AC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:17:12 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so2255500wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Bl3XIfXLjah4oPLTL/rDwdpYDwZ3/9YGgHZMl8zqpLA=;
        b=L1RvLKNqtxs6nWiVoFNg7xichLnVL9Lw3ZKE0k6yBdT/h/bZSuUjuNni35i5O+T0wX
         hqWkOEcklsePlmH06tF2lai3NWe0NMjpCEPFYtiqRQOeGdIOzwlvUIHmMMCVLHQcG+pl
         EPHj4l00LRIcJrkcjr3sg+qPq3wjU7VAABRN0xVdtHiV+yETGHhP09DmQHGNXTNItqRw
         Wf38K8gqyd6DE4EObx8W201R6UdLtP19Qn4vBHLs2h1Mmrq4bc/8FieHxRNjvaU6EBP9
         WyWnbBxtC5js/1G51fWbyPja+pMNFlbQc0UBS9hhuu5iT/frnPqiFChyfAv1JPDIcoAb
         MRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bl3XIfXLjah4oPLTL/rDwdpYDwZ3/9YGgHZMl8zqpLA=;
        b=LrYsdCiOga+96ZRoWd02oLWLVmvM8jNk4sHaJshYEY0VXfdJty3AhqIf5dxeKM7Khr
         +mq5lllXlvIpO2cK0jxFpbLFtN/lRMTVo2uCKb6y9OwU/5iS4ACuSeOG2lkFJ4L8m9Uu
         QSSnQdxJ5+oQ6ZjHYbnJvpYj49/5z8Hn//TZQBf3V6VFio0681jfvG9afvxVAoUx2cYc
         McF5No+gjaitAZo17kECszYtoTpi1d5D5I7ofP9aezGQ1YnAKvGdxKkCTpeA38iVlB/+
         TcM3qtENQ5FYqyOYPO21g94AQJg6MbdIZ2ozY5G0Hip69F4W11LqtHfjz9/r6gxb0Wkn
         xVqQ==
X-Gm-Message-State: AOAM531SyH2LIWWe1lxHZXLwqLq9W27b667JxXR7UWuthQvPnjxqJ7PZ
        45XbatMndAWI0b6jb3LS4zi8zg==
X-Google-Smtp-Source: ABdhPJzaSOzBg/P/7Wo8uh3IBjKdlBxyt8Ncn2NlVZKOs8h2lFF2aYdaM13WWnx7mJ8ljvT5Y/hECg==
X-Received: by 2002:a1c:e088:: with SMTP id x130mr3252719wmg.14.1595326630904;
        Tue, 21 Jul 2020 03:17:10 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:3590:b402:869a:11fc? ([2a01:e34:ed2f:f020:3590:b402:869a:11fc])
        by smtp.googlemail.com with ESMTPSA id w12sm39791729wrm.79.2020.07.21.03.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 03:17:10 -0700 (PDT)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: CLOCKSOURCE,
 CLOCKEVENT DRIVERS
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20200708165856.15322-1-grandmaster@al2klimov.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f84744cb-92a3-a731-732f-996bd556ae87@linaro.org>
Date:   Tue, 21 Jul 2020 12:17:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708165856.15322-1-grandmaster@al2klimov.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2020 18:58, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---

Applied, thanks



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
