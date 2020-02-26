Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71103C4BA2D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4911424679
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="p/9RYB8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgBZXsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:48:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40556 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgBZXsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:48:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so338346plp.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 15:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=UW09MiMy2GaFwFAJ/K3zl0bfOBctGn1N/5oBnyfXBBo=;
        b=p/9RYB8kgMB0e8z5IDwOgAal1bA5SLd2SFKLv25Ung8/p0BhAB86euEgkobREoxfmp
         yKqg6pDpBKuUpdrEwTr9vEVyrfSL+cXkHm3hBTYBDohCfSV3uahMaoXMOOdshJ4aR+Fu
         V1toxermAqGtoIKM5MGgcSal+/esLdjYKwiLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UW09MiMy2GaFwFAJ/K3zl0bfOBctGn1N/5oBnyfXBBo=;
        b=KbiLdbAM0ktHSUBRvxHQHDh1cL3IqJ1N7wqbM7xq7nRST98qqTOx214OoKX8bH35Lk
         E0ql2qTGop/3LeTYJWn+4mhBPd4jtJjDjkLByroG79esSRcOJA9R7lLr5Ls2eEgIyxkk
         /AYxaVktEAITpCeOKjoFoQQEKJ5LVgY8L3YXG8Te4d1PU4Yskir6WR8qxPj8GpDDwfB6
         on0gspoHtahkuJkONrP8HiXgD5Tn6JccAF8DRD5ynov5/1bJynUHdpWw3PzLvAloOLWY
         82XZcuXliLRoXxDabsCSYIrdPY0aTrc519hSkQSS+4VkD975eEZgbS00WnIkcn1hH40E
         KYew==
X-Gm-Message-State: APjAAAXMOc6m7hF5SLGSWhG58LC5aWXedicI+IpqXc5baAa9YQv8w1ZZ
        JNg6Pi061Xyk0h/bQHFGAGsIn76zF84=
X-Google-Smtp-Source: APXvYqwO0geOgUQ2VFTz4udUkoL6gA+i5YLlDwNbhBkmZKUuVfAD8LuxK/3KK4B4kuG2YBBwmhPS2w==
X-Received: by 2002:a17:902:ba93:: with SMTP id k19mr1782695pls.197.1582760911494;
        Wed, 26 Feb 2020 15:48:31 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-5952-947b-051c-ea5f.static.ipv6.internode.on.net. [2001:44b8:1113:6700:5952:947b:51c:ea5f])
        by smtp.gmail.com with ESMTPSA id f127sm4475804pfa.112.2020.02.26.15.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 15:48:30 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org, dvyukov@google.com,
        christophe.leroy@c-s.fr
Subject: Re: [PATCH v2 0/3] Fix some incompatibilites between KASAN and FORTIFY_SOURCE
In-Reply-To: <20200116062625.32692-1-dja@axtens.net>
References: <20200116062625.32692-1-dja@axtens.net>
Date:   Thu, 27 Feb 2020 10:48:26 +1100
Message-ID: <87o8tkrjud.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:

> 3 KASAN self-tests fail on a kernel with both KASAN and FORTIFY_SOURCE:
> memchr, memcmp and strlen. I have observed this on x86 and powerpc.
>
> When FORTIFY_SOURCE is on, a number of functions are replaced with
> fortified versions, which attempt to check the sizes of the
> operands. However, these functions often directly invoke __builtin_foo()
> once they have performed the fortify check.
>
> This breaks things in 2 ways:
>
>  - the three function calls are technically dead code, and can be
>    eliminated. When __builtin_ versions are used, the compiler can detect
>    this.
>
>  - Using __builtins may bypass KASAN checks if the compiler decides to
>    inline it's own implementation as sequence of instructions, rather than
>    emit a function call that goes out to a KASAN-instrumented
>    implementation.
>
> The patches address each reason in turn. Finally, test_memcmp used a
> stack array without explicit initialisation, which can sometimes break
> too, so fix that up.

Hi all,

It doesn't look like this has been picked up yet. Is there anything I
can do to help things along?

Regards,
Daniel

>
> v2: - some cleanups, don't mess with arch code as I missed some wrinkles.
>     - add stack array init (patch 3)
>
> Daniel Axtens (3):
>   kasan: stop tests being eliminated as dead code with FORTIFY_SOURCE
>   string.h: fix incompatibility between FORTIFY_SOURCE and KASAN
>   kasan: initialise array in kasan_memcmp test
>
>  include/linux/string.h | 60 +++++++++++++++++++++++++++++++++---------
>  lib/test_kasan.c       | 32 +++++++++++++---------
>  2 files changed, 68 insertions(+), 24 deletions(-)
>
> -- 
> 2.20.1
