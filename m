Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A75CC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1893E22CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PfLeP1nV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgH0QtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgH0QtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:49:08 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C17EC06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 09:49:07 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p37so3779784pgl.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WiGBqbvIsFO7z3w2LMazIC2FdnllWalUyM7tW1jEsT8=;
        b=PfLeP1nV8B3U6EqkOgNzN84iR7UUy8/qiTcl/n3tYajHLnYHYm389y0pz4BY9Of1PY
         JgbSGcf1d7WEcDLjR1sQPrpu42wCr6/27pbNXF5vziV/LDpvB3m0qY5a0GAkUWJWVU8A
         EVZ6HlhvzrsITdJad7o0fkqp6zaLStbRbS/0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WiGBqbvIsFO7z3w2LMazIC2FdnllWalUyM7tW1jEsT8=;
        b=TfeyvzfHb7e38ZlPDhrIQZYaX48vWqBgRywxSm6LBe0VPpgyol3asSQTelgTKT8kEL
         XyJCduOxCXb9EJOYD8uQ6NgU4Ws7nRJ6MhWA2v8XOcoMkNK5yCXk91anQXdLE9ibtGYK
         V4We++Jc8gLZbNYuxgpvUcK88tjJGuSi/aPoYUKJ32I0vElc4ZHGMvOlNcTrikGin11+
         sKSJ+bWKYp3BBzWi6tXG22hULAn8fGBWaMiQOkTG/IdCeitX9bdUmUcrIuyG/TliPzL/
         3dAIotII5roOmgn7SQKQSoznD6FIIAd8jr36Sd99yukW/YkZt3AuFINH6r3Z6ec56fJn
         EASw==
X-Gm-Message-State: AOAM533LC1vYtTZtU20QxY16RvTza1xpQNMYPvpjj1/3bQ2TbwAppqup
        KZPOXRwltAZsiaM+TNgLFMmfNg==
X-Google-Smtp-Source: ABdhPJzcuCsRrPfIfLlHbR023NYEZxh/FkaJVSEHWhDNKlQXZmCOAVL9LXU4hpqCbh4th+9qlI/bQA==
X-Received: by 2002:a62:1803:: with SMTP id 3mr17714286pfy.198.1598546946678;
        Thu, 27 Aug 2020 09:49:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m3sm2665362pjn.28.2020.08.27.09.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 09:49:05 -0700 (PDT)
Date:   Thu, 27 Aug 2020 09:49:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        'Alex Dewar' <alex.dewar90@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "accessrunner-general@lists.sourceforge.net" 
        <accessrunner-general@lists.sourceforge.net>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: atm: don't use snprintf() for sysfs attrs
Message-ID: <202008270936.6FF344336@keescook>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
 <3e882693bb344424af37d4d35f3db605@AcuMS.aculab.com>
 <20200825082406.GB1335351@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825082406.GB1335351@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:24:06AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 25, 2020 at 08:12:05AM +0000, David Laight wrote:
> > From: Alex Dewar
> > > Sent: 24 August 2020 23:23
> > > kernel/cpu.c: don't use snprintf() for sysfs attrs
> > > 
> > > As per the documentation (Documentation/filesystems/sysfs.rst),
> > > snprintf() should not be used for formatting values returned by sysfs.
> > > 
> > > In all of these cases, sprintf() suffices as we know that the formatted
> > > strings will be less than PAGE_SIZE in length.
> > 
> > Hmmmm....
> > I much prefer to see bounded string ops.
> > sysfs really ought to be passing through the buffer length.
> 
> No.

It really should, though. I _just_ got burned by this due to having
a binattr sysfs reachable through splice[1]. Most sysfs things aren't
binattr, but I've always considered this to be a weird fragility in the
sysfs implementation.

> So this is designed this way on purpose, you shouldn't have to worry
> about any of this, and that way, you don't have to "program
> defensively", it all just works in a simple manner.

Later in this thread there's a suggestion to alter the API to avoid
individual calls to sprintf(), which seems like a reasonable first step.

-Kees

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=11990a5bd7e558e9203c1070fc52fb6f0488e75b

-- 
Kees Cook
