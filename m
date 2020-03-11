Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A2CC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F126020736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpR821mE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgCKOzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:55:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45367 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbgCKOzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:55:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id m9so2986944wro.12;
        Wed, 11 Mar 2020 07:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=T6dhYyYvJS/8Bl4FjnByulc+SHG/kFSfXU5KSrYTgvo=;
        b=YpR821mEYGSQYCAJdxDmyyX1QVwPDu7Rb+v0SpjUUf77rpGL4EX+ni4S+CA2f5Ddd4
         Tn6GVumWKMkc+KSE4/YRS9Bh9EXH07aq1OGbWacOITIjyrgjPKWp5s8QtRFCtElId6ap
         loh9EfaNtUHKS0cARkPlOA5W3ZvPDVQe4YKYApAG4RFW2sO+D4lojIESO+ye4U8YfB0U
         OA7UmdyO96F/KOBzabiUxreqyVAmzi4lLfGFxNyETOZu5z/8kdcwLFq4eTsGGz3FN+Qt
         Zq9+pswIm00N4KRxKmDlZZouEd/pvKvXEVr3JS3V9AZ8rQJlOaDRPFtcDijkVtvYv9mf
         QLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=T6dhYyYvJS/8Bl4FjnByulc+SHG/kFSfXU5KSrYTgvo=;
        b=NRgBx/07bnOHz1vHwnZ+kpO/r8pxWqonrmp0/7Zeto4BTzspdNp8ak/Qi8Bp7TcY2g
         MIg18Kvpn5TiwrTahqCXFVta0L6LqRW3nIBkJA0zu5X7Du1a5YWxdBl0Wb29wCXbOhik
         lz0/W4erX0UXGZI5YIU1d9JbBCjCaEX/kWAK3XoTYBQzxxq1n2kBzivvFdRt2eaX+tO5
         Sc3kJNOgRlYtBIx8gML8EqzVuts5jFcM/qWJeFR1wuVFcEAFy+piNLa1Lvi26m1gO/gf
         3hkMdG2SQxKDBaJvoAzyMxTskxbK15yODxoX/HReFyHQ+2u30VOYgaY+5ykwaH1laeiX
         AVfA==
X-Gm-Message-State: ANhLgQ0otppPNH6iaySJc1mwqZLFwurqxlKIRKgMvpxflAMqzwBMPQ8F
        kDqZ6FauZ3+L9iyGDCCiqF4=
X-Google-Smtp-Source: ADFU+vs4BWU2lMGWUFQMXyBURcsQiYdsefcfXhTiCwDFmuMlBP9RvmVVDzc5UzvPBDK9q9P6PpDWBQ==
X-Received: by 2002:adf:a506:: with SMTP id i6mr4636282wrb.146.1583938503671;
        Wed, 11 Mar 2020 07:55:03 -0700 (PDT)
Received: from wambui.local ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id i7sm56001662wro.87.2020.03.11.07.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 07:55:02 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
X-Google-Original-From: Wambui Karuga <wambui@wambui>
Date:   Wed, 11 Mar 2020 17:54:46 +0300 (EAT)
To:     Thierry Reding <thierry.reding@gmail.com>
cc:     Wambui Karuga <wambui.karugax@gmail.com>, daniel@ffwll.ch,
        airlied@linux.ie, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 10/21] drm/tegra: remove checks for debugfs functions
 return value
In-Reply-To: <20200311143753.GC494173@ulmo>
Message-ID: <alpine.LNX.2.21.99999.375.2003111750360.14786@wambui>
References: <20200227120232.19413-1-wambui.karugax@gmail.com> <20200227120232.19413-11-wambui.karugax@gmail.com> <20200311143753.GC494173@ulmo>
User-Agent: Alpine 2.21.99999 (LNX 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Thierry,

On Wed, 11 Mar 2020, Thierry Reding wrote:

> On Thu, Feb 27, 2020 at 03:02:21PM +0300, Wambui Karuga wrote:
>> Since 987d65d01356 (drm: debugfs: make
>> drm_debugfs_create_files() never fail) there is no need to check the
>> return value of drm_debugfs_create_files(). Therefore, remove the
>> return checks and error handling of the drm_debugfs_create_files()
>> function from various debugfs init functions in drm/tegra and have
>> them return 0 directly.
>>
>> This change also includes removing the use of drm_debugfs_create_files
>> as a return value in tegra_debugfs_init() and have the function declared
>> as void.
>>
>> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
>> ---
>>  drivers/gpu/drm/tegra/dc.c   | 11 +----------
>>  drivers/gpu/drm/tegra/drm.c  |  8 ++++----
>>  drivers/gpu/drm/tegra/dsi.c  | 11 +----------
>>  drivers/gpu/drm/tegra/hdmi.c | 11 +----------
>>  drivers/gpu/drm/tegra/sor.c  | 11 +----------
>>  5 files changed, 8 insertions(+), 44 deletions(-)
>
> Applied, thanks.
>
There's a newer version[1] of this patch series as this specific patch 
depends on other work in drm.

Thanks,
wambui karuga.

[1] https://lists.freedesktop.org/archives/dri-devel/2020-March/258793.html
> Thierry
>
