Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB31C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 15:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2734423AAD
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 15:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PKro4SUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgFUPgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 11:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbgFUPgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 11:36:42 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040ECC061795
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 08:36:41 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b7so5778619pju.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gRP16u1hGpLUV3yyXDqoC8CE4YUA8ZpoMcUkBaKy1z0=;
        b=PKro4SUneqYE3bvs/1xZhKR519MFxNvu2l21K3NWg9zeWKlc1VHRaKXtWuUsaJ/fjW
         QeD3veZTQyVPEOMLMz3za2xKDPa7r53bN0FnNyf/ERHXsYbyqyZn91tkHqvls7basJnH
         Qsa+8L+FOYXo8Zk8mniRb1S2uaZEFZtnVAIDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gRP16u1hGpLUV3yyXDqoC8CE4YUA8ZpoMcUkBaKy1z0=;
        b=mImQRCCIuWhOEmuKKHraNXUkK09QeMijdqfxGiZ/R6QBO20FUyLbz8YErOIvLXsHle
         OkHs2EyS0txTMIrGvhZ6DCAo8+szwCYGKr2GYJNoPu/97lb2xTACpR9eeWQMDLHZwstr
         BNKSq2lJ4rrWeqBHGpPxN/5etpcJoN9/OzP8NrUTol0Qr8Pr34ak75OgOmiP+7wxGHRR
         IK/rYtdb+swpI2O7/t/T3HN7nfID5zi1SHUOLX7bH6EUHUgKTjLSgoMJ05YHX1WvSDca
         M0qpysAW5anNuusYHubu0b+h2miSaL/x3LngF1bOe0f7e9GEF4/Ffr5nUHkjq43HP+r4
         Y6QA==
X-Gm-Message-State: AOAM532iRzmUtWwx/JDgXM4Dr3dwP+Z8nYnFLPJFk+3k9nL24HXW4X2i
        Q3bGUQNShflwicmEf+KBmhJ97w==
X-Google-Smtp-Source: ABdhPJwKoiOm2N5IhzFQsoZM9U+ei319pSVs6AopcRngDYPXYQIA9nW38cCMcJgv95kKauGw7wk+Jg==
X-Received: by 2002:a17:90a:e7cf:: with SMTP id kb15mr14422643pjb.86.1592753800496;
        Sun, 21 Jun 2020 08:36:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o1sm11141702pjf.17.2020.06.21.08.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 08:36:39 -0700 (PDT)
Date:   Sun, 21 Jun 2020 08:36:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sargun Dhillon <sargun@sargun.me>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <202006210828.6AC290C4@keescook>
References: <20200621234851.64cf82c7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621234851.64cf82c7@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 11:48:51PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kspp tree, today's linux-next build (x86_64 allnoconfig)
> failed like this:
> 
> x86_64-linux-gnu-ld: fs/file.o: in function `__fd_install_received':
> file.c:(.text+0x1010): undefined reference to `sock_from_file'
> x86_64-linux-gnu-ld: file.c:(.text+0x104a): undefined reference to `sock_from_file'

Oh fun. Okay, that's the first use of sock_from_file() in core kernel
code. I will fix linux/net.h to include a NULL-returning static inline
for the CONFIG_NET=n case.

And I will add "allnoconfig" to my test workflow. :)

-- 
Kees Cook
