Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B586C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2743420731
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkedV2Zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgEHJCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:02:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36189 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725379AbgEHJCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588928529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aJ/vCWQziGGAHdCpfAy+xf34kA3gxYY1I2GtZ3omRwc=;
        b=HkedV2Zy9FEJ6GShwhcmgpGP5Kekj2PLC0ineQRcKuB7cw116MMYaB56tpVfXeq97yfDHf
        DXtGoU6S9zXiUdaLrcGi8jxFbVS+6qgrqYKvi4C2rM9tPTyAI5//G6gUnHrh/RQpbJ3IWV
        eNu8XpQ3pLZGDrBkCzpQBaB3wl/hGxw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-L8LX0ymdN766N0oSyWrhPQ-1; Fri, 08 May 2020 05:02:06 -0400
X-MC-Unique: L8LX0ymdN766N0oSyWrhPQ-1
Received: by mail-wr1-f69.google.com with SMTP id o6so581376wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 02:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aJ/vCWQziGGAHdCpfAy+xf34kA3gxYY1I2GtZ3omRwc=;
        b=gqX+9DxZgwcD+9He5bB8GGQc3a0+RFp8ycE5MEkTRWTwGhSja/fyzWjY00EztOOOLM
         VaT5wA+LdveDkzPvLu4fg/LeTnMsDBYlxBL/S6i73m7lEbRnehR2M/zDXYvFLcPp20K8
         rOzh2r8mhqdc+Y+YSAhDbrYSu07ELOBRZ6QAXW/y9sDzh99FX2Tmv/SfDQ/cDN6PhVSJ
         vhdCuOX1qr4bmEF9+UPZBphNCTSqnlzdBeevmFIAaHfmZT5+Yl9eB5UB5uK1RWkWT2X5
         b/KPT6RWzVfH8pU0ryo5lbf8qifykbilqPYqDkE1h4do+aZpwjT5BkxT2jIGtD+Opq08
         leUA==
X-Gm-Message-State: AGi0PuYN9xLniqp8lrKHHRncVwQuaeuW34xU0AErJXP3MxKLJmgy3/k9
        WUZ7yUPmCvIm/P/2ku5xLuSQ9totxEPQCtEk8oVNexbf2GEBHCNLOH83YDR26L84r7OJ+cvxGuG
        pE9/7eSpNrpmP7tonb4NUNsJ5
X-Received: by 2002:a1c:43c6:: with SMTP id q189mr14065931wma.115.1588928525218;
        Fri, 08 May 2020 02:02:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypKVJ+1XBDDa7icMSyR+gktwvOZygoadhbzew8DJUfzWdJIWSwlrwRERyiQeCk7fHt6InTegBg==
X-Received: by 2002:a1c:43c6:: with SMTP id q189mr14065904wma.115.1588928524959;
        Fri, 08 May 2020 02:02:04 -0700 (PDT)
Received: from localhost ([2001:470:5b39:28:1273:be38:bc73:5c36])
        by smtp.gmail.com with ESMTPSA id c83sm12462768wmd.23.2020.05.08.02.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 02:02:04 -0700 (PDT)
Date:   Fri, 8 May 2020 11:02:02 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] Kconfig: default to CC_OPTIMIZE_FOR_PERFORMANCE_O3 for
 gcc >= 10
Message-ID: <20200508090202.7s3kcqpvpxx32syu@butterfly.localdomain>
References: <20200507224530.2993316-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507224530.2993316-1-Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 04:45:30PM -0600, Jason A. Donenfeld wrote:
> GCC 10 appears to have changed -O2 in order to make compilation time
> faster when using -flto, seemingly at the expense of performance, in
> particular with regards to how the inliner works. Since -O3 these days
> shouldn't have the same set of bugs as 10 years ago, this commit
> defaults new kernel compiles to -O3 when using gcc >= 10.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  init/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 9e22ee8fbd75..fab3f810a68d 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1245,7 +1245,8 @@ config BOOT_CONFIG
>  
>  choice
>  	prompt "Compiler optimization level"
> -	default CC_OPTIMIZE_FOR_PERFORMANCE
> +	default CC_OPTIMIZE_FOR_PERFORMANCE_O3 if GCC_VERSION >= 100000
> +	default CC_OPTIMIZE_FOR_PERFORMANCE if (GCC_VERSION < 100000 || CC_IS_CLANG)
>  
>  config CC_OPTIMIZE_FOR_PERFORMANCE
>  	bool "Optimize for performance (-O2)"
> -- 
> 2.26.2
> 

Should we untangle -O3 from depending on ARC first maybe?

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer

