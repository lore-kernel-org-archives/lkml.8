Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698C3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43D632068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij7KH78W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgGMCYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgGMCYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:24:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613B3C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 19:24:01 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g67so5371332pgc.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 19:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ys0wtJn2ylz1a82TiT93wYbEpYpuKsySkVf3eVrvnzY=;
        b=Ij7KH78WidjD51ASKpnuV/5Wg7SwBxUazd3O+tZ53JTy//B1ekQYGk9oKO8EwcNTGZ
         K5ZJ8jLfz0Wk+2N5N/wsAoKaGi9QiveXBMfORkqxVjaKfnraCnPX8ts1+JrdBu0PJU+6
         vNl+0heNz4HOwiBk5+tHVnkxbPqpekXFCRem8xuEbWMnHw7dJ+O5af0hm7H/2qM3ng7p
         9Rn5rB3Bu6PLC1Aeag6DP/L+uGU83jaW/RKGZ8p7aLImzv5kRIs1Ul4eJ1Mjwu0ISYoD
         DQ6wGEAcfGv2nOepzWKIniZFIKArW8NZFuEzdmB/2D21xd7IgIBDCNYLgIomMrBmA+hg
         lgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ys0wtJn2ylz1a82TiT93wYbEpYpuKsySkVf3eVrvnzY=;
        b=WUxoIZ0XYKFr5oo2+FDpxtZS4b/8RLiUdAA0FyUTKXRk00fZh0fUGW8EtS5jq7dVPy
         vGtLpfX8mHx2nXE0FqZU1bMcAraGlIJRP5dL9F2XZibARJ9ysfeZykpR14JvK78KFwiV
         CWwLeo1SUG8wSnihI+DTwLiBhGY5n33nBjARfYwCIZw+Ws4BwKKZHJ+1lPfG9Qt8EjuA
         Pdg/V6tgfQ8dn3RIQty90QewgDxeVeH8azu2eeoWWwNIDwo9qFMbopDxa6OtBOJRmT4K
         SmikFRnZ1ukmje4lzU6+LnVP4Q0Sa8nsbpeYkgaoiI5w9o9+2hQ00yuEl6sv6857U8xv
         imgA==
X-Gm-Message-State: AOAM530P97/f/pHqsaf4U/l3lREvRLQO0JOjNK+V8YCXv0x+E5j0XYl5
        B5CEiXUCEGtCDZUOMkTsCaM=
X-Google-Smtp-Source: ABdhPJz5/5YyiB3YF3w9/9MmzbEciW1iW9pzkK5KvLwUp3MnrResaVAtq8KaAgCjAS6RvYM7JKqBpg==
X-Received: by 2002:a62:3744:: with SMTP id e65mr37616402pfa.20.1594607040696;
        Sun, 12 Jul 2020 19:24:00 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id c207sm12731674pfb.159.2020.07.12.19.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 19:23:59 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 13 Jul 2020 11:23:56 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] printk: replace ringbuffer
Message-ID: <20200713022356.GB491026@jagdpanzerIV.localdomain>
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200710082833.GM4751@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710082833.GM4751@alley>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/10 10:28), Petr Mladek wrote:
> On Thu 2020-07-09 15:29:40, John Ogness wrote:
> > Hello,
> > 
> > Here is a v5 for the first series to rework the printk
> > subsystem. The v4 is here [0]. This first series
> > only replaces the existing ringbuffer implementation. No locking
> > is removed. The semantics/behavior of printk are kept the same
> > except for a minor optimization that is reverted (patch 3).
> > 
> > John Ogness (4):
> >   crash: add VMCOREINFO macro to define offset in a struct declared by
> >     typedef
> >   printk: add lockless ringbuffer
> >   Revert "printk: lock/unlock console only for new logbuf entries"
> >   printk: use the lockless ringbuffer
> 
> The patchset is committed in printk/linux.git, branch printk-rework.

FWIW,
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Thank you.

	-ss
