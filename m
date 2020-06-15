Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78125C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52882207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhMfsiax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbgFOSH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbgFOSHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:07:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F958C061A0E;
        Mon, 15 Jun 2020 11:07:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n24so20268630lji.10;
        Mon, 15 Jun 2020 11:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NNImWCHhqtVojGsejk+J9a5xVKeWHP7W32GZw/jq2rU=;
        b=PhMfsiax1F0GGmU/3UlPcnuAdoANLNF0BEfPxiOqIPK1akEnQxyIgigJivXEqMaXo0
         a1qHBTdoHDqU628wXUXrX4pF/ySYe7Tb+Mb7PBD+JGteidbWgcKR/lHS+w4eEv0Y/XHC
         X51dcTQjHHT1n1QYZ0YIJX057l07QPNIcqygM+gVP7pkeEnpm5xfzRUYoqFj2TWlEBtt
         Lkm5ShpF/pfwZzxQX4q0xlQCySYBNxPtvyShbRykK97+sbUavl0hGJ4zu9smWN8LwYwU
         KOm48VEI/Kreye82qxJtoEujLnviMUqzNNePJFWILkD2y8xUE3aGutF5D1n3XlEJXjrV
         4R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NNImWCHhqtVojGsejk+J9a5xVKeWHP7W32GZw/jq2rU=;
        b=nyMrYUtyIkF7iS5LCzLg3LEwyNF9BS9vxt7iKh5yPZbOWkfpctAaPiCYodIbJw3FQY
         JUP8hko6xhOTUFScFKrEiU0XwQ1W5axh2WjFr4PbMLN5xFtmQgB0gryW2xC1gJcK5mCx
         1rQ2vHcMGjOvVvUexUUHGeU/HDp6INIaNwhRC52GPjftvG5etDCzLXxSnep4HSHf4bal
         DzGYviLMFyctx0xytsxJmOtnZp2QR/jkKLkWQ2PsVmoXOVolhNbfKuoxfxDoHtcR1c1K
         7bkuazTo7Cv/1T6ukKhqLyDFKyL+Z5b7exZwje8679ZuDx7x8LqJkZgjnRPB7vDbGzvL
         k0dA==
X-Gm-Message-State: AOAM530pPylwNpzzPwcsvBx8vZuMS0oGuP5GCO1338G4eZE91Aw8iPbD
        no5G1bzp59c8NejzGeFHRAg=
X-Google-Smtp-Source: ABdhPJxamRu1no/0/HxGYEY1/YGWpSzM/ErZw9qvr5rjj+WTz8FcixUS/8+BKmChF630FnamwPhT3A==
X-Received: by 2002:a2e:81d4:: with SMTP id s20mr13376914ljg.184.1592244472721;
        Mon, 15 Jun 2020 11:07:52 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id o16sm4678233ljg.90.2020.06.15.11.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 11:07:51 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2_5/5=5d_drm/tegra=3a_plane=3a_Support_18?=
 =?UTF-8?Q?0=c2=b0_rotation?=
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20200614200121.14147-1-digetx@gmail.com>
 <20200614200121.14147-6-digetx@gmail.com> <20200615165758.GR6112@intel.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a22285cb-21d9-bb0e-3b6b-3b1876ebbb59@gmail.com>
Date:   Mon, 15 Jun 2020 21:07:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200615165758.GR6112@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.06.2020 19:57, Ville Syrjälä пишет:
> On Sun, Jun 14, 2020 at 11:01:21PM +0300, Dmitry Osipenko wrote:
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
>> @@ -608,6 +608,7 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
>>  {
>>  	struct tegra_plane_state *plane_state = to_tegra_plane_state(state);
>>  	unsigned int rotation = DRM_MODE_ROTATE_0 |
>> +				DRM_MODE_ROTATE_180 |
> 
> Leave this out ...
> 
>>  				DRM_MODE_REFLECT_X |
>>  				DRM_MODE_REFLECT_Y;
>>  	struct tegra_bo_tiling *tiling = &plane_state->tiling;
>> @@ -659,6 +660,14 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
>>  	else
>>  		plane_state->reflect_y = false;
>>  
>> +	if (tegra_fb_is_bottom_up(state->fb))
>> +		plane_state->reflect_y = true;
>> +
>> +	if (rotation & DRM_MODE_ROTATE_180) {
>> +		plane_state->reflect_x = !plane_state->reflect_x;
>> +		plane_state->reflect_y = !plane_state->reflect_y;
>> +	}
> 
> ... and drm_rotation_simplify() will do this for you.

Hello Ville,

Indeed, thank you for the suggestion!

> Though the bottim_up() thing will need a slightly different tweak I
> guess.
> 
> I'd write this as somehting like:
> rotation = state->rotation;
> if (bottom_up())
> 	rotation ^= DRM_MODE_REFLECT_Y;
> rotation = drm_rotation_simplify(rotation,
> 				 DRM_MODE_ROTATE_0 |
> 				 DRM_MODE_REFLECT_X |
> 				 DRM_MODE_REFLECT_Y;
> 
> Also note my use of XOR for the bottom_up() handling. I suspect
> the current code is already broken if you combine bottom_up()
> and REFLECT_Y since it just uses an OR instead of an XOR. That's
> assuming my hucnh what bottom_up() is supposed to do is correct.

The bottom_up() is a legacy way of specifying reflect_y flag of the
modern DRM's rotation property. It's was used by older userspace before
Tegra DRM driver got support for the rotation property and we keep it
today in order to maintain backwards compatibility with older userspace.
Although, maybe it's about time to retire it since I don't think that
such old userspace exists anymore.

The legacy bottom_up() duplicates the modern reflect_y flag, so these
are not mutually exclusive. Combining with yours suggestion above, we
can write it in this way:

  /*
   * Older userspace used custom BO flag in order to specify
   * the Y reflection, while modern userspace uses the generic
   * DRM rotation property in order to achieve the same result.
   * The legacy BO flag amends the modern rotation property
   * when both are set.
   */
  if (tegra_fb_is_bottom_up(state->fb))
    rotation = drm_rotation_simplify(state->rotation |
                                     DRM_MODE_REFLECT_Y,
                                     rotation);
  else
    rotation = drm_rotation_simplify(state->rotation,
                                     rotation);

Thank you very much for taking a look at this patch! I'll prepare v3 in
accordance to yours comments.
