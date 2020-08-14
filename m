Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8386C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C15EB206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597400444;
	bh=epS/nXOPp2l3EgDWDwTgxn3dzjE1vy66rbFWP9bIvH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AP43ASx7R6lJ+syoZR6hi4skBUTa2Po6EfBVKumL3Rr3aa1RXP8xbpSAxb3oZTOVJ
	 ZQ/d6NsamwOxmFG3E/cylX4vLSbRwwIOlWju+aqWMgmQQCfLqoAUwWivDUB3LhlEdo
	 dWhxswczh5V6TNeXM4WuUmwlmYDxY4/6GLYMdJqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHNKUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgHNKUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 06:20:41 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0953C061383
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 03:20:40 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id m22so9337294eje.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 03:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I+i5vZQXWrf/KUAk9C11ycLkrkSmvUWDkdy2tm1Gwew=;
        b=RPjeU6zqdODP1C8UKmtoZ34WASOQ8dU9xOyDNJR/DU8hqWTmthOTFPiV8Zf0Wfgjs5
         QGEMS4K+6+HO5eiQ+knMMNrEt10zyvhBbCHP3qXVjCkAOTiQQMFzmFSRrffRRr8UzOH9
         BIGUhlx8mJdELzeUwdbBOwy7L9H4D3H3Wtf2UOiexiHusBSomrUrAh9kX7ACXXZpLmeJ
         D9M7yP2DHYC9+zkMzivN9sO3ZwmNBcmdYeLF1a7gHQJ5L9+3cQdY0q1SUPIfkZAPjRcY
         4Du+AJQrG2zPhMKrffE76e/GognfAwd+yJLK1+DdOX1SuiVusRn9F/zIwH6BAg4hINxJ
         PeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=I+i5vZQXWrf/KUAk9C11ycLkrkSmvUWDkdy2tm1Gwew=;
        b=qIfGL5WWE6TiuG6C9+O15CJDvEUCmKMrYcl6yzhdGjvXetcBkuAMwxyLyJya3JmuSO
         ScBSYeL+NxXUfWD664qUOj7Dh6oHjnVQYsa9Dk7KhJoSdjsGko1ftM4/mkU2IyN7R6LH
         TZUIujK8cO5koR6suRD8XfUpziCk3jHBeYzBfS9BCI5IsUVB5FsOIxyvwp6/LSYNp7MQ
         j8pP4RWg+yJTqF9Ahqjz3/++sss4keBv8AX1/2TVmVsUFHX1Muw/PdFOXjwbrpV+xHxY
         hhnR7j3XW7Rcaac3HGqsB3SVVePHV2goBwmcw2xGjJNnndynzm6IlUq0R25YW27vLPh6
         qmtA==
X-Gm-Message-State: AOAM533ntUBjX+DKVXTfKDwGaTWV5jQeAibv2sZN17oq/RJYBSSbic2G
        VJGOiCDJ749Fohmc9ZKQQEI=
X-Google-Smtp-Source: ABdhPJxf5zummerY5PHRzjHLaWoEocuJWTAxzMU5FjOPgu4/bmZ5/siuxdAmXXbknzS/zJFFDt2/YQ==
X-Received: by 2002:a17:906:4047:: with SMTP id y7mr1631507ejj.21.1597400439336;
        Fri, 14 Aug 2020 03:20:39 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id z10sm6349708eje.122.2020.08.14.03.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 03:20:38 -0700 (PDT)
Date:   Fri, 14 Aug 2020 12:20:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Xingxing Su <suxingxing@loongson.cn>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] seqlock: Fix build errors
Message-ID: <20200814102035.GA2367157@gmail.com>
References: <1597378358-2546-1-git-send-email-suxingxing@loongson.cn>
 <20200814083552.GE3982@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814083552.GE3982@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> > Signed-off-by: Xingxing Su <suxingxing@loongson.cn>
> > ---
> >  v2:  update the commit message
> > 
> >  include/linux/seqlock.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> > index 54bc204..4763c13 100644
> > --- a/include/linux/seqlock.h
> > +++ b/include/linux/seqlock.h
> > @@ -17,6 +17,7 @@
> >  #include <linux/lockdep.h>
> >  #include <linux/compiler.h>
> >  #include <linux/kcsan-checks.h>
> > +#include <linux/smp.h>
> >  #include <asm/processor.h>
> 
> Wrong place, it's lockdep_assert_preemption_disabled() that requires
> asm/percpu.h, and thus lockdep.h should include linux/smp. before
> asm/percpu.h

It already does that upstream:

 #ifndef __LINUX_LOCKDEP_H
 #define __LINUX_LOCKDEP_H

 #include <linux/lockdep_types.h>
 #include <linux/smp.h>
 #include <asm/percpu.h>

So it would be interesting to know what kernel version the build error 
occurs on.

Thanks,

	Ingo
