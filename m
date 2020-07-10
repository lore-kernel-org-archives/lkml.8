Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955D3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6364220720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQUiEISG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGJOzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgGJOzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:55:51 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B4EC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:55:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc15so4610729pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5qlBUNa5GnmurWKf45fRGBNv+xXITvxnHNdiqqdzLVE=;
        b=TQUiEISGLpt2qX9mjXGnWDdTRRW15bV5vv8PVhdAuiwttnaAFn7MGVn+PvQxPSzxLA
         Redu6gCKwM5KvQcBiAcQqEF1Uyuq1m5GdlfCVebtZ0AGd7J26Qbarw637HptZCYn4w6w
         42TaN9XHSYqX1zA4CDIF150ybYL94YYoFtkWdgzl+ak5xsgiemBk7wuiWuCyNq2eritr
         U6AGwgg0lKMuzsplqoi5p8IlYuT21SuaESvzPGaq8FX1sFAdAwAaoBvEusWIM6tO7yD/
         f3lmDMaqCcfIvEegQztLFuBFUkLxNC4UF+Qx36RJoqOLFSDY/UI7dtdvrYUApy9tsdSz
         VI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5qlBUNa5GnmurWKf45fRGBNv+xXITvxnHNdiqqdzLVE=;
        b=cvYPNIaBNcp7/nJL2BRO5fVmbEbOSCHwwO75UWDmWeD3PoWPA4eQ/8D2+WFJWQVBID
         DDzpPEVIb94LDfGmiGZSRhi0dqEJXul36eZjxYMrzIQqSWGrH5OM5q8VOg988qImrY8M
         CWqOMRuQks/4kgPL1MdzmeFtIOy1D37r1mCYUwCBUditom7mK/r5Qw3XZjTq5LCmJo2R
         FF6mP1KaYyzTpo/vfuNdu4bnfoXh+i5C8P/ed5Qd+WUT2tphPb/JLLCpOGOarSk984QV
         qUsu5BtzT0j0qDYM5b7i5A/5RaLlBL+R68wdoGupcOyS1BWRVZXKMGey8EEcyorolAgX
         PhzQ==
X-Gm-Message-State: AOAM531RuDxsfIXrE9t9GIt9DA4ND3RsMq5sMX9MNb/Kiwtdnz89EqT6
        3JPOo3we8ztiVLe2B1Oz9Zp/g4JL
X-Google-Smtp-Source: ABdhPJw9yHfzHm5pu+2n+OMjSmScsNozxWbsZ0/I3o6AeWlSRoYWjc4CPfGTYllVaLT/eljlBuEwUw==
X-Received: by 2002:a17:90b:188b:: with SMTP id mn11mr6152281pjb.179.1594392951114;
        Fri, 10 Jul 2020 07:55:51 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id z5sm6334795pfn.117.2020.07.10.07.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 07:55:50 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 10 Jul 2020 23:55:48 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAIERS: Add John Ogness as printk reviewer
Message-ID: <20200710145548.GA491026@jagdpanzerIV.localdomain>
References: <20200710094432.19655-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710094432.19655-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/10 11:44), Petr Mladek wrote:
> John Ogness has started major rework of the printk code. Add him
> as reviewer so that he is aware of all other coming changes and
> could influence their integration.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
