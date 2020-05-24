Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B45BC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 498C42075D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="jV5abBUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388609AbgEXX6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 19:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388559AbgEXX6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 19:58:35 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7992C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:58:33 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id b18so12661222oti.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ujgmu6qsF8KjwF0asTJwlN/jtHorDxcj3S3k6D7sfR4=;
        b=jV5abBUXtxyNey4FdgLuz5aknabD6HeVYSYsWWwVfhdAice2CVc4CA1W3B8auInwQE
         gnOuh9u7VPvwRnOLAx237unvR/r7zl/5Kg7025KjFSFCaS8HVAh71QRYqSlZX7UXNjQw
         77qmB+EB6hxMeAUPgbtrBZUHtGeWEAn+tQdTkU8cbUc71pT8kG8Gd2pCSXYvqOy1tXMh
         5MUMduFTA7+8GH/fZdRiZe5vl8bQKE+8p1ppqmDfc1llEvjph0KccZ6dx9AQPJN7GUco
         itgSd4SND67rD4CZXVhq5tZeI3YHToadTvsEjq+7QezEaPQ4yYBLEZzGe6jIlDOz1pbJ
         bQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ujgmu6qsF8KjwF0asTJwlN/jtHorDxcj3S3k6D7sfR4=;
        b=m2Nsot6rYydnrsaAeCsTQBMeNxOnKEEyVz5HNoWVRFu+y8z8LLS7bWrK6O2R0uJkJo
         jwXWLVg54EzdTR/ocsEdcZCAOjm09O21XKIBFH1wgvAIcYIii1TJnVK8FG/vpOz9el6I
         Rlt+liWZFeF8dnbcb5/qjq8Mzp4LyJDWGFLQyuDQS+ZPzSoFSRpG6RDyyCdIqPR5woHQ
         SHyHfx05yk98/y7UCNYO5eYWBKx+0TZAXdhtd59z5a25fp+E858yjpIQYaBxm7QFUzO8
         eBmujIvJkSzrxY4xT3qI02LOSWbXsCI6kn6/aW49BtWKhr9+ii6W3xDzeBYfCny58iIN
         7MMA==
X-Gm-Message-State: AOAM530GkJn8X1uOj4NiSyFitD1IhwBst+4h00A+iUqKj5F25tVrq3Az
        GVLU34loZpTuoVpJnJJEyyp65g==
X-Google-Smtp-Source: ABdhPJx+fCXqTvAG+9ISY3kf3Llc7o0fLy7/xyCQNcjszyp+Ny99EH8k+j6pXMd/J4mglh/dYopq7A==
X-Received: by 2002:a9d:785a:: with SMTP id c26mr18109817otm.39.1590364713095;
        Sun, 24 May 2020 16:58:33 -0700 (PDT)
Received: from cisco ([2601:282:b02:8120:e9d7:5ec6:88ea:b4a1])
        by smtp.gmail.com with ESMTPSA id c184sm4808180oif.3.2020.05.24.16.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:58:32 -0700 (PDT)
Date:   Sun, 24 May 2020 17:58:34 -0600
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
Message-ID: <20200524235834.GJ2605652@cisco>
References: <20200524233942.8702-1-sargun@sargun.me>
 <20200524233942.8702-3-sargun@sargun.me>
 <20200524235732.GI2605652@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524235732.GI2605652@cisco>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 05:57:32PM -0600, Tycho Andersen wrote:
> On Sun, May 24, 2020 at 04:39:39PM -0700, Sargun Dhillon wrote:
> > +static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd)
> > +{
> > +	int ret;
> > +
> > +	/*
> > +	 * Remove the notification, and reset the list pointers, indicating
> > +	 * that it has been handled.
> > +	 */
> > +	list_del_init(&addfd->list);
> > +
> > +	ret = security_file_receive(addfd->file);
> > +	if (ret)
> > +		goto out;
> > +
> > +	if (addfd->fd >= 0) {
> > +		ret = replace_fd(addfd->fd, addfd->file, addfd->flags);
> > +		if (ret >= 0)
> > +			fput(addfd->file);
> > +	} else {
> > +		ret = get_unused_fd_flags(addfd->flags);
> > +		if (ret >= 0)
> > +			fd_install(ret, addfd->file);
> > +	}
> > +
> > +out:
> > +	addfd->ret = ret;
> > +	complete(&addfd->completion);
> > +}
> 
> My previous comment about SCM_RIGHTS still applies, right? That is, we
> should do,
> 
> 		sock = sock_from_file(fp[i], &err);
> 		if (sock) {
> 				sock_update_netprioidx(&sock->sk->sk_cgrp_data);
> 				sock_update_classid(&sock->sk->sk_cgrp_data);
> 		}
> 
> and perhaps lift that into a helper.

Oh, and now I see the later patch. But is there a reason to separate
these? I can't think of one.

Tycho
