Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C988C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86CB20774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597347015;
	bh=ZnzeTWs7atZJIs8iUg+7UC+AZAj4tMgj2Ua44fbGLBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HCKyx+G++ZeVEB0dYxRCCQSZYLuGk3VJsIFRHrFuJSw55kCSfAzCdh34HQWIqV9Kr
	 mPEDcXjCU+uFUYciG9X26nI8ZpgP2V3Ob8kTys6a+qA4tkSUrQuZ2xp9L9geV8eBEz
	 uP1H4/sGw4/DcnOhw1ZhMjUmXN/c3Grvud3MPgNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHMTaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgHMTaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 15:30:12 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CDAC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 12:30:12 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o23so7436691ejr.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 12:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KGoyKokYgkY0KstgPIEsrfMx9as5ZNK0N1QCyf7WEHM=;
        b=VtcVrl4hwhZI1tpRPlGSZ3Paeh2ijMYR7Qdg3cohnOEoCPtBzsk1bib+tqr/leJdEr
         YGPs4iXxAIiWGCw17TVrtw9fDenxp2KBvRXAxyYiUrEoCMXH6TNRFqxEima1BXLW6D94
         hMaXIN3u6qlpidzq4nETcJs1nyknBiy7Fv79MSGA40cOv6O6MOzq9Rmiyuj2wlWH941c
         Yeu1rDUInDBviXZtdl7qtB4Bw7kEaF9Zy/Z6gEjrMSmhPOuy3v7Htry9jVbWl0KhPhtm
         +ZXJYBwXWSAz8oKxvueBkQj1MihG3RKvZGqWfZtSb9cy+bRBECc1xZ9SKPNVRjttyCN9
         /VoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KGoyKokYgkY0KstgPIEsrfMx9as5ZNK0N1QCyf7WEHM=;
        b=YB32Y0NmviqRXX3gYBO9JW/Ro/erXf5iMOGtQ/sviNY3DcZ2EbC6H1Q6FfiWIXThIB
         Bos+eCFMDoevflX2u44cGf56D75HVMJSnHtugKLITgbs6vkElm8v2++WEU73IUWTLuT5
         y/46eGMU9+ctqsBV4XI9Lckmjdisb8+NQq/fLKr/qPVxq52EQUzoWfoFyqcuNEmOg+hB
         9mzhkAYYvzvLQRNY8LiABkKqtvhes3ZWIpb+xlXyKSuMQQ2F3ZfRPDgruaTh1JRvSsdb
         JXA/fOSXbcEQltA39fCD918NzvN1ttMGSnkTQyQC0fW4gP6aowfC8O6p5VtlmBVu8N7m
         VnLA==
X-Gm-Message-State: AOAM532Jg4qwG3kLPn2/O/ooDOACg0zImA0D0IKaaqX6BuHAIg7fxthy
        Xgem0KjLeafW3OJ4JwCpOhOPD5Bh
X-Google-Smtp-Source: ABdhPJyioVGVPAILwXZxlGhH2CBIrxWgQDuYCiBKALn5cyPFJJ4kc99l3Y1nwp0MYeyYzJov6EIMpw==
X-Received: by 2002:a17:906:a84f:: with SMTP id dx15mr6186757ejb.377.1597347011260;
        Thu, 13 Aug 2020 12:30:11 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id ah1sm4955923ejc.43.2020.08.13.12.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 12:30:10 -0700 (PDT)
Date:   Thu, 13 Aug 2020 21:30:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/mm changes for v5.9
Message-ID: <20200813193008.GB2338781@gmail.com>
References: <20200803190354.GA1293087@gmail.com>
 <20200805110348.GA108872@zx2c4.com>
 <CAHk-=wiq+7sW3Lk5iQ0-zY5XWES4rSxK505vXsgFY=za88+RZw@mail.gmail.com>
 <20200806131034.GA2067370@gmail.com>
 <20200806185723.GA24304@suse.de>
 <CAHk-=wg7PHCUMD1xY=YCCeVHspAhw0YNEhyO3CnHfRPwsf6P8A@mail.gmail.com>
 <20200806212019.GA2149204@gmail.com>
 <20200807084728.GA29510@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807084728.GA29510@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Joerg Roedel <jroedel@suse.de> wrote:

> On Thu, Aug 06, 2020 at 11:20:19PM +0200, Ingo Molnar wrote:
> > I've reverted it in x86/urgent as well earlier today, can send you 
> > that tree right now if you prefer that route.
> 
> I sent a fix for preallocate_vmalloc_pages() to correctly pre-allocate
> the vmalloc PGD entries. I verified that it works and that
> swapper_pg_dir contains the correct entries now. This should also fix
> the issue Jason is seeing.

Thanks!

There's one thing left to do. Linus has reverted the patch which 
exposed this bug:

  7b4ea9456dd3: ("Revert "x86/mm/64: Do not sync vmalloc/ioremap mappings"")

and has applied your fix:

  995909a4e22b: ("x86/mm/64: Do not dereference non-present PGD entries")

I think now we can re-apply the original commit:

  8bb9bf242d1f: ("x86/mm/64: Do not sync vmalloc/ioremap mappings")

Mind re-sending it, with an updated changelog that explains why it's 
now truly safe?

Would be tentatively scheduled for v5.10 though, we've had enough 
excitement in this area for v5.9 I think. :-/

> Sorry for screwing this up :-(

No problem, and it was my fault too: I sent 8bb9bf242d1f to Linus too 
quickly, just 7 days after applying it - x86/mm patches usually need a 
few weeks of testing.

Thanks,

	Ingo
