Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BAAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF9820702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLbyCocs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393331AbgFWVM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393266AbgFWVMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:12:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F520C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:12:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so47581wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fkq9ZLDXUn+7v5h5NYAGxclwihh9EdJ53ZL4LdO1hnU=;
        b=YLbyCocsMXvHK7YAaraaoWys7UOHuW2b8BY/f1rkazivx1iqxVALjBmnG6IYUPMlcl
         bMliOaMVVm4yunIOU7URiSBEhUVFZL0Wl6wmlrcnfUZjkDzk07aoCFNoBOCTZJvSp7LO
         qZs+mtKdLFgL44ANhN9QMuUcHWcl+bOvi+D7x3cI4e1U70X6ba0EucBOqVzWxFmXinSi
         APIBF/qyyWtJch9Gg8IES8kKRU6pgu+KJ4y5nfVbUf+6aLVSZqIgWtLZiNqeKEClhx8S
         Is0UZU32P3INGJPuiEdOh3Q+zqsf05GynqrDhvh81eYsljZGTvcZPFJ0sBSAdhEYPSOP
         aGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fkq9ZLDXUn+7v5h5NYAGxclwihh9EdJ53ZL4LdO1hnU=;
        b=mPfIgt+PEhnxVBruOkA3G+8tenx6bgHiwNPaVRHx7nojzpfytWgbVCjabpZuWVl6Ap
         K0uc5nwxoxQe4Lf9Z+iLe+4o/0cOGJp/ZO7oD8eZQcZj0YptvPYeERU387WEztfwy09q
         HldSGIYQinh10h3YuzUdhGdYdQkBFeiw1NH8xMvbMOkkOiX2XSSqTVsBIY6AfAYnNXWE
         F9oC/ZwhK4IN+7iBngVXI4g8XRZz/kYWRgSQqXct2n3873i0fXDWwsWpXo6TjMmLfakB
         W/Q0KD8MaUp4Ml4gcetKD8hijckU4iMpdggL2k7r4pcuBtyhqUQwKpgG4u8qrnf8TJCN
         2Oiw==
X-Gm-Message-State: AOAM5308dcNu+XHnZDcVWJjPKt9M/MNC+OUe78q31BqP1yx54E7qbUER
        SbMQsf+lDfsSRBOVIwfmtrMIlGM=
X-Google-Smtp-Source: ABdhPJwMht4aDFW9imA+eX2pY+4ilmwfkx4Jpl4INOy77RsUMwVoDdLYdaPOIFQsRzuu8i231SznpQ==
X-Received: by 2002:adf:e60a:: with SMTP id p10mr8859099wrm.181.1592946741898;
        Tue, 23 Jun 2020 14:12:21 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.162])
        by smtp.gmail.com with ESMTPSA id f12sm10994093wrw.53.2020.06.23.14.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 14:12:20 -0700 (PDT)
Date:   Wed, 24 Jun 2020 00:12:18 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Kook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: process '/usr/bin/rsync' started with executable stack
Message-ID: <20200623211218.GA40110@localhost.localdomain>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
> Also, the PID is missing from that message.

That's intentional. I for one hate pids.

> I had some long running rsync 
> processes running earlier, maybe the RWE status would have been visible in 
> /proc/$PID/map, or somewhere else maybe?

If you think process is still running, /proc/*/maps should have 'rwxp'
indeed. You can do quick

	$ grep -e '\[stack\]' /proc/*/maps'

to find it.

> $ checksec --format=json --extended --file=`which rsync` | jq
> {
>   "/usr/bin/rsync": {
>     "relro": "full",
>     "canary": "yes",
>     "nx": "no",
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

	$ readelf -l /usr/bin/rsync | grep GNU_STACK -A1
	  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
	                 0x0000000000000000 0x0000000000000000  RW     0x10
