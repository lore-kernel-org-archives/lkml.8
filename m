Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D333C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 01:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724F22184D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 01:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZKDLymJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgHMBqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 21:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgHMBqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 21:46:23 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C141C061384
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 18:46:23 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s15so2006227pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 18:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xaZmZ58nPgUEXLVASZ0NTZ0Q5w9YibP8zVkGp5tVypo=;
        b=hZKDLymJvcoH4OveH6pSQJcqCoDirImQ/3Hc4J0WXJetaB+AgtW6ABKngUSHDKMvMC
         Hqz0NF2ZdVTJJ1N2kv/B6a66CNBeTbQfeXtBOAj+12ChUYxS8gin74gcl3H0w/9zBi3K
         MXVgZl4lktdYGuSzc0i+ga9NpZFcH0MFaxxxyE4L0eDDfIeGPpOKUbNI1o4ESn0i0I24
         gPw8Idy+tgT+xKRwer9sJvRLTmyxIxsrSrMJIJvly52mWLPI2NBlPk8yjjvfM/vaV+3i
         p2YNXNSaqm5YVXq8x4ETGr8UFft36FknuvuKiKMFJYPcxO2T9eUPtqm5+zXerwLMeeRO
         3aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xaZmZ58nPgUEXLVASZ0NTZ0Q5w9YibP8zVkGp5tVypo=;
        b=kLp44IWpyZpquDPvi4YPL14E67+nWo8aBwU/WRuTFHA++n7yViq4AW0z/CPSrBHKBX
         wEnTLEER47TEZ3ZmrMpwavgX5g62uh8Q+8qQhx/2GeWvTYfJeTIxsKcTZaUeTmNo1jn/
         UCQeQ33OMSa4YINhoKuoSewcxjrGKFIQeuhyDTZN49BevmIB31M1uSgOTJb3D4efQENs
         qjaKN4W9d+3/dXMHaXsp+ieuOKE98aOCJPoU4bo3o9xPYbVhYV1IRcwz5r7Yp4PL1usN
         FH+cmFq6pm6j+XNms6J1lu24OcCcn7WFouITR2+t4UFooIgTVewJfHJgCtKxeE+AwOSg
         4wVA==
X-Gm-Message-State: AOAM5312dQRRuoCQ9MdPTBlaF/Y3FVAGEsAyo4rAezQ9uMFpz0Pcj51+
        +9ZeDr8ieZKyXBy/9g9Rs7w=
X-Google-Smtp-Source: ABdhPJyb1inmvj/XJE43rxOQQe8iJHDMYaLQqPx4yWeuz8cheTcbgUBpadWc0x7ijj9cgKRSig1liA==
X-Received: by 2002:a62:1a49:: with SMTP id a70mr2217758pfa.297.1597283182959;
        Wed, 12 Aug 2020 18:46:22 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 74sm2720762pfv.191.2020.08.12.18.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 18:46:21 -0700 (PDT)
Date:   Thu, 13 Aug 2020 10:46:19 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] printk: reduce LOG_BUF_SHIFT range for H8300
Message-ID: <20200813014619.GA2020879@jagdpanzerIV.localdomain>
References: <20200812073122.25412-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812073122.25412-1-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/08/12 09:37), John Ogness wrote:
> The .bss section for the h8300 is relatively small. A value of
> CONFIG_LOG_BUF_SHIFT that is larger than 19 will create a static
> printk ringbuffer that is too large. Limit the range appropriately
> for the H8300.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
