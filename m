Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D204BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A52C72053B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KbxBnfch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbgFWXK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387829AbgFWXK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:10:26 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EE2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:10:26 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so126384plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7CGyJvgDfqa7MpUh5embDkSIvDYKMmy2PpptbOHIrEM=;
        b=KbxBnfchg2RNBRCTFJcBQBqbQAmyNQh/HXi+viuVz7TZ4U9dkUGXHvTy44WpHvxokb
         87n0dBDZDidnAzVyqWRq33wij2V0sVhaVFfIaucT3qotWt3zH2jjPWJkJS2kQILaoMQL
         yRN9ZLg8FrVnGR1hLX+DaepKcjahJ0EpkhK5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7CGyJvgDfqa7MpUh5embDkSIvDYKMmy2PpptbOHIrEM=;
        b=UoFtyIWKuFB/r5QdYh5STCJqGlgbZTtzfaH0fnOUvoe2TXi4EZm5dgPjxe3MyeiXUf
         TPsH8Du523ulgYALwsJvoR/eJLQ6qFyd/nCnnDlI95aukqNcEfIMUSYKufQ03+Nn1jEK
         6TNEh07C4w56YVP9Vfd/Jj2/dz5FfNTJq0McsuzScasCuW9WWv7a+kA6NsceTvTM9WvW
         BUlF4v6X5yggga8qNJOjHKTB4HC3aDBPJHWCukGYpStKgE7CegaFJP7eVdVDrEYUZZUp
         iK5zQWt5Gk2sB18wxcBz+cAeYHhrnbkecz6eWqyVqZ9Bry0qm9vURvfXFuHp9Dxq/ZIz
         emmg==
X-Gm-Message-State: AOAM532BP8mlWxiuAJIpYoLgzVLhf+Rlu2IGsM16nluDeyX64HcgzKEp
        xCIb9jBfz0RnOLdtE7hN16MR4Q==
X-Google-Smtp-Source: ABdhPJxWiopvITqQoUsjOrkPVJLPViTKTyfPSXoXAyVLmwAy3lfwE9jEZ/6WkBPSzCGcW/dk/mk+LA==
X-Received: by 2002:a17:90a:d186:: with SMTP id fu6mr3871728pjb.185.1592953825608;
        Tue, 23 Jun 2020 16:10:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r7sm13275139pfc.183.2020.06.23.16.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 16:10:24 -0700 (PDT)
Date:   Tue, 23 Jun 2020 16:10:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
Message-ID: <202006231610.4993DC5@keescook>
References: <20200529200347.2464284-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529200347.2464284-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 01:03:43PM -0700, Kees Cook wrote:
> Hi Greg,
> 
> Can you please apply these patches to your drivers/misc tree for LKDTM?
> It's mostly a collection of fixes and improvements and tweaks to the
> selftest integration.

Friendly ping -- we're past -rc2 now. :)

Thanks!

-Kees

> 
> Thanks!
> 
> -Kees
> 
> Kees Cook (4):
>   lkdtm: Avoid more compiler optimizations for bad writes
>   lkdtm/heap: Avoid edge and middle of slabs
>   selftests/lkdtm: Reset WARN_ONCE to avoid false negatives
>   lkdtm: Make arch-specific tests always available
> 
>  drivers/misc/lkdtm/bugs.c               | 45 +++++++++++++------------
>  drivers/misc/lkdtm/heap.c               |  9 ++---
>  drivers/misc/lkdtm/lkdtm.h              |  2 --
>  drivers/misc/lkdtm/perms.c              | 22 ++++++++----
>  drivers/misc/lkdtm/usercopy.c           |  7 ++--
>  tools/testing/selftests/lkdtm/run.sh    |  6 ++++
>  tools/testing/selftests/lkdtm/tests.txt |  1 +
>  7 files changed, 56 insertions(+), 36 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
Kees Cook
