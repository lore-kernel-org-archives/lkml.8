Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA417C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDAE920723
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E27hEDFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404256AbgFXPYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404017AbgFXPYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:24:04 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844FCC061573;
        Wed, 24 Jun 2020 08:24:03 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y13so1483594lfe.9;
        Wed, 24 Jun 2020 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7ouKIzv9lcqviAIR01eC0zUDPcbdP0WKdUxuCP9SSpw=;
        b=E27hEDFRxtZsQruEYVPTKunSsgJg6aALuxPxpQbSwxDRgiJZXbVdVQJKazLD8M5Wjo
         om0KM0Faci6ftvWbxcquMgWXyDdqtOfBWWlErm0YTPMPTa03xNpBHyYwVibyb2Zzo0M2
         lLUKMh7OyfZEu106pZZ0RNyuGDGS/S4uk2L6AOrXY+Jh1/LOzcsft59VuVdAXRCw8/UI
         tcjTk82W9LuJXvGO7esKypzBLAlzPsyTJqqSq9tTMUXUgl0I+StFKkE/jGlxVfZXHQng
         5tBnnQZgaSockOreNNvEUaLFcdjWc5LD4DodWFz7Xw5DP5j7+DI7/+krFCr1JuaAiZiq
         yuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7ouKIzv9lcqviAIR01eC0zUDPcbdP0WKdUxuCP9SSpw=;
        b=a1xGszQOqrl8mVakOWEcsD5EL4zA6M+a1lBNRSGDlhN1ZtNEn7J977PGFWdWNEcChy
         C2H0RyfbGx4IBD+TwwLSbCHqIMcuZV36tDQqO8DlKka3/2UcGuh/07+8KbqFdt5HcHF7
         yQ10H08cHyPhkHu059btIIlVEvYygF5GIuON7ZFkm3i14PD6PxuGjx8tm0qhBQiDnMCX
         cjgUmaGzlg6Daq9gU2cChTBomW3yIR4G6UBPjNtdkhh/WdzoidstvG8tFu8t5wW4Mact
         ktoqEnv1LxUiEgP7HiGWl3w6GnAfmk5G6vUBiEENC94efQioC8L7Nf+7fsrI7VkfGs/W
         d9zQ==
X-Gm-Message-State: AOAM5327AR6hfLXbl9hAnX0jWL9kYGAODVL0L7lKM5YPdhbVfG4rp61m
        R9zSX2HVNWY8ezznqESNhbOKFnuY
X-Google-Smtp-Source: ABdhPJw5CK19plm3sDVgaQZ/FaKkfb0UTJA6gbhs1PnwT7h7YAvOtoMlEmVpoVoZxpLFP0oqUejuXQ==
X-Received: by 2002:ac2:47e7:: with SMTP id b7mr15661708lfp.68.1593012241393;
        Wed, 24 Jun 2020 08:24:01 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id d20sm5262732lfi.22.2020.06.24.08.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:24:00 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Tegra Video Decoder driver power management
 corrections
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200624150847.22672-1-digetx@gmail.com>
 <90323aa6-38b5-0a45-69a7-ccf380690a78@xs4all.nl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <23cbaa18-9461-8f72-3d43-aa14cd0c1095@gmail.com>
Date:   Wed, 24 Jun 2020 18:23:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <90323aa6-38b5-0a45-69a7-ccf380690a78@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.06.2020 18:16, Hans Verkuil пишет:
> On 24/06/2020 17:08, Dmitry Osipenko wrote:
>> Hello,
>>
>> This small series addresses a Runtime PM issue that was discovered during
>> of Tegra VI driver reviewing by balancing RPM usage count on RPM resume
>> failure. Secondly it fixes reboot on some Tegra devices due to bootloader
>> expecting VDE power partition to be ON at the boot time, which wasn't
>> happening in case of a warm re-booting (i.e. by PMC resetting).
> 
> Can you rebase this on top of the media_tree master branch? I think a variant
> of patch 1 has already been applied. I found a mail today where you mentioned
> that you preferred your version (it looks like I missed that) so you'll need to
> rework patch 1.

Hello Hans,

I'll take a look at what patches has been applied, my bad for sending
the v2 too late. Thank you for the heads up!
