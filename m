Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A59C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245572080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocd2XjHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgAJRpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:45:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36246 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgAJRo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:44:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so2632581wru.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=5hI1Z6zc0isNIwOCpgK9mbSp+WfDRjfAoj1TrQlEpEk=;
        b=ocd2XjHL/6q7Bv/03GFAnmNwBPQIoL9bJ5BkRsKBNXMqvd8Uvwjxfo9N0CltqGK4D9
         m6WC8vwBiEcX3wu3eGMFNb9s9JE5ssWh1ubdTMtX2neDKxdmN8y0MdX9llmGxdVV5lGs
         3gIhVrGO3MV5UOrO6jzR3kPtPxQfHl1qEdTRSp91kXAxaWWTp9RD7jhUvsAOoiEsU9ct
         nJNZ0yLcdvlOBT37oT5m7bgVdT0RWO7rA1ntLhmdpnghc3srvwMQ/4BZ5HMOOwSyd7yV
         USMWVFuK6BQn4GknPaflrM+p4Dcpadd6N1Hxtm07GZt4017QGXtJasMEiwZ16KRqxOsH
         7Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=5hI1Z6zc0isNIwOCpgK9mbSp+WfDRjfAoj1TrQlEpEk=;
        b=WoNhLw/o672c0AkGNU6+S61FfzPMD8u+k2ADKdDj74FhUSUf8AzC/jNZNL1KCDJWnY
         ccqsyQLaDPVoV/V9cYn45V4394nm9TlhDfkpLytEDj/050XzRSBq+4TTDEw777VWo7OB
         l/HPQ5YmiAbBH5q1Ck8mU2hNBaJsaFTZglPkn3q5GGw+OFCUMKiT65ENfOH3pOpEFTnr
         hDYG5dSH6gN4U28khihfq4q112yz5xKpMLe4ORPJrZ19R6TrqeaJHZ5gsHZHxoOnI7QI
         Xwy6qZL6j0pOjluv/4K0OLyslX/TcLFbTPS3bLFN6YPV/x/ELPL/0Q2qG+4s4fw+75ld
         Zu7w==
X-Gm-Message-State: APjAAAWcA8erFon4Ut0quThlyXIhqjrvvnzxpWiLLNAasjjJjdpvotVS
        SfYyrOFGSrd8Q5llqiXwt7o=
X-Google-Smtp-Source: APXvYqzt7Qr8UDP3Dv38WgfWk/xkS6KCAOtCWgJWi+dWf98rcqNzc/uJiB+XqpYBSc+PgqaRuSXu8w==
X-Received: by 2002:adf:d846:: with SMTP id k6mr4500598wrl.337.1578678298144;
        Fri, 10 Jan 2020 09:44:58 -0800 (PST)
Received: from wambui.local ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id i8sm3140572wro.47.2020.01.10.09.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 09:44:57 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
X-Google-Original-From: Wambui Karuga <wambui@wambui>
Date:   Fri, 10 Jan 2020 20:44:48 +0300 (EAT)
To:     Jani Nikula <jani.nikula@linux.intel.com>
cc:     Wambui Karuga <wambui.karugax@gmail.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, seanpaul@chromium.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] drm/i915: conversion to new drm logging macros.
In-Reply-To: <8736cno0ow.fsf@intel.com>
Message-ID: <alpine.LNX.2.21.99999.375.2001102044220.23860@wambui>
References: <cover.1578409433.git.wambui.karugax@gmail.com> <8736cno0ow.fsf@intel.com>
User-Agent: Alpine 2.21.99999 (LNX 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Jan 2020, Jani Nikula wrote:

> On Tue, 07 Jan 2020, Wambui Karuga <wambui.karugax@gmail.com> wrote:
>> This series begins the conversion to using the new struct drm_device
>> based logging macros in drm/i915.
>>
>> Wambui Karuga (5):
>>   drm/i915: convert to using the drm_dbg_kms() macro.
>>   drm/i915: use new struct drm_device logging macros.
>>   drm/i915: use new struct drm_device based logging macros.
>>   drm/i915: convert to using new struct drm_device logging macros
>>   drm/i915: use new struct drm_device based macros.
>
> Thanks for the patches, pushed to drm-intel-next-queued.
>
> As it's impossible to distinguish the commits from each other by the
> subject line alone, I've amended the prefix while pushing as follows:
>
> drm/i915/pch: convert to using the drm_dbg_kms() macro.
> drm/i915/pm: use new struct drm_device logging macros.
> drm/i915/lmem: use new struct drm_device based logging macros.
> drm/i915/sideband: convert to using new struct drm_device logging macros
> drm/i915/uncore: use new struct drm_device based macros.
>
> Please pay attention to this in future work. It's not always obvious
> what the prefix should be, but 'git log -- path/to/file.c' will go a
> long way.
>
Sure, I'll do that from now on.
Thanks.
> BR,
> Jani.
>
>
>>
>>  drivers/gpu/drm/i915/intel_pch.c         |  46 +--
>>  drivers/gpu/drm/i915/intel_pm.c          | 351 +++++++++++++----------
>>  drivers/gpu/drm/i915/intel_region_lmem.c |  10 +-
>>  drivers/gpu/drm/i915/intel_sideband.c    |  29 +-
>>  drivers/gpu/drm/i915/intel_uncore.c      |  25 +-
>>  5 files changed, 254 insertions(+), 207 deletions(-)
>
> -- 
> Jani Nikula, Intel Open Source Graphics Center
>
