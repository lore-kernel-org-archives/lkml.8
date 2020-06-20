Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F04FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 13:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD0823B70
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 13:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6Vf4hPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgFTNTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 09:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgFTNTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 09:19:04 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99508C06174E;
        Sat, 20 Jun 2020 06:19:03 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d7so7089329lfi.12;
        Sat, 20 Jun 2020 06:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q+HPq9rW61DL+VfRzHknH+s+PfhTro91G/UUlHPqxLM=;
        b=F6Vf4hPViwBSIMfo8n/dilKTnUx1KvbMipBDiWABoTRTGpL4u6tsybqseu0EI6DMln
         B/vU/UFzDbiuFg41pg3ou4PCp/T7v1S9E5CBx3pugxTexjRTWuY/oUZTFmFtAJx2qZXu
         dCCpcDyO3PNL66D5fg1OSomdr1GNPoqngdydT1TOrcmqodSIqmor+9oFPOE3cSDvi54n
         tIPeRGz8m0NE70L9tZyjRgLvaPGI90a9r3Z9Tszup/ivaZBCag6HB5Awl5QQgQ5vrx/X
         0Fxcf8kn3kwHcz2qtHo1lDXbOINAIGO3kuL9BHf8/ohDU5BQf8+wkjLtZ+YmEPCIVjb3
         HUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q+HPq9rW61DL+VfRzHknH+s+PfhTro91G/UUlHPqxLM=;
        b=Zpc4HgvCJw/V2/vnzC31aFqklfDTs3jodNGzv4e32fnpdbkK414LJlkZ348Le4Ib5t
         hl9yO/jEVEp2ga/Pcx9HDGWeIyMaB4tChF9rNzEIUqgb2HfO4eCBBLLv6ti8CN9ZEGgO
         7nfFyUAenKzVvY5DOFY6s0C42Dspatp5ycA0WjN311tGSDpP1ZxwXSiGBhfbEUybPheG
         QglCKg728UyjxkZp6pkNycW5GvB4yBqkZryAKmUGiiyYd5AewuP9SINcuFdgo9fOTtxD
         ciLSXTXmpmOzRJeHj8cG8dyoMO+QISUc02Zoqi8MmrqKacDOO68Z29wNMeHcqBctZ+4p
         c2fA==
X-Gm-Message-State: AOAM530OE5N9fURcIy8kSz6LoeW0cAe64ZdJzB9qSyG8SGe6mBOoV0yZ
        fdmvHa5ZAwL2bz2SY4fEQzI=
X-Google-Smtp-Source: ABdhPJzHdeFt48oSkDQi8A35rPILoGoyNbXE/0ti1Lfi6bNWNubUqaD+fn4PzK0tY6D+4Uf5iT19qw==
X-Received: by 2002:a19:ca11:: with SMTP id a17mr4612844lfg.120.1592659141932;
        Sat, 20 Jun 2020 06:19:01 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id j25sm688506lfh.95.2020.06.20.06.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 06:19:01 -0700 (PDT)
Subject: Re: [PATCH v8 7/7] drm/panel-simple: Add missing connector type for
 some panels
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20200617222703.17080-1-digetx@gmail.com>
 <20200617222703.17080-8-digetx@gmail.com>
 <20200620112132.GB16901@ravnborg.org>
 <20200620114934.GB5829@pendragon.ideasonboard.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ea421084-a91c-bc03-5997-1723075b7cae@gmail.com>
