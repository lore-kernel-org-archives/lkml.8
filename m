Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F118AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D9A2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="imy5ooMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgHGRpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHGRpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:45:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B909EC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 10:45:34 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w17so1386492ply.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 10:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ODTsy2l7DCvq5FYJ8roRFOkitYdJCNz7j4/THusjSsM=;
        b=imy5ooMKwPOS0aQs/RWCcwaV4isPXG8mWYl2sIGl+iPsUvcGzM0h4xxEvLSkIFLLuL
         YwZz5JCtYM2ZHFrK+mzJtUsMSa0wfckdKf3XDM06fGN5DkreVDafwk2j8jIQW2HFfhDk
         2Zn+4QEHKi5m4UqRF7UXyhK2JMdJ2oYl76PrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ODTsy2l7DCvq5FYJ8roRFOkitYdJCNz7j4/THusjSsM=;
        b=I6q6hRAeKKwpkkSTGbc4yWEnQkENlNHTvfBzwEw+aOwvfqA0kJUx97Hwa2XgNvpcHF
         q5LpLvPuNjgEhMy7ajs3yy1ivxzjXKxMDIVjwbQT7kBwWX3FLlmCzj2ln/wjkdpg0vwH
         6TMUeSOm0xdQaNydc0+lR2O+TXrGqyaagE///rmqdDXKJsF0kZ48WhWomYYqkQbnW261
         iN1PPZaTtjWeETX29DcsVg9reOY49fP/AI3LPI+P9VJ59ObemLA54Kav/nIkqwBdiReS
         ZVnCvvdmh/b1W74dChOLV8YiGpZAL2PZTDsQSYfblXviEvFWhXSktzCke7HpcgRFYxPp
         HdCg==
X-Gm-Message-State: AOAM5310QWzm35bESymJc3Xqk4subWSVgQE0wO8R3N962iqy/XfS4L4L
        CPQZPrSBCgEHySDulf18lLAWfA==
X-Google-Smtp-Source: ABdhPJx2xXxTtydgZISi3Tc3Pg8IIcA/ofEJbMfE0aTRRh8Yk2tk92FIkSWt2cKTg0eG8EBDfQwWZQ==
X-Received: by 2002:a17:90b:2092:: with SMTP id hb18mr15011251pjb.118.1596822333949;
        Fri, 07 Aug 2020 10:45:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e29sm4990922pfj.92.2020.08.07.10.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 10:45:33 -0700 (PDT)
Date:   Fri, 7 Aug 2020 10:45:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>
Subject: Re: [Latest Git kernel/Linux-next kernel] Xorg doesn't start after
 the seccomp updates v5.9-rc1
Message-ID: <202008071043.2EABB8D24B@keescook>
References: <67cd9693-10bc-5aa5-0898-ff2ac1f9c725@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67cd9693-10bc-5aa5-0898-ff2ac1f9c725@xenosoft.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 04:45:14PM +0200, Christian Zigotzky wrote:
> But Xorg works on Ubuntu 10.04.4 (PowerPC 32-bit), openSUSE Tumbleweed
> 20190722 PPC64 and on Fedora 27 PPC64 with the latest Git kernel.
> 
> I bisected today [4].
> 
> Result: net/scm: Regularize compat handling of scm_detach_fds()
> (c0029de50982c1fb215330a5f9d433cec0cfd8cc) [5] is the first bad commit.
> 
> This commit has been merged with the seccomp updates v5.9-rc1 on 2020-08-04
> 14:11:08 -0700 [1]. Since these updates, Xorg doesn't start anymore on some
> Linux distributions.

Hi! Thanks for bisecting; yes, sorry for the trouble (I'm still trying
to understand why my compat tests _passed_...). Regardless, can you try
this patch:

https://lore.kernel.org/lkml/20200807173609.GJ4402@mussarela/

-- 
Kees Cook
