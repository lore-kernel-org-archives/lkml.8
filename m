Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55361C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A6520663
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XK6g9oF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgGIGW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 02:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgGIGWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 02:22:25 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD8AC08C5DD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 23:22:25 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t6so538716pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 23:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GwK6pLYPrPUs5yveGhJkt3hTcCJVlVwdvkUrxWZwIrA=;
        b=XK6g9oF5rVK8h2Ktpldva1AUJKn84SAYAySai+xmUGvYvLNfuStAl3CGnSkTzle9kE
         7VfZjjgOHVQO5f4asjNLbpIlpjrXh2afqX7pW1lVNHuAiZwtZ8j91gkuboRqoZXLSgNo
         j2+BkK7ndUpEYcXEO0B+pNhTWmGC6yn4K/kuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GwK6pLYPrPUs5yveGhJkt3hTcCJVlVwdvkUrxWZwIrA=;
        b=FYPahVNjIgg6KMdayGlU/OA3ETciWosfuontUPGloidYG1o9fPFS1Sbh8elsF6PaqZ
         Kpie0ma4FKJuBTM3V5s9FmZT7h6aPFRa5FsSBnRmBW9uFp1s5TeNxwlGu3btHA1UblRe
         MNcHxrhnIoQhp7fUxPTYKXQfu/3leJKtwY6fX5GuWX11iKuabG4Bk6MTq5TPn+2DfqFU
         /eaUljiPMpsZTWLCeVzgMX3H+6rjwwGwTpAW4FfQAd/ttUOvi1H5ze3/6P6mc5vCkgdz
         29k+0dd8nCZaLtpROV79kFCgZ24Hr4+ayELOAQ/rMD3DKnNUo7bQwhLDSnHSk3Zqiiml
         7c3Q==
X-Gm-Message-State: AOAM530afAzaAhHUn5VfjZsGRoOBXyEopxjjr4Ue+mohxSN1Q18QL04+
        HABbE0/i2WluBlolqS92Ah7sBg==
X-Google-Smtp-Source: ABdhPJz6DzZ+MCgRaZ50Qj9ZS596r7B+aOgFDLQmqElZxP3SuvzOKNttykPpyoMSmZAOXe0ubfyoaA==
X-Received: by 2002:a05:6a00:15c7:: with SMTP id o7mr55029056pfu.51.1594275745079;
        Wed, 08 Jul 2020 23:22:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a19sm1549192pfn.136.2020.07.08.23.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 23:22:24 -0700 (PDT)
Date:   Wed, 8 Jul 2020 23:22:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Sargun Dhillon <sargun@sargun.me>, Will Drewry <wad@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Robert Sesek <rsesek@google.com>,
        Chris Palmer <palmer@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Matt Denton <mpdenton@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6.1 6/7] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <202007082321.1C295A9F5@keescook>
References: <20200707133049.nfxc6vz6vcs26m3b@wittgenstein>
 <202007082314.A661DC3DD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007082314.A661DC3DD@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 11:17:27PM -0700, Kees Cook wrote:
> +static long seccomp_notify_addfd(struct seccomp_filter *filter,
> +				 struct seccomp_notif_addfd __user *uaddfd,
> +				 unsigned int size)
> +{
> +	struct seccomp_notif_addfd addfd;
> +	struct seccomp_knotif *knotif;
> +	struct seccomp_kaddfd kaddfd;
> +	int ret;
> +
> +	BUILD_BUG_ON(sizeof(struct seccomp_notify_addfd) < SECCOMP_NOTIFY_ADDFD_SIZE_VER0);
> +	BUILD_BUG_ON(sizeof(struct seccomp_notify_addfd) != SECCOMP_NOTIFY_ADDFD_SIZE_LATEST);

*brown paper bag* I built the wrong tree! This is a typo:
seccomp_notify_addfd should be seccomp_notif_addfd (no "y").

-- 
Kees Cook
