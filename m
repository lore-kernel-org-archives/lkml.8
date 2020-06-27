Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF0AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 23:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E982920706
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 23:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ockKC02y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgF0XoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 19:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgF0XoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 19:44:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB36C061794;
        Sat, 27 Jun 2020 16:44:18 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h22so6883546lji.9;
        Sat, 27 Jun 2020 16:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DsD7awmAZIv1K0t/HRUOLxMTKUOvG6ubHXppAfzr2+A=;
        b=ockKC02y8P4bF4ese89yysHA7TROKDspX0VPiNSFOxcxPv1bs5o4Ipzt77U6F/bToM
         Hi5GccIUp1bZi9B8t5Bea8vkAuA0LNa5bZQlODZAVq8wOSDdwwK079pGT1jls92QbPJ0
         mJZcs6Si2zDMdlaKOgvh+jIstcSQBf3Qq7BMbljOEFNq2QrusldNPkAyay8JdIeW1yhl
         O5cdFlSsmQuSltOEMqr1kARitCHny0HzAZHwudX3LNX/nWaOUxxY2GRIVwNJ9IX2B9/l
         KXOHIMcXqRussDfLMZKqMbCM8gKdIBr/1Pa0A8ZubuZ1cBPDwRg5khPkSBSi5FzxpBwG
         HcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DsD7awmAZIv1K0t/HRUOLxMTKUOvG6ubHXppAfzr2+A=;
        b=Gc34Yvpy/BJDoutr5zMg1plloR2HBovES8fuDa0RsXkOX9fl49ykYBr/VJOf3e79c0
         kNwScwUdVRuBhLi+vcPs+6+V0HFeyMusUIWoxG7teytpUdkIlKCOO3G41bHbJIG6t8Hu
         0R1JbY7Wek9a2irskUCbeZCsemL+zBBtIT0t39ZC3u+UAkLLogU+hXvBf8d+d5JmUzQB
         +tMu0K4i0zhH7IQ3dQOXpjaoM9fzHZMTCwcTVN91ujrNsU3r4DLL0w3/JWbgy8uY7IRi
         DQvb0m1eQsNlOgaFLNtZyD7ALsPo34K4mrX1V3hbmNphyVzQr76a3ux1wtIAFNPZ4K+T
         CmDg==
X-Gm-Message-State: AOAM533D4GncG9U3rNiCLJzO9wuE0gUVIQhkjha/t4X83xC4TPj/pWdA
        rRVCU0G9uLxXw7qTvasezmKTOLkFOK8=
X-Google-Smtp-Source: ABdhPJydon2sdcY17f+37qAc3+Bk9DQ7NUVVnunr1D2iOWg1bSdqs9Wqpr8bbJ6Ewek0R4fAVsDI4Q==
X-Received: by 2002:a2e:7601:: with SMTP id r1mr5117761ljc.111.1593301456651;
        Sat, 27 Jun 2020 16:44:16 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id e13sm6321404ljo.6.2020.06.27.16.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2020 16:44:16 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] drm/panel-simple: Add missing BUS descriptions for
 some panels
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200621222742.25695-1-digetx@gmail.com>
 <20200621222742.25695-3-digetx@gmail.com>
 <20200627204338.GL5966@pendragon.ideasonboard.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dd1c5972-bbac-c2d8-76e8-08997b951e52@gmail.com>
Date:   Sun, 28 Jun 2020 02:44:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200627204338.GL5966@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

27.06.2020 23:43, Laurent Pinchart пишет:
> Hi Dmitry,
> 
> Thank you for the patch.
> 
> On Mon, Jun 22, 2020 at 01:27:42AM +0300, Dmitry Osipenko wrote:
>> This patch adds missing BUS fields to the display panel descriptions of
>> the panels which are found on NVIDIA Tegra devices:
>>
>>   1. AUO B101AW03
>>   2. Chunghwa CLAA070WP03XG
>>   3. Chunghwa CLAA101WA01A
>>   4. Chunghwa CLAA101WB01
>>   5. Innolux N156BGE L21
>>   6. Samsung LTN101NT05
>>
>> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/gpu/drm/panel/panel-simple.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
>> index 87edd2bdf09a..986df9937650 100644
>> --- a/drivers/gpu/drm/panel/panel-simple.c
>> +++ b/drivers/gpu/drm/panel/panel-simple.c
>> @@ -698,6 +698,8 @@ static const struct panel_desc auo_b101aw03 = {
>>  		.width = 223,
>>  		.height = 125,
>>  	},
>> +	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
>> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
> 
> Does DRM_BUS_FLAG_PIXDATA_DRIVE_* make sense for LVDS ?

To be honest I don't know whether it make sense or not for LVDS. I saw
that other LVDS panels in panel-simple.c use the PIXDATA flag and then
looked at what timing diagrams in the datasheets show.

> The rest looks good, except the Samsung panel for which I haven't been
> able to locate a datasheet.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks to you and Sam!
