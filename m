Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E710C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B0820787
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2DzLyU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbgEZPaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgEZPaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:30:07 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D394CC03E96D;
        Tue, 26 May 2020 08:30:07 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ci23so1476146pjb.5;
        Tue, 26 May 2020 08:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=an9KhWgQP+/Fji7KQ32EAN6LrJ7/yGHMUcaJcF1rPZo=;
        b=Y2DzLyU7ga/1gd25vfMIXc2hsI4Jl/HI4zlSDDOkQhLjym0fyD97OT9l7rWdxoJrU/
         Gj3F2USd8BzEhDLGRw4nN84mi1/lfHKsxlGsJm9d94hKH33e8JCz7bkqWE8HVxS4xfr4
         kAeeO3cgUL5AngjhHOzIJtBVGgGNQTTrZiUP4eoo0qO2kjoiAgOkH9JXshk4ySA7B9nm
         NGOAQj/xKe6K/sQFiMrsghgYJtRxXOTgrssil/3FzmV+HDJh+i+9JQgKdGxxcj1vJgg4
         TO2EIHLXV2MBQbfLSoYVohMTVpFDuQjuWApEa67mCt0rdBj589x73BosdSLh22w07/cP
         bVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=an9KhWgQP+/Fji7KQ32EAN6LrJ7/yGHMUcaJcF1rPZo=;
        b=H3p2ezEY4iU4dCARpXoi0L2dE25UDT594Op/0xu/wisewzZH1ZCl/SeWflS4KyJ8+H
         1BALIF6udSxb0mWhWet5hwvZaGxcA80iFG9+KzBBpaF8YFuNOz2Ql7o/A1JVVTzXLWgF
         gaRIMVNE07UVo1jjXLJnI8PqpixG1TpeNwD+jJcQuChXORpwrGkCvCZUIDoL34Z7kLPR
         qoQKCvXVaEVcPzytbUnzs9o8iEohQTdJJboxHb/RK9gI1aTwMO4sQxH58ztIUUeJFG+u
         86W/9IXR4i1OJB/srZssn5ixhqM0N8c1FmeWzgW6tEvwt0FitJNBY5pH36uNAYrZgFNc
         1O0Q==
X-Gm-Message-State: AOAM533N5ZiZ8znZKpIRfGrJGY7UOEjjkOZKdpaH6DmQufUb/KbFXA2P
        UCKyonAyP9VKagoow3aBZno=
X-Google-Smtp-Source: ABdhPJw607K5Yy3cpbQj7QtR27NhBpQq/vORS80zd+2iyq/bZjMIWObM4XLjhk4EssLGpG1TV8rNyw==
X-Received: by 2002:a17:90a:297:: with SMTP id w23mr17965652pja.140.1590507007342;
        Tue, 26 May 2020 08:30:07 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f18sm69423pga.75.2020.05.26.08.30.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 May 2020 08:30:06 -0700 (PDT)
Date:   Tue, 26 May 2020 08:30:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Will Deacon <will@kernel.org>
Cc:     Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] compiler/gcc: Raise minimum GCC version for kernel
 builds to 4.8
Message-ID: <20200526153004.GA74229@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 09:41:37PM +0100, Will Deacon wrote:
> It is very rare to see versions of GCC prior to 4.8 being used to build
> the mainline kernel. These old compilers are also known to have codegen
> issues which can lead to silent miscompilation:
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> 
> Raise the minimum GCC version to 4.8 for building the kernel and remove
> some tautological Kconfig dependencies as a consequence.

My hexagon compiler is v4.6.1, and I have been unable to find a more
recent version. Does anyone happen to have a pointer to a hexagon toolchain
with gcc 4.8 or later ?

Thanks,
Guenter
