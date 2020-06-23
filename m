Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFB7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD232072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AENfaNVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387465AbgFWScs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733102AbgFWScr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:32:47 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2EDC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:32:47 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g17so289240plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zM9UJPmqH/uivaDuT+boW9jaBhqjP7MlOqWA/nUW2MY=;
        b=AENfaNVEdXr6w72rhyrdTL92lkyid8j6xhmJvbaCRkkHMG4QPB3bQq4xfUY/nk/anr
         UdAcmEUJDpXWI3sgCow99B1wadOUIbh9mS9fNzEYwnAvq8zMt00iIOwEtiUgR15swyi8
         NP0C4RRE0Mt1BNbSZOiDpAxCi/owmZYLr38nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zM9UJPmqH/uivaDuT+boW9jaBhqjP7MlOqWA/nUW2MY=;
        b=Pgi91ZvG9n1M9Bq+TnChccackELGzl200PDIddoxjnXXOcu/9I7PtMZgLxpQGsnB6w
         Zs6ZuYB5X7dDb7gywIaFURSdx2Hg8Hn/g2sO+or5efBfzpqhE80YlEjBINBqVg9fKsaf
         7yN4+FLjF5lEh5x54XDiLqgrF/+Zt8rRYWrfGJXrIuW0V/ZQN5nasSHJw/1qw1f0pNMG
         sz+LIlNzL1yn8V1DPu4PzlILLkqDx/nENZLzzkRtJaMCi716A6W1VquEQlYzRsH8gXTz
         kg+Q5ygjyyKvplKrLhsLFCd1DJ4DvpJnd757WM4UE5vwI3iNn1+H/L0pFJIhG4WsE55c
         lKfg==
X-Gm-Message-State: AOAM531+bqvMKKDnFQl/D8AeS+MoMwlTs3MkS9pnTBCL/ZVPUUXZnCxO
        V1QRXn1CWrhyFXqUHEjvexQsASZO5Fc=
X-Google-Smtp-Source: ABdhPJwFoB/YxOk0T5aBZrS21QE4Ipj9CPW5ymqQpNkMl7IDi1V8efyNWyYzYc1WaOkTPZ5g9OQghA==
X-Received: by 2002:a17:90b:234f:: with SMTP id ms15mr546488pjb.7.1592937166889;
        Tue, 23 Jun 2020 11:32:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v9sm17578308pfe.198.2020.06.23.11.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 11:32:46 -0700 (PDT)
Date:   Tue, 23 Jun 2020 11:32:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: process '/usr/bin/rsync' started with executable stack
Message-ID: <202006231131.AD0A7F5F@keescook>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:39:26AM -0700, Christian Kujau wrote:
> Hi,
> 
> exactly this[0] happened today, on a 5.6.5 kernel:
> 
>   process '/usr/bin/rsync' started with executable stack
> 
> But I can't reproduce this message, and rsync (v3.2.0, not exactly 
> abandonware) runs several times a day, so to repeat Andrew's questions[0] 
> from last year:
> 
>   > What are poor users supposed to do if this message comes out? 
>   > Hopefully google the message and end up at this thread.  What do you
>   > want to tell them?
> 
> Also, the PID is missing from that message. I had some long running rsync 
> processes running earlier, maybe the RWE status would have been visible in 
> /proc/$PID/map, or somewhere else maybe?
> 
> Please advise? :-)
> 
> Thanks,
> Christian.
> 
> [0] https://lore.kernel.org/patchwork/patch/1164047/#1362722
> 
> 
> $ checksec --format=json --extended --file=`which rsync` | jq
> {
>   "/usr/bin/rsync": {
>     "relro": "full",
>     "canary": "yes",
>     "nx": "no",
^^^^^^^^^^^^^^^^^^

It is, indeed, marked executable, it seems. What distro is this?

-Kees

>     "pie": "yes",
>     "clangcfi": "no",
>     "safestack": "no",
>     "rpath": "no",
>     "runpath": "no",
>     "symbols": "no",
>     "fortify_source": "yes",
>     "fortified": "10",
>     "fortify-able": "19"
>   }
> }
> 
> -- 
> BOFH excuse #244:
> 
> Your cat tried to eat the mouse.

-- 
Kees Cook
