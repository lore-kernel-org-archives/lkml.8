Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9920C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB622077D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RycEdWpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgFCXmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgFCXmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 19:42:13 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5DFC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 16:42:13 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g12so1375704pll.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 16:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b2mOQDo3SZaN/Rw+KcRuMiA15KwU/mOHQn3QZXLxbJg=;
        b=RycEdWpJjs6aQR35gSfW6hNn9bIP1Lv/qGy/dAmbZ66xCycKCJOwLsDOD1pBxbDNvP
         pFeyI1V0zJgyZdHfAHqY7tEF3G2WGkP8/Pz02lYvK6n6vdZkpaepsFg+VJbq5uF8craw
         AGki2c1Qa+eIWB9r1S5XqHIYyuFmY6Q8DtBA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b2mOQDo3SZaN/Rw+KcRuMiA15KwU/mOHQn3QZXLxbJg=;
        b=KLjtyL8KOL48UjMUR3UPh5NZQW0tM/kctIQ59fd+jvHqmjq0raS74Ob+v77hnDsBEE
         hnobuijw+UuN7arhjMd5GbE3ezJCTqWx5CA3lZqUkkCDU77BDFI2h12CzsN7dZB7NriA
         pQyi7SM774GW7KdsldjfBK4xsY+Y5gxG4jSjD5K9y2EDqz6xmvc2G97X78L/JzG9F9QJ
         ZJ4JQ1Tb4vXI4zTC3/34qU659HFYzZnK4D46K7NzgmUM/XXw6YhokvIbyPcSppcbORQf
         HdmMt0i2lcRJRj0YYyyZdx1aZRlKYuw9MIJrlc1dOHHzq4Rw0imlU+z+Qrup4ke2QXM6
         Aqnw==
X-Gm-Message-State: AOAM530QKojV+kCbLw3Y7lV+ivW1z6pPxz4FyNuJaaNQRbL4zRvPKqjr
        0crMrNN6cLab/k+o+WJO3LQnzw==
X-Google-Smtp-Source: ABdhPJwBQdQUHx7O769tTARnXz2SKa2R92cBnuwDdPBLi4/tBILPpzbrO8W1YTbp+5PJRJTvZslXDQ==
X-Received: by 2002:a17:90a:6546:: with SMTP id f6mr2615658pjs.55.1591227732906;
        Wed, 03 Jun 2020 16:42:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j7sm2747835pfh.154.2020.06.03.16.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 16:42:11 -0700 (PDT)
Date:   Wed, 3 Jun 2020 16:42:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux-foundation.org,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/4] Add seccomp notifier ioctl that enables adding fds
Message-ID: <202006031639.E053742@keescook>
References: <20200603011044.7972-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603011044.7972-1-sargun@sargun.me>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 06:10:40PM -0700, Sargun Dhillon wrote:
> Sargun Dhillon (4):
>   fs, net: Standardize on file_receive helper to move fds across
>     processes
>   pid: Use file_receive helper to copy FDs

The fixes (that should add open-coded cgroups stuff) should be separate
patches so they can be backported.

The helper doesn't take the __user pointer I thought we'd agreed it
should to avoid changing any SCM_RIGHTS behaviors?

>   seccomp: Introduce addfd ioctl to seccomp user notifier
>   selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD

Otherwise, yeah, this should be good.

-- 
Kees Cook
