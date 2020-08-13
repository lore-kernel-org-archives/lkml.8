Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5D7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C32720658
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsOWri+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgHMRCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMRCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:02:24 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D760EC061757;
        Thu, 13 Aug 2020 10:02:23 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i92so4488303pje.0;
        Thu, 13 Aug 2020 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Vk3YdyPwM3Yi0T3RlnCgnVEkxm4LoiWvkWBDsVzMi+0=;
        b=gsOWri+jhqUMqyoCo/wkFxKHCoNcGQ0HTMCp4DSpccDASDWpiLZnG+AzyP/Z6N7LUg
         2N/Sr/5oLGA8wP2rgBHGCWqNGfchIVYOKdpTTjcJwFy4YMkW1h/4bp5kKG3IW7oUJ8cC
         2EBG9TBbtRTYHSfAO7XqNsvMqGglujqXkX5TLJdpFuiq3L7r+51gBs5PinF7grnVp4Hv
         5U6BCiXRzRu65yTsGYJUmHni62zVDgwIgGgZI6CAU1LQgsy6EZDUTqN3dCg2L5LZ2DIG
         od76HPwvOsnXNN4a+veVYp8OO3YZeFOX1i5JqZV5F7TVEQemGVBtv3g3lwQUA3y7+RTm
         uZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vk3YdyPwM3Yi0T3RlnCgnVEkxm4LoiWvkWBDsVzMi+0=;
        b=VBQPXY9aRgkO8cNaHMVjDxcUWS82RGPzKRnwAhYvcmM5V8PSG5zfHcTwOCRoIoCPxc
         cJzPepQglREuyns8xwAQ+R9JKJ7W36bcH0M1LLuVFhYst1OXlKwq2vD2M7wyi1MDVgMG
         gKcQ+mcdmyKivFEY4tldfJDbxOG0rxXOnZOqr1AgYkN/pj0k+4j9Vg01+2o7OJrlGIQO
         9hNyi1zlfitWHI9SMePktOlRcgLHUy+u3GTWJl/wohXhQRtbbmyo82DHJRJPrdo57b+R
         R3U8J2KOJ4Chi4iP4vX02Nd1ynXxZrXasRfQY6W4SlJrrIYwOCg4km9dKn3u13xA9L+4
         ImFw==
X-Gm-Message-State: AOAM5324db/hgFct1QLiBsvoGDgSXVGC0HiZLCQOkX/C/j5XPKRiep6H
        SZ73QZ0EERVafxOSzqXKiuXL5MHx
X-Google-Smtp-Source: ABdhPJyFAAabzjqYglNu+cnpdGfKWfmVb19azt7tnUERKZdwazE0f19Jh8uf2kAz6pXKhG+fm6mGuQ==
X-Received: by 2002:a17:90a:a10c:: with SMTP id s12mr6144794pjp.32.1597338143039;
        Thu, 13 Aug 2020 10:02:23 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i185sm6270943pgd.28.2020.08.13.10.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 10:02:22 -0700 (PDT)
Subject: Re: [PATCH 06/14] mips: bmips: add BCM6362 irq definitions
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        robh+dt@kernel.org, tsbogend@alpha.franken.de,
        jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200812063129.361862-1-noltari@gmail.com>
 <20200812063129.361862-7-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <67e35ffa-e9a2-d391-6255-0d56e5d0c249@gmail.com>
Date:   Thu, 13 Aug 2020 10:02:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200812063129.361862-7-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2020 11:31 PM, Álvaro Fernández Rojas wrote:
> Add header with BCM6362 definitions in order to be able to include it from
> device tree files.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
