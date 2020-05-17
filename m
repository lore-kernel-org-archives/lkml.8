Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D67C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD24B206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhNSpImq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgEQJe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 05:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgEQJe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 05:34:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A882C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 02:34:55 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n11so3276189pgl.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 02:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yVlmeLGnp90jJYb5jgHidG2aB0CdImKuBH30RFWsXK0=;
        b=KhNSpImq0B0NVOEpidL1zFDrBP1EW9J1j3ucq6P1zrI6Zib44BbUT3pwAAy+JzcMYJ
         AO6x4OTdiqxyREM3eDmlO4Zs3v4Dq9ZZ9R4O2z1HLUKG9k7VML2kpdv6QSKoD0hlUmJM
         EA1jHxMjk2bwujbHBhosOiSSvwxEm8jvVDn1VndoGQumRzo6QWIOVuTLgFA0Vzd+bkif
         HexZri7n99Eqy+alAPcEsYl3AQ+hOL3I1Dk29Zbip3mwLu9U7nKnJ/qSZUyVmQumLBiK
         4AOZA16OU1cKLqXBXt7/+nslb5FH7Jwdi6MkV71W9osalnGZtNmfsVC6H+9Qv0TWF84w
         QOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yVlmeLGnp90jJYb5jgHidG2aB0CdImKuBH30RFWsXK0=;
        b=s48cY85IHn0dYqGNUbSPcRHclhkyvQEAtKjhMNyQmxkDWwBliC6FzAzafcY5y6G1HG
         pfew+TLcvpaeYsXxol3AXYtaePWBRumnKHDeEbv7yqiUI8hbeuWRAuoVEqC1lidSDKHb
         oxCaqPJXJrpbSkj+P3jOQ6xKYZpAgqLiX2FQgA/3nQ5mFdS14wPZr18qPiFGJ8ejOVgS
         wzYgK7gllHbVNEXXOnTd+xSV6RTP6Icf4/ciiXUDUwRLqBRaoqBK6Bsgw7O/5jmAFhYV
         JJG5yQSIjW5GL3OFAmJv0u1kzlWNgpZrFecfOjk/1P08GGZydHborKJeFI/iJe+VUBXz
         pLJQ==
X-Gm-Message-State: AOAM530QU2/IvmDJdZpFEiznZxlkvBi/EOHs2doCStZNv0eIxXLzy06I
        rl6qbQMvKPlNbfgJKHeNRYc=
X-Google-Smtp-Source: ABdhPJwyuXcaND2LBT8Cxc4eqUgAM04nsdxDsAPqBKKSkE+oja4gQDlQs1CD0IbNBT9veaJfnvNPpg==
X-Received: by 2002:a63:68c3:: with SMTP id d186mr10417684pgc.269.1589708095311;
        Sun, 17 May 2020 02:34:55 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v9sm5606663pju.3.2020.05.17.02.34.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 May 2020 02:34:54 -0700 (PDT)
Date:   Sun, 17 May 2020 09:34:52 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: do not create option file latency-format
Message-ID: <20200517093451.uvm557aatmll62fo@mail.google.com>
References: <20200516161017.155791-1-changbin.du@gmail.com>
 <20200516131521.02005210@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516131521.02005210@oasis.local.home>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Sat, May 16, 2020 at 01:15:21PM -0400, Steven Rostedt wrote:
> On Sun, 17 May 2020 00:10:17 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > The flag LATENCY_FMT actually is usually set by latency tracers internally.
> > So I think we should not export it to userspace. This patch removes the
> > option file 'latency-format' but keep the flag defined as usual.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> 
> Sorry, I actually do sometimes use that option for things other than
> latency tracers. So NACK.
>
May I know which tracer use this option as well? As far as I know,
besides latency tracers, the fgraph tracer also uses it.

I think 'irq-info' and 'latency-format' is somewhat overlaps. So
my thought is:
 1) function and function graph tracers should use irq-info.
 2) latency tracers should set latency-format.

I am not quite sure whether this is a good idea. :)

> -- Steve

-- 
Cheers,
Changbin Du
