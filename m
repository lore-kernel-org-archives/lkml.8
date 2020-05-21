Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11B2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA9320748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="YwMWYEID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgEUOlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbgEUOlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:41:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D83C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:41:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e1so6900639wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dhqgwc6WC4sGph0fTaZYpLFUYgJuFwqFipF8kzGg7aA=;
        b=YwMWYEIDZKgGNTuRgHtBpp8tsHZEoFXKNIobdkQNKtgHEdzWctntTPQtjS0FqyKdPQ
         ZnlT8L7xd3M+MGpVswRyowDTAk9y1fX/XHY+4yxg75VIUUpWFsvSW1xTBM+Idbt1HVow
         5UrwZf8YqQZFhnrcr1TUonjdJSccmSyAp2/AJy6f5oWg1qFblv8D+ECcmNHToEudT+34
         EWFkfQ8uME+1cRaMH31FEhQTNlsrcmsgNa7ySO0PQI9wB0gC/25Zw2uiiF0LPbSBXubX
         0dpPEF9aJpYWKL2fM6X0bgb9X0gc88ameeqD5RRpNSa08QB62ZCFKcaF0Doj+yppEGuW
         dkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dhqgwc6WC4sGph0fTaZYpLFUYgJuFwqFipF8kzGg7aA=;
        b=fluYeNdVE3MZOOyioDn3HnXXrC2B311IfVAVdPmiTkJZB+Z2dB2+NRbmzXs14Yho0J
         JzEmCajmxRNhDzEeiNh0dKjPcL3Q0Mmst9Z14xFm+63RUT00tF8b3xmPcGhly2rcRAop
         FM45E19lgwPEUU7gavbeyfmNGkFTaKfMTaDKfgzhb17HyBjuOjF24dihi4+kxBE/2WWq
         9pn6riKKszWrhz1dpUEVZ6U2Qq2H59V28Xdu/P5CaN7XMp9gU6fgU0kXDp/1YFZXa4l0
         eAqq3JjfHBfVdLfo2sFVnug8udc7ZTp29ECV3l6vLr9ZOkqleGJ1TzUvunLVldti2A2g
         evKw==
X-Gm-Message-State: AOAM531eYIBYvlGNU+8NdZyBcARmIKOJcbEG2bn0x2D7zhh0glH6SgeA
        6JTLwaVDZGLiIwzMG+YPH//VNQFVrWI=
X-Google-Smtp-Source: ABdhPJwVmjb9n8pdxXv6l+OHvaVrQQcKvEB2zY5XuQd8WAaKoOMZROc6yEX5h8NaePi3Cxcp6iH6kA==
X-Received: by 2002:a5d:604b:: with SMTP id j11mr8830998wrt.193.1590072092483;
        Thu, 21 May 2020 07:41:32 -0700 (PDT)
Received: from localhost (05462bf6.skybroadband.com. [5.70.43.246])
        by smtp.gmail.com with ESMTPSA id r2sm6711865wrg.84.2020.05.21.07.41.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 May 2020 07:41:31 -0700 (PDT)
Date:   Thu, 21 May 2020 15:41:31 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf ordered_events: Optimise event object reuse
Message-ID: <20200521144131.GE19431@codeblueprint.co.uk>
References: <20200515210151.2058-1-matt@codeblueprint.co.uk>
 <20200518120408.GD3726797@krava>
 <20200520130049.GC19431@codeblueprint.co.uk>
 <20200520215234.GO157452@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520215234.GO157452@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May, at 11:52:34PM, Jiri Olsa wrote:
> On Wed, May 20, 2020 at 02:00:49PM +0100, Matt Fleming wrote:
> >  
> > Nope, the tests in this file are unit tests so I'm testing
> > free_cache_{get,put} which are file-local functions by #include'ing
> > ordered-events.c.
> > 
> > The above define are required to avoid duplicate symbol errors at
> > link-time, e.g.
> > 
> >   util/perf-in.o: In function `ordered_events__flush_time':
> >   /home/matt/src/kernels/linux/tools/perf/util/ordered-events.c:461: multiple definition of `ordered_events__flush_time'
> >   tests/perf-in.o:/home/matt/src/kernels/linux/tools/perf/tests/../util/ordered-events.c:461: first defined here
> > 
> > There are other ways to resolve this (linker flags to change the
> > symbols) but I couldn't find any precedent with that, so this seemed
> > like the easiest and most obvious solution. I'm happy to fix this up any
> > other way if you have suggestions though.
> 
> hum, could we just make free_cache_{get,put} public?

Yeah that's totally doable. I'll send a v2 with all these changes.
