Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E678C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A94B206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m0ElpsF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbgEKNos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729641AbgEKNor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:44:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F21EC05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:44:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h17so2143833wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hpFE9CUsmF5QuTw9fCnRsO/HIcrfLKfZVWo5gx0AO38=;
        b=m0ElpsF0pRp5TglEUDXatsddqa+Pb36Mj0Ppynh2iPIzzZz0EgUlzEtzkWyZeAg3vB
         uBs8o5cgAfl1IJaebtKgziRr73o57iHO5kRqVLTfaRC9X/zbKfqE0X7WUY3tyIHVtzsE
         vFx9MY8AD+wURjQHSKOL4msglFChmdK1OF0GOTXEyOPCB+/qCeUlNUl3WRSD8mjpJY46
         hSQALRhOTEhqYS5oyb8QdeT0A4PD7fA1adHgJP7v3DqW9SxYfGkzAgGWjuOFXLrwzjzb
         N6qFsfSm3T/OSIzW2mqIAKD2F9YJwb6IdZnQgigtlyOUiCH7V2syhUCmrF3QsgphlAHW
         IDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hpFE9CUsmF5QuTw9fCnRsO/HIcrfLKfZVWo5gx0AO38=;
        b=srzwoHKAxlD4FmaXTw2dJGGZppMCiVrYoQCGfw5ciUejo951FupyZ3bgGkIG07KyPO
         DRs9dgOKzWNCsjLd+IcUzc1kC+y5vfHC0afvsrYHlf32hrpvOZO4NH+jzaQn3iJQpp5f
         WYU+u0McOTh4HvytUixIaLcI/Zz+h06zr8nukk1y1nVKdOSVEDrSDSWPsySGvVrhPtHo
         1QETT8vo8sfc2sdQarstR+VMpQW4ogPNEd/8s0PwXSaHT9/7KNdyAmKKSK6EFxC0ZjWx
         9ptOyCiHWB4JxdDvKnTjr8Q6wAEt+Ic47ZLk6GHcAjpiQ1d8VIcnykvs3rHTtlIbj24I
         H1WQ==
X-Gm-Message-State: AGi0PubWHZWGn/CxyYqlgCOpamIhj0GtunOGLpBJ+Wlzf7PWdbD4Tb+5
        0qhL+TE33DTQuJl5I20fHsLM5IJqD1+YZA==
X-Google-Smtp-Source: APiQypLqeWUYDX3crs5ryt2QKIDbqRz/76rh57q7pYtJbxnpgj5n76IycVeDM/ojI700iAgxeVhE4Q==
X-Received: by 2002:adf:e28c:: with SMTP id v12mr21053389wri.157.1589204686152;
        Mon, 11 May 2020 06:44:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id a15sm18111170wrw.56.2020.05.11.06.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:44:45 -0700 (PDT)
Date:   Mon, 11 May 2020 14:44:41 +0100
From:   Quentin Perret <qperret@google.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
Subject: Re: [PATCH v7 05/15] PM / EM: remove em_register_perf_domain
Message-ID: <20200511134441.GB29112@google.com>
References: <20200511111912.3001-1-lukasz.luba@arm.com>
 <20200511111912.3001-6-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511111912.3001-6-lukasz.luba@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 May 2020 at 12:19:02 (+0100), Lukasz Luba wrote:
> Remove old function em_register_perf_domain which is no longer needed.
> There is em_dev_register_perf_domain that covers old use cases and new as
> well.
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

So, as mentioned in patch 03, I think this one could be squashed. But in
any case:

Acked-by: Quentin Perret <qperret@google.com>
