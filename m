Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07575C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 19:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2762072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 19:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fahfwsIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgAQT02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 14:26:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39567 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgAQT01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 14:26:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so8748537wmj.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 11:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=CrQQQJS6hPBOvSxXvrnAqrRK6fwLt7e2C0voH4SKr0k=;
        b=fahfwsIRCL5XcTiGfHpb3xGA0wah3PeuQkVPJ+bnXWvwF8ZLPAyRVZUvCSuRWwP4Cj
         ur0GAKBTlTRdpHIREQ8aSuOXyNpFoPb6iE8otT46i3QXIef0/J5iI5oexgHOY6JogqYV
         3GPSBxNVU08D0HYXxxzvYLIyiv5W/XDutH95CdP9gcTdXmm9UE91QnYTF/U+3deBcB2N
         rpH/zmemra+IW4ovEzPmp8On7ZJ+HLghcYzgYrBYqHRnYovG8ekFuubY11ikbpKvZpEs
         2Ct3BRmqAPvR/21AB9XSSyN14ruV9V0eWn2mf+x9AaBQAx3zHabOT4rx3HnBNZHFgIzX
         GLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=CrQQQJS6hPBOvSxXvrnAqrRK6fwLt7e2C0voH4SKr0k=;
        b=f/k/6fGVwMSLkxSiz2gMfg/64lfudf2x0xz6qvNVg+ndrawVLhn19PanzoItOrecmv
         2KBl2O0yMAxlaeo0mb6Fe4Dtk1VuLW8v17RuFvWEc6+USmpCuSMPQrNsoxhzawuf6RYD
         sv1fbfkKNbeB+Wk38DobxXfji/j+ZDBhvES194ODBTUsqkERvJ8WXu6H7V853Nq4we5/
         hCuhtSJVVDLC/AMTff4NyA4l48x62afydRatFg3HEuH9s9thaYMo8KZjW80Gi3kqUX1F
         bWUXZ7zQFFRrCUehgv59/yr7z64l19gqspYsZ8QLvhH0WO4MNiYKVBuEyBOk/o1wBowO
         rKng==
X-Gm-Message-State: APjAAAXa4p0jkmZI6OPs5TjgIt0H0Y9VQei6/AAChQ17/4NrYSnmvf5Y
        dc4+fGzwSRVuKidfgbokcWI=
X-Google-Smtp-Source: APXvYqwOum254fHTkisVnySvou7896TOt5jeUfPQz9ywH+p1klU2v02mlCRjQfhM3e1ZB/NTNFeLXQ==
X-Received: by 2002:a1c:a78c:: with SMTP id q134mr6234664wme.98.1579289185316;
        Fri, 17 Jan 2020 11:26:25 -0800 (PST)
Received: from wambui.local ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id q11sm35636991wrp.24.2020.01.17.11.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 11:26:24 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
X-Google-Original-From: Wambui Karuga <wambui@wambui>
Date:   Fri, 17 Jan 2020 22:25:44 +0300 (EAT)
To:     Jani Nikula <jani.nikula@linux.intel.com>
cc:     Wambui Karuga <wambui.karugax@gmail.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, sean@poorly.run,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] drm/i915/display: conversion to new logging
 macros.
In-Reply-To: <87pnfigpi5.fsf@intel.com>
Message-ID: <alpine.LNX.2.21.99999.375.2001172219550.18007@wambui>
References: <20200116130947.15464-1-wambui.karugax@gmail.com> <87pnfigpi5.fsf@intel.com>
User-Agent: Alpine 2.21.99999 (LNX 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Jan 2020, Jani Nikula wrote:

> On Thu, 16 Jan 2020, Wambui Karuga <wambui.karugax@gmail.com> wrote:
>> This series converts the printk based logging macros in
>> drm/i915/display/intel_display.c to the new struct drm_device based
>> logging macros. This change was split into four for manageability and
>> due to the size of drm/i915/display/intel_display.c.
>
> Please still write more descriptive commit messages than "part N".
>
What would be a more descriptive subject line? I wasn't really sure about 
the subject line since the series is for the same file - which is why I 
went with "part N".

> What are your basing your patches on? Our CI uses 
drm-tip, and it's > failing to apply the patches.
>
I'm using drm-tip, but I can rebase and try again.

Thanks.
wambui.
> BR,
> Jani.
>
>
>
>>
>> Wambui Karuga (4):
>>   drm/i915/display: conversion to new logging macros part 1
>>   drm/i915/display: conversion to new logging macros part 2
>>   drm/i915/display: conversion to new logging macros part 3
>>   drm/i915/display: convert to new logging macros part 4.
>>
>>  drivers/gpu/drm/i915/display/intel_display.c | 1021 ++++++++++--------
>>  1 file changed, 596 insertions(+), 425 deletions(-)
>
> -- 
> Jani Nikula, Intel Open Source Graphics Center
>
