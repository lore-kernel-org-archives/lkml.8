Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72F9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90953207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VEv60SuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFLG6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 02:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgFLG6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 02:58:15 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABE0C08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 23:58:14 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j4so121775plk.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 23:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hbBTPedvojIPOHUOPrzkvqJhdMTFZotSf6yPfyzcSVc=;
        b=VEv60SuR1xOiTK9xkgyJTKlyILo0gJSwdIeMlGuiTetR5wFnYj6YsL3yI5plGAsZg/
         OMWGwHmJ43PaYQmc4gd+GLuzIVpWUsVLdppG1kCQK4jIBzjwWXGw0RM5BZd3bMh5g6Op
         5zaycbbMBN8Yc9oPnkdOTIpZ4v5cFWgsPof1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hbBTPedvojIPOHUOPrzkvqJhdMTFZotSf6yPfyzcSVc=;
        b=J/4Z/C+kHNKThkJAbRzqRDAxmJm4oNfYLmXJjlaw0TqpGcXheV5Jl7fqe8RxrKrdau
         zv73bhE/NTnKOyL+Tww91t9pVMN412ZqdekZgNm4gHPX7UrS7rGuhgY69owwYUocpijw
         6cIVdJeXEzebmzqpVJHj9/hh9aerx7Nfa/jMJbNa5hJE50RjZSVlmUGv4WLItc1qpGKd
         Wy2fto2Aok8dCFJ9xG3r5aiKxgISO0eO1E2+SZLWnx2e57zMqYi8L6r7J9YuoyVWke/e
         o+EUl8HspaM+LeURhxVWJtFa0GSGP9Lj6WQ7qMPbCpfBOkq0alSXRM1at26nJm7FpIT5
         f9Pg==
X-Gm-Message-State: AOAM532bb4lO5HfaWSSBCvUdyX0nMl8kvEPNpUbzYAqf+pqrJpUsqGkc
        5rHX730hftSpOyNzCM1ETGRf3g==
X-Google-Smtp-Source: ABdhPJzFarvRyhjwA03KJI+npCqldj7tRexddeTWqnuMNZdeX8tlh9W+3uGOuYbwK6XOUnTfUmmkPQ==
X-Received: by 2002:a17:902:23:: with SMTP id 32mr10294486pla.40.1591945093613;
        Thu, 11 Jun 2020 23:58:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t201sm5206590pfc.104.2020.06.11.23.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 23:58:12 -0700 (PDT)
Date:   Thu, 11 Jun 2020 23:58:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Sargun Dhillon' <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>,
        Chris Palmer <palmer@google.com>, Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matt Denton <mpdenton@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 1/4] fs, net: Standardize on file_receive helper to
 move fds across processes
Message-ID: <202006112355.932D0AD@keescook>
References: <20200609200346.3fthqgfyw3bxat6l@wittgenstein>
 <202006091346.66B79E07@keescook>
 <037A305F-B3F8-4CFA-B9F8-CD4C9EF9090B@ubuntu.com>
 <202006092227.D2D0E1F8F@keescook>
 <20200610081237.GA23425@ircssh-2.c.rugged-nimbus-611.internal>
 <202006101953.899EFB53@keescook>
 <20200611100114.awdjswsd7fdm2uzr@wittgenstein>
 <20200611110630.GB30103@ircssh-2.c.rugged-nimbus-611.internal>
 <067f494d55c14753a31657f958cb0a6e@AcuMS.aculab.com>
 <202006111634.8237E6A5C6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006111634.8237E6A5C6@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 04:49:37PM -0700, Kees Cook wrote:
> I think I prefer the last one.

Here's where I am with things:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=devel/seccomp/addfd/v3.3

If we can agree on the ioctl numbering solution, I can actually send the
series for email review...

-- 
Kees Cook
