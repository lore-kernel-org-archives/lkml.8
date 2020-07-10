Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B2FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F83F206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FjiqjH9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgGJWwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGJWwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:52:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814D7C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:52:41 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x8so2830753plm.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gX6YgcMfSykw3J9R6ZTzJu/j6sgShmyRfXIsXkOHBlY=;
        b=FjiqjH9k77nNIvYx9JltNxNXqW1sklSIL+l3o/ZEJWxqMRU22TIW5BUVRtBVPVWYO0
         ZpIEamJ/+0PlfnjjMLwhgX+EGHduhPTT4EawVUVRNNpCyc4jGxS7RiaXGoEHef8Xwbqn
         cSDqyCEeHG6PNgkWHan8+RKDP6XgPY2cGnGGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gX6YgcMfSykw3J9R6ZTzJu/j6sgShmyRfXIsXkOHBlY=;
        b=e6QTtxWcq0R+KJWcv/o7AlYOLTT/8crYZSgP/s0aFi9wzTmljviRLWN2YK65GfNLsi
         WykkkkSqIpXuCbs5b5RQ9EJCuRwW65nPuxTrx6zIWzEjjNb6AzoF2gGzukKuuCssalSb
         NBOooTrn0JmBckylopP9Y++/S35eCAOAO9BOs4M+PE6FUNQEM89vlsdR681d3ULzM48F
         wOC8Y8MfqpljP7A98Qa2HBPZ2tveyOxhUcb3a5ER985vhc78Ldq88KtZ+8i+0W7ZLXZt
         EjmYUKzzGF1OHByNG2OuoQE57qdXY6pq2R0Lvy4g+Zo8bJA1a9cLZRPpuMhAZ3tJrU4D
         GTfQ==
X-Gm-Message-State: AOAM531hTo37T2NnzWS960HHBr4ytX/MacL85hi0LP/1rCxHXB2ifSCO
        TO/29rgihoZtKPcoRJk2dVxsZg==
X-Google-Smtp-Source: ABdhPJyjD+MX9/tUbhYu/hHqC62kKTUtC0c5Keo979l3OQm7+syZHI2OCgg9mIAvOjzRnLigqpYaTw==
X-Received: by 2002:a17:902:6b87:: with SMTP id p7mr56254761plk.275.1594421561099;
        Fri, 10 Jul 2020 15:52:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f207sm7340205pfa.107.2020.07.10.15.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 15:52:39 -0700 (PDT)
Date:   Fri, 10 Jul 2020 15:52:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next/seccomp 1/2] selftests/seccomp: Add SKIPs for
 failed unshare()
Message-ID: <202007101551.E001F7B1CE@keescook>
References: <20200710185156.2437687-1-keescook@chromium.org>
 <20200710185156.2437687-2-keescook@chromium.org>
 <20200710191023.GA2700617@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710191023.GA2700617@cisco>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 01:10:23PM -0600, Tycho Andersen wrote:
> On Fri, Jul 10, 2020 at 11:51:55AM -0700, Kees Cook wrote:
> > Running the seccomp tests as a regular user shouldn't just fail tests
> > that require CAP_SYS_ADMIN (for getting a PID namespace). Instead,
> > detect those cases and SKIP them.
> 
> But if we unshare NEWUSER at the same time as NEWPID, shouldn't we
> always be ns_capable(CAP_SYS_ADMIN)?

Oh! Yes, you're quite right. :)

Instead I guess I should actually check for EINVAL if CONFIG_USER_NS is
missing.

-- 
Kees Cook
