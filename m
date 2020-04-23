Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7FCC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F942076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ePd5uThm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgDWRwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730056AbgDWRwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:52:07 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63800C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 10:52:07 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d17so3266726pgo.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 10:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gUBWqO+doxiCdXhXr0gP3xCZStrWlqjjVcMdf3dRmaw=;
        b=ePd5uThm0bXYSdghyVL6I8ByRtTuSR6tLpg9uD5btVJ1E85KUfRyUDcADHutASIuDr
         wDRbsm9ApCKQZzTHq3mRpCwYKxFbfoi6FBL+jrJjgTuhJOa3JtS04BSBu7+j0Gvo0Kfp
         GWql8yW1YEi7K+fykGXsWHbz9wd1XAGEE+AXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gUBWqO+doxiCdXhXr0gP3xCZStrWlqjjVcMdf3dRmaw=;
        b=dxFJ1Iys4po7kqns3OBc3UDxDFSrRWiL9n90pZ4zqcNNZtGa0a0PiUaNnpWRxYThD0
         lvoiVgywoo4gXCTr/ygEgVRvB7l1tmQih2JDP5k/YSG0g8RW2rmBtWLpBkmubBG+39vB
         qp+tUAegzyLh3KV3AmTYpbSuOgQHm9zAG4+W2XKYmr6d76LWi6S7oL0jR5S+PQKOdKTa
         Eszs4eZu4Uq11iEbyhZhk9t4ahBuu/CrXlGIOT1VNvJnz9BHZLcdN3Ds0zNIudnG5C0O
         HEBIK/LnilpVq3+a1x5o/Ai9S3oObK6TLMbMT67QYNhLFDUvK/lBCuzub5u7sqUx3GnS
         zQeA==
X-Gm-Message-State: AGi0Puaq9UnFGVxYX50dOiwgSN+U4WDss3Zl0i0kFzdxEhEsu1YIKzbQ
        uLJ4rtEojRrqnkY3vvPZ23XUELoQQF0=
X-Google-Smtp-Source: APiQypJjwRJAqItcsR/IbYNtsDxmiUE23oypy6sxVf2T83GopjZzhZgPEk7nNNtXCX6Xs1QV17SLXw==
X-Received: by 2002:aa7:80cf:: with SMTP id a15mr5116879pfn.124.1587664326513;
        Thu, 23 Apr 2020 10:52:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y26sm3046528pfn.185.2020.04.23.10.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 10:52:05 -0700 (PDT)
Date:   Thu, 23 Apr 2020 10:52:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] ARM: decompressor: simplify libfdt builds
Message-ID: <202004231051.5DF870A@keescook>
References: <20200419191958.208600-1-masahiroy@kernel.org>
 <CAMuHMdXmJ3gfYzubQRbN6Bx0A=p8TodidmoeaZkJVtYjhDcQnw@mail.gmail.com>
 <20200422075854.GK25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422075854.GK25745@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 08:58:54AM +0100, Russell King - ARM Linux admin wrote:
> On Wed, Apr 22, 2020 at 09:44:38AM +0200, Geert Uytterhoeven wrote:
> > Is there a real reason this is only applied to a subset of the C object
> > files, and not to all of them? Or have we been lucky so far, by not
> > triggering the issue in decompressed.c, misc.c, and string.c (yet)?
> 
> I don't remember the details. See commit 7f66cd3f5420, which came from
> Kees which introduced this.

Just to clarify: the original change was just removing it where it was
detected in the then-current build. I was going for the least invasive
change to the build system.

-- 
Kees Cook
