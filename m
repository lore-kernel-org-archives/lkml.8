Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B14C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7EB2145D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGpSh21a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgIIJPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIIJPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:15:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3751C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 02:15:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id o8so2454335ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 02:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jDSk/EIH8mKSIyGf3zG1fsxE4diyBZAwuCGQRHuI3J0=;
        b=BGpSh21a1/60PSgwZY3nWxGFYkAX/T5H72uTm4YSIZUFCiu9/E17Jh8xfq+aWbrB/O
         iGhuQftUFN4STpGsbfCW7HIkF7Sdwm8jP8zkkvp7sn7ddYMbPgeMOhCznfJYRHx5JreY
         rcuTBnrFCSXEOUCRg1woJ/XazEYNc6+qVYfzBTp2ngOwlAF8aztNtAcIob3y9hO0Lw+b
         ZpUuN0d2O4ukD9ar9uKlrEqToyeQoWjqdnmSPaRsWyT8DrZr8Tg1UxFOF7C68pAoWZQ2
         BcWHCH6FIjItD2vlRtAoN6natpKwQuyRK+xOusSOwVBofKPj+PcgDZ7HhGc0WzOOQRXx
         Qm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jDSk/EIH8mKSIyGf3zG1fsxE4diyBZAwuCGQRHuI3J0=;
        b=g0bKkReFEqSyCLByfiUSCNYQt2aSIU2OLEbut13uI9qeDJ5p2lN0wxPhxuo95yARaw
         +BaU2cnJGRpe02I+pJc0eooALrT0gmJ0L2n0R+Fx1GfoktfmtvYerTTYbbs58cCKW0ha
         asl+7ySXXHOSB756ljwT7Vbonb8pM3UAFgtAwcoAg25qmG9tlZuTt1Ua8djGE+0bYAjE
         s9zvD9Be9TxdYOWf7rf8NahEgunoxlmYowiXThvhay/N/kRIy/c+FH4ru8LMC0DgWENv
         oEk3uth4DnSQWujDXv1PFUxv5i3e4S3l5ob1Dn4K1vzijEY3ASswmBWa6z/QBdCwuwmv
         mz4g==
X-Gm-Message-State: AOAM531RnSaaEg8KiNvRZBeAeH1RsP3nCOfQfwI0EVspuf50uWJHn63Z
        lzTH0h9hYaMK0lGkhTRuReg=
X-Google-Smtp-Source: ABdhPJxyKPj+7/wSjBwIusGihPJN9H/gzj0p77AiIFrRIVcxrfuAdH6fQnmUNif+vRDUxM2dd8x3yA==
X-Received: by 2002:a17:906:4cd6:: with SMTP id q22mr2615078ejt.139.1599642913384;
        Wed, 09 Sep 2020 02:15:13 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id t6sm1456158ejc.40.2020.09.09.02.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 02:15:12 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [REGRESSION][BISECTED] 5.9-rc4 disables console on radeon
To:     Mikael Pettersson <mikpelinux@gmail.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <CAM43=SOCs699z9E1EK3EG8BCJFw_9veWa7xWOEokvwj01NVS6Q@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d207de12-3143-1243-bcff-b4ccbfb32b92@gmail.com>
Date:   Wed, 9 Sep 2020 11:15:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAM43=SOCs699z9E1EK3EG8BCJFw_9veWa7xWOEokvwj01NVS6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, that is an already known issue.

We are most likely going to revert the patch ASAP.

Christian.

Am 08.09.20 um 18:27 schrieb Mikael Pettersson:
> Starting with linux-5.9-rc4, the Dell monitor on my desktop PC goes
> black during boot
> when the kernel activates the framebuffer console, except for this
> error message shown
> in the center of the screen:
>
> "Dell U2412M
>   The current input timing is not supported by the monitor display. Please
>   change your input timing to 1920x1200@60Hz or any other monitor
>   listed timing as per the monitor specifications.
>   <DVI symbol>"
>
> The monitor remains black until I reboot.
>
> All kernels up to and including 5.9-rc3 were Ok.  A git bisect identified
>
> # first bad commit: [fc8c70526bd30733ea8667adb8b8ffebea30a8ed]
> drm/radeon: Prefer lower feedback dividers
>
> as the culprit, and reverting that from -rc4 makes the console work again.
>
> Adding a bit of debugging code to that function shows:
>
> avivo_get_fb_ref_div: fb_div_new 136 fb_div_old 137
> avivo_get_fb_ref_div: fb_div_new 142 fb_div_old 143
> avivo_get_fb_ref_div: fb_div_new 136 fb_div_old 137
> avivo_get_fb_ref_div: fb_div_new 119 fb_div_old 120
> avivo_get_fb_ref_div: fb_div_new 136 fb_div_old 137
>
> during boot, where "new" is what the commit above changed the code to compute,
> and "old" is the value computed by the working code from rc3.
>
> The graphics card is a Radeon HD6450 silent model:
> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Caicos [Radeon HD 6450/7450/8450 / R5 230 OEM] (prog-if 00
> [VGA controller])
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

