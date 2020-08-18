Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDA7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95C1D206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l2ujWwd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgHRTe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHRTeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:34:23 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E2CC061343
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:34:23 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mt12so2048pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tc2Y/7wRUGR7GO4HI5D5o1JOg/02jGLqqiMyiLuhQfs=;
        b=l2ujWwd6BMG71uJ+lE/u8hWi1z2UCA7KAWMpdnE1WzCwTe07wkyg50hoJQMVi/k5vS
         10b1jlIwnAAB1jWtkPfeKBvqJMoyZBbScKD9sht7QrmX7W7SSdxi+jcaauUGkGBX0fzB
         CHA2p5bBmBuY5K3LiVDClVPuHglS30NtSusnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tc2Y/7wRUGR7GO4HI5D5o1JOg/02jGLqqiMyiLuhQfs=;
        b=riP//L8XNhJAfsjvSLf3PjUXb1+a8t3OOJn8++YgU55CXZzlcakQFpnlsTU+hpEsuD
         wSrTUI3oxfr7MEptHJ696p33lKyg6rxb5p0YszaM68+qpguaszaiHjtIekdfS94V2Rp+
         KyTcgVZfDsJhJEmoJAcHSxNedOHK/DytLvLV1JqvpI/KuwrnF+XiIMyRLElmj2skWwJ0
         W4GyqtQ1a4WUNFqJG+xavQjJjYOq9iF0AX/75fpWUQEU5JTEXZYDllGfXuBdl6v9Dw3A
         fhJSgqrb9RLynmxqo7Hs/beEBuhNLN8cyOhhULLiS63dGKme5zoMIsvnEMIXUct/gBN8
         UTYA==
X-Gm-Message-State: AOAM530PRYGCqqSbAS39QpWDTH6SrrtI7xgKVm9vZzqVvg0IdzNSNb/U
        6hlZYsr2o7PGoxizt6nHzzoZ/Q==
X-Google-Smtp-Source: ABdhPJyRtGUPEH8hQB3PYbEreefecpWhQ0b3Q4RWm7821VkslhtwepOtRIsUHn68CV2l8iU1xIwP+A==
X-Received: by 2002:a17:902:9f8a:: with SMTP id g10mr16598513plq.158.1597779263268;
        Tue, 18 Aug 2020 12:34:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k21sm22549273pgl.0.2020.08.18.12.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:34:22 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:34:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/11] fs: don't allow kernel reads and writes without
 iter ops
Message-ID: <202008181234.B1D9572C@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817073212.830069-3-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 09:32:03AM +0200, Christoph Hellwig wrote:
> Don't allow calling ->read or ->write with set_fs as a preparation for
> killing off set_fs.  All the instances that we use kernel_read/write on
> are using the iter ops already.
> 
> If a file has both the regular ->read/->write methods and the iter
> variants those could have different semantics for messed up enough
> drivers.  Also fails the kernel access to them in that case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
