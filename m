Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB56C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FB82081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJ30OfnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAMNRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:17:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39013 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbgAMNRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:17:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so8527295wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 05:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tLJdz8uHGTwFRe/HfbeIyswyOes5Ps1w2SyZzjK0TNI=;
        b=oJ30OfnCy02mfkWDYfM6xJM6U4Ab0kvMs5beVhw0Sqr61CvOixDWeh8PqjtINQwt0d
         A867CVEQp98L5jJ1b2/31cz6mXrjuWnk5GF4jIfjSqYN1cQBkWuRe2RltVQrUwNvdqPB
         XGf1fUv+QJXpdfnxcNt29RsAgRM3QVOVij+9WBaIxSHOOh+uPGvZxG0Ef9ftujiYJqMW
         14sGUu3FksxgHoT0X9xHSxhOGYp/yPH0v4ouRv0yK6hMh2yiysnDuHibM4s94DSDTj+j
         +v3cGQ5D3qRo3o5NCtX0FDeN15dRuGewPgYuAZB5DvuHtLuN17Nr4fjC/2aDFfMO2W9j
         wWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=tLJdz8uHGTwFRe/HfbeIyswyOes5Ps1w2SyZzjK0TNI=;
        b=LfStC01TL1hcUNX71DSYjAg7Q1N4XXuUL66yBy7cnrBQTddaJ98N/22zzcBbkrcQE/
         KsM4kWtrC4Kd8gkwGsteUs2GUcdfCQfNKpVhk4eda9U0Zm/dyZd+qbtKLN0K7Ao2zerj
         IJAUyH3m+Tf0qPBnFOv8IrnvKCFhvk7jIWpE2H/c+PfaUXYtuhkLlAq9CiPpQjgyuDzh
         SgkDXCxZlWUicMbVuxO4lZKpfc0Chg5GTCatsET2lWUMl46R7dQgfE9p2glznerJph55
         RSc9M3Hm+x1v9U5cKIoXtQLBXygOs4uMhi09IIzAL5khtJmSLnRZJxXpt7flvw7/Qvgt
         uJCA==
X-Gm-Message-State: APjAAAUDNjryFvQxJgi3PXw6PsWTJbXZBzq6p0lnbTf0VimLV5uqvY5Z
        bf4XvfdcrAcKnlANXEq7kHY=
X-Google-Smtp-Source: APXvYqypgXFDN3UkdfYGIXJRIf4nrTfjdzE2wUiuGM7IrbMrIloOZZE987luKGr5Shnf5Cgg4xzGCw==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr18004142wrn.386.1578921465172;
        Mon, 13 Jan 2020 05:17:45 -0800 (PST)
Received: from wambui.local ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id b18sm15054407wru.50.2020.01.13.05.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 05:17:44 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
X-Google-Original-From: Wambui Karuga <wambui@wambui>
Date:   Mon, 13 Jan 2020 16:17:11 +0300 (EAT)
To:     Jani Nikula <jani.nikula@linux.intel.com>
cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Wambui Karuga <wambui.karugax@gmail.com>, airlied@linux.ie,
        daniel@ffwll.ch, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, sean@poorly.run,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: convert to new logging macros based on struct
 intel_engine_cs.
In-Reply-To: <87lfqbmudl.fsf@intel.com>
Message-ID: <alpine.LNX.2.21.99999.375.2001131616050.10470@wambui>
References: <20200113111025.2048-1-wambui.karugax@gmail.com> <157891427231.27314.12398974277241668021@skylake-alporthouse-com> <87lfqbmudl.fsf@intel.com>
User-Agent: Alpine 2.21.99999 (LNX 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Jan 2020, Jani Nikula wrote:

> On Mon, 13 Jan 2020, Chris Wilson <chris@chris-wilson.co.uk> wrote:
>> Quoting Wambui Karuga (2020-01-13 11:10:25)
>>> fn(...) {
>>> ...
>>> struct intel_engine_cs *E = ...;
>>> +struct drm_i915_private *dev_priv = E->i915;
>>
>> No new dev_priv.
>
> Wambui, we're gradually converting all dev_priv variable and parameter
> names to i915.
>
Okay, I can change to that - dev_priv seemed more used in the files I 
changed.

Thanks,
wambui
>> There should be no reason for drm_dbg here, as the rest of the debug is
>> behind ENGINE_TRACE and so the vestigial debug should be moved over, or
>> deleted as not being useful.
>>
>> The error messages look unhelpful.
>
> I don't think you can expect any meaninful improvements on the debug
> message contents from Wambui without detailed help at this point.
>
>>
>>>                 if ((batch_end - cmd) < length) {
>>> -                       DRM_DEBUG("CMD: Command length exceeds batch length: 0x%08X length=%u batchlen=%td\n",
>>> -                                 *cmd,
>>> -                                 length,
>>> -                                 batch_end - cmd);
>>> +                       drm_dbg(&dev_priv->drm,
>>> +                               "CMD: Command length exceeds batch length: 0x%08X length=%u batchlen=%td\n",
>>
>> No. This is not driver debug. If anything this should be pr_debug, or
>> some over user centric channel.
>
> I'm sorry, I still don't understand your reasoning here.
>
> BR,
> Jani.
>
> -- 
> Jani Nikula, Intel Open Source Graphics Center
>
