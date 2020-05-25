Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C76C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CDB2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFmfYN4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbgEYJMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEYJMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:12:00 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79178C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:12:00 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x10so7274173plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/OWDsHDL70sQccYbo8Luw6/UtlKJg70Rl3vnaAOycYw=;
        b=PFmfYN4YmPTzCr9oNgJE8uG4Yj2KzMbpmILiU0eap+q1Ezba8aE9u2lAn34ZF+/R9/
         Ex7W6dsTHbBOZeC0jLET4tJ7DoOQPqpPYqQ7mIjoNmT7WLz7bJfJdJmG/1h1mFe5R6tm
         NII+xiE0yerCBIqrGI29tCFQqE8ckF/wN/MnbXSMhciV4L6qXEXhhp8aMNVIXVPAJtwa
         nCQBkOT6sP3nVPbo1lQ8MYbzRDm8KJ7WeY+3mlEEJDma3msEaPXeLw8yLGcaZxVIwV0y
         lb5IPeAFDW2FzsMTmoSZvWsjtjWGLu+CWWmKY0A3AxQPtpo8Y8SkjGOcQiNeQwUWZt+1
         Wn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/OWDsHDL70sQccYbo8Luw6/UtlKJg70Rl3vnaAOycYw=;
        b=DW9jdv28G65jRb8qFQBYHx14lRXKimji5+boM02I422gXhEge7l5pRmHOuq6FJ2xha
         XlJvVkBQbzrVrxc2VmgNC1Pphut5SIPhvtRHWAsQ8zf+1KZmphJXkMtaexHuyeobgsI3
         PW25nagh/nC/e6T+IA1hnYaXB8NbqtmcYVLVMyqXWVuKCYUCWYJJL8t3Cqsm9RBvgQOq
         OM4HC89FISlaOJE/SGvcicqbb4kgglYX52XuEWotszga+jYiAo0HTScZIwBBqqsWs1TU
         IhsEZjB5dueoDDwQgrSz6nPUXbTu7OJ43Pz+q/K4coG1jn73RLe+YNsG3p1XWOZ9HPnm
         Hudg==
X-Gm-Message-State: AOAM533O0oHiXUNY41JAR530+Naz3MgX2XD1bq0BCBcbFGt0ybgo80YM
        mLvvP8YpnAyMfMPMCGdOLBY=
X-Google-Smtp-Source: ABdhPJwoTFH0E0p8PB2diBbPX7wR8FqwAcpVy617XVpKhy36D3+11mywcV76iigm3DFRF4Y5w2zP0Q==
X-Received: by 2002:a17:90a:e28d:: with SMTP id d13mr19546896pjz.128.1590397919968;
        Mon, 25 May 2020 02:11:59 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id q15sm12455429pfh.188.2020.05.25.02.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 02:11:59 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 25 May 2020 18:11:57 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] twist: allow converting pr_devel()/pr_debug() into
 printk(KERN_DEBUG)
Message-ID: <20200525091157.GF755@jagdpanzerIV.localdomain>
References: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200525084218.GC5300@linux-b0ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525084218.GC5300@linux-b0ei>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/25 10:42), Petr Mladek wrote:
> On Sun 2020-05-24 23:50:34, Tetsuo Handa wrote:
> > syzbot found a NULL pointer dereference bug inside mptcp_recvmsg() due to
> > ssock == NULL, but this bug manifested inside selinux_socket_recvmsg()
> > because pr_debug() was no-op [1].
> > 
> >   pr_debug("fallback-read subflow=%p",
> >            mptcp_subflow_ctx(ssock->sk));
> >   copied = sock_recvmsg(ssock, msg, flags);
> 
> The NULL pointer deference was found even without this patch.
> This patch would just cause that it will manifest itself on another
> place. What is the benefit, please?

Right, I don't get this patch. A NULL-deref is still a NULL pointer deref.
pr_debug() will fault reading one byte from the address and print something
like "fallback-read subflow=(efault)" to printk-safe buffer, but then
sock_recvmsg() is still going to do its thing.

	-ss
