Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698E3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C9902063A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmcllhSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgHABgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 21:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgHABgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 21:36:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9058C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 18:36:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e22so8629130pjt.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 18:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pxAEA0+53qgyl4Uc2oHtAITDQ4MZNgAMN6Zdiw4qC64=;
        b=rmcllhSkSXIh9FjDOoVavm2a5uMqwXBwh9lgR+ZgDbBstm4O/n/JUGAPeHD9ej/EZz
         0FzRo4C4m93GJ/AnPBELAh8tzkEUPOUOQQfshePlw5KkCDTmhLoHzjMW/2c50umCQNds
         0J987JYpcEFD8CNZqnCKqtG/12Zzp+MvmQ0s0arTfmNFm71whYVM1HOyIYq+dFsPtyh4
         0C1awMQRSuD/RbbLnJxuRi2dDdDpAWDcucQMUy92ugySlFOGH1MTDy0JUQHW0Xw7LLeU
         XPAu+PW8kXIzilxBp6H0rHOOb6KBMbGBm3jbEpU+tHyVCVpL+N1hj8OUP1+RHz6WE5/C
         1mGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pxAEA0+53qgyl4Uc2oHtAITDQ4MZNgAMN6Zdiw4qC64=;
        b=WsJuwGIKAx+4AARZfOao+IcJIVzqMo4XDFzNiV9307oOhRSG2H7IzK81l/zfto+e94
         xaffSY/yxFG0yPgPF8DsaM70e6gD+shX4Oz1cOsk7jPOayOlc6IWDSTpgFvLXEL7fStF
         buCXDQCXZSVqsQZ4GUaC2Rbz8IBVWZaBT2jHfrsetafcQs6HxmfxagF0rpoE503UZGO1
         UnQR3yHVx9pUkkIovFHwstT2uuU2xAVq5ynMTxv7xxYSDnhxULO5joqtgCHEIBTCHHSY
         JGsUNGd54Kdr0mzALFjX6PA96cKDF3VSZAu5m9RuQnwlMmJsoWKzTmlXA2dCw20j4Lt4
         P9rQ==
X-Gm-Message-State: AOAM533ZvNxMvtTFD+bSqtKkNYlr71vKvmg+oGtfOuZLmlOZrlMJ/HD3
        vQS0nTI+Zl6HALi/a/G12Mk=
X-Google-Smtp-Source: ABdhPJwpY9jEMwUj0VL8KhQZvb6/WF6ddlSjfXgB1LYkhSZiEfmlAR7UPItjzqFM2MIgLateVBS+Lg==
X-Received: by 2002:a17:90a:d3cf:: with SMTP id d15mr6315034pjw.202.1596245779221;
        Fri, 31 Jul 2020 18:36:19 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id r185sm12056854pfr.8.2020.07.31.18.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 18:36:18 -0700 (PDT)
Date:   Sat, 1 Aug 2020 10:36:15 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 3/3] lib/vsprintf: Force type of flags value for gfp_t
Message-ID: <20200801013615.GA796@jagdpanzerIV.localdomain>
References: <20200731180825.30575-1-andriy.shevchenko@linux.intel.com>
 <20200731180825.30575-3-andriy.shevchenko@linux.intel.com>
 <20200731164900.3ece67fb@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731164900.3ece67fb@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/31 16:49), Steven Rostedt wrote:
> On Fri, 31 Jul 2020 21:08:24 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Sparse is not happy about restricted type being assigned:
> >   lib/vsprintf.c:1940:23: warning: incorrect type in assignment (different base types)
> >   lib/vsprintf.c:1940:23:    expected unsigned long [assigned] flags
> >   lib/vsprintf.c:1940:23:    got restricted gfp_t [usertype]
> > 
> > Force type of flags value to make sparse happy.
> > 
> > Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks.

> Petr or Sergey,
>
> Want to take these through the printk tree?

Can take through the printk-tree.

	-ss
