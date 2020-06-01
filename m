Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3510C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B49732076B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g6HEz2aB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgFATtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgFATto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:49:44 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53294C03E96F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 12:49:44 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q16so370532plr.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 12:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CV7mubTvEBdNlKnhsE7VGPqdTkRnwn99m97ta59lmfk=;
        b=g6HEz2aBlNKZcFsotKI4pWut9t2Aah2dMfCm6GzqIN9apkiVUT5tnI7f3sDv6swxov
         mQyEuHW8GPOln+tF0OFqF3HLcdlMNPN+1dPq0bv+ETJqM5wQzZDI3SYpkc6/Ul+Rg1TA
         X74mV36Y8g3wrwU5DMJnT/Ql93eBuSKvycaiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CV7mubTvEBdNlKnhsE7VGPqdTkRnwn99m97ta59lmfk=;
        b=mWRsR4t0OaoPmgUGVUnkZlFA3409ecIoSDgtR7yaiAHAeXyxnbwFJCpGNaW09aU4VO
         YXdtiiSwXGQHDnZYnWLYGPTvsFMYcJIvDhRUxMgqtNubo/MIEUsKCAHHf9FNOpUlbV1z
         1NovFmZJkWuZE3oFh2rk5kJbuK5yWHjKSwc2S92qbJ+KCndDEO2og7uUuvEVV5zrto7+
         4Ii4fYkoBaHyJwYtbsTu960jz9LzU6G7xZ1x6tFwNHU74Xc/zabwVGuCFhYwbEUXLZOm
         W2j9H4FbWVZYTtyOkPyc+waRWRPWRMGlfGY39Ko13j+7NVpotCjTvSkQ+7RfwiCoz7op
         xs/Q==
X-Gm-Message-State: AOAM530UxhKo0HMwyM1qlVk4WT0d2thMKShLstLDyami61328XClwVYS
        /FrXSYO8kaem72f97778oIEfyA==
X-Google-Smtp-Source: ABdhPJysKrG9WjCl3R8UKGAvcZbIaRgJHSv+b58jR0g7DDChW61bHTe3IuA4U+poaf1+x+tpj41lsw==
X-Received: by 2002:a17:90a:9e8:: with SMTP id 95mr1095838pjo.189.1591040983872;
        Mon, 01 Jun 2020 12:49:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b11sm240437pjz.54.2020.06.01.12.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 12:49:43 -0700 (PDT)
Date:   Mon, 1 Jun 2020 12:49:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH] selftests/seccomp: use 90s as timeout
Message-ID: <202006011249.3E72ABDDE3@keescook>
References: <20200601123202.1183526-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601123202.1183526-1-cascardo@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 09:32:02AM -0300, Thadeu Lima de Souza Cascardo wrote:
> As seccomp_benchmark tries to calibrate how many samples will take more
> than 5 seconds to execute, it may end up picking up a number of samples
> that take 10 (but up to 12) seconds. As the calibration will take double
> that time, it takes around 20 seconds. Then, it executes the whole thing
> again, and then once more, with some added overhead. So, the thing might
> take more than 40 seconds, which is too close to the 45s timeout.
> 
> That is very dependent on the system where it's executed, so may not be
> observed always, but it has been observed on x86 VMs. Using a 90s timeout
> seems safe enough.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

Excellent point! Thanks, I've applied this (well, actually, your v2)
to for-next/seccomp.

-- 
Kees Cook
