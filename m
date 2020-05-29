Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074B4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA93207F9
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P4jV66QA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgE2P74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgE2P7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:59:54 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C87C08C5C6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:59:54 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id i17so1297612pli.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kurCmkIiK6G16S1AS8MjE3nGZ5QMFbDaJnDr19QRtow=;
        b=P4jV66QAnPYba6PsFDUDr1f6sy7Ye12Q/5dWhR5ZwIKceETcyEqNKs1s6UYIKj140U
         DKCSzND8cGlwh197eDms/epq3q4w1x6YqaqhjBLumAbsr1EMuO42IE/3ZgKLrHD0azZb
         WLuikp4YBl2qTTbDlCepkKiRA02G8QEjZLHiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kurCmkIiK6G16S1AS8MjE3nGZ5QMFbDaJnDr19QRtow=;
        b=TcJ2HKRRe5IlvyBRB8hu3UVR+//exit+XOD1DqvqmST/R/F+Tj3nqhS1hwaujyoe9o
         EJl8RQSDFVyRRjMJ6uHmJqMGgMSOqmEinMMdndHOpqAwF5rGVJmQ8CABJJjWMxTqb7K6
         ncRM70oOmkAItdmmQb4FfNYKCcVq3xfYYp76drIuEalRTsvVnkzC1fuMISC0Qv38gpRz
         000Jog+irBUNnLBvOJfsLRQ+Ij7PIh5myyEuQ4Q3XjZnWFF2ybTY1Yf+Jbb143O/ElhR
         IFGSRgOal9rOBQk5rnxFiKcHVJyEFrfXdkeGl82i2/0nES2zAFf0yGYRBzTyfUnx0qZF
         nNRQ==
X-Gm-Message-State: AOAM5336DeAnXozh1Jjhq+iBlvzk1sy4SS2lIdoDyNxNCPW9A3zoW5II
        id1RrPboHBMGSTFZh8Z7n0UqMMmheos=
X-Google-Smtp-Source: ABdhPJwtQNV2OvNaIRbkCIkqCwxriayrw68HJNbfr/VBL6ehccOxrthYFVFhrqhSbdeBanDCFD9b0A==
X-Received: by 2002:a17:90a:1a17:: with SMTP id 23mr10401588pjk.198.1590767993701;
        Fri, 29 May 2020 08:59:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id gt10sm8447666pjb.30.2020.05.29.08.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 08:59:53 -0700 (PDT)
Date:   Fri, 29 May 2020 08:59:52 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org
Subject: Re: [PATCH v4] Bluetooth: hci_qca: Improve controller ID info log
 level
Message-ID: <20200529155952.GN4525@google.com>
References: <1590763573-8302-1-git-send-email-zijuhu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1590763573-8302-1-git-send-email-zijuhu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 10:46:13PM +0800, Zijun Hu wrote:
> Controller ID info got by VSC EDL_PATCH_GETVER is very
> important, so improve its log level from DEBUG to INFO.
> 
> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>

As requested earlier, please add the tags from previous
versions (in this case my 'Reviewed-by' tag from v2/v3),
unless the new patch has substantial changes.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
