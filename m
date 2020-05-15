Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2D0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 875E3206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhAOfp+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgEOQgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726246AbgEOQgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:36:41 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528B5C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:36:41 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z1so1186876pfn.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bh8ixcsDUuAv48rLKduFHjKYM7D8+5KBZ3dzDMIQTNo=;
        b=ZhAOfp+UMX7lLYJr0/PzKOR6v3qyxcZXl6kAhItI0c2DozwmG3GHhsAqobF3tB1Jvd
         J9KilAgtSIXAm4tsiWHhTQAd49AVoLwHeU0onuhtROXUoKNksqRkcWoiDMcSwMu7ECY6
         slkOEZDJPkv89qedsX589SJUcHR0iwluBOh68DJUz591pQWXlJDhv0YuPMjrMsH4IzOb
         A9Tjb+tkJUovBT14Jg6IR2YvPBvJ4qX23PG2Mqkh56Ql6OCE0uYq2OD8sqw37IY97Gw0
         b4ZvA6YJfE2uVIADBY8mrnPQDDImVu2JeTffLG/JLbox29tZsIqWAO9YD9YLFVFmipUQ
         SGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bh8ixcsDUuAv48rLKduFHjKYM7D8+5KBZ3dzDMIQTNo=;
        b=XCe3fQFIT3gDIN0NUqz9t4rlhbZ/ExzYCf2/4yU/PrsbwuIXQZHNLIqqiAnuqkBLfs
         uiJcJ2D4oO2MNuTiHqhJS5IGpqDGNs62NGqbgIBgqR6Q179R+eDD7gJRewI3fPd7Zb7L
         Ea9c+5psfdicafch2DoKhxItQUUNcGG/+q7H7holOuZAWtrWKJ/ZIeZ6MyaUPVjgLJsR
         Y+UNmxqFBTjE5jnEeQYVv8lf4yF9BbTbhKRqBaot96aDh3mvVEnX8upNZYi2VE8cNKJC
         zA3GHaJp1C0Bvgl8Ip0ZUf4ZSAYBlfPEy6DASrNodeSvPeKe2CTG/oepinCz58MHjA7B
         +MvA==
X-Gm-Message-State: AOAM530ldjiM6xRi0DQ4m9VlxxjFsqBiygjNHzE2nBL7EyDlhvegehNO
        bPaGyB33dBBMeCCVFyaLQiY=
X-Google-Smtp-Source: ABdhPJwzdar/iwUxzCQU7H1yQOkxLGAdRa+i9xU4TgPUhSS8+Y06un4TwoVVGYWcRVTsTSJlSN0p4Q==
X-Received: by 2002:a65:6799:: with SMTP id e25mr4100089pgr.9.1589560600837;
        Fri, 15 May 2020 09:36:40 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id kr1sm1882333pjb.26.2020.05.15.09.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 09:36:40 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 16 May 2020 01:36:38 +0900
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
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
Message-ID: <20200515163638.GI42471@jagdpanzerIV.localdomain>
References: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org>
 <20200512142533.ta4uejwmq5gchtlx@holly.lan>
 <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
 <20200514084230.GO17734@linux-b0ei>
 <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
 <20200515085021.GS17734@linux-b0ei>
 <20200515103308.GD42471@jagdpanzerIV.localdomain>
 <CAFA6WYOBsimP1j8Fwq4OcePEug4MGoaY3wTTTVydHtTphZ-FTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYOBsimP1j8Fwq4OcePEug4MGoaY3wTTTVydHtTphZ-FTw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/15 17:32), Sumit Garg wrote:
> > Can I please have some context what problem does this solve?
> 
> You can find the problem description here [1] which leads to this fix.

[..]

> [1] https://lkml.org/lkml/2020/5/12/213

Thanks for the link. I'm slightly surprised it took so many years
to notice the addition of printk_nmi/printk_safe :)

	-ss
