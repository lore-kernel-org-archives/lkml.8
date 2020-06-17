Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3953C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0090208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8QbXD3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgFQSur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgFQSur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:50:47 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7754BC06174E;
        Wed, 17 Jun 2020 11:50:45 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id x18so4204910lji.1;
        Wed, 17 Jun 2020 11:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=niGCVV02yGmCTRiNUXF586GuPtEiVqmlf9Dj30WKY8I=;
        b=M8QbXD3dhMgoC9HGZspqf7XvjFgGe8WazwwUzCVArg0/V4J/2jzwL8H4RGbmNBNkwD
         R8wGcFDnf2lOnU41m/g9QNA/9d+ub6zNKxZNXZWQ8tvxe8mZUd8MMFDtixbRyq/Pc/BF
         PIlXs0P58oAy4Q0Hx7D0IDtf6qGVRToB7UUTEKeWrh2FvdpOJVARsCgHhh3DM2YDYITG
         yv2i+lxcsBl69kQVaF0qbqTQ0Q5+tPfaYHxiZHxuDl7GF//mofzMEAyRhY5MUNk0ZEEC
         ecIvPUB2Ri/1v20pzwyv+rz8M4vudDHoEqRG2l6oEitpvq6n6iLOMI6v2o8SNoiAejZ8
         ZauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=niGCVV02yGmCTRiNUXF586GuPtEiVqmlf9Dj30WKY8I=;
        b=U2+gxQS7UexMuXU93D9tcwVFGURVgTOryPuJp05WfPX68eKYAftCDrtmuYErkGg6M4
         vjVLxZcXOHyc8SOEY8MRT6AZdPOLYek5QD9Mj0wW4xCg3/G9bituUG7ZIQk+P0AflvL4
         sTrvZR0YS3nxvG55gvFUXsp0T1ZvJYaZXwhewQlg8OPZhkhIBVUrwJtZ7jF37zYSr+Tb
         4kN3jCTZWCb1O126ZLAKWAu/SOUcnynkqHnWwRsAOQL5WitX+izYWgNpbqh2OAJW/LTp
         62RBHlmBzVyBbsD6p+SiLQp0ZcHnBS13IQaiQnSlTmRfsQ1W8OTKPrC6DfAlffPbuON9
         QLlg==
X-Gm-Message-State: AOAM530sL807Jevi4UHrOMTVkOftGz8z7aH2g90ZnhEnC1qqSBfkzozl
        +C0M7E64I5Lq0tMaz8QD21M=
X-Google-Smtp-Source: ABdhPJwHrFp7hl7apCuUIGY5sl9ZXw4ffQukc+KSdkIkDhhEWKTpuESWMBtJoDInAjZab47xZDYMIQ==
X-Received: by 2002:a05:651c:544:: with SMTP id q4mr348194ljp.310.1592419843008;
        Wed, 17 Jun 2020 11:50:43 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id r15sm119829ljm.31.2020.06.17.11.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 11:50:42 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2_5/5=5d_drm/tegra=3a_plane=3a_Support_18?=
 =?UTF-8?Q?0=c2=b0_rotation?=
From:   Dmitry Osipenko <digetx@gmail.com>
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
 <e21404bd-49c9-039e-4aef-c4912a9c0640@gmail.com>
Message-ID: <2a004826-a505-75e4-b922-c74618404166@gmail.com>
Date:   Wed, 17 Jun 2020 21:50:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e21404bd-49c9-039e-4aef-c4912a9c0640@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.06.2020 14:25, Dmitry Osipenko пишет:
> 16.06.2020 00:47, Emil Velikov пишет:
>> Hi all,
>>
>> Perhaps a silly question:
>>
>> On Mon, 15 Jun 2020 at 08:28, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>
>>> Combining horizontal and vertical reflections gives us 180 degrees of
>>> rotation.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/gpu/drm/tegra/dc.c | 13 ++++++++++++-
>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
>>> index f31bca27cde4..ddd9b88f8fce 100644
>>> --- a/drivers/gpu/drm/tegra/dc.c
>>> +++ b/drivers/gpu/drm/tegra/dc.c
>>
>>> +       if (rotation & DRM_MODE_ROTATE_180) {
>>> +               plane_state->reflect_x = !plane_state->reflect_x;
>>> +               plane_state->reflect_y = !plane_state->reflect_y;
>>> +       }
>>> +
>> As mentioned by Ville the above is already handled by
>> drm_rotation_simplify() ... although it makes me wonder:
>>
>>
>>>         err = drm_plane_create_rotation_property(&plane->base,
>>>                                                  DRM_MODE_ROTATE_0,
>>>                                                  DRM_MODE_ROTATE_0 |
>>> +                                                DRM_MODE_ROTATE_180 |
>>>                                                  DRM_MODE_REFLECT_X |
>>>                                                  DRM_MODE_REFLECT_Y);
>>
>> Would it make sense for drm_plane_create_rotation_property() itself,
>> to add DRM_MODE_ROTATE_180, when both reflections are supported?
> 
> Hello Emil,
> 
> That's a good point! All DRM_MODE_ROTATE_180 should be removed because
> Tegra can't do 180° + reflected-x. The DRM core takes care of 180°
> rotation when both x/y reflections are supported.
> 

I just found out that I forgot to drop the WIP patches which added
transparent rotation support while was checking whether these plane
DRM_MODE_ROTATE_180 could be dropped and it's actually need to be set
for the planes, otherwise 180 rotation support is filtered out by the
atomic check.
