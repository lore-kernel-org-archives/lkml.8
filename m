Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E39C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BAC2207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bx5HI5nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgE2F5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 01:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgE2F5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 01:57:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD61C08C5C8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 22:57:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 185so859913pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 22:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SF3sCg5EU3YnkaxWsqKF6EgCQwUSf3m7IaDAB8UTyRM=;
        b=bx5HI5nrUX+igPb9py6fThZgzGqrey0SgnNIr5N9VtsU1W62Y64dvJcfOzhGhr1bf5
         QZOrrQ0mmtdn1xRj+90t4vHLsxpd/DxbFPNyJ4SIOpECiNcZFN1h8iJ+RgNPDxwlY5OV
         /MFhhwfUTdby9jh5AXrDGCqvZzbIo6UPu4/tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SF3sCg5EU3YnkaxWsqKF6EgCQwUSf3m7IaDAB8UTyRM=;
        b=CRWZeSN1c7Cyu0FVnRIk5zVGP8h19Z3WC5MIxuf6tInU0g8gxCZcO2FuUXRaP/etLT
         wQdgumCmQdKNlFvY5VhMqX/eN2rz1zHDclcYva33XAt9eX9m6WOt8f7ooy2C3C9CVa0g
         w/wsLNAwxTve4V+E+G1iAh36cINdKEEeXcTBxuxOB2K//Va1wIw8w4Y/ssa6+lAkT9+/
         5usPspLMwqDhDKqea8UCnu0My8TdQPYWYBDhN4tYsi/Z6ybHmz0GhFnLXQhIAayPr8qn
         HhXhJ2KK7z+eopXmmDt+DWB5GVLFytu85OocrA3Kxqmkvj6ADCQy55cZOXyNuI3ep8HT
         0Wfg==
X-Gm-Message-State: AOAM532+w8Tysx4h7VVyOsNSN+Pb3r+x9oKblssE9P+B2lA3yQ2WS8zn
        aaERif1tMGkRtRkWguvA5NyVpVLJmBBbJQ==
X-Google-Smtp-Source: ABdhPJx9YGgcLgJ0ntOaQ/pT2UeTQNFQc+PjjokH7xnOdMSwCNdtLY4V8ITuJRa/df4vrMYc1Pri0Q==
X-Received: by 2002:a63:480f:: with SMTP id v15mr4187332pga.148.1590731872760;
        Thu, 28 May 2020 22:57:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lj12sm7108885pjb.21.2020.05.28.22.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 22:57:51 -0700 (PDT)
Date:   Thu, 28 May 2020 22:57:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH 4/4] selftests/sysctl: Make sysctl test driver as a module
Message-ID: <202005282257.B9747A0D2@keescook>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
 <159067755690.229397.12060049846042042480.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159067755690.229397.12060049846042042480.stgit@devnote2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 11:52:37PM +0900, Masami Hiramatsu wrote:
> Fix config file to require CONFIG_TEST_SYSCTL=m instead of y
> because this driver introduces a test sysctl interfaces which
> are normally not used, and only used for the selftest.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
