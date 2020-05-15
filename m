Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77506C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5E1206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="ifUAfR6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgEOIvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727833AbgEOIvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:51:40 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B703C05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:51:39 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a21so1352750ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E8iSa6ALDqacyJ/a+HRe0nZCH4WvMfQxe+p585lwoJE=;
        b=ifUAfR6z5qzxx2rSJkcgO+arSZPSic63yjaBwBK+DBtdY41jLP1+kSNu7RDNaz6Rz7
         uy8vIdVtQPqR4XjnUdzngajCpDyOrLcnBZI5rmDlAU+NgSr5B0wf/EZtSzP3Yv4XFLRl
         h1DS5lpjBTR4bFDjpUtKXXS0eviDfS0h0/Jg/US9uB+flzv+Fx+D4Gogami8mz7gpaFE
         HDJw6tllwrmoRy5xtniAg5kd9FSAzLnuMqrEKpiJmojLr223NbhFraZnEJo55fc7WOgA
         9powX8lqymWuLCZwl6D8TXwuliU6FPoYuNxvsF2EQLwirxzivoY6nDoYBfeWOcRyyypg
         +a7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E8iSa6ALDqacyJ/a+HRe0nZCH4WvMfQxe+p585lwoJE=;
        b=EF95GBhlmbtNR+HJWPk2m3ONJfgfbk3Ok0KhCepM6viaZ5e9AgE+BXyY/qliZ9Om3d
         UmFw1tuZRxwrUdDC0k1BanbvYcUWgG/akseSk+glidftYqFremjlhPwGeBghESHYiaZF
         79tY2AYgiQbJJfKnORaZOzSHdAzHKkcPzHUFy/4vqdPW7mbCwCiDh1HN9SsGAIU/2vmQ
         Fxe2XUxL6FNz+H76KC6pGKg2g1XCLP/mpBe840X4cE1RtkgRWUsA8g3Eka5TdJUoIbCp
         yz2bZjwp9a23b4Fn+P4F+21EOuNdWvQzWf8gVFaOTdVTaGNWilpZq9G6xvTpzzXm1Zfg
         oXUw==
X-Gm-Message-State: AOAM530wxFff/PAYJYSn9KwbDfE0ZUfxCXIaoj0UnmZ7UvaeGmwLkyVZ
        qvUI2jaqujQfpl3MqcROB9PGxQ==
X-Google-Smtp-Source: ABdhPJy/YvG5iCdqZMV5vnOhHeT1sBeHj6YHDTBZHwNFu044wP6T3JgWzucfB2LxnYJz4S5Zqa3i3g==
X-Received: by 2002:a2e:9455:: with SMTP id o21mr1599107ljh.245.1589532697455;
        Fri, 15 May 2020 01:51:37 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:46b9:e14c:2541:1887:9a5d:d412? ([2a00:1fa0:46b9:e14c:2541:1887:9a5d:d412])
        by smtp.gmail.com with ESMTPSA id x2sm797962ljc.106.2020.05.15.01.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 01:51:36 -0700 (PDT)
Subject: Re: [PATCH 1/2] MIPS: Loongson: Fix fatal error during GPU init
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
References: <1589508901-18077-1-git-send-email-yangtiezhu@loongson.cn>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <1264becb-44aa-9e29-4e67-d1b5fbc0b56c@cogentembedded.com>
Date:   Fri, 15 May 2020 11:51:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1589508901-18077-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 15.05.2020 5:15, Tiezhu Yang wrote:

> When ATI Radeon graphics card has been compiled directly into the kernel
                                ^ driver

> instead of as a module, we should make sure the firmware for the model
> (check available ones in /lib/firmware/radeon) is built-in to the kernel
> as well, otherwise there exists the following fatal error during GPU init,
> change CONFIG_DRM_RADEON=y to CONFIG_DRM_RADEON=m to fix it.
> 
> [    1.900997] [drm] Loading RS780 Microcode
> [    1.905077] radeon 0000:01:05.0: Direct firmware load for radeon/RS780_pfp.bin failed with error -2
> [    1.914140] r600_cp: Failed to load firmware "radeon/RS780_pfp.bin"
> [    1.920405] [drm:r600_init] *ERROR* Failed to load firmware!
> [    1.926069] radeon 0000:01:05.0: Fatal error during GPU init
> [    1.931729] [drm] radeon: finishing device.
> 
> Fixes: 024e6a8b5bb1 ("MIPS: Loongson: Add a Loongson-3 default config file")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
[...]

MBR, Sergei