Date:   Sat, 20 Jun 2020 16:19:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200620114934.GB5829@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.06.2020 14:49, Laurent Pinchart пишет:
> Hi Sam and Dmitry,
> 
> On Sat, Jun 20, 2020 at 01:21:32PM +0200, Sam Ravnborg wrote:
>> On Thu, Jun 18, 2020 at 01:27:03AM +0300, Dmitry Osipenko wrote:
>>> The DRM panel bridge core requires connector type to be set up properly,
>>> otherwise it rejects the panel. The missing connector type problem popped
>>> up while I was trying to wrap CLAA070WP03XG panel into a DRM bridge in
>>> order to test whether panel's rotation property work properly using
>>> panel-simple driver on NVIDIA Tegra30 Nexus 7 tablet device, which uses
>>> CLAA070WP03XG display panel.
>>>
>>> The NVIDIA Tegra DRM driver recently gained DRM bridges support for the
>>> RGB output and now driver wraps directly-connected panels into DRM bridge.
>>> Hence all panels should have connector type set properly now, otherwise
>>> the panel's wrapping fails.
>>>
>>> This patch adds missing connector types for the LVDS panels that are found
>>> on NVIDIA Tegra devices:
>>>
>>>   1. AUO B101AW03
>>>   2. Chunghwa CLAA070WP03XG
>>>   3. Chunghwa CLAA101WA01A
>>>   4. Chunghwa CLAA101WB01
>>>   5. EDT ET057090DHU
>>>   6. Innolux N156BGE L21
>>>   7. Samsung LTN101NT05
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>
>> Very good to have this fixed.
>> I went ahead and pushed this commit to drm-misc-next as it is really
>> independent from the rest of the series.
>>
>>> ---
>>>  drivers/gpu/drm/panel/panel-simple.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
>>> index 6764ac630e22..9eb2dbb7bfa6 100644
>>> --- a/drivers/gpu/drm/panel/panel-simple.c
>>> +++ b/drivers/gpu/drm/panel/panel-simple.c
>>> @@ -687,6 +687,7 @@ static const struct panel_desc auo_b101aw03 = {
>>>  		.width = 223,
>>>  		.height = 125,
>>>  	},
>>> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> 
> Note that, for LVDS panels, the bus_format field is mandatory. This
> panel, for instance, according to
> http://www.vslcd.com/Specification/B101AW03%20V.0.pdf, uses
> MEDIA_BUS_FMT_RGB666_1X7X3_SPWG (see
> https://linuxtv.org/downloads/v4l-dvb-apis/userspace-api/v4l/subdev-formats.html#v4l2-mbus-pixelcode).
> The panels below need to be investigated similarly.

Okay! I'll add the missing field in v9.

>>>  };
>>>  
>>>  static const struct display_timing auo_b101ean01_timing = {
>>> @@ -1340,6 +1341,7 @@ static const struct panel_desc chunghwa_claa070wp03xg = {
>>>  		.width = 94,
>>>  		.height = 150,
>>>  	},
>>> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>>>  };
>>>  
>>>  static const struct drm_display_mode chunghwa_claa101wa01a_mode = {
>>> @@ -1362,6 +1364,7 @@ static const struct panel_desc chunghwa_claa101wa01a = {
>>>  		.width = 220,
>>>  		.height = 120,
>>>  	},
>>> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>>>  };
>>>  
>>>  static const struct drm_display_mode chunghwa_claa101wb01_mode = {
>>> @@ -1384,6 +1387,7 @@ static const struct panel_desc chunghwa_claa101wb01 = {
>>>  		.width = 223,
>>>  		.height = 125,
>>>  	},
>>> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>>>  };
>>>  
>>>  static const struct drm_display_mode dataimage_scf0700c48ggu18_mode = {
>>> @@ -1573,6 +1577,7 @@ static const struct panel_desc edt_et057090dhu = {
>>>  	},
>>>  	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
>>>  	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
>>> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> 
> This contradicts .bus_format and .bus_flags that hint that the panel is
> a DPI panel, not an LVDS panel. According to
> https://www.lcdtek.co.uk/dwpdf/ET057090DHU-RoHS.pdf, this isn't an LVDS
> panel.
> 
> I'm worried enough research hasn't gone into this patch, and I'd prefer
> reverting it until we check each panel individually.

Hello Sam and Laurent,

Oops! Good catch! Indeed, I blindly set the LVDS type to all these
panels. Please revert this patch, I'll double check each panel and
prepare an updated version of this patch. Thank you very much for the
review!
