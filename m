Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4B3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4221B208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590785508;
	bh=u6wXccwyYZJmOL6yuaK6lweEhKZCVHTEDlkRQ6N4RM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JQoOv1joBqqBeMIAbW+QG9HR06nneNdRED1eRBy4jcZWJObFcLgjP3WY3IdxX2VWC
	 YbJF8qE9Qk70NgH4tWghNWZOKbL/PyLQjOrz2dMpn6aWQtgzN/297fEgNmS7A3YetO
	 8DGckNBq/vMLyTGHM43X17X0fKAAO5L4RhKJ10ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgE2Uvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgE2Uvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:51:47 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0662C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:51:46 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u5so483903pgn.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8RJwxpvXZ7yHUIYItjDCi3nEt97AjOQZqm5mktIKglM=;
        b=M/KDB9MVaJ3bKK/pSESfGDhUz2/eSe8W2P3XY9ttwdBfbkd2+ZwCKif/7rKU8+FZne
         6pRhMTY1Ee9UfZ5VyWUThjzb8XwTmQ6C5UOdp7MI6rT5x4/FKGRCqO7wwaTVedFFOJqM
         eUUxTb2emHppUghqPa+BKIje7JIAwBlz2f087ZkLF018eRz8boXoVqOa53W3RnqKVaS9
         lWKzFj+LVMjz36NVbwhSi1TC3+lMsyufmMTZIQEZghxhB7ZORyPnPciLj/i4E2mAlx4o
         By89gmt+knU/npTwLbi3RePvKtwYVg/TyDa5EBnkMoekT1/nAMZwy6mEMfhUuIIJfU5Z
         rn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8RJwxpvXZ7yHUIYItjDCi3nEt97AjOQZqm5mktIKglM=;
        b=WD2c8CRdoMyhUzzGHn9tIylZt23+GxG2mvbE8BXWmcHmF8qttcakBhUKS3pquJkbKN
         VLi+Fc4exIxlMiTU7s55IINu+sa39CLvmj+k86pM99qnbirX8eCBZDtZT7ZK/eJ9dsJA
         rJS03Ky3pUXbftUnc71PeGsOr94eY481oxAXET5441HS3XyjzrmK4rIapGVmVQ69kVEq
         3IKUx5ZUEa0RjDC3v7cikKhz21RupAShXUnGqOjAfWKm7L7HBff8zb+mh6QvrH4wN5yi
         6d0M+7VfODto/bC4RqHimQwnGYuHZs2D2FsYGpq0QTPp17uLxL9RhdTwhg9Jmh7eT7Fq
         Ov0A==
X-Gm-Message-State: AOAM533MWg7IKd/w1ZCle+PM8BuryBwNBw/bbyW6BgcIN12hBnaCT38v
        p/W+88mM/PBGIj6uL8dGDy0=
X-Google-Smtp-Source: ABdhPJyNoA/GZeqgO4Y+adzG5eB639WejmPT5GFCWGmSayfvnl6iB8AzfdqsTvoSm68wTf+ydNVklQ==
X-Received: by 2002:a63:ff07:: with SMTP id k7mr9168036pgi.449.1590785506465;
        Fri, 29 May 2020 13:51:46 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id f66sm8313300pfg.174.2020.05.29.13.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 13:51:45 -0700 (PDT)
Date:   Fri, 29 May 2020 13:51:43 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v3 6/7] zram: Allocate struct zcomp_strm as per-CPU memory
Message-ID: <20200529205143.GC86436@google.com>
References: <20200527201119.1692513-1-bigeasy@linutronix.de>
 <20200527201119.1692513-7-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527201119.1692513-7-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 10:11:18PM +0200, Sebastian Andrzej Siewior wrote:
> zcomp::stream is a per-CPU pointer, pointing to struct zcomp_strm
> which contains two pointers. Having struct zcomp_strm allocated
> directly as per-CPU memory would avoid one additional memory
> allocation and a pointer dereference. This also simplifies the
> addition of a local_lock to struct zcomp_strm.
> 
> Allocate zcomp::stream directly as per-CPU memory.
> 
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Nitin Gupta <ngupta@vflare.org>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Minchan Kim <minchan@kernel.org>

Looks good to me.
