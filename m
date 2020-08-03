Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09251C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE7172064B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pyA0kJeP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wDhSnfhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgHCMNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCMNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:13:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1958C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 05:13:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596456794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rmIWem01+9lmXN3VtjDT3yiVThwq4jm87twPB6Hb5rI=;
        b=pyA0kJePgUH92ctdJsnYSyuvp4ZyMNxskf6iTcvWXxCM8fNJvkhxlw5XjNIppBFokvazLP
        yvsxaopLC84SEa/GtEeWt4/BXjelqAPZ1YEBkcYakMlULPT3nhS3jt/AlnzDsOvcoBxHsu
        uoOq0LRUE1ONP1rrwkftN3OgzQAIxaYzW4yMTeNKEtGXwDeZRRsNXDzpUwg2D7YTvRtYav
        m2hhoDN7xqX+3n4yjsnxr5zHmLRSiKEkI6jKXQZ0oj4D1OrS1MoGT3568QYC/vtUsBWfKL
        hd90EvLPBtF/cO6O5P6zf5K5pbu10VWmL9iuqAcuxsj7nxprzAWn7QGRbUl1VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596456794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rmIWem01+9lmXN3VtjDT3yiVThwq4jm87twPB6Hb5rI=;
        b=wDhSnfhxzkwcAZUm4UIv/OGucSwWdS/Z8yZLHTMH06lc8t1yePkBPhWgKeLprOPx+Y6Sb8
        7Vnq6FDCw+QsHNBg==
To:     Sven Schnelle <svens@linux.ibm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH 1/2] vdso: allow to add architecture-specific vdso data
In-Reply-To: <20200803055645.79042-2-svens@linux.ibm.com>
References: <20200803055645.79042-1-svens@linux.ibm.com> <20200803055645.79042-2-svens@linux.ibm.com>
Date:   Mon, 03 Aug 2020 14:13:13 +0200
Message-ID: <87ime0lyg6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven,

Sven Schnelle <svens@linux.ibm.com> writes:
>  source "scripts/gcc-plugins/Kconfig"
> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
> index 7955c56d6b3c..74e730238ce6 100644
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -19,6 +19,10 @@
>  #include <vdso/time32.h>
>  #include <vdso/time64.h>
>  
> +#ifdef CONFIG_ARCH_HAS_VDSO_DATA
> +#include <asm/vdso/data.h>
> +#endif
> +
>  #define VDSO_BASES	(CLOCK_TAI + 1)
>  #define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
>  			 BIT(CLOCK_MONOTONIC)		| \
> @@ -97,6 +101,9 @@ struct vdso_data {
>  	s32			tz_dsttime;
>  	u32			hrtimer_res;
>  	u32			__unused;
> +#ifdef CONFIG_ARCH_HAS_VDSO_DATA
> +	struct arch_vdso_data arch;
> +#endif

just a few nits.

Can you please spare that #ifdef and do:

#ifdef CONFIG_ARCH_HAS_VDSO_DATA
#include <asm/vdso/data.h>
#else
struct arch_vdso_data {};
#endif

Please keep the tabular alignment of the struct members and add kernel
doc in the comment above the struct.

Aside of that 'arch' is not really a intuitive name. 'arch_data' or
something like that. Hmm?

Thanks,

        tglx


