Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987B2C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7048820823
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="0SR5MhSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388568AbgEXX5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 19:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388124AbgEXX5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 19:57:33 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9BEC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:57:32 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id g22so3287334oop.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BpvyLok9gg59rHQ96tPQz62O5JGQHpn3e1cNrN9rySg=;
        b=0SR5MhSCS0DP1pS/LdoJS5PhxrVO5tydztNhtW1omJkuFiGIB8aeravFNiBE6xijry
         1HtjaI0/u0oI7KAJWjEhC0M5XCy0XwhDOQ9xg17+UWM2CX7aY0FpE3Oup4s/IpWwiOtu
         Vmj1xyliJcXjkFD1R+cKGIfTjsMuN2ozaqpLNWg2FlKFZ8ct5fOHIOTU1iZ3hfQYD1gS
         g1kzeEmR2wIoi3NULMOX6Cy/PwX54npQ79yQuIvjZCGydwl2C31ouBLA8ZpZ2rjC+C+p
         j7EEjj9t4u+c75SgGTOoynDuyEtyP/kgDSh8y5iJrJ6Xdf+KTkVIzMM7RTrVz/+HQnpF
         cCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BpvyLok9gg59rHQ96tPQz62O5JGQHpn3e1cNrN9rySg=;
        b=hNFV5JYzIznyWsRR2Rj9uyarbk9UBS7nPc61o6D8Bmkmo2F7xF4VbY84bITWqlQKrL
         jzqvAGht4OAV30QlYcVwwkd47A3RgYTqaIQpDEe+sd3opMyjRNSWLSu8f4mb9hmMOEEV
         U0XLYCs+SW9nnWgAGmH9KiSBWb1MNJkwYoi0u7ALpS2gCTWizyu2cl+YzAP4XQPiTetQ
         /rfuFPIaRVOvSzHO9V9/qNaOaTIbxOITvXVPcr9CAZGq0QLKuKvK93z1V6x2R1jMaHoG
         l4c/3YLaa9jpAJg6ckCITGJfjI1sVCmhnvhA2pKTAJTo3HGEtrniumzv0XQSfbNndvPJ
         RKxg==
X-Gm-Message-State: AOAM533Z4Ltt+Z3jw4Xz2Q2LIk8Ko+QYs2uDfmDZ214zBFinyBIhGGLM
        U9JlH55sa5ndLrH0yiwJgIH0bg==
X-Google-Smtp-Source: ABdhPJwQsux1cordCUHJU+KfO5uaHmoIhE9Ty2bxegSzcdfkYw0V11jRjHORSFEwM9j6vlzjYtJrGw==
X-Received: by 2002:a4a:6c5:: with SMTP id 188mr3218734ooj.32.1590364651352;
        Sun, 24 May 2020 16:57:31 -0700 (PDT)
Received: from cisco ([2601:282:b02:8120:e9d7:5ec6:88ea:b4a1])
        by smtp.gmail.com with ESMTPSA id l8sm4617586otr.7.2020.05.24.16.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:57:30 -0700 (PDT)
Date:   Sun, 24 May 2020 17:57:32 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        christian.brauner@ubuntu.com, keescook@chromium.org,
        cyphar@cyphar.com, Jeffrey Vander Stoep <jeffv@google.com>,
        jannh@google.com, rsesek@google.com, palmer@google.com,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: Re: [PATCH 2/5] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <20200524235732.GI2605652@cisco>
References: <20200524233942.8702-1-sargun@sargun.me>
 <20200524233942.8702-3-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524233942.8702-3-sargun@sargun.me>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 04:39:39PM -0700, Sargun Dhillon wrote:
> +static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd)
> +{
> +	int ret;
> +
> +	/*
> +	 * Remove the notification, and reset the list pointers, indicating
> +	 * that it has been handled.
> +	 */
> +	list_del_init(&addfd->list);
> +
> +	ret = security_file_receive(addfd->file);
> +	if (ret)
> +		goto out;
> +
> +	if (addfd->fd >= 0) {
> +		ret = replace_fd(addfd->fd, addfd->file, addfd->flags);
> +		if (ret >= 0)
> +			fput(addfd->file);
> +	} else {
> +		ret = get_unused_fd_flags(addfd->flags);
> +		if (ret >= 0)
> +			fd_install(ret, addfd->file);
> +	}
> +
> +out:
> +	addfd->ret = ret;
> +	complete(&addfd->completion);
> +}

My previous comment about SCM_RIGHTS still applies, right? That is, we
should do,

		sock = sock_from_file(fp[i], &err);
		if (sock) {
				sock_update_netprioidx(&sock->sk->sk_cgrp_data);
				sock_update_classid(&sock->sk->sk_cgrp_data);
		}

and perhaps lift that into a helper.

Tycho
