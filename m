Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C35C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 02:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 926F62078D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 02:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nzua3Ghu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgH0Cbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 22:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgH0Cbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 22:31:42 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE72CC0612A0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 19:31:42 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t9so2298710pfq.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 19:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=49yMxH6diGPmKrZzMb69pa6ebAiIJKOxRAHVKeFG8KQ=;
        b=nzua3Ghu75BXNzDuPG/7vO5dh7uJ+wvamCkqYZ6Fq6grznw9z+7sTkMwkDTQuOT4mj
         RL4aM32wQphKxz3CI7fWgU/sart6GTa+UHZsfHuRlXDTaKiz1klAf9DBh311fRqDgxuK
         96mOy2VPdz9/2Dr6Pfmy2OeA9ggwAP3xrxVRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=49yMxH6diGPmKrZzMb69pa6ebAiIJKOxRAHVKeFG8KQ=;
        b=HfVj0S8chr2va9ZTgIqM6NxqteRYyQcoQg31Jks3K5d0UX4lpKlMUqv4BWW4ANxcUw
         4ojNoGtb7Ef3Td5LSzubSfRFoePpyH89Yzb7bltZXkBJY30bbJsMghgsmBqfjKhJghN8
         TfUSlEsaxMF2xJ7zCE+yB2aCbfgA899g+Ld8jmWV316OwVItxS5iOubjc4xCtEgItd7S
         wKrRXLtMl5ods5mIu06nDKi4d6HQue185qAKotXy0V8Fa9jYiIyaoUW0Qw2XyDgUxBTQ
         D7tmsg7P0fVaYR2NoN/3AHcTdPXaUn+giqAvcW42Z3H3dkikhtZjj5avpMnn21xxoW50
         GJmw==
X-Gm-Message-State: AOAM5323CUQ4YXFDpfZoVa1A3WiXHTr80hPG4Qg86ZqB7bekSi/O8PGJ
        eN8s4fkI0tdNoEwyPxJ5xHcwNw==
X-Google-Smtp-Source: ABdhPJxdskc51Ch/jDcJnLOl2DbAFS3Bt9aQlYLddIvMn/PUy2yGf0YlhGNRnyFSFQt+q/WnlfNvng==
X-Received: by 2002:a63:9a41:: with SMTP id e1mr10278787pgo.183.1598495502091;
        Wed, 26 Aug 2020 19:31:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a1sm586212pfd.65.2020.08.26.19.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 19:31:41 -0700 (PDT)
Date:   Wed, 26 Aug 2020 19:31:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] linux/kernel.h: add container_from()
Message-ID: <202008261929.A50D0DB3E8@keescook>
References: <20200827013636.149307-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827013636.149307-1-allen.lkml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 07:06:36AM +0530, Allen Pais wrote:
> Introduce container_from() as a generic helper instead of
> sub-systems defining a private from_* API
> (Eg: from_tasklets recently introduced in
> 12cc923f1ccc: Tasklet: Introduce new initialization API)
> 
> The helper is similar to container_of() in argument order
> with the difference of naming the containing structure instead
> of having to specify its type.
> 
> Suggested-by: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

Acked-by: Kees Cook <keescook@chromium.org>

Who can carry this so it can get used by multiple trees? Should I keep a
git branch folks should merge when taking Allen's conversion patches?

(In the future we can do a treewide replacement of the
subsystem-specific from*() macros into container_from())

Thanks!

-- 
Kees Cook
