Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACAEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061FC20776
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ILxzkVPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgFATb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgFATb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:31:57 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ECAC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 12:31:57 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p30so3939058pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rc0ffG4B7DbyEjVVBPqwcsPl4TEVTHzQjkFrixO/llc=;
        b=ILxzkVPezMPuAXZ2E86GYWwFCMoJjekAHTNti5CWGgjLNxgLwOjS9rCUtvTFtw/RUJ
         KwRN2goH0MCs2vLE0ySXTlO3qIYT/SCO0iyIUcMxvSmrqkCSPCoba75EmiAhG7DFkq/1
         UzEMR5nnms5aNb8JxiAU/8fVM+RV8ztpj+tzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rc0ffG4B7DbyEjVVBPqwcsPl4TEVTHzQjkFrixO/llc=;
        b=LrAGjELqiUyfniUwfkC8bL0WS6BO0s5RJQgG3cwe5b8iXnBkrTjenUU+rieUnIxfhm
         MWS6W5LsJlHS+pqv7NIvGre/7TywGXj7h7JaM9aJW9RnGOH0KH7AN20+7AUQWKWahDIa
         pA09p6xWzdVDhr8fxNQ9VZKt3gbv2O7W9aqh+kJvQpKMR/Eq+BU14COkLJQ1X/P6UELR
         KIM/Nc5U+ktNC4AUGVz52sDd6T2t2/hzurmWyyFPrr81RPpgTconHjQynQttpArOShwH
         aH/iUs49w9sPzaEztr/l1ifT2zQI06c/Jv7gjPYEAd+fR40dPpi1bfi0kRb634x0scXm
         FEpg==
X-Gm-Message-State: AOAM530XYdLzzcck2dhCWF7raFKoDDFx9Fx+49AVMBgnYApMPhIx/JTe
        uNaRnADbBbXkbR9/6QH68/ZEDw==
X-Google-Smtp-Source: ABdhPJxysNV2ViVcPbuEHw3i32T33CvqmqADXPwPh7S8mJZDbHNY6N9jZ2A1m+Tv7j5emyS4dt8h+g==
X-Received: by 2002:aa7:8651:: with SMTP id a17mr4062452pfo.144.1591039917130;
        Mon, 01 Jun 2020 12:31:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j13sm198512pfe.48.2020.06.01.12.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 12:31:56 -0700 (PDT)
Date:   Mon, 1 Jun 2020 12:31:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH v3 4/4] tests: test seccomp filter notifications
Message-ID: <202006011230.982CF462EE@keescook>
References: <20200531115031.391515-1-christian.brauner@ubuntu.com>
 <20200531115031.391515-4-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531115031.391515-4-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 01:50:31PM +0200, Christian Brauner wrote:
> This verifies we're correctly notified when a seccomp filter becomes
> unused when a notifier is in use.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v2 */
> unchanged
> 
> /* v3 */
> At first it seemed sensible to add POLLHUP to all poll invocations but
> all checks test for revents to be equal to POLLIN. Hence, when POLLHUP
> is reported we'd fail the test so we don't gain anyhing by testing for
> POLLHUP additionally.

Ah! Well good; the tests were already sensitive enough. ;)

Applied to for-next/seccomp.

Since 5.7 just released, I'll be waiting for rc1 before actually
pushing for-next/seccomp to linux-next.

-- 
Kees Cook
