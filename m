Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E22C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B5AD20734
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdYAIpb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgFPLZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFPLZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:25:44 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E35C08C5C2;
        Tue, 16 Jun 2020 04:25:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x18so23016989lji.1;
        Tue, 16 Jun 2020 04:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J1DJhGQSDd9qg+4bq2SW3OfC6fEmq2H0sypmce6w78g=;
        b=NdYAIpb7i1OzFNFczOX1yx07+L+e97QHtSv2zsJBVC0+5rFPj/vk8NM6zyAqza9cI/
         aZgSWHyLtVqhA/TO0g+Y5YU7ghd1YNeh7rll7dE1Gmq63UWE1uK1U7A6AB5wDyyjmAGH
         0tCVT1k81e2XaX/j5wxbsboGwAxRlllezqIKYjcYrgo59S/MCSUAgmuYZZtOibTPsdul
         ezj1+z4QIVnIW1e+EdjMWWfu8LSRScN1uN6prsTMMU2U9MEmd9wg5aoHPJnJWZ54kFTS
         1782YCmue9vyxtN6OvJXJt0NSxZLtGMmW87yOmVALqr/l781Bj0s8EPJQiHH0sOmlpaB
         bmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J1DJhGQSDd9qg+4bq2SW3OfC6fEmq2H0sypmce6w78g=;
        b=kSXrlwDm/AuE1Am+cLrh6C2PSHpqWEDmxcgAgF3r4CrIFlUpPHU0eC9aZYAC3GIayF
         wsmNDp9HTLkaIFa+SR+yYgcyIeRKw7ofJIFhfA3A7KPwTNHBuEj7CJ00MOWIvEREpy7Z
         bNy/2FK5MQpjDL+90E3uuaim1rQlm5f3YjpPsRb+8q/Du00swWASWnbyUBO/6Kaco6Lr
         jJIvd7Ha7KAzMrP7oBKhFwWQURCt4Ay4/5LOl/MlKA91q9vvBL9WSuBYZmE7ZAuWj8Xi
         qJ7ghoMeerpFJ2jyfpXsBOwIjk0evAj/FWzv81R7eT9s7rsYycE99PaUZXiJFneYTv7Z
         DJAA==
X-Gm-Message-State: AOAM531OKxwqUSh735BzmfLDAakCQ983K+E8w65Sf7UbEPXPycZzs8T8
        gmzH0IIMAg+eBTYw1gxjdvk=
X-Google-Smtp-Source: ABdhPJxncMV2D3cQoYqF+t1E8bMGN3msVW0HWI/2ula2kxfrb21MS9IJZ6vNePInt+ZL3dFG8Esxxg==
X-Received: by 2002:a2e:8744:: with SMTP id q4mr1240969ljj.91.1592306741034;
        Tue, 16 Jun 2020 04:25:41 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id 72sm5201098lfa.52.2020.06.16.04.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 04:25:40 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2_5/5=5d_drm/tegra=3a_plane=3a_Support_18?=
 =?UTF-8?Q?0=c2=b0_rotation?=
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, linux-tegra@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
References: <20200614200121.14147-1-digetx@gmail.com>
 <20200614200121.14147-6-digetx@gmail.com>
 <CACvgo50P5i2jX6ZrMD=UuGr_bA=8MbFhYBWBNvkMcdCyJKS5xg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e21404bd-49c9-039e-4aef-c4912a9c0640@gmail.com>
Date:   Tue, 16 Jun 2020 14:25:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACvgo50P5i2jX6ZrMD=UuGr_bA=8MbFhYBWBNvkMcdCyJKS5xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.06.2020 00:47, Emil Velikov пишет:
> Hi all,
> 
> Perhaps a silly question:
> 
> On Mon, 15 Jun 2020 at 08:28, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> Combining horizontal and vertical reflections gives us 180 degrees of
>> rotation.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/gpu/drm/tegra/dc.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
>> index f31bca27cde4..ddd9b88f8fce 100644
>> --- a/drivers/gpu/drm/tegra/dc.c
>> +++ b/drivers/gpu/drm/tegra/dc.c
> 
>> +       if (rotation & DRM_MODE_ROTATE_180) {
>> +               plane_state->reflect_x = !plane_state->reflect_x;
>> +               plane_state->reflect_y = !plane_state->reflect_y;
>> +       }
>> +
> As mentioned by Ville the above is already handled by
> drm_rotation_simplify() ... although it makes me wonder:
> 
> 
>>         err = drm_plane_create_rotation_property(&plane->base,
>>                                                  DRM_MODE_ROTATE_0,
>>                                                  DRM_MODE_ROTATE_0 |
>> +                                                DRM_MODE_ROTATE_180 |
>>                                                  DRM_MODE_REFLECT_X |
>>                                                  DRM_MODE_REFLECT_Y);
> 
> Would it make sense for drm_plane_create_rotation_property() itself,
> to add DRM_MODE_ROTATE_180, when both reflections are supported?

Hello Emil,

That's a good point! All DRM_MODE_ROTATE_180 should be removed because
Tegra can't do 180° + reflected-x. The DRM core takes care of 180°
rotation when both x/y reflections are supported.
