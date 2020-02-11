Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A865C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBE82082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcviG1/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbgBKTGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:06:10 -0500
Received: from mail-yw1-f46.google.com ([209.85.161.46]:46432 "EHLO
        mail-yw1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbgBKTGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:06:09 -0500
Received: by mail-yw1-f46.google.com with SMTP id z141so5683043ywd.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 11:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wPdyB8BXraQOD7tLtMr9ZV817UwsVe3LQShrz9AB71o=;
        b=hcviG1/qorx7l4xH40ZtuRYm2w+B4cOpjR68es00EDjvVqtgKLGTMp2tWDQpxurDSP
         B2tcidAOREXJ9g+9tnplWkUnE5PqcH/1Pwjk6J1ybG1r3+ZapTsYc0/p7CRZ2CMEFvci
         gsLFkVJjDaR6SATkziFS3Kw5aLXZIPzbiVZ01nDpLHIxXdor2e9PXVo49LyE4nV6B2jI
         NN/CVR7/rhSWKG1QzTDHQwWxeOAuRDelG1lSrSLoLK48sDXhqJPw7B7QSAntf/s1SeOn
         GzAFSvu1GZdKPKWFQUVffJSllZ0lruxX1XgAWHQrUfsoGAn12KxdWf0R7isqwYxBiSYY
         H5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wPdyB8BXraQOD7tLtMr9ZV817UwsVe3LQShrz9AB71o=;
        b=F6pogeqdrq0CQbqLKNdRBBYgE/8yuo+7dVileP9Dn5kqhri0NONuCKjb2mHHAI9h2t
         VK7z4uAVzk19RmEHgCzPLCOBLQcoRCW4PQKVjR3C8kHTten24Mt28jnacQqlhHfCguKZ
         +V1M3L9MeQ+ifoUxJx4rw9zxavWvS/7TAjfel0ssUq7ktoDshe3NgicYwRwnZtIh9UCK
         hiZG73wUSXqIeE5r+kALbCPkajDkvLANjN+k2qaNjY5LOhm2Jmu9X2IAq1rfFe1QdqRj
         eapH6MvkzImMFjNpcum45i+KiAArd2rhewtBeJq31m0dwr4v7wtBW27s1Smpg7mIV+e+
         KoZA==
X-Gm-Message-State: APjAAAUfpbeiINWWpyJrtXPGAPS797V+6SJGaKSDqJ17TyGq8elUI4CX
        ea3oZKY0WmU8wWEXO0r4gHc=
X-Google-Smtp-Source: APXvYqyrbf0Yi0My9AVtmvvXRiHg+YhKUVB+wqHwXuqkiygW0m3qa3XX1OCLmDSfhL6EsR/P1W3kDw==
X-Received: by 2002:a81:50d6:: with SMTP id e205mr6470075ywb.208.1581447967258;
        Tue, 11 Feb 2020 11:06:07 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id b73sm2281079ywe.28.2020.02.11.11.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 11:06:06 -0800 (PST)
Subject: Re: build error: f7655d42fcee drm/edid: Add CTA-861-G modes with VIC
 >= 193
From:   Frank Rowand <frowand.list@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <4e918a35-dbcd-b2fd-1888-a86e7d448128@gmail.com>
Message-ID: <3e5d7142-cacc-6830-94d3-f57ef18592d9@gmail.com>
Date:   Tue, 11 Feb 2020 13:06:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4e918a35-dbcd-b2fd-1888-a86e7d448128@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/20 12:48 PM, Frank Rowand wrote:
> I am getting a kernel build error at version 5.6-rc1:
> 
> drivers/gpu/drm/drm_edid.c: In function 'cea_mode_alternate_timings':
> drivers/gpu/drm/drm_edid.c:3275:2: error: call to '__compiletime_assert_3282' declared with attribute error: BUILD_BUG_ON failed: cea_mode_for_vic(8)->vtotal != 262 || cea_mode_for_vic(9)->vtotal != 262 || cea_mode_for_vic(12)->vtotal != 262 || cea_mode_for_vic(13)->vtotal != 262 || cea_mode_for_vic(23)->vtotal != 312 || cea_mode_for_vic(24)->vtotal != 312 || cea_mode_for_vic(27)->vtotal != 312 || cea_mode_for_vic(28)->vtotal != 312
> make[4]: *** [drivers/gpu/drm/drm_edid.o] Error 1
> 
> 
> Kernel configuration:
>   make qcom_defconfig
> 
>   (arch/arm/configs/qcom_defconfig)
> 
> 
> Compiler is arm-eabi-gcc 4.6.x
> 
> 
> The build error goes away if I revert:
> 
>    f7655d42fcee drm/edid: Add CTA-861-G modes with VIC >= 193

I did not actually revert f7655d42fcee from 5.6-rc1.  I checked out the commit
before f7655d42fcee and was able to build the kernel.  Then I checked out
f7655d42fcee and the build failed in the same manner as at 5.6-rc1.

Simply reverting f7655d42fcee at 5.6-rc1 does not result in a buildable
kernel due to other related changes.

-Frank

> 
> 
> The build error also goes away if I comment out the two lines added to cea_mode_for_vic():
> 
>  	if (vic >= 193 && vic < 193 + ARRAY_SIZE(edid_cea_modes_193))
>  		return &edid_cea_modes_193[vic - 193];
> 
> 
> -Frank
> 

