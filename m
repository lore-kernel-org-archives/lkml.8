Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A0BC4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33012468E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWNRCmtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgB0M36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:29:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37562 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgB0M35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:29:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id l5so3127665wrx.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IIQDA+tILyCgis3eGzX3uwCoD2bNMsa23VuAcEl8vLQ=;
        b=IWNRCmtZSP+sggBUUbz53Z2M+bpKk3376XLiYXyv0u72WIo8rBHn9cJONARUJl7uVs
         BVGFpIwGzLrFU3gyIP+zQQvrRNq2ntDoYTTeC0FzikpHL6JPxA8Bl9VktQfS7Gs0GL3J
         kSZ4FRLsRFYdwexVnHs7IwqZn6j4vhBY5xonCKvObHwmbXG1uP6DM08oBvd5AQueVPU2
         iAykxZ4iO3SoxDZspxY71Nh2/99TUiGF1o6mPFEhvqvkR2tpfRsUZ0+9LYuO/0UwTvRO
         KHbj5LvL250mnk3SswK/lfrAq53zoNSLmhnp971X1kVwLyTg/AwTXoTtHQuSkcnSYt0D
         AFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IIQDA+tILyCgis3eGzX3uwCoD2bNMsa23VuAcEl8vLQ=;
        b=VAX9s9TZsXd1YAV+oqkZ2UkvoxXAdBClOn3WEgnw+uGQI7Ff3H4fwzwcJ0FvVcuQQq
         df0NbD9IsMuNOYdndRq2J3vEiKq0gFD4yJ+SU7ytaoJbUKkUv4boi5FYy9VdDIswe13s
         nPEx4bcR00D+5k5AgZy3v8lrf5o5OZ89dh1K5KVC/f92y682lxHEAV2TAWPS7ZGuD22Z
         lwzvcPZR+NFU/fzyLJ03FV3HHLngHmMDjduW6vkDyhd8T+j6qMiro0yDv3+oPed4UNRF
         bdJBSBm5r2rsNELT5A+RMo0RVdLD4lzohB2gyxWTapZBQMJgbxAFhmMX85Qx1pJ/rleM
         immw==
X-Gm-Message-State: APjAAAXm1CbCWNGtlWo2V5xDTSgFXW3/BXRHJFGX2QzAcoWbmezm3XrM
        LgbSrU2gcfkHK2NWBDCWOxU=
X-Google-Smtp-Source: APXvYqwPHNF+JPCOcRmhlLQ2ZlGa0G7cxgWqv/b8nuMluNPecxiyGd4RGvqDNxh21bQ+cyf5VKkhgg==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr4561077wrw.193.1582806594536;
        Thu, 27 Feb 2020 04:29:54 -0800 (PST)
Received: from wambui.local ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id f11sm7611144wml.3.2020.02.27.04.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:29:54 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
X-Google-Original-From: Wambui Karuga <wambui@wambui>
Date:   Thu, 27 Feb 2020 15:29:46 +0300 (EAT)
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Wambui Karuga <wambui.karugax@gmail.com>, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 02/21] drm: convert the drm_driver.debugfs_init() hook
 to return void.
In-Reply-To: <20200227122313.GB896418@kroah.com>
Message-ID: <alpine.LNX.2.21.99999.375.2002271528310.19554@wambui>
References: <20200227120232.19413-1-wambui.karugax@gmail.com> <20200227120232.19413-3-wambui.karugax@gmail.com> <20200227122313.GB896418@kroah.com>
User-Agent: Alpine 2.21.99999 (LNX 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Feb 2020, Greg KH wrote:

> On Thu, Feb 27, 2020 at 03:02:13PM +0300, Wambui Karuga wrote:
>> As a result of commit 987d65d01356 (drm: debugfs: make
>> drm_debugfs_create_files() never fail) and changes to various debugfs
>> functions in drm/core and across various drivers, there is no need for
>> the drm_driver.debugfs_init() hook to have a return value. Therefore,
>> declare it as void.
>>
>> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
>> ---
>>  include/drm/drm_drv.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
>> index 97109df5beac..c6ae888c672b 100644
>> --- a/include/drm/drm_drv.h
>> +++ b/include/drm/drm_drv.h
>> @@ -323,7 +323,7 @@ struct drm_driver {
>>  	 *
>>  	 * Allows drivers to create driver-specific debugfs files.
>>  	 */
>> -	int (*debugfs_init)(struct drm_minor *minor);
>> +	void (*debugfs_init)(struct drm_minor *minor);
>
>
> Doesn't this patch break the build, or at least, cause lots of build
> warnings to happen?
>
> Fixing it all up later is good, but I don't think you want to break
> things at this point in the series.
>
So, should it come last in the series? All functions that use this hook 
have been converted to void in the patchset.

thanks,
wambui karuga

> thanks,
>
> greg k-h
>
