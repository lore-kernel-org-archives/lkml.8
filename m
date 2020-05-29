Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B76C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 498F0207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C1iYwcTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgE2F5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 01:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgE2F5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 01:57:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D625AC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 22:57:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id i17so629569pli.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 22:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SmdvPVUjEJ1MorlU0qEr+89lJ/TqPv17jXhkR0M9z6I=;
        b=C1iYwcTi9aU+6iTf6LemO5XEeea0R+4156ui+IRXga9O5+NrAUPdc7maNHvpPiBiCl
         6YD3bmSXGXrdQJWmiR95iq1NdXs9RwvipRqzY+9vU0+jUMhm2YnlIzIBmpBe7qLCSzSD
         2KLNWE09RYUeiTCRuSoxNEoePktj0FjsFVVaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SmdvPVUjEJ1MorlU0qEr+89lJ/TqPv17jXhkR0M9z6I=;
        b=LOwWEcpy64NaY5o8S3nzK3mltTZt4ds2p6XozQmBX8felttHLvrL7Cw84jQisIooLN
         9W9nvlrVh89ntRAzAhhmszfTVUzOM+WMRENnRoIb+opvRPNp5Vq9rLkaS0e5jGuf3Uh/
         HpiYgz82Fog9ioslGWp2ciX0cwvdnZMqHLqPyiEmm5QlB3JytMMbRhCA22HfxWrKOSFC
         yNmXzaxhleWjBufxfwbOCGUWO15vlyWorA3P3TLr2fpj5ZV7pohB90YRTzKHukuztDG9
         SiHulfy+oLRf38HHPjOWPk0rWuiq4yXg5KDURoj1Rzw+/1A7z2kJfQu1hxX8T+69VQYU
         i91Q==
X-Gm-Message-State: AOAM531TOZ1Ad77YLUKCT7Zk+4rq24mgdfe3M8KPIDT93a6XiC8NSgG9
        YW6lRe9Xf6He4Ie+XvGMREQlng==
X-Google-Smtp-Source: ABdhPJwvpgjvLzgpa1euBQq5Ky6r/xSxbGnAqui3q0dC/fMCbR+poNAclYZy1Vn5xrb8jJ51lLJi4A==
X-Received: by 2002:a17:902:7c81:: with SMTP id y1mr7526349pll.236.1590731821465;
        Thu, 28 May 2020 22:57:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m5sm5771238pga.3.2020.05.28.22.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 22:57:00 -0700 (PDT)
Date:   Thu, 28 May 2020 22:56:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH 1/4] lib: Make prime number generator independently
 selectable
Message-ID: <202005282255.63F6EFE55D@keescook>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
 <159067752610.229397.10253900294111245982.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159067752610.229397.10253900294111245982.stgit@devnote2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 11:52:06PM +0900, Masami Hiramatsu wrote:
> Make prime number generator independently selectable from
> kconfig. This allows us to enable CONFIG_PRIME_NUMBERS=m
> and run the tools/testing/selftests/lib/prime_numbers.sh
> without other DRM selftest modules.

Nice catch! I see that tools/testing/selftests/lib/config already has
CONFIG_PRIME_NUMBERS=m (based on this commit log I was expecting to see
it added in the diff, but I see it's not needed).

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
