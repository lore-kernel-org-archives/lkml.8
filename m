Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50613C433E3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E39120720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VSTVR4XD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgGHXs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgGHXsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 19:48:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98715C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 16:48:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ch3so259886pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 16:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KX2uewx3IUSFSrhS49nvHbreqfSp55lLuPQ39ByWwuc=;
        b=VSTVR4XDCZkzC8WSBJX/KM/kGq0iHH2AcaBaZDwX5J91prDWjxtRm3s3HYgPSgN/gH
         veaQZ9BPpfL/s4wD2q9BT8GIPNH9KkzzQ2iS0XPhAxWjlDKuLM7GqVWkH4fj6SxMa+gR
         +SwRkobGC4/zeqpOJAwzIZX+ALIgbBGzMliAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KX2uewx3IUSFSrhS49nvHbreqfSp55lLuPQ39ByWwuc=;
        b=n9fOD7eZS+vHxmrD2zN8QZLeKfT14c0qhsBWM9Oe7w/jN5idgtpWT/Eul6nSMnWMPR
         FdENFRHwOP70OvgZUEb0aEyYThiJFDMLz5s474KgdldIfSjALTaWjx8fGTRa6ZmWIShH
         iXZTifcCCHXAX9OuUZLpjzSB5W/XlZy4GzmpTO4uJPyk163DzFzkdfrNUKD/BxSKNSXc
         g1Atyq4RBAo53lIDZLRZxUi8w57yg/YUeHXWJkefbqPO65Lnk8N1OHkH7vkrnYemxDIG
         r8QONAU0rjo26nsthfbG6nkKFLLwb61XslWzYzOiizQR/DgQM5VqDzu/EshMQJPjd2A5
         baTg==
X-Gm-Message-State: AOAM53236jWzUAz+topUGxyI5KmzPTVEprBgyiNNbquFDkzkPPTE0GF2
        5EIMDUKnynA/HEfMdIEDW+gLJA==
X-Google-Smtp-Source: ABdhPJyiszI8/x+0s4vNHYAvtZesBdjqbGz/Qvm/wRI0AQQLImcB72/hJw/YuEZdEteyZw91l1ugpw==
X-Received: by 2002:a17:902:9042:: with SMTP id w2mr53578773plz.9.1594252105178;
        Wed, 08 Jul 2020 16:48:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i125sm794790pgd.21.2020.07.08.16.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:48:24 -0700 (PDT)
Date:   Wed, 8 Jul 2020 16:48:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 3/7] fs: Add receive_fd() wrapper for __receive_fd()
Message-ID: <202007081646.59E1A664@keescook>
References: <20200706201720.3482959-1-keescook@chromium.org>
 <20200706201720.3482959-4-keescook@chromium.org>
 <20200707114923.6huxnb4e5vkl657a@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707114923.6huxnb4e5vkl657a@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:49:23PM +0200, Christian Brauner wrote:
> On Mon, Jul 06, 2020 at 01:17:16PM -0700, Kees Cook wrote:
> > For both pidfd and seccomp, the __user pointer is not used. Update
> > __receive_fd() to make writing to ufd optional via a NULL check. However,
> > for the receive_fd_user() wrapper, ufd is NULL checked so an -EFAULT
> > can be returned to avoid changing the SCM_RIGHTS interface behavior. Add
> > new wrapper receive_fd() for pidfd and seccomp that does not use the ufd
> > argument. For the new helper, the allocated fd needs to be returned on
> > success. Update the existing callers to handle it.
> > 
> > Reviewed-by: Sargun Dhillon <sargun@sargun.me>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> 
> Hm, I'm not sure why 2/7 and 3/7 aren't just one patch but ok. :)

I wanted to do a "clean" move from one source to another without any
behavioral changes first.

> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks!

-- 
Kees Cook
