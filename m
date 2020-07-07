Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1577C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A2820773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eJZR57Yh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgGGRd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgGGRd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:33:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52E1C08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 10:33:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o11so46133647wrv.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c9Pf+frUb/qMKN1qCaZPERox37ZCJpz+B8FdrOvw8Ng=;
        b=eJZR57YhUyn/zMwpsAHvIFkhb9hFkvj/ZlhzoHNfRdrvDihtRFAb5A7nmEygIrukPd
         4MMAGRGLegHp4KrpPtN/J1rHcEcmTm63YDBdNMX9nJIfgs1J8/tmRZVDmcPJ0qIonVVa
         C6OF0ZDEHZIiLLqdLiQAabpvi7qyrbFCMAU4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c9Pf+frUb/qMKN1qCaZPERox37ZCJpz+B8FdrOvw8Ng=;
        b=qCv7HRWOyHwPFF+cMPIVFYUs1VwPxr33cZoN4YsKvTGF1y78TIqVdaFAS4LERwzyaR
         5I8RPIsczpRKDpR2jxB1BYCUYHkz6Su4iTfNzXhXfdespxEI/mJdVjtcpB5m/qZqYE7z
         ErexpBr2I6n4YXQm3QLnr/6sYo2FBhgh3Qp1k1AWuPVYuYdAYYZKBVHh4XzG5ZkckiQ0
         BzDK55Pkk8yFLU5+s6vaVjarv3exAagoJHwUVbeSUJRBLUWdCn9RudejOqtsOg5rPLlM
         dGweZoFeEoX1m+8nltcxce2+iaAvda8PDzLU6lJF21iiQF/2CkrHmF9hq1Gh01iBrY03
         YNwQ==
X-Gm-Message-State: AOAM530aTAuQabDDw1BuoiL8Rk4PRwaTa5D80kqDNzo7fWFeL1A7+PqB
        gIVc1uU1herEjO2Rhll8DyCs0A==
X-Google-Smtp-Source: ABdhPJwCY1rsY8+YAy/uIC2hGIvV7PFLECFt4XiABJ+hbH7UG4usWnRSaGLAFUGG7tc8ZTY3RK21YA==
X-Received: by 2002:adf:de07:: with SMTP id b7mr58959850wrm.302.1594143207314;
        Tue, 07 Jul 2020 10:33:27 -0700 (PDT)
Received: from chromium.org (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id a2sm1802722wrn.68.2020.07.07.10.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 10:33:26 -0700 (PDT)
Date:   Tue, 7 Jul 2020 17:33:25 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     kyungmin.park@samsung.com, s.nawrocki@samsung.com,
        mchehab@kernel.org, kgene@kernel.org, krzk@kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] media: exynos4-is: Remove static driver data for
 S5PV210 FIMC variants
Message-ID: <20200707173325.GA2621465@chromium.org>
References: <20200426022650.10355-1-xc-racer2@live.ca>
 <BN6PR04MB06603A626BB6D54D11CB502CA3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR04MB06603A626BB6D54D11CB502CA3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 07:26:40PM -0700, Jonathan Bakker wrote:
> The S5PV210 platform only supports device tree based booting
> where the FIMC variant data is parsed directly from
> the device tree, hence the now unused static data can be removed.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  drivers/media/platform/exynos4-is/fimc-core.c | 59 -------------------
>  1 file changed, 59 deletions(-)
> 

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
