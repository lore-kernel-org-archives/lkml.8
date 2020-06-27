Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BE4C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 15:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C3F20E65
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 15:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BWOD2zVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgF0Pwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 11:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0Pwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 11:52:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8320AC061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 08:52:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b92so6188367pjc.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=41PjtVw2FCnymQIWQmtqJCNWG/zIBsJ1p+vOmqPkCKE=;
        b=BWOD2zVOkpWNo2bPFp4ryz2GzTvlrG4eRcB7J1dRZGF2dC02SxWF6s4ngC2sUr5+Bb
         eDY2hiyrwzKyw5MPZkEq3pceBPMsMcWggsPLBtAFkb3BeqEQctFko234Pn4GYrqlFPY2
         CUyBk7DmCZTz9+V2L2y1dJEjvvVQ3YRUIPMkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=41PjtVw2FCnymQIWQmtqJCNWG/zIBsJ1p+vOmqPkCKE=;
        b=dV/DgU8JgaIQfrRcvYi9QWfacewZg7c0IRGk7YzKpIRAZPpcceRC1LOVgK9kNggCIM
         gQ0apS1NXyKVC1Zl/AFBIuEnK/igMgK6je3MpPGFZiw9Q/9fv3B8P3B/io5rKX72FSB0
         k7hxBh7NCohYeCmTrN+0PWT5yNhSBSJBjq5TPOrukho1f7rGZFNkmsPHvBvu5lgBACj1
         BLyidy6SyGTnPPNyIj5P/6Z3WK5Xsy5+SUafF6+4CNnQVRnLufDVXPBY6jqbcnG9exWi
         pmYgk5VP3mmzKcdxQWKiAxa+WFzN0DCl+98qtOC4nthXD1zc2tkz8Y035uU2ow1oPMgK
         XeIw==
X-Gm-Message-State: AOAM5334UZDU3wWpVpyeJar6HbE9oZFga4VNsNkEyee9w8X/A5PBhpmz
        /5uKn/0XdR6BqCr1rVoJhdRfgstzKug=
X-Google-Smtp-Source: ABdhPJwq0luAdpdlmLTPEl4oe8Od9vPb+TjMSBktwbCClEDhgr3jX3UYqoZ/0w+XuhMn1QXco7RLsA==
X-Received: by 2002:a17:90a:8545:: with SMTP id a5mr9009522pjw.35.1593273173171;
        Sat, 27 Jun 2020 08:52:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b13sm7419617pjl.7.2020.06.27.08.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 08:52:52 -0700 (PDT)
Date:   Sat, 27 Jun 2020 08:52:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Shuah Khan <shuah@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/lkdtm: Use "comm" instead of "diff" for dmesg
Message-ID: <202006270849.7190A26@keescook>
References: <202006261358.3E8AA623A9@keescook>
 <87k0zsbubg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0zsbubg.fsf@mpe.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 09:51:31PM +1000, Michael Ellerman wrote:
> Kees Cook <keescook@chromium.org> writes:
> > Instead of full GNU diff (which smaller boot environments may not have),
> > use "comm" which is more available.
> 
> Although using "comm" requires CONFIG_PRINTK_TIME=y doesn't it?

No, it doesn't seem to. "comm" doesn't carry about the line prefixes.
AIUI, the only reason for a mention of "sort" is because of how "comm"
does its line pairing. i.e. as soon as it goes out of sync, it starts
accounting for the disjunction between files. But that's exactly what we
want it doing, and the prefix doesn't matter.

-- 
Kees Cook
