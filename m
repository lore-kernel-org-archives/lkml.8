Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1C4C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AEC9207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590761064;
	bh=nPZI5E8VenEhpBE8FgyAIJfbnI1vMVkdIHvbqmIkhYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CTJQZ80YVOE2dbIU/uMpewosZ+Uuau0AsfBJQXWnqFecnh06wXWQbq4WSTfEOBSPt
	 Hbbfd+FfUj/4Zgbsvrj1GkCu2g2yVGD3VB8IwBV6IQ6ZQSfp73VhA5zNOZFzWu10iZ
	 VIvHr5twqhY8Iak2sRKV90zYRq387NJTXMXutPdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgE2OEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgE2OEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:04:22 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF99C08C5C6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:04:22 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q8so2207506qkm.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2BtUdOQyGPlGDF+q6c4cmyjxfpO0PiKUjZeADUce3dM=;
        b=qROU/kJqjIpZMs2rehvA+BJ785eWCFjUawbyzNCjcb6DtYRVy3B/l0H4AwxY67KrkD
         99ISgk2YWPfuhMD+bS+f4YVma+WU5ab4u83Y93Tzh3IDQUSJjYjBCR6SrmIdMBfYno00
         IHLLFg1gRXzeueLP4urLjuJXUSXGkPipD2my7f55Sni8f2Fmr7MXsgo8WpcCvzcIRc3S
         hVbIBBQcNWMH42ldRkbuyl7sia+qy6VuNZqnfyEM14nZlizl3gRQfkThATqR6+iH09zu
         SQewj/6yD5fMeyKHUh+06rdoy76agdAWCthFQopPgKe/a35W/TOJ5Ny+I06d7Wve0ITX
         nz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2BtUdOQyGPlGDF+q6c4cmyjxfpO0PiKUjZeADUce3dM=;
        b=WDph2bYvdG6qVoiqs6RXUPNo+0yTNhkHe8INJmEa8Rot24Dspfav0aLqCgDntQeTab
         FyM3wD2D8RjFVNYwvYioYoIin74Z9bof1Zw4Wvz2pqWx4C4sA99C+EBstpMP8+jkgOrq
         Oxha0761sg7FugLOBgaBaUG2TAVIL/7bdigx2lFrfk5YeS5qCZY/7awfNtt37/VfEqUH
         5fcZ83cjNbvSKRV31030g3ivSMa0lNvxyrReiansoMcQT1Mg1xIkYKqOe00MJsbhoCFU
         DIEz9nzEbtzYS3NhTgQ0zoCXAL9Yd94mxqnDJbu1T7rMSEV3g2aUZ8PWqBBIO7NAVW/0
         VdKQ==
X-Gm-Message-State: AOAM530HgHDICH6lYVfsmjPVe+PsOPvEQOlj8fkQT8RjvCHRuuOF08j1
        cLg4clKH4aWOKtHf7IwFiHg=
X-Google-Smtp-Source: ABdhPJzb6s4my5oVC8a7X2sH2hw7BE2/cSd7Fe0mklU06If3uP6f5YEZEcjH8fT1OGSlg8LBHo0Wew==
X-Received: by 2002:a37:a8b:: with SMTP id 133mr7785629qkk.134.1590761060985;
        Fri, 29 May 2020 07:04:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:5493])
        by smtp.gmail.com with ESMTPSA id n123sm7418991qkf.23.2020.05.29.07.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 07:04:19 -0700 (PDT)
Date:   Fri, 29 May 2020 10:04:18 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] workqueue: Convert the pool::lock and
 wq_mayday_lock to raw_spinlock_t
Message-ID: <20200529140418.GA3530656@mtj.duckdns.org>
References: <20200527194633.1660952-1-bigeasy@linutronix.de>
 <20200527194633.1660952-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527194633.1660952-3-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 09:46:33PM +0200, Sebastian Andrzej Siewior wrote:
> The workqueue code has it's internal spinlocks (pool::lock), which
> are acquired on most workqueue operations. These spinlocks are
> converted to 'sleeping' spinlocks on a RT-kernel.
> 
> Workqueue functions can be invoked from contexts which are truly atomic
> even on a PREEMPT_RT enabled kernel. Taking sleeping locks from such
> contexts is forbidden.
> 
> The pool::lock hold times are bound and the code sections are
> relatively short, which allows to convert pool::lock and as a
> consequence wq_mayday_lock to raw spinlocks which are truly spinning
> locks even on a PREEMPT_RT kernel.
> 
> With the previous conversion of the manager waitqueue to a simple
> waitqueue workqueues are now fully RT compliant.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied 1-2 to wq/for-5.8.

Thanks.

-- 
tejun
