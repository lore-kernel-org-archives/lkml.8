Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6C2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 833F02078E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ghe0LNHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbgFXXhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387843AbgFXXhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 19:37:31 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A9BC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 16:37:31 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h22so2053206pjf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 16:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mo7Dwe07kJhP63QLmOzciNFvW218NBaVIlEPp4HbWlg=;
        b=ghe0LNHZStIXrutzWngNn1w8HnVKxzkKAANg+f3UNbpWa1VXDLTQLRRUxQiw0ETxf1
         8IwO0ripMH+IKCR86WNY+ysG11jZ8MVO51xum9mEa475UtB+fdRpajYIKrof1LeRnhfw
         q/KZy9ALnBT7rcr/zSWyqYTnZ3OeY5pBxENZEDhKneGeIxS3jxNDb3T6z60V1Qc+Vdy6
         OTaykXWX6WKsBL92+Zu8AYSrqkunkoROSncALDdIHd5jRSMEYzkTx2v4nRNz4Z77j4S9
         tRCzT7qVWnXl4XZ9bSsfQVqiYUdUQyfJWFL+rlMfK7ACBBFVz6umkgQZxUMxIfkAgDuf
         rFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mo7Dwe07kJhP63QLmOzciNFvW218NBaVIlEPp4HbWlg=;
        b=QfZ1f+WgA9LkTDl+PcD7W/wnUJ0KGhxgFw1OhUFm2YukIlb/uZVSxEGRmGSFaf2Vty
         tljSExzuzCfqJ1c4MR5B5qpXyh++sSFqUjY/4dZV0J8Iel57KgnSeO3OjSprJqI/60mD
         oaHc371oCqbgTV16S4ScnwUS/IOhycGUaSjDhGPR2i6APl7QD+CoSDBPG5CDdPc8m+wt
         ygvf+ncMSdCUXRWxme3Jrvh4qLmWZnekF8HepRzfZ+Xyo5o/C315FSGBu1tEGJ5umYGL
         y0RNANS6pThkdVKgRTrFHY8idqI6zIOayLx5nBGogN+P98qgXUeHM96xtfcjxYYCyhVs
         9y6A==
X-Gm-Message-State: AOAM530JTLaleTZFpdAKdBBf72tTaQOunyxJd0CaccS/L5KtqvOntd/s
        fWQdvaU0xIG55vh60UItzlanZg==
X-Google-Smtp-Source: ABdhPJzbL+A8YRu6cQqMhEnH4JVMHPuZevDUkJdMyUg1rfNtOurVArWJG2BoYxI9g7/QXZLvtzZHnQ==
X-Received: by 2002:a17:90a:9d8b:: with SMTP id k11mr267919pjp.10.1593041850610;
        Wed, 24 Jun 2020 16:37:30 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id c9sm21338811pfr.72.2020.06.24.16.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 16:37:29 -0700 (PDT)
Date:   Wed, 24 Jun 2020 16:37:24 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, George Burgess IV <gbiv@google.com>
Subject: Re: [PATCH 06/22] kbuild: lto: limit inlining
Message-ID: <20200624233724.GA94769@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-7-samitolvanen@google.com>
 <20200624212055.GU4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624212055.GU4817@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 11:20:55PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 24, 2020 at 01:31:44PM -0700, Sami Tolvanen wrote:
> > This change limits function inlining across translation unit
> > boundaries in order to reduce the binary size with LTO.
> > 
> > The -import-instr-limit flag defines a size limit, as the number
> > of LLVM IR instructions, for importing functions from other TUs.
> > The default value is 100, and decreasing it to 5 reduces the size
> > of a stripped arm64 defconfig vmlinux by 11%.
> 
> Is that also the right number for x86? What about the effect on
> performance? What did 6 do? or 4?

This is the size limit we decided on for Android after testing on
arm64, but the number is obviously a compromise between code size
and performance. I'd be happy to benchmark this further once other
concerns have been resolved.

Sami
