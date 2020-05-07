Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A504C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E63208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oe0PU5NZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgEGTpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726326AbgEGTpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:45:44 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780C2C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 12:45:43 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t7so2500149plr.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 12:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IbfxBGzYrCHzzfTqHU4rAuwYtieZW8IZ52DJWF9xsUo=;
        b=Oe0PU5NZ2azBtHLJKpX3ha1q5sVBZ4ZHO+l13jT6Erh0ACOWTwKch462jXBcFXyD24
         s/knbIwKHieGmlCElrOSj0hDSdIyuGY9V7VyJlbqfYR/GtTzoLQNjVaFkcRQYiSY3Hh+
         93C47ECe6RAr7s+FMJPAHvDax6a3hMvgtnLag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IbfxBGzYrCHzzfTqHU4rAuwYtieZW8IZ52DJWF9xsUo=;
        b=ThnYoPMIazo/DS27Z65U4GnPZz+LFiiNUMVWrvUCjREAvrOV4mSRTR4fSiYcWaDVX5
         kqlv/t0FVim4WZtmVYsA3vOT4UH0xS00QJ0Ju8KJCx5I15SDGLSBlJ1/hRt4547sFxiG
         tbQRQrseE4KYqFCFOgRgjwruNS4Wrj5T1mcX3lbpnhlalVfsGMMRf4tVMmu9eRGUYrNb
         W6ubUsHx9T3cjonf/6pYc7iEtQ8ojOX32v19MgGvR+hlzoJqUKD9zO0Rk+H/ADvDUS6Z
         9rRPUSdsUya5e6KOqhX2RS2sjQTNUwV0D10Jd8gL40hKKqGdGiIuy/sCKeMfpZQqIEOO
         o5zg==
X-Gm-Message-State: AGi0Puaun2ST0VqmArmjL9UzR50qxuygZH8sC3TcDNDsaTN7s16LzT7/
        OvmAKv6wcRT9zirC6ENMGE6krg==
X-Google-Smtp-Source: APiQypLBhRh1xD+zBIxgBZHXiwlmz2uQ7tdEn6c4Ababtg8mWoyu4ca2B3WYR9T4i3qlo9eH8sYYZw==
X-Received: by 2002:a17:902:eed1:: with SMTP id h17mr14686969plb.312.1588880743038;
        Thu, 07 May 2020 12:45:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l30sm536526pje.34.2020.05.07.12.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 12:45:42 -0700 (PDT)
Date:   Thu, 7 May 2020 12:45:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 00/11] pstore: mtd: support crash log to block and mtd
 device
Message-ID: <202005071244.AAD82F41F@keescook>
References: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 04:54:55PM +0800, WeiXiong Liao wrote:
> [PATCH v3]:
> 1. patch 1~10: a lot of improvements according to Kees Cook <keescook@chromium.org>
>                including rename module, typo, reorder, rewrite document, bugs
> 			   and so on.
> 2. patch 11: rename funtions of pstore/blk and update document.

This is looking good. I'm going to update it for the recent max_reason
series, and make some tweaks here and there and send out a v4 tomorrow
to see what you think. Thanks for your patience!

-- 
Kees Cook
