Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4FAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3630020771
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eij/r8Vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbgGARbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731542AbgGARbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 13:31:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12686C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 10:31:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id t11so6433643pfq.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 10:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4fNzrypwA+h6/cDmXnWYSRWs2TnExn3KjSMmEODDS5k=;
        b=eij/r8Vh/rQed6wZTqGpOc18VEuPZcxNJDWCztfwt/yJl5o9O50Y0Kioeg4lEoOUYf
         b5COS9gDdoCUd6jRHA4b8V3qeWtiUT35a4EVNWIv1kVBLT60wpQew/R3aqshKT3jEnh2
         6uh9PjDzwpNLFb86pW5QGPdxBz12d7V2eGx48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4fNzrypwA+h6/cDmXnWYSRWs2TnExn3KjSMmEODDS5k=;
        b=J2n3gh0+AQTycYkpsBSORtgrJOFwTkNRu726W422fI4I41txkiuWmZ59WLv/JsU3JV
         CX3x3IFDjlxqEMq4Xa6fCzpdDtWG3Ex6SCRkpcT3hWpZm5jtzCr8xgOQh5NjJ7wyTUIN
         YbOfRHvLh2lS72cErCHhfXnTV49MGKNHeQ5+exv3PWrW20tWVJKVPbgrS0w81fJB2eey
         VEl1EhT5pOsus7dV3yexlEBnB9wrCBM97UR80zkLURutI6hpNHxeLcMevOm0+iWpM9ia
         a6cH6/m9mWvMe2u9pOfT7yEPV6oYB/CsNxfPu3EVZsDtOy6Y1HQVU9fumrTYny5PvH8W
         yQFA==
X-Gm-Message-State: AOAM533X2+U19yQawRJc9vrS1AHWh4O9P/FeDbCKQV1H4LdYe8SUZnna
        ywuWx9kUoNeyG7Q019Tfkk8C8A==
X-Google-Smtp-Source: ABdhPJxDxBe8JvlXms+W1hWSshtDpF7DzlWzhcD8TjKp0cMR4Tp3lor5DHtOOMRLn11J3GiOW8kXnQ==
X-Received: by 2002:a63:fc43:: with SMTP id r3mr20981507pgk.423.1593624699558;
        Wed, 01 Jul 2020 10:31:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id 21sm6435524pfu.124.2020.07.01.10.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 10:31:38 -0700 (PDT)
Date:   Wed, 1 Jul 2020 10:31:37 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Jonathan Marek <jonathan@marek.ca>
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
Subject: Re: [PATCH] drm/msm: handle for EPROBE_DEFER for of_icc_get
Message-ID: <20200701173137.GD3191083@google.com>
References: <20200701030842.24395-1-jonathan@marek.ca>
 <20200701171228.GC3191083@google.com>
 <49af8f44-51d4-aded-a34e-55c7c5780008@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49af8f44-51d4-aded-a34e-55c7c5780008@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 01:13:34PM -0400, Jonathan Marek wrote:
> On 7/1/20 1:12 PM, Matthias Kaehlcke wrote:
> > Hi Jonathan,
> > 
> > On Tue, Jun 30, 2020 at 11:08:41PM -0400, Jonathan Marek wrote:
> > > Check for EPROBE_DEFER instead of silently not using icc if the msm driver
> > > probes before the interconnect driver.
> > 
> > Agreed with supporting deferred ICC probing.
> > 
> > > Only check for EPROBE_DEFER because of_icc_get can return other errors that
> > > we want to ignore (ENODATA).
> > 
> > What would be the -ENODATA case?
> > 
> 
> The of_icc_get for the ocmem_icc_path can return -ENODATA when the ocmem
> path is not specified (it is optional and only relevant for a3xx/a4xx).

Thanks for the clarification!

In this case it seems reasonable to me to return any error for the
'gfx-mem' path and all errors except -ENODATA for 'ocmem'.
