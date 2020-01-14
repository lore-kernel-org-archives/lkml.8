Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7118DC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407BD207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CF/xuhzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgANH6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:58:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36864 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbgANH6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:58:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so11145738wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 23:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rbig32eOr50Fg3Pl+aEs/mNBrNThyFSHZWhVDQMxVUU=;
        b=CF/xuhzmVCRthuwJH06L18yseaKb7oIXNzM152sOtUAKNQ+YGt8p0UuH0t5KvJop+7
         CF1e3iJdULcUGDZl+0D+R3UUWIZ3Ytb96EOBDCtkCxq1Yrrnv03SE9t8QoKd8uO5nTDq
         Tn87CN+c/Yv35vPFg/vlEho5bsYjXmX9QVrcPEEbIAPEuH9IAHc2xbYZ6LG9PizvQy2N
         xfDC8GCUotkzreEMrT3nZQ0Fd5CiK+pimz6fND0la5j38JuOEbRZ12LeztGSLZId+zjv
         Ic2HeH7zK+Q3eiYOFQzW6exqSs+6bPVE4dHg7gBMPyCmM1qiv2lex2qajD7Ddqu9H5n9
         kv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rbig32eOr50Fg3Pl+aEs/mNBrNThyFSHZWhVDQMxVUU=;
        b=blDXDwDpYpgCtPdalyWxbKCTI+oTga/5sWQl7eNupixouO6WTJLmc8NrwEBnpPRamR
         8GMesFetLeuA/JiKuqAn/8nPhdDRxt19d9Q5FflGcSi7JvoVlCaKlfEqB7KSaOHNunFO
         Tf+pEGo+NwHyd9yHxxZofo+P1TBXuwdbhuVMPgNl/XlSfCfmtdG28ajHea5FZb0+gU28
         72JkgKYHHkotmPyIIEcB/obzMfxuPHexz9qd+qXBL1UoMo+tDwrXg9Wt7oq5I5i6rlIk
         GMB2BR3iuqiCF6vANr+w7zIAehLViOA5NQGB6zmwL6FHLZDL1dhY0Na2LSmLuPttkRII
         uSuQ==
X-Gm-Message-State: APjAAAUuIoRsCXCo47BPztY2+2ityAqOmcFm5we7E0z1o4N29/QYLrkq
        cA37ycZ8jTFByDwrNiZbLrvz+aFYi9k=
X-Google-Smtp-Source: APXvYqxOFNKkysW5IxjL1XmW18JG1x16t20l6Ie3rcKpVfh4ZhISo4dMlH20xO3vOn3h/zvIllwx5Q==
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr24104295wrw.25.1578988694185;
        Mon, 13 Jan 2020 23:58:14 -0800 (PST)
Received: from wambui.local ([154.70.37.104])
        by smtp.googlemail.com with ESMTPSA id t131sm17972758wmb.13.2020.01.13.23.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 23:58:13 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
X-Google-Original-From: Wambui Karuga <wambui@wambui>
Date:   Tue, 14 Jan 2020 10:58:03 +0300 (EAT)
To:     Chris Wilson <chris@chris-wilson.co.uk>
cc:     airlied@linux.ie, daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: convert to new logging macros based on struct
 intel_engine_cs.
In-Reply-To: <157891427231.27314.12398974277241668021@skylake-alporthouse-com>
Message-ID: <alpine.LNX.2.21.99999.375.2001141057240.2558@wambui>
References: <20200113111025.2048-1-wambui.karugax@gmail.com> <157891427231.27314.12398974277241668021@skylake-alporthouse-com>
User-Agent: Alpine 2.21.99999 (LNX 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Jan 2020, Chris Wilson wrote:

> Quoting Wambui Karuga (2020-01-13 11:10:25)
>> fn(...) {
>> ...
>> struct intel_engine_cs *E = ...;
>> +struct drm_i915_private *dev_priv = E->i915;
>
> No new dev_priv.
>
> There should be no reason for drm_dbg here, as the rest of the debug is
> behind ENGINE_TRACE and so the vestigial debug should be moved over, or
> deleted as not being useful.
>
> The error messages look unhelpful.
Hey Chris, could you please elaborate on the debugs that should be 
removed? These patches are for just converting the current debug 
instances, so removing them might need separate patches.

Thanks,
-wambui
>
>>                 if ((batch_end - cmd) < length) {
>> -                       DRM_DEBUG("CMD: Command length exceeds batch length: 0x%08X length=%u batchlen=%td\n",
>> -                                 *cmd,
>> -                                 length,
>> -                                 batch_end - cmd);
>> +                       drm_dbg(&dev_priv->drm,
>> +                               "CMD: Command length exceeds batch length: 0x%08X length=%u batchlen=%td\n",
>
> No. This is not driver debug. If anything this should be pr_debug, or
> some over user centric channel.
> -Chris
>
