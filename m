Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5369C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECF420663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JHxuqay5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgGPClo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 22:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGPCln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 22:41:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C7CC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 19:41:43 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so4099444pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 19:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jqVUIDpGCAipRS+ecPG15XM7TieBrIaHAd9mloEKAfg=;
        b=JHxuqay54G74N6vgudi5DVmCfb4LywmFRGcKR/VpugHM8EUk43/s0CR2VP3/5kLIdx
         UvyJZpGYeun6i18sh6eYGHmfAvaouR2XxCQugfkAC5YUal7+JFzkKqNxJm/QVlqbFxeq
         Z/OHtPeZEPIIoWCPsB5YvZ+H78MRYn8SrV2cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jqVUIDpGCAipRS+ecPG15XM7TieBrIaHAd9mloEKAfg=;
        b=WqUyC9VI4UOHEpyWiBNdeg6Zic95B2Pn2n+3UtHh8x7nDbpqsxY4SQK9sij0fCUtRN
         2++3qi+nfF1qUGBYw/Q8Dg8O1yf2uNfy/9ILJkNOD7yrhplpwAoeejTx47pSc3adNBBh
         96hBInaCEnfCkZR4ajgiTNWkX8yk1qE7kXKNybT92ZnOdCx+zCaBaLHYN7Y+DBsK5PdE
         kNpXIerjph46STHdV6k3ZgM/QQl7TNhxeXS3aZyRT4zWGhqpdDtX62glMqUL6GqrUzyI
         NyTKTPqEC5tHsA+3BUrH7kLtbUZKp9DTb6oeReaqspc70eQCNi2Zmxuzj+Iq9QXcVDp6
         J6rg==
X-Gm-Message-State: AOAM531fS4j785jLC57gZHKmBibd/Qi5sn5U3HCr+jQUYbIfPfEJ+MxA
        zf/Ozhm2hpwy1t4l/U09uy1cNA==
X-Google-Smtp-Source: ABdhPJzMM1zSFnYR3x2DnMDjCvyMLDkK5b+zSz4ErPk651/nIfO+yLt/HL7ZZk7cQTCfVqxRQyJNQw==
X-Received: by 2002:a65:6883:: with SMTP id e3mr2401712pgt.5.1594867303051;
        Wed, 15 Jul 2020 19:41:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z2sm3271605pff.36.2020.07.15.19.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 19:41:42 -0700 (PDT)
Date:   Wed, 15 Jul 2020 19:41:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC 0/3] kunit: add support to use modules
Message-ID: <202007151939.62EFE6F@keescook>
References: <20200715031120.1002016-1-vitor@massaru.org>
 <CABVgOSkBAiMSMzCx62_CRo_0e2SGdvRWZ0dSC4t628YJBw-3Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSkBAiMSMzCx62_CRo_0e2SGdvRWZ0dSC4t628YJBw-3Aw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 11:47:11AM +0800, David Gow wrote:
> - The inheriting of the mm stuff still means that
> copy_{from,to}_user() will only work if loaded as a module. This
> really needs to be documented. (Ideally, we'd find a way of having
> this work even for built-in tests, but I don't have any real ideas as
> to how that could be done).

I'd like to better understand this ... are there conditions where
vm_mmap() doesn't work? I thought this would either use current() (e.g.
how LKDTM uses it when getting triggered from debugfs), or use init_mm.

I'd really like to see the mm patch more well described/justified.

-- 
Kees Cook
