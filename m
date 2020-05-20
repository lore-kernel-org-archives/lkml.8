Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C37C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1ACB207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlEtHzbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgETJDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 05:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETJDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 05:03:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3277C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 02:03:13 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u1so1813311wmn.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 02:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fe1y1P3KuNT27Xt1HIe0Tg/h4Eje3e3b/mEovm8Unro=;
        b=QlEtHzbVimMMdRXvv73kp2w+o5F6H4x1sYU4+rH6GgixXkylmS5m0rHB2BHbyZBEZx
         0GtVnuEklagqyysOmxpPMSD0LeVgnX1oaVcFSJDBEYFvEDbV6hUYrkslZtkdSJyQ/3iH
         kMroLkNP/SJZVYZ+NGzgLmlhZRPgFCmcEMdCaAlJjgpWrOwTd8YxV1Jmju312HOhXBdF
         AyNwBYoneT8mQtAO1ua93Hkmx0GBjGDp1SxM6/6nQJ0boi38STs1J03mJe6eLjdpw2U4
         rfKvY7eIva/MyhLLij0THeiDFlM0DbjXnTtPYzdH9+ePTKrMB/2qFYETRQHp691sIqs5
         /lIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fe1y1P3KuNT27Xt1HIe0Tg/h4Eje3e3b/mEovm8Unro=;
        b=pg95F6LziAOuO6vhTTLfa/OngkKkUVlLSR7QSufGikfhwQMaFkObPH2J0EN9bUUvgN
         Rtqusya+04gJNgY2Ol60VKyGdiP++lew/HpYxJmKc4rTXpqMw/coOBrGrU8uqkznYiWa
         yg6vJ4bkxysJRdnpjJBEnRSdSTl5NdzY6+oLgrOmxuT7uEyAWaJP8SQaJF1Y0YdcAgFA
         fkzAgrNpcfSsc9rcXfdL7SqSq6uTzlTqsP/BLBwR6LKD8TgUQIGf/3szyyPSyRX9p2lH
         0XsvbVkmclmN5I9z3Nt5M3pT7pmf7EhyHl+LfCZ4QmiLeN9ZLNyAGglvIFFHiFJYCWlI
         oANA==
X-Gm-Message-State: AOAM533rfecVSi9LML0KAQ8mvjUO576geJwiEJ2b+cW3VDQbI67Ch0LV
        LjnIUNWGfuiYbvbWuxxD0bmhr9wNKMY=
X-Google-Smtp-Source: ABdhPJw9c4b0FEt51IGNxa1OVFTu4fGFAjKQqnYYgQj9H43HxMbDDt1wTz7bJ12iotKnqA/WDSczSQ==
X-Received: by 2002:a1c:1b0d:: with SMTP id b13mr3869519wmb.171.1589965392202;
        Wed, 20 May 2020 02:03:12 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:f9a0:30c:ec6c:7971? ([2a01:e34:ed2f:f020:f9a0:30c:ec6c:7971])
        by smtp.googlemail.com with ESMTPSA id w82sm2389150wmg.28.2020.05.20.02.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 02:03:11 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Do one override clock
 parent in prepare()
To:     Tony Lindgren <tony@atomide.com>, Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Suman Anna <s-anna@ti.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200427172831.16546-1-lokeshvutla@ti.com>
 <20200428182209.GT37466@atomide.com> <20200505180734.GN37466@atomide.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4d279416-64bb-822f-2783-a7aca7e03877@linaro.org>
Date:   Wed, 20 May 2020 11:03:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505180734.GN37466@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2020 20:07, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [200428 18:23]:
>> * Lokesh Vutla <lokeshvutla@ti.com> [200427 17:29]:
>>> omap_dm_timer_prepare() is setting up the parent 32KHz clock. This
>>> prepare() gets called by request_timer in the client's driver. Because of
>>> this, the timer clock parent that is set with assigned-clock-parent is being
>>> overwritten. So drop this default setting of parent in prepare().
>>>
>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>
>> This works just fine for me but depends on the dts changes.
>>
>> Daniel, for merging, do you want to set up an immutable branch
>> for the related dts change and this? I'm afraid it will conflict
>> with the related systimer changes for the dts otherwise.
> 
> So I've pushed out an immutable branch for the dts changes
> this patch depends on against v5.7-rc1 as omap-for-v5.8/dt-timer
> [0][1].
> 
> Daniel feel free to merge it in to apply this clocksource patch if
> no more comments:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> [0] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git omap-for-v5.8/dt-timer
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v5.8/dt-timer

Merged and patch applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
