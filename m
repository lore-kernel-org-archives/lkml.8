Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2435C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1DD420747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="lrfta52O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbgGAROn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbgGAROn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 13:14:43 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5BAC08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 10:14:42 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id u12so18993225qth.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uyDrreb5/43nRuyXAG5DxhddbAStHj2IykaaREeLOAs=;
        b=lrfta52O1r0UsfmM79fscXfWiTmQ4Zl4t2olGT+gIZQ+ikYdcVVjEEd7tfkDk3mVJo
         2yeVQsPbar4qpD3ErrFTsEMkmKrRg76t0/D5OdajQasvPoDo2HEYmv2xcnO+9Cr06g/5
         Jhgc14xFsLMXwm3zxMkcSzoq/Te/N+53cBoyeqOmOdNzg12m6a2/JCR96jBDDynnF+0p
         XdFp+xxEdg2W/Hqx+zlpYGrcRGmEMvYDfAktg0VnTxy3DKaeHF29ak7MAJVmOg3kobx6
         o+dyGtunNjmaa4MAMH2gTlnr4U/10Ur7ZqaShJOB0OaBuTd35v18MCOnI/NBMC8jQ/bp
         xv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uyDrreb5/43nRuyXAG5DxhddbAStHj2IykaaREeLOAs=;
        b=CLFoJBYgwD2W0skSjJR65yR8afpZyWsVKiu/wY0l0oHBRL9jUhHRrcvINe5bvQOroV
         vJwLeozcClYrirJ9W496HhktQGi3PwuFWj3IHqKMCpXRin0kEPfR2qnkVT2cOtX7Muez
         j+GUtMscfl3gnidNmQQ8PGU2BQb7p98Y9FDhRErbIBssQHZafUY04HK4OLQFNDOPMVUi
         5Rf9SI/kEgEd7OVFJyLNHLwdcGr6ZjEZuXbE7unuBY6cir7BiNMIUDikYHjaHJxJzL4r
         LbiaOskLwmq6kZZALG3qxBVSzHcykZvDWYJO8ZSingn7mWgB49LC/WGDHVkn2CjJx2js
         EQHg==
X-Gm-Message-State: AOAM530nyFeNV3W7+YrHHiZn4vi+Y2BIQtqwNEFV4B7vekURoYJW8Txb
        9tnJoO0SOIp/1a+qVkbhW0+v7H2OWq9SjQ==
X-Google-Smtp-Source: ABdhPJwsdDTczZS+vX8/Nxdl4H4faN26QV/tRRi0cKAX20gxeG3JVW5sYGRaK3dP0UeDm5JOzT1QbQ==
X-Received: by 2002:ac8:728b:: with SMTP id v11mr28496958qto.297.1593623681674;
        Wed, 01 Jul 2020 10:14:41 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id u27sm6069257qkm.121.2020.07.01.10.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 10:14:41 -0700 (PDT)
Subject: Re: [PATCH] drm/msm: handle for EPROBE_DEFER for of_icc_get
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200701030842.24395-1-jonathan@marek.ca>
 <20200701171228.GC3191083@google.com>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <49af8f44-51d4-aded-a34e-55c7c5780008@marek.ca>
Date:   Wed, 1 Jul 2020 13:13:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200701171228.GC3191083@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/20 1:12 PM, Matthias Kaehlcke wrote:
> Hi Jonathan,
> 
> On Tue, Jun 30, 2020 at 11:08:41PM -0400, Jonathan Marek wrote:
>> Check for EPROBE_DEFER instead of silently not using icc if the msm driver
>> probes before the interconnect driver.
> 
> Agreed with supporting deferred ICC probing.
> 
>> Only check for EPROBE_DEFER because of_icc_get can return other errors that
>> we want to ignore (ENODATA).
> 
> What would be the -ENODATA case?
> 

The of_icc_get for the ocmem_icc_path can return -ENODATA when the ocmem 
path is not specified (it is optional and only relevant for a3xx/a4xx).

> If the 'interconnects' property is not specified of_icc_get() returns NULL,
> shouldn't all (or most) errors be propagated rather than staying silent?
> 
> Thanks
> 
> Matthias
> 
