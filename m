Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5479C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D402074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxQNPxCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgFKH1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFKH1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:27:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E4FC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 00:27:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d66so2299920pfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 00:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F9YRyl1QH8nNLxQb6YLXx+y0EshlCzJxB+jfKLjlAqM=;
        b=TxQNPxCdxCFIlxp1IRQ0D8Vg8XFC00Bg44uvyzsUqyx/qoeEbJWb3Mnt5q6gUimqT7
         T25vKLwTHkwlPT/ja4Cfdhlny+1HZBqfBwTnX1lgltBfscYNxT8xBAX2YQAgzwhDEa60
         GdfWj4jhMDxUKdQMlK62NwFZ0n6OlvWmEkeHonIv3Qq3NZOe2gkw38y8cEhu69qalJjl
         FGq2+yPg3xe7Wh47U9W/R8HuIlY6E2ELpAezBXHuvX4HVM1Adz+bBpEIBBHizDPmDExV
         Wi/JAI/TmK9L5DuunYFH56e6fG3wJEPkeC68iUkcKc7s3+m5RCT0RrILg4QdEEysMndO
         8qpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F9YRyl1QH8nNLxQb6YLXx+y0EshlCzJxB+jfKLjlAqM=;
        b=ZANCzuyWTJX/OtRU/EGJ0WezeiEitajYJFY38IwsgOqvKH3GMGRhwWfG/dJs7MfCSW
         4bJKiPLAkD5JKIXWotZCISxkaiJjK25WbPVt1RR1jV6O06WpPhhNLm/2o/zfQLGqxce8
         ZIwOTGWnz2hTGpEA2tKL9LEDSW1SiPh1VW+lvQaKojFdXFJDY10oy4g42c+Q9yzPWRwH
         iANmqHY8ar5SYcJE0qPlUbBalhUQUVSM2GaJJ1HWO/pVFpPiez10jaFvkLZG8dKaHWQV
         yqK9E9o53TNlvIVWE4kQSf5SxDpxV16HicnLrI1pUUBpk9EURe6wWO0jJfQJitfNkAB4
         VzSw==
X-Gm-Message-State: AOAM532bz/hSkB14wwOHOJmX7qdapZEoywosOKVhGzpJP177LLMAM7q6
        xx2BhhRH3wo5eJ5AUDgOrRo=
X-Google-Smtp-Source: ABdhPJwhkrcAHfXYK9Qyr3n+8oV1pTLg7pFg4+NYq8gkVla26gxDRMXpFWipLKzcxbjwfYs46M449A==
X-Received: by 2002:a62:5ec2:: with SMTP id s185mr2426106pfb.0.1591860455453;
        Thu, 11 Jun 2020 00:27:35 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 15sm2152353pfw.189.2020.06.11.00.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 00:27:34 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 11 Jun 2020 16:27:32 +0900
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] printk/kdb: Redirect printk messages into kdb in any
 context
Message-ID: <20200611072732.GA429@jagdpanzerIV.localdomain>
References: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org>
 <20200512142533.ta4uejwmq5gchtlx@holly.lan>
 <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
 <20200514084230.GO17734@linux-b0ei>
 <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
 <20200515085021.GS17734@linux-b0ei>
 <20200515103308.GD42471@jagdpanzerIV.localdomain>
 <CAFA6WYOBsimP1j8Fwq4OcePEug4MGoaY3wTTTVydHtTphZ-FTw@mail.gmail.com>
 <20200515163638.GI42471@jagdpanzerIV.localdomain>
 <20200610164140.tgzcn5oip2gzgmze@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610164140.tgzcn5oip2gzgmze@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/06/10 17:41), Daniel Thompson wrote:
> > Thanks for the link. I'm slightly surprised it took so many years
> > to notice the addition of printk_nmi/printk_safe :)
> 
> Rather by coincidence (at least I think its a coincidence) the problem
> has recently become much more obvious.
> 
> 0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()") just brought
> this to the surface by treating debug traps as NMIs. This means the CPU
> that takes a breakpoint, and where almost all of the kdb printk() calls
> take place, will now unconditionally have printk() interception enabled.

Interesting. Feels like ist_enter() should have been using
printk_nmi_enter/exit() in the first place.

	-ss
