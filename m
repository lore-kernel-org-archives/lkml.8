Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F262C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703C6206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgC0LDh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:03:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50548 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgC0LDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 07:03:36 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jHmlx-000088-P4
        for linux-kernel@vger.kernel.org; Fri, 27 Mar 2020 11:03:33 +0000
Received: by mail-pg1-f198.google.com with SMTP id g10so7557390pgg.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 04:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4crqkcDa1cMvjuMptqnnf+6Biw5Iu2+wMpwA6yeSEso=;
        b=NF6Dfdq9RRukMCUV+Fw2TNndLvFc/l7FFx4344JFc/xZ3AnHzYOmMAvDiyB6vR8S/f
         ZnY6HNqUQxXl4rD/Ji7O1TdAPqma+PSPP9PzcmygD3kITwk1CdIC5bc87zWeV/hg8l6x
         s0g8XR76usZeBnmnu3+3FzcvyLdlUzwlR9/Lwbv6fY7MXVYaAn0qmu3Q3f/T+zkro1dq
         H4lof9YIaO86jnqDB7CFJgmZXWWewTaEsn6IeF3M/DM1XKn5N+/VsjNjZirJX5kOKLKw
         9Vd3yOQCm/8cjn6tyXiO0t+q+S5qDTqp1kcDQcCqCmRywLqyiR63FkCS9oEUUETMxa1H
         /fHA==
X-Gm-Message-State: ANhLgQ3ry1jCK8IdDcXG+XLjpH0Dc3jXto/Z13r3EyoBTep0ovOEqCAd
        oTdtyUsp0mT2IqokqkaTFSeqlVn/WVKdbVpv8ffH7ngygq/e/Y2NFcNFr2Aszob0+YnhyDPBQy0
        5wOPuEcpZlw0kYlN9OEdPNBPzznHtf+PbLqZ9bHYZtw==
X-Received: by 2002:aa7:9566:: with SMTP id x6mr14121995pfq.104.1585307012291;
        Fri, 27 Mar 2020 04:03:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuxxfXRfgKbsH0hsGV8BhF/ACIktFsowvrKfYYjdEGovkm+Ou4UR209n3gvSkXPfi+rEfp2OQ==
X-Received: by 2002:aa7:9566:: with SMTP id x6mr14121922pfq.104.1585307011385;
        Fri, 27 Mar 2020 04:03:31 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id i7sm1784358pgk.15.2020.03.27.04.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2020 04:03:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] drm/i915: Force DPCD backlight mode for HP Spectre x360
 Convertible 13t-aw100
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200323053528.3147-1-kai.heng.feng@canonical.com>
Date:   Fri, 27 Mar 2020 19:03:27 +0800
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <41FD4AD2-81F9-45E8-B5D6-9CC255D0581B@canonical.com>
References: <20200323053528.3147-1-kai.heng.feng@canonical.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Mar 23, 2020, at 13:35, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> There's another OLED panel needs to use DPCD aux interface to control
> backlight.
> 
> BugLink: https://bugs.launchpad.net/bugs/1860303
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Would it be possible to review this?
I'd like to send a similar quirk for a new panel, and I want to avoid causing any merge conflict.

Kai-Heng

> ---
> drivers/gpu/drm/drm_dp_helper.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 8ba4531e808d..a0d4314663de 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -1301,6 +1301,8 @@ static const struct edid_quirk edid_quirk_list[] = {
> 	 * only supports DPCD backlight controls
> 	 */
> 	{ MFG(0x4c, 0x83), PROD_ID(0x41, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
> +	/* HP Spectre x360 Convertible 13t-aw100 */
> +	{ MFG(0x4c, 0x83), PROD_ID(0x42, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
> 	/*
> 	 * Some Dell CML 2020 systems have panels support both AUX and PWM
> 	 * backlight control, and some only support AUX backlight control. All
> -- 
> 2.17.1
> 

