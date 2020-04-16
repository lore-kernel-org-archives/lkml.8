Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36161C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16EB7206F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeAIfPwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388490AbgDPCeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 22:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388304AbgDPCea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 22:34:30 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB59C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 19:34:30 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t11so942554pgg.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 19:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VGCTsZjOfwFALrkTwHQ3BpKRCT5jRI1JLGMxn0Y9Io0=;
        b=LeAIfPwLQw9DBknPFg6e3/Rarsty8kFj4HU0JI76pU69OVXr0j/8WdtKwEcp5TWflh
         uqqsaqXNv9unt0JC2Y/BvfZIa58C5Nl0RT1xCiNAxvzyQicyraupyqrhdRL6+TG/eGyl
         N8U2b6A8FUntyv+jkwOuSLFuavktCQyxzPpywiGCfm8QTEjt+Y4uqbg9uLhDSsiuUx8X
         7S6wkr9E4gXIi7hviHV60h0vPxFd7IfL3QXmRSuydREOBqJGO3edua5hTnb/tp72Zg5o
         ibs8RYaNSsET90SlRjRcO0dXKCDfBqr+itjKqesOUKsO6yNw64QHC2K9c9MENU+byHL9
         7kEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VGCTsZjOfwFALrkTwHQ3BpKRCT5jRI1JLGMxn0Y9Io0=;
        b=KL1x0PbQPQJy4kj4amCVyg89/MrZvnEO1dAJl6eS9594sNA9gaYVAaZWJseal0nuPS
         lBSWSJvNS+T/VIW+8AH3WCr9r0LVDSLv1xnSQWloRiGRNRNNREXeoJYwd9TU/aehw/Z6
         u6tAxKZm/z7UZ3qsY9l0WeU8Qpwz7/Kw2X7T1XvWjKfq2S8A+VcfoAXriCaxcDE3/ARj
         +aMApqylwz0GYNfRmV5ZM9Vs/9mgFniUSiTYTTZS9cS3ASuFMswdeKkbrD9L4dfSRoUU
         xQHjWSTCTvKpqGdTHaLVcfpjdHV8S61LLQoGzOcbN1uqDNWLIomvqZhjF3hw2wlTZ1z7
         TkXw==
X-Gm-Message-State: AGi0PubEwPgPI+I2cZIbCNH1EVWY+smT8vstad72XQUSg9AzjBB30BI8
        kXGljBYV1Vbf4S545y3N3vw=
X-Google-Smtp-Source: APiQypLQYpXG1C0l+UPgqnSiTa4WrIO0PT9bf1rvG3mQFlUYrH603chFIPsz2jx1VV7kknZVDneQ/w==
X-Received: by 2002:a63:4047:: with SMTP id n68mr29012752pga.321.1587004469709;
        Wed, 15 Apr 2020 19:34:29 -0700 (PDT)
Received: from localhost (181.56.30.125.dy.iij4u.or.jp. [125.30.56.181])
        by smtp.gmail.com with ESMTPSA id i13sm14969773pfa.113.2020.04.15.19.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 19:34:29 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 16 Apr 2020 11:34:25 +0900
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/3] lib/vsprintf: Introduce %ptT for time64_t
Message-ID: <20200416023425.GB30641@jagdpanzerIV.localdomain>
References: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
 <20200415132011.624f35f6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415132011.624f35f6@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/04/15 13:20), Steven Rostedt wrote:
> On Wed, 15 Apr 2020 20:00:43 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > It is a logical continuation of previously applied %ptR for struct rtc_time.
> > We have few users of time64_t that would like to print it.
> > 
> > Andrew, since Petr can't pay attention on this perhaps it can be passed thru
> > your tree?
> > 
> > Sergey, Steven, what do you think?
> 
> I'm fine with these changes. Sergey, what do you think?

I'm not against it in general, I'm slightly concerned if "two users"
is enough of a justification for new vsprintf() specifier.

	-ss
