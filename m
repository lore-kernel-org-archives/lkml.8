Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B92C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9AC207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RvN4IGZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgE2F5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 01:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgE2F5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 01:57:42 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06F3C08C5C8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 22:57:42 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id n15so705348pjt.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 22:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S1pJP0zIjVkIj/rRde/f3WN6OKHKfEgWbqfA/JHK4Lc=;
        b=RvN4IGZXDr8jjz0wBCffohZ2KJcST7bTayzHhjp8XCKlkoKA9dHkMB/rOOjz0YYI/H
         DPGEHGsDHOk5daxT4S6nDzBfcXvGA+GQemOYfuxbkfoZtua/LAl2IjE5tx2uLr0Cs2NP
         ev+FkGmwuHACWW533A9NtFU5nbo++e402JvX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S1pJP0zIjVkIj/rRde/f3WN6OKHKfEgWbqfA/JHK4Lc=;
        b=TeY3TZH9zGIOfi1ItHjHhCjDgyWVAw+oBilCb0EKJU6YIfI7H4XQgS2aQgGE+yGXlP
         0kmHCJmagreuIORvV6l7539m2Hnmg5csxn1BDwpBVco0DRlRroG+xSIBZAZNekHneQSR
         6nf8ECw82ciGXT3gBSuj9WcdxAVT0VAbDx3uvW/BmH+b8+OtwmfrJ57npPhH46pWZkos
         8l+uECD5zFOqlm5GRB0E8lqeXgnc5qu1LaBzB+ArxkMgMkd8L04xdV1Rz5CxMfsQvpqB
         IcPV2pF/naFd2N48wlEI9srkXmnWwRwob1iA6phrGROZr5vjOBMr9W8yLMTTBALmMXfW
         1ASg==
X-Gm-Message-State: AOAM531oqdPwO4BC6tsl5hAMKt/V63EEfvexe/ugS0OdmgE+Mo62Z8eb
        8RIXmmbOzJkrZ3GvdTKld+iGwA==
X-Google-Smtp-Source: ABdhPJwdJXa3Glc0NQSI7NM6PGvoNtECNhFF5hzvOMEielqzGB14RK10hNdRpzwae3b3tTwq7sqHvw==
X-Received: by 2002:a17:90a:c004:: with SMTP id p4mr8133936pjt.170.1590731862388;
        Thu, 28 May 2020 22:57:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w21sm6801908pfu.47.2020.05.28.22.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 22:57:41 -0700 (PDT)
Date:   Thu, 28 May 2020 22:57:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH 3/4] selftests/sysctl: Fix to load test_sysctl module
Message-ID: <202005282257.0EB7813@keescook>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
 <159067754657.229397.15961438722058766667.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159067754657.229397.15961438722058766667.stgit@devnote2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 11:52:26PM +0900, Masami Hiramatsu wrote:
> Fix to load test_sysctl.ko module correctly.
> 
> sysctl.sh checks whether the test module is embedded (or loaded
> already) or not at first, and if not, it returns skip error
> instead of trying modprobe. Thus, there is no chance to load the
> test_sysctl test module.
> 
> Instead, this removes that module embedded check and returns
> skip error only if it ensures that there is no embedded test
> module *and* no loadable test module.
> 
> This also avoid referring config file since that is not
> installed.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
