Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E49C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 12:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F9C2070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 12:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lj9s4MQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgCGMFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 07:05:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39389 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbgCGMFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 07:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583582749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fvJgabj3nTJUkbCxeSwOD5bKpyXRPk1GpZ8xJvwqzQk=;
        b=Lj9s4MQ5xWWJsRc0E/4yqoO6VtcbiM+UvaOppXebjBpzidx3ulFBMDdu+ErsT+W2n9P8Kh
        GthpRR3UQ24inmftMMEfxgXq3FWsh7zGhh4u3+sGL+zQci1p35cWj5K9dKt99m6L33zxio
        zGbC6qTCpRjmuzWVYnmfJxlQAT3B6jI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-_J3Ps1sFPBSaZvt_lyvSNQ-1; Sat, 07 Mar 2020 07:05:47 -0500
X-MC-Unique: _J3Ps1sFPBSaZvt_lyvSNQ-1
Received: by mail-wr1-f72.google.com with SMTP id u8so2328863wrq.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 04:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fvJgabj3nTJUkbCxeSwOD5bKpyXRPk1GpZ8xJvwqzQk=;
        b=bKcPjuazqBDOlMwl3qKxni5+ebf+0SrdEVAk0lN/1N+IkN7s1nC/OeJA5qcTjWM7Ds
         iW+NNy6QSDga2D3H9Y+NEEj+JA8VmialPJNfpYYdCM2P78EpYEaiFDlBHVah9o1+k+tQ
         X7PVDrTXX6vhJURpng1qT2ZOb3I3rIoW0xO3xZDf2E56sms+r27NA0DrxgJt9wWqUpb6
         q6V6SkUxBs2nnwY/cVUNh0kOWnGuWqwKPl8yBFMKf8WwEE7HdAwvHr6Vx4dU4UT3aYr/
         JgWoZNIfQvSJDB79KePGpFpwT2QhBz6wQoNlmEg3CxoyorUHHe/aaxKGhj4pbbSK9kiJ
         ON/A==
X-Gm-Message-State: ANhLgQ0pkKsDmT54PonYJHS0u1nnssqR0du51T9L9JPeEPq4AlySjj7n
        ytSbgodwrkQzYqDrx8WgzQNXrWjLIt4WUGUf9Kegq/KtLMWky3R1vumH6pvdpqgQjWGeVq4fUGx
        czPzcziMfDHb3FKHgmV9RLKgW
X-Received: by 2002:a05:600c:301:: with SMTP id q1mr9892453wmd.182.1583582746432;
        Sat, 07 Mar 2020 04:05:46 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtcqSvMkLYigsEgmysDgrOMIgorxgb+49Gq6V9uAFR0HQduVQt4zAHXPJMq1m3LelhxCOkZDw==
X-Received: by 2002:a05:600c:301:: with SMTP id q1mr9892434wmd.182.1583582746220;
        Sat, 07 Mar 2020 04:05:46 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id o3sm2465440wmc.38.2020.03.07.04.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2020 04:05:45 -0800 (PST)
Subject: Re: [PATCH v2 0/4] drm/dp_mst: Fix bandwidth checking regressions
 from DSC patches
To:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Mikita Lipski <mikita.lipski@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <seanpaul@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>
References: <20200306234623.547525-1-lyude@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f2ad071d-ae50-d840-439b-dc2df85cc88f@redhat.com>
Date:   Sat, 7 Mar 2020 13:05:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306234623.547525-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/7/20 12:46 AM, Lyude Paul wrote:
> AMD's patch series for adding DSC support to the MST helpers
> unfortunately introduced a few regressions into the kernel that I didn't
> get around to fixing until just now. I would have reverted the changes
> earlier, but seeing as that would have reverted all of amd's DSC support
> + everything that was done on top of that I realllllly wanted to avoid
> doing that.
> 
> Anyway, this should fix everything bandwidth-check related as far as I
> can tell (I found some other regressions unrelated to AMD's DSC patches
> which I'll be sending out patches for shortly). Note that I don't have
> any DSC displays locally yet, so if someone from AMD could sanity check
> this I would appreciate it ♥.

I can confirm that this series fixes only of the 2 FHD monitors on
my Lenovo TB3 gen 2 dock lighting up, thank you!

This series is:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> 
> Cc: Mikita Lipski <mikita.lipski@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Sean Paul <seanpaul@google.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> 
> Lyude Paul (4):
>    drm/dp_mst: Rename drm_dp_mst_is_dp_mst_end_device() to be less
>      redundant
>    drm/dp_mst: Use full_pbn instead of available_pbn for bandwidth checks
>    drm/dp_mst: Reprobe path resources in CSN handler
>    drm/dp_mst: Rewrite and fix bandwidth limit checks
> 
>   drivers/gpu/drm/drm_dp_mst_topology.c | 185 ++++++++++++++++++--------
>   include/drm/drm_dp_mst_helper.h       |   4 +-
>   2 files changed, 129 insertions(+), 60 deletions(-)
> 

