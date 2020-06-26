Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C65C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358FD2089D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F2+fUMuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgFZVzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgFZVzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:55:19 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5F8C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:55:19 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j4so4750528plk.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xVIBEC+6IvqYyqsLzY3ZM3qq2NbIukPx/+eBe+BGeXY=;
        b=F2+fUMuKvctNZKgNU87gtAVWASVljxBaic/ryGSKImj0xmbDNRaAicGKMiqD1sJ8ZD
         83nI7ShtW0PzUMfxh9aWUDNMBUiAt7sJTzq99DDgqe1lIHgrsv24WntvjO438xSkBA5y
         uMivYIX5FQV0eyAyMlV0e1gIBY670O0Bwvw7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xVIBEC+6IvqYyqsLzY3ZM3qq2NbIukPx/+eBe+BGeXY=;
        b=qMNZqYp87SAjXTKhMNMd53oX/9lmtEBvVoqy8bnOyrq7hloehlnU1fOEXWXood9QCO
         VLUfOhh4nXUQmFItvXoPo13fnlC+6ajjkuQM9oScDW+cK4JiakAquwjbS3fAdxzF8eDt
         P41IoBv4xhO+oQuBWtenA4vKLbhwL9drFJnzV8Oyl2z2NDwE3OlFTB2N8d1dbD1Hh5Hn
         cN0wSqIsdTyHi6ggtBdrgm67pY+9cpF0d3r69yfdL+4LnQ6S4xnJlcRH78EXKUxAfcB/
         vWqz3iBbXjuDTRxY9fTb9WXD4RIaWoJV6MFoUKuDcJa+bK1pjvzavWYxPCHx1OWaAtuA
         m3Kw==
X-Gm-Message-State: AOAM532YCdpzp8oSTP/8bVZFY8oigRj0H8t3ICX4rpI44nV3kG7pikG+
        rE+bxXTyokcD4J36CD/FwJuzeA==
X-Google-Smtp-Source: ABdhPJzITcH6IJheYeVw6JKSdUw3PRKfIdesXQ8hn3koNQnG5M+abE+edLKuYAeKTGbywU/fzyJGYQ==
X-Received: by 2002:a17:90a:e60b:: with SMTP id j11mr5753077pjy.189.1593208519004;
        Fri, 26 Jun 2020 14:55:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m1sm4481809pfd.145.2020.06.26.14.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:55:18 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:55:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@quicinc.com>
Subject: Re: [PATCH v2 1/2] arm/build: Warn on orphan section placement
Message-ID: <202006261453.348213A71@keescook>
References: <20200622204915.2987555-1-keescook@chromium.org>
 <20200622204915.2987555-2-keescook@chromium.org>
 <CAKwvOdmYa6V=W2eupEmHcuF8+479F8XHxm1NAo0s2N=sawbKAw@mail.gmail.com>
 <CAKwvOdk-racgq5pxsoGS6Vtifbtrk5fmkmnoLxrQMaOvV0nPWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk-racgq5pxsoGS6Vtifbtrk5fmkmnoLxrQMaOvV0nPWw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:36:44PM -0700, Nick Desaulniers wrote:
> If I enable CONFIG_THUMB2_KERNEL=y, is where things become
> interesting. llvm-objdump produces wildly different disassembly before
> vs after removing .ARM.attributes.  There's also lots of decode errors
> in the disassembly.

Yeah, at your earlier recommendation my v4 series will be keeping
.ARM.attributes. Thanks for verifying!

-- 
Kees Cook
