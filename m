Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36361C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119482051A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgDGGHl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:07:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34641 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgDGGHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 02:07:40 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jLhOc-0005XK-8h
        for linux-kernel@vger.kernel.org; Tue, 07 Apr 2020 06:07:38 +0000
Received: by mail-pg1-f200.google.com with SMTP id e22so591568pgm.22
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 23:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rKcIrGYLaZasUY/dGlYc6IfmlJJj/4gRzNcvO+62t4g=;
        b=nfUSIZTzHStl2Zl+coC6Xj/u3MlfMEsHuyybUFKPRlIyIld9iXGxMA4hJWUR19zt90
         ilKhumQe1d72OnMz3mZwV9y3cMMCTpr5hncviWw2+wI/8GmbKqkUuVQMs9EiY3U0eIs7
         qd1ow7HP7XcsmLcxvVsB7OKNrUNsRt56JVzTwRHynV7hYTeNarAKh83JtgisOgeLF00k
         GxlcvvGAH6Wyyo5RJwszzZUgP/vBV984Cgu1R/iz7FqlQnlq1WX3CCscq+ZKd1qUprs2
         F/gu+sziIUEGuUxcjKacMhXY8U6ob9qsiTnvgUiBHwhgND+IcSHA5k9YnCmvsXyoe2aw
         EfkA==
X-Gm-Message-State: AGi0PuY0I3udrrXD7QoLMdphSwowVbVHIxjJmebaBxHEjzU6zUJOcxnL
        xvY/YMsEsAEcSG71/248voUgqZZIyOaFfAVYWbthxh1t0BiLfZCsRmln7nPjoQEM+PMJyQ4gupB
        6J7Ux1Vc0QXCc0+6yiY+mDc18UEB37ZiIOiLhH2u8Bw==
X-Received: by 2002:a17:902:bc4b:: with SMTP id t11mr1002696plz.2.1586239656387;
        Mon, 06 Apr 2020 23:07:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypIIVyuQxWKtSF5cfUw0BN07y2sRFKFXDRNq7JG6JKzUKbDp/X7Mq47CYE5saZCyJub5T1wzhg==
X-Received: by 2002:a17:902:bc4b:: with SMTP id t11mr1002678plz.2.1586239656091;
        Mon, 06 Apr 2020 23:07:36 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id 8sm13108207pfv.65.2020.04.06.23.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 23:07:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] drm/i915: Force DPCD backlight mode for HP Spectre x360
 Convertible 13t-aw100
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <41FD4AD2-81F9-45E8-B5D6-9CC255D0581B@canonical.com>
Date:   Tue, 7 Apr 2020 14:07:33 +0800
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <1F57CA05-3E23-4CA8-A138-6785906ED465@canonical.com>
References: <20200323053528.3147-1-kai.heng.feng@canonical.com>
 <41FD4AD2-81F9-45E8-B5D6-9CC255D0581B@canonical.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        mripard@kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 27, 2020, at 19:03, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Hi,
> 
>> On Mar 23, 2020, at 13:35, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>> 
>> There's another OLED panel needs to use DPCD aux interface to control
>> backlight.
>> 
>> BugLink: https://bugs.launchpad.net/bugs/1860303
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Would it be possible to review this?
> I'd like to send a similar quirk for a new panel, and I want to avoid causing any merge conflict.

Another gentle ping...

> 
> Kai-Heng
> 
>> ---
>> drivers/gpu/drm/drm_dp_helper.c | 2 ++
>> 1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
>> index 8ba4531e808d..a0d4314663de 100644
>> --- a/drivers/gpu/drm/drm_dp_helper.c
>> +++ b/drivers/gpu/drm/drm_dp_helper.c
>> @@ -1301,6 +1301,8 @@ static const struct edid_quirk edid_quirk_list[] = {
>> 	 * only supports DPCD backlight controls
>> 	 */
>> 	{ MFG(0x4c, 0x83), PROD_ID(0x41, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
>> +	/* HP Spectre x360 Convertible 13t-aw100 */
>> +	{ MFG(0x4c, 0x83), PROD_ID(0x42, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIGHT) },
>> 	/*
>> 	 * Some Dell CML 2020 systems have panels support both AUX and PWM
>> 	 * backlight control, and some only support AUX backlight control. All
>> -- 
>> 2.17.1
>> 
> 

