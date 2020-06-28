Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A22C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 128EC2076C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593367351;
	bh=JazwLBHGAnbWAIyVgHUZkwcWVanOFEGcnRAZcJPCKHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I8IlgW0SDd99U4jDT7sIm8VKIdRMhFYoJ931xFb9FMQAnOuYp+fWD8MtqCwP+EHrl
	 6IePghN8kyn8BtrL1tVqa6zT6Eus24f6u0tXfX0vj2sz0TyA2vM8zDQ26Rr6eTS2iX
	 0/+oy+gqA7lTwpt5wLPn+awzEN3JHX2jzNBaPQ+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgF1SC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 14:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgF1SC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 14:02:28 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA94C03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 11:02:28 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id b15so10996855edy.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 11:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ycf4p9QItE2wSoXopvfC4fLvCzxJ49eQgNZFIlZ34gA=;
        b=P9xQBtB64hFNRHImpQEqPP9tN2Dnm2ZaeQjuoIqV8TP288dgaDWQcAz9ujxpanbWaI
         2iyQeamqtvAT0WMrRSurc7DSLqY/5GN3kL0VFj1eJfd+NZxSCqbOqJsQvvDQhR+zV65+
         4JQUgS5XFUyGWoJQZMuAFNPKiR7BgzrMcR7P/d2TX0q1igXXBNu/o0IVwBxMDbNrqnSP
         Z+zMRtuYmcgif/hTfUH/b6modyk6saxDrxoxhp4mjKAYa1XkIXqVsNnn3hKGV4Y9yNQc
         J7LTQxHPWQq2T0gPF5oLQadpLwdFOJ0yVZZyR6BOe58LNIrCp4mB5PbsZAXna8D5Y6uV
         2tqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Ycf4p9QItE2wSoXopvfC4fLvCzxJ49eQgNZFIlZ34gA=;
        b=ncxuc+LOvwDIxbUvzFc9ifn3Rz6s+NRLkWzWuqsm3QVQbS14nAOFt3yNm/eVQ3xUMX
         cJqW2lUmaYX+4XK5oqWzY1X9MyZ6kpGxMZ7vU4KH7yqGIelvBuf5RJVgpbyL5cfzA5jY
         bh2z3uup418Q1ecCR6xa74ERH5HbAXOPbisPTahnd/e/Rzp6rDFfcpN9GPJWdzzwySyV
         QwFK4r6QGFekNRcJk1G8orcGcmKkjsNS2nBB9sGq27Sc1m/l8shLEYn7MLeryhMCAr2n
         OL9y5rfHBrF7kgH0BmkAFDAa5Jnmk05rkvTTC78UH1W706uxk0B1/6SE4a5+72N76o9F
         jsmA==
X-Gm-Message-State: AOAM533DY14hwEoRm3u6kFz9gpI0gxr1wHgfccIjUiRV26YtQB8sWbWK
        z9ReZM9zj/DAVU8TXSjlYwI=
X-Google-Smtp-Source: ABdhPJzrK4yRmYL8+cFUT49ZP+5d6D0O0dz3/p26FNVe6ydXFxSCkiBHXmlTYzkyH3m32Qkq6FBUkA==
X-Received: by 2002:a50:d0dc:: with SMTP id g28mr13336746edf.169.1593367347208;
        Sun, 28 Jun 2020 11:02:27 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s23sm18299115ejz.53.2020.06.28.11.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 11:02:26 -0700 (PDT)
Date:   Sun, 28 Jun 2020 20:02:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/entry for 5.8
Message-ID: <20200628180224.GA19572@gmail.com>
References: <20200628140523.GA18884@zn.tnic>
 <CAHk-=wiu9wquJ1LO53sA7=9ZCmQkRpu1-hZwwopeu8OVzt4qsg@mail.gmail.com>
 <20200628171816.GF18884@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628171816.GF18884@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@suse.de> wrote:

> On Sun, Jun 28, 2020 at 09:57:00AM -0700, Linus Torvalds wrote:
> > Tssk. This has an unnecessary merge "to resolve conflicts". I'd much
> > rather have seen the pull without that.
> 
> Yeah, reportedly because "Linus renamed probe_kernel_read() and [peterz]
> removed a call". I guess they did that for linux-next's sake.

Yeah, I did the 2c92d787cc9f merge to have a clean integration - but 
if the merge resolution is the tail commit of a branch, then I usually 
strip it just before sending it to Linus, and let Linus resolve it 
instead - a branch with a tail conflict merge commit is arguably ugly.

> > Oh well. Pulled.
> 
> Thx.

Thanks guys!

	Ingo
