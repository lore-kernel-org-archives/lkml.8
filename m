Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C039C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AF0206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JGlzm0vC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgBTWvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:51:25 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39555 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbgBTWvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 17:51:25 -0500
Received: by mail-pj1-f66.google.com with SMTP id e9so113660pjr.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 14:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xUODmT3izmnK2/3rXHfMIJC5LaJlKPGnGXA3PxU3bIs=;
        b=JGlzm0vCBpE/kCib0dY+jJB1ACPbGboIdU9+eh3bWp96p37rDdYVpx0OTA1BjYBIg2
         zYaNJ0gyebRhAzCrFtYzeKIn7mTgU3VPRQmHNQKxTNmFnYMAlHoG9Yn8vXRA2aeNGg/F
         zOY9iSo7lLSNuPU3hdJgKCzok3fWfRS64h5Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xUODmT3izmnK2/3rXHfMIJC5LaJlKPGnGXA3PxU3bIs=;
        b=b++CCshC5yP1WiWEY5OEPJPfTdU9sx9mATy0qyMZQnClRjw59AzOjbfGDdDhb02C8v
         wozn29zFzato4QU+OLSL6vaxDpJwARjMEd12Jr5A77jVBExeWsWDNH3HMMK9P+g9bCwP
         GeQdLggy1nc19bzSVyjgbzGSkboFIahXQK+SviCEyg9cJYLn5+Kp5w/HUFrOLvvXoi37
         I6Eu8cl9yGJG95+JwxXiCxJClom5xkZes7ApKhhUBU9y+ZEyzRHdOvXSYL6NPjEupQGE
         aKt+JvTYZkjOZUWPKpxjHOfOOBINGie+cPWGQnM/CmQ28rNk9HtxiiZd6S3YW7gUpuP6
         pLog==
X-Gm-Message-State: APjAAAW/znYW2UJ5U8wHG3DsM9VRiog9P6Ba9eA5RNZHc2AVM+3vL97B
        wA84l+sKG9Joq/gsNxRAhyx5GQ==
X-Google-Smtp-Source: APXvYqwIsRyk6knJ6cpQX+pqL+SFKQ58ujoDFJuEcMgob+s0hLlXXQmC7R3/ABnLUxkvI+4/NJTQYQ==
X-Received: by 2002:a17:902:8c91:: with SMTP id t17mr30684494plo.98.1582239083274;
        Thu, 20 Feb 2020 14:51:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 11sm630218pfz.25.2020.02.20.14.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 14:51:22 -0800 (PST)
Date:   Thu, 20 Feb 2020 14:51:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: Install settings files to fix TIMEOUT failures
Message-ID: <202002201450.A4BB99421@keescook>
References: <20200220044241.2878-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220044241.2878-1-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 03:42:41PM +1100, Michael Ellerman wrote:
> Commit 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
> timeout per test") added a 45 second timeout for tests, and also added
> a way for tests to customise the timeout via a settings file.
> 
> For example the ftrace tests take multiple minutes to run, so they
> were given longer in commit b43e78f65b1d ("tracing/selftests: Turn off
> timeout setting").
> 
> This works when the tests are run from the source tree. However if the
> tests are installed with "make -C tools/testing/selftests install",
> the settings files are not copied into the install directory. When the
> tests are then run from the install directory the longer timeouts are
> not applied and the tests timeout incorrectly.

Eek, yes, nice catch.

> So add the settings files to TEST_FILES of the appropriate Makefiles
> to cause the settings files to be installed using the existing install
> logic.

Instead, shouldn't lib.mk "notice" the settings file and automatically
include it in TEST_FILES instead of having to do this in each separate
Makefile?

-Kees

-- 
Kees Cook
