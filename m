Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB03C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF3120637
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DS824e58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbgBYSf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:35:58 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40984 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBYSf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:35:58 -0500
Received: by mail-pl1-f196.google.com with SMTP id t14so136758plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 10:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Oq7ZlHByEKisw958sDxdjAX7fiFkXlFc5ymByAOxAI=;
        b=DS824e58go8okeMKOqEHEbHc21x7FkHA0PkE7JjUV/ffMD1jaGlRVRKQiy5G78ZSYi
         w1g8VqpgDd0aOt7TLWrv9NKqWgKZYpnTPxeD6k9lHXhVVPmM22eWvb8eWDmVot6ePvL1
         8WChB0KvbivUsKRrpzgsb+e+Tym3KoTwLEdn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Oq7ZlHByEKisw958sDxdjAX7fiFkXlFc5ymByAOxAI=;
        b=OUxh0P1LKWXu33iYr9pX2pU+SVoeLn8OCtYMP+Quv135e2Qc3PlUMGl+iY9pejqv3O
         v4LHFIOLg6Rl/J54DgxhBy78G2Sq/V6BAbrgXkCKpZ1BcgxN+qYz08tDgv7n7JgOvnXX
         +TtrCEpxwHWUhkFBtjQXFMnuZF4zByP8cJ4jXpjhqJIxtXTgA9e/t54ebhXMQDH6olcL
         GpO1YxDbeDLBRvGZhG1A6pp4c2qaLbvAHeOTv6tcZGHnH9yDJRA1Rxo5pFshi0GRY/Uo
         CSPEzp8MO9m2rpzmsl1Ck+KuuVjvE7ui3uy8a8Szygnm0ElgCgqrf4ZMLuBsR1+rHZ5L
         LhGA==
X-Gm-Message-State: APjAAAWTqhmJ6SO0v8EWyoyQ//KlHiZNQTxn7DxlCUx0f5qZ6/29XZGj
        4iX74SKJ7+0nmA9lcLb7fYL63w==
X-Google-Smtp-Source: APXvYqyPmhYJr4gUqySGuqxkFqZHzAJ4hcxUjGcAw4ErEw4uaojqet99DnUp7LnumFp67PKFXpJf/w==
X-Received: by 2002:a17:90a:7187:: with SMTP id i7mr379790pjk.6.1582655757813;
        Tue, 25 Feb 2020 10:35:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d3sm4311417pjx.10.2020.02.25.10.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 10:35:57 -0800 (PST)
Date:   Tue, 25 Feb 2020 10:35:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Micay <danielmicay@gmail.com>
Cc:     Daniel Axtens <dja@axtens.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5/5] [RFC] mm: annotate memory allocation functions with
 their sizes
Message-ID: <202002251035.AD29F84@keescook>
References: <20200120074344.504-1-dja@axtens.net>
 <20200120074344.504-6-dja@axtens.net>
 <CA+DvKQJ6jRHZeZteqY7q-9sU8v3xacSPj65uac3PQfst4cKiMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+DvKQJ6jRHZeZteqY7q-9sU8v3xacSPj65uac3PQfst4cKiMA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 03:38:22PM -0500, Daniel Micay wrote:
> There are some uses of ksize in the kernel making use of the real
> usable size of memory allocations rather than only the requested
> amount. It's incorrect when mixed with alloc_size markers, since if a
> number like 14 is passed that's used as the upper bound, rather than a
> rounded size like 16 returned by ksize. It's unlikely to trigger any
> issues with only CONFIG_FORTIFY_SOURCE, but it becomes more likely
> with -fsanitize=object-size or other library-based usage of
> __builtin_object_size.

I think the solution here is to use a macro that does the per-bucket
rounding and applies them to the attributes. Keep the bucket size lists
in sync will likely need some BUILD_BUG_ON()s or similar.

-- 
Kees Cook
