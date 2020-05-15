Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D26C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD48F20709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kWPQyQcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgEOQF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726239AbgEOQFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:05:25 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEAFC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:05:25 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t11so1154812pgg.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kBN7u719Cy+shKvcAVCN3eO0onmk0cAZNndd2T91fYA=;
        b=kWPQyQcIp2zXKifRK1Dv6Ra/KBVZqU1Wut7JIevx+X1l3Fl1xt08KxLokd8gTA5nf/
         phh2ydFNzpCGYimlY3sOGzsX+GLukMmnheQGuqhbdLLuIIC1/jK3wgszDfDBmtr4l5MS
         TPKA3kwehV8tvBgG0ClpGcazblx3HEXVVqnj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kBN7u719Cy+shKvcAVCN3eO0onmk0cAZNndd2T91fYA=;
        b=srX7KEnPXR0FH/UmiK0yV2SFotwocXDGjcGkH59xrqqdm/ataB/H77k+Cm+WN8mBPB
         gj3VD7vy00Kg72V22vsFmn1j5wyHgcFvZYz7vbRG3pJfT2/TEW2ub0MM35W8tVU6VE3D
         +9FZ9gJM2wnXxY8WIRdsWg0hUbuZzeml/W5ObXDp3e/ZDqJtmj0O6PHPL1GI6FDGwQpS
         37qw8mpNEUQdUITCeA6B9MSMkc0EakucrFAHiQaNdF9YM3JJ/0Azc9pP7lcBkpDlhp8S
         4VQ/IHecijxfq+9zyVe9u6hYYzkd7eOxLOFNHLdTJkjNbtqA0dzYFN0akiGt0XHXPdc6
         /fnA==
X-Gm-Message-State: AOAM531wlvYfvWx4efc6bcaEpF+2pahvoNOlu7OEUswGkNlGtN/bcTGQ
        qG/fPp67R8UTZaXdxT5uOTmuL4GPVOM=
X-Google-Smtp-Source: ABdhPJy/E4iAlJTSoztVAYeb2pssKSMgsfT38t5zxKIrypg7WleSfgY9+nixllTCxRpcb4v+qwo6QA==
X-Received: by 2002:a63:7152:: with SMTP id b18mr3761898pgn.100.1589558725255;
        Fri, 15 May 2020 09:05:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k14sm2135911pgn.94.2020.05.15.09.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 09:05:24 -0700 (PDT)
Date:   Fri, 15 May 2020 09:05:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        mingo@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, bauerman@linux.ibm.com,
        gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
        dvyukov@google.com, svens@stackframe.org, joel@joelfernandes.org,
        tglx@linutronix.de, Jisheng.Zhang@synaptics.com, pmladek@suse.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, wangle6@huawei.com
Subject: Re: [PATCH 2/4] proc/sysctl: add shared variables -1
Message-ID: <202005150904.743BB3E52@keescook>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
 <1589517224-123928-3-git-send-email-nixiaoming@huawei.com>
 <202005150105.33CAEEA6C5@keescook>
 <88f3078b-9419-b9c6-e789-7d6e50ca2cef@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88f3078b-9419-b9c6-e789-7d6e50ca2cef@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 05:06:28PM +0800, Xiaoming Ni wrote:
> On 2020/5/15 16:06, Kees Cook wrote:
> > On Fri, May 15, 2020 at 12:33:42PM +0800, Xiaoming Ni wrote:
> > > Add the shared variable SYSCTL_NEG_ONE to replace the variable neg_one
> > > used in both sysctl_writes_strict and hung_task_warnings.
> > > 
> > > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > > ---
> > >   fs/proc/proc_sysctl.c     | 2 +-
> > >   include/linux/sysctl.h    | 1 +
> > >   kernel/hung_task_sysctl.c | 3 +--
> > >   kernel/sysctl.c           | 3 +--
> > 
> > How about doing this refactoring in advance of the extraction patch?
> Before  advance of the extraction patch, neg_one is only used in one file,
> does it seem to have no value for refactoring?

I guess it doesn't matter much, but I think it's easier to review in the
sense that neg_one is first extracted and then later everything else is
moved.

-- 
Kees Cook
