Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67247C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40EB3207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gwytSsmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgFZPXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFZPXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:23:16 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23912C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:23:16 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cv18so1646315pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wzxRCwXrTp9pra+6lnRKOjX9XhXo/vr4ZCsuBD6HuVs=;
        b=gwytSsmFplYFx5bQzChZW4ZBybTa1p+pyLKIKwAWKhBdGjhOGMxt0cgcRBw0hYw4kK
         vYd7TzPGAYaSSo+Po7oPlGsEZQLpSUO+QmhcRNnUglYTKYlqXlL3sLY8OY00s/mC/0Sp
         jEEsCrEs+dn4QvM7AhE7FViVdaJpDyclmVuqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wzxRCwXrTp9pra+6lnRKOjX9XhXo/vr4ZCsuBD6HuVs=;
        b=a1TP3C97+7Wk5VADrpLnuk7/vcpWroe8byUHRCwyYKcxQXANQ7rVRUv/cpiNAZOZqb
         1xEgdqzsmyNiQ+E/dH6FlR3aAl6HQau7gXGQJtXkNUh9iKEygOCCSjVdbPc0Br2BDy7m
         ng9iNnWSrv+5MWoWH+QGlUm2V6jHjndfu8+b30Baqsp8qRx3aqmJp7hC1w3QdVhJYPv2
         6H1iGNvRX+zB1+4jIcAJXbSYSwiWd1Knh6N4FN/McChoP+Bz1OvHJw4yxaTXhvU7ThGR
         bUwuYsk7Pdw/mgST8kf2uwiVPMlzmaP8+5FmUhMJM7hTKsQxnR8f00ngUcaeQe2wjzMm
         2rNA==
X-Gm-Message-State: AOAM530/GFeqQ9ORf+Al8gAbcj3SObw3meE+bb+eZ7LTsyCLsq1gmjuR
        WyhSq54AsuqWmmzPNN9auPNkyA==
X-Google-Smtp-Source: ABdhPJx4Wuwe+drzHLg9tLtrReQAK0xHDZIu4jqj+/0+/ZBY18JMJuroUvMk6IoQpbrxVtXyghdoWA==
X-Received: by 2002:a17:90a:fcc:: with SMTP id 70mr3926943pjz.106.1593184995653;
        Fri, 26 Jun 2020 08:23:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u2sm2638273pfl.21.2020.06.26.08.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:23:14 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:23:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] misc: lkdtm: Always provide prototype for
 lkdtm_DOUBLE_FAULT()
Message-ID: <202006260821.0079FA827@keescook>
References: <20200626130525.389469-1-lee.jones@linaro.org>
 <20200626130525.389469-6-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200626130525.389469-6-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:05:20PM +0100, Lee Jones wrote:
> lkdtm_DOUBLE_FAULT() already has internal logic to handle
> !CONFIG_X86_32.  Compiling out the prototype actually prevents
> that logic from being useful.
> 
> Fixes the following W=1 warning:
> 
>  drivers/misc/lkdtm/bugs.c: At top level:
>  drivers/misc/lkdtm/bugs.c:420:6: warning: no previous prototype for ‘lkdtm_DOUBLE_FAULT’ [-Wmissing-prototypes]
>  420 | void lkdtm_DOUBLE_FAULT(void)
>  | ^~~~~~~~~~~~~~~~~~
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Thanks! This change is actually already part of another
patch and is waiting for Greg to pick up:
https://lore.kernel.org/lkml/20200529200347.2464284-5-keescook@chromium.org/

-- 
Kees Cook
