Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5990C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5AE20637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0On6Qfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgCEQlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:41:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55425 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgCEQlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583426476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=stJeKdSC+Wyig8nOc8URVbuDCJaVJQbI9Q0Eokb7KMg=;
        b=S0On6Qflan1Y3BWaY+LfD8OmccE+rTxYPC0ZNQNQsjRbtWyKBM6Agj1ax0pIbXRbJtSJlx
        5Kh/00Nj0EYkRIuoLkyeRB9s1MvtZ5jJDOD6/lBDiQkK4onA/mD55+xu+tGJv3zwyoXFnf
        czikHT4o2QgV2fA4R97zRL0Vulvtm1I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-OPHL368sNDWQqJxO3jt-9A-1; Thu, 05 Mar 2020 11:41:08 -0500
X-MC-Unique: OPHL368sNDWQqJxO3jt-9A-1
Received: by mail-wm1-f71.google.com with SMTP id p17so961189wmc.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 08:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=stJeKdSC+Wyig8nOc8URVbuDCJaVJQbI9Q0Eokb7KMg=;
        b=CPTKx2lP4AiC3aET9pwzc3nUPUmpMdOcP0CvmOcQwM0hzke9hQ8bHqF1+fQ8Xcow5f
         D8TuR0ZvEJTklv8NSfhE7b/OrdkPkbZghRzrIG0V3SAcKUD5AvWB7LgK7mgR4b0miGrl
         If7n1Nv/+7OYUMrAk3phi7vcOLEX+xpxGKY4mQc1bYUILMyKV8AHVTCminMY5DEAGxEU
         CcShuVynKZJxqgFsPNfYg1FzJgUgoLjeJrVtJcavewqXcCKJy/9DcytGvmfzyYxLb5PA
         iz8m9JlqZToT5Q20fkGzO1Tcg9QDO/+kkdMNOlD29aCzI0pWcTAHzJC4cG6x6D4yJzXG
         h+VQ==
X-Gm-Message-State: ANhLgQ032K0RRMz7S77ma620sFkj5qEoKQWVLIT4EXtB3bSkHocfVS8R
        tXLh+Y3z4WtJr7DJC86F02Px2gHX0FWHWrH4AQHoHwt7cU5UNs7f8yk4kIw5B1TS+awzxVUFidr
        8fHvPT66zNXs/XuoBUQMgVPB7
X-Received: by 2002:adf:aa9e:: with SMTP id h30mr11559466wrc.288.1583426466396;
        Thu, 05 Mar 2020 08:41:06 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvIRURKAgOSIvMEgAlaIX1+gfcD5nWklGx0bgkXynnCMfd09Tx4Bg7BqopFIY/UJQ2dyoc+DQ==
X-Received: by 2002:adf:aa9e:: with SMTP id h30mr11559440wrc.288.1583426466108;
        Thu, 05 Mar 2020 08:41:06 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id w8sm11151809wmm.0.2020.03.05.08.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 08:41:05 -0800 (PST)
Subject: Re: [PATCH 0/3] drm/dp_mst: Fix bandwidth checking regressions from
 DSC patches
To:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Mikita Lipski <mikita.lipski@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <seanpaul@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>
References: <20200304223614.312023-1-lyude@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <89275eb6-662d-73d1-a593-8271df5aadc0@redhat.com>
Date:   Thu, 5 Mar 2020 17:41:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304223614.312023-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lyude,

On 3/4/20 11:36 PM, Lyude Paul wrote:
> AMD's patch series for adding DSC support to the MST helpers
> unfortunately introduced a few regressions into the kernel that I didn't
> get around to fixing until just now. I would have reverted the changes
> earlier, but seeing as that would have reverted all of amd's DSC support
> + everything that was done on top of that I realllllly wanted to avoid
> doing that.
> 
> Anyway, this should fix everything as far as I can tell. Note that I
> don't have any DSC displays locally yet, so if someone from AMD could
> sanity check this I would appreciate it ♥.

Thank you for trying to fix this, unfortunately for me this is not fixed,
with this series. My setup:

5.6-rc4 + your 3 patches (+ some unrelated patches outside of drm)

-Lenovo x1 7th gen +
  Lenovo TB3 dock gen 2 +
  2 external 1920x1080@60 monitors connected to the 2 HDMI interfaces on the dock
-System booted with the LID closed, so that the firmware/BIOS has already
  initialized both monitors when the kernel boots

This should be fairly easy to reproduce on a similar setup, other
users are seeing similar problems when connecting more then 1 monitor
to DP-MST docks, see e.g. :

https://bugzilla.redhat.com/show_bug.cgi?id=1809681
https://bugzilla.redhat.com/show_bug.cgi?id=1810070

Let me know if you want me to collect some drm.debug logs, I guess
if you do, you want me to use drm.debug=0x114 ?

Regards,

Hans





> 
> Cc: Mikita Lipski <mikita.lipski@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Sean Paul <seanpaul@google.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> 
> Lyude Paul (3):
>    drm/dp_mst: Rename drm_dp_mst_is_dp_mst_end_device() to be less
>      redundant
>    drm/dp_mst: Don't show connectors as connected before probing
>      available PBN
>    drm/dp_mst: Rewrite and fix bandwidth limit checks
> 
>   drivers/gpu/drm/drm_dp_mst_topology.c | 124 ++++++++++++++++++++------
>   1 file changed, 96 insertions(+), 28 deletions(-)
> 

