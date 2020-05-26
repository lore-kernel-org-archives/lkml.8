Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8F7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49C26204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590522405;
	bh=JF2mJpH+HydxO3JSBpjf7QgE5k6YKEl14ZaTJj0kxyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lSgD6k1QVje+fG9Kk97W8afwww/rgkvXUrmxfP4o7fcBiT9p64jsb7qrzhf83hwwH
	 6rmA2rWwKZkVBCv0j67OZJGp7+s00dW/r1bSOkTO43LzEer1YtRKGLKJy0gSMi2XbQ
	 JR/T1c6H/UkGWH/Rk09OLZFKLWIusGA4eaVXjY88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390026AbgEZTqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389798AbgEZTqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:46:44 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BF9C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:46:43 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s1so21927241qkf.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I0RoJLS4GC+98Xv+xGkQ27w/dIAY9pprJAGrxJoHF3k=;
        b=FnPdjB6e7/tqWtVykaVTskwAjpls12vQlfJQJxiH4S+BUEGGO48GecqBvHdjRa3aln
         EykDdNf+9rKjcktMZdPv0WwvpBgTqn4aTtEM5Hv5KHoh6UhWeU7xcVAKAWuBhiLAZwYu
         YyOGFNelG1/fgX8H9GhCOaTnPIX2fGZTRs/QmVZligGszitncesga8UPdW+warcyZ6Ls
         ocOIoXU/5xu1IKXDm70aYXKQgR67shgrq8rwy786LwrVURbMeWSTBHd6vPXV0lTIMkFc
         xHV2TZyvHKpZ2TQr4sEdLvYiLSuYZ09UNNjJFVSdkRqpDkivxD+G0LBd8rzdS0SAckBD
         vYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=I0RoJLS4GC+98Xv+xGkQ27w/dIAY9pprJAGrxJoHF3k=;
        b=uevGDC2asbjgDuutp5pC8hv7wPx1JFsrUda8WAirHk58mfoVWjJMd8NBfJ3SUjKd8l
         7YhlNrzW/qMCa/D4HRKNH+d76D6SqHI5PA05quoZ2JoP79S+gN5NKD4wR2ULI5sj8EAj
         TqAkJrsI8SUP9V5JOqJlR8WDsqvklW/6msRQJY3defURCAkv75idoFkhg0SzFIEggz2k
         zM9nXBhBBdiBIxGyD0zHw0uuIzOiY4xC9Aad/hnnDXYEQ2CSGxmTb28r2JbQAIUNmBMc
         3ZN7OREdOgNYDp3b5MYgYOu/+XAOZcA/QtjR4byH//bP0mc513v5sb18o1GaRq6gs7J/
         wjLQ==
X-Gm-Message-State: AOAM530Ykh/qPGXvfNaDmeYAnh5ZmkUO+iP/0TW1wTKsqX2c5vJ6Pg/b
        uKUZL/knGS0/BBL3RpJ5Pl8=
X-Google-Smtp-Source: ABdhPJzQ/6G6ZodV0qRRzRMUX3CKTGqLX59UsImmzMS+2+fFOeDLOxj1XiV9r3CLhRgj3ObIi8l65Q==
X-Received: by 2002:a05:620a:205c:: with SMTP id d28mr518435qka.436.1590522402921;
        Tue, 26 May 2020 12:46:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:85c0])
        by smtp.gmail.com with ESMTPSA id n63sm484886qkn.104.2020.05.26.12.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:46:42 -0700 (PDT)
Date:   Tue, 26 May 2020 15:46:41 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] workqueue: Make the workqueue code PREEMPT_RT safe
Message-ID: <20200526194641.GF83516@mtj.thefacebook.com>
References: <20200513162732.977489-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513162732.977489-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, May 13, 2020 at 06:27:29PM +0200, Sebastian Andrzej Siewior wrote:
> The series changes `wq_manager_wait' from waitqueues to simple
> waitqueues and its internal locking (pool::lock and wq_mayday_lock) to
> raw spinlocks so that workqueues can be used on PREEMPT_RT from truly
> atomic context.

No objection from workqueue side but the comment in swait.h doesn't look too
encouraging. Kinda difficult to make a call from my side. Linus, does this
qualify as the RT use case you had on mind?

Thanks.

-- 
tejun
