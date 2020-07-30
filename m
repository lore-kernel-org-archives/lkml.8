Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A08C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1156E20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lon34e/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgG3Q5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3Q5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:57:43 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F8FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 09:57:42 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id r19so4323204qvw.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ETunvLqbk5CjqHvVxeZIz++L3Dx+FtAcI8w4/6l5xVs=;
        b=lon34e/EG+IgHsvdg4C7LC1QTcczEt1KsPe8RdKfRR7fIni7wKE5wwZh7Hrww2Xx1Q
         pswSpGVIuT7OJFb/NfhuAhS5sUowf8ciN90vY0hEJxOAMGrIQuF58bbleJ4XH+R7l8SW
         tdFANeynASe2IaKTxWpKTo/zj5NVmXGsJKbSehc2M2hMvrPt0sWguvj1tQUtQhQYR1Te
         FhQNWgSj4O8DRtrACLwnHEBvbvrwuituYdaJ8ItXgToHW+OAkxy4Hbefe7wBqHWSvOv7
         IuAz1s4gEt9iH46gGQ1NSZwyJnWJorZq64wsjfRObPkFFg4PQRRbtDy4pvrFm7bMKUno
         j4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ETunvLqbk5CjqHvVxeZIz++L3Dx+FtAcI8w4/6l5xVs=;
        b=QhhtTL8VprOsPSBVsumTrXz8Df0NUGcTIPdEe9FCTpBbUkUrViH3AwNzBd8xJgsKMm
         kzaMNuRjneIryAj0YsB9fGooEsZ2f9YmKZb4w36rgPPd+RvprtF32H891ZyRpMQNqEo9
         mUlmmJ9+cVJknkIQY6shXORL9Ol25b7X+EwAF92MDi7y4aQlCXZ649FNBRehcAzxzrdJ
         NNCnUnpyBZhLI7Wxn37pHixvQaigkfmbOeIYZ5R01FQR0Z9vRFTb/StJ6TgWoqHkEUO+
         GrVEVnBhUVodaE1S1MX5sPFQ0I0OIFO7+pWvXVcrT7Fp1FeNCFboaDr4EJlTP0Kp/8wb
         oPjw==
X-Gm-Message-State: AOAM532rNMP2QaK5OUJaXMXHmBKar923eGTtkoLHV+C2VJOO96NMApCK
        oJ4ue8xaxK6LNQf7iTPJcwYrVbym
X-Google-Smtp-Source: ABdhPJw1mP2jHHVPGS8Gsbw/YU8iW0YzMuTUkQyAcWISnV8quYex5YuxVAxeJJlAtBshHYGQboAX2g==
X-Received: by 2002:ad4:4e07:: with SMTP id dl7mr31018qvb.134.1596128261838;
        Thu, 30 Jul 2020 09:57:41 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id u37sm5229702qtj.47.2020.07.30.09.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 09:57:41 -0700 (PDT)
Date:   Thu, 30 Jul 2020 09:57:39 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] arm64/alternatives: move length validation inside the
 subsection
Message-ID: <20200730165739.GA488827@ubuntu-n2-xlarge-x86>
References: <20200729215152.662225-1-samitolvanen@google.com>
 <20200730153701.3892953-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730153701.3892953-1-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 08:37:01AM -0700, 'Sami Tolvanen' via Clang Built Linux wrote:
> Commit f7b93d42945c ("arm64/alternatives: use subsections for replacement
> sequences") breaks LLVM's integrated assembler, because due to its
> one-pass design, it cannot compute instruction sequence lengths before the
> layout for the subsection has been finalized. This change fixes the build
> by moving the .org directives inside the subsection, so they are processed
> after the subsection layout is known.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1078
> Fixes: f7b93d42945c ("arm64/alternatives: use subsections for replacement sequences")
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
> v1 -> v2:
> - Added the missing Fixes tag and dropped CC: stable@.

I think that the cc to stable should have been kept even with the
addition of the fixes tag. AUTOSEL will still most likely pick this up
(or even Chrome OS's patch bot that they now have) but the cc to stable
would have made it clear that we do need it there and the fixes tag
would have guided how far back it should go (rather than an explicit
version that is added).

Something for the future I supppose.

Cheers,
Nathan
