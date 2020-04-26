Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6EAC2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 07:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48440206D4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 07:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587885982;
	bh=prLBCkI3xp9qQLWxoF52qKDFhT9Og2rJI5VimrEkDJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Kr1hci5uorwmuaaURWkxJD6OqmUdbh6mPACxz8NS5scP/gMXuUy9BHVXRn+k+RGsm
	 vd+/t0FzE6+cBlWFytNYaTeYp7qq9MIL5Ej09FB9TRPEQscZVfwoWgcb7F8mwkOrAc
	 8I4weuGE6RdQ8JHFcQV8WEX1uevlHwIWEDZMwELw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgDZH0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 03:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725847AbgDZH0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 03:26:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964B0C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 00:26:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so16678176wrx.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 00:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ivweoo5j5lp8R19knPnRQOBFL35YnGwnv/pT426ClFc=;
        b=N+4XXvYbp6cPn1dL1Z37tvvtxGy2nKYDXOxPN6maGQZO1UBZtBAjnNggOlD0Qchv2n
         NPKg+a2c+DkTEGtFK2H/im5OcrotYF97jcUjnrQTOoDsNJlOFq7hx2xXzAVqnZWH1/uC
         jqBnZk4BlAbqEQTTAD2ZmzPh/IIvBCOfWNjQSIiCpwxLy5yeF9Wh4q3OKBaERcY+PCNb
         R76wq/QyRt0aiVqSJR+RrMdxdzyvpR5qc3I1QKdp+qMQa7EDGlZUm/1kY+3XNzTfx1HH
         95Q8zETRmh2/MlrkrBpkjaHL0TQeGBJXIse46w1x1c6Wn0HNBzKCHhTzFdzZDIwMwr7U
         Zmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ivweoo5j5lp8R19knPnRQOBFL35YnGwnv/pT426ClFc=;
        b=so89fZFRRmMB5VwsgZUF5KMYJwx73+GBMP0V4Adkh9uU1DWk82dHLeA11TzrcOG6Y4
         VzsocWkwTr6ocAjDTJ/2pjgRxfD8ZpB4bFosPRuGhkhxJH4JWVTctUL63lLzyC2MD4vf
         bffI2xSihWjI4dGGeBw/sQ9tkGIoBFfCWmlfMGdDrtTW2T5ooxXXbNxsbsIvcqPqBZ44
         7d2oEAUanAvM+mNm/o6VfiCCDhFcqTalgib7XNsG6JOwSYBatBdxnUnI3e65XHlZi1FD
         jtqx/9g3hiFMoZ5nDqexj7Z/YFyGN9hI1AQFMPXZfUGri/eazn0EnUaOBSnW1UelxZtr
         Anrw==
X-Gm-Message-State: AGi0PuaGT67lavDGhH5T0KhicUJ1yzCQVftymWD7+qlgu8BKzLArKMyc
        J+X7uyj4dqFORLCsfpNWih3k3e6/
X-Google-Smtp-Source: APiQypLI6OTI616rRNBLP4bug6RIci6H/hATG1L+7q2Tpkr5r2re4vIeihbMnQOpp8mbWDOc1uGfyQ==
X-Received: by 2002:adf:e8c4:: with SMTP id k4mr20188872wrn.209.1587885979362;
        Sun, 26 Apr 2020 00:26:19 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id f7sm15396921wrt.10.2020.04.26.00.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 00:26:18 -0700 (PDT)
Date:   Sun, 26 Apr 2020 09:26:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 00/11] ORC fixes
Message-ID: <20200426072616.GA2744@gmail.com>
References: <cover.1587808742.git.jpoimboe@redhat.com>
 <20200425102512.GA12331@gmail.com>
 <20200425104110.3bx5xb57fssdvd4y@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425104110.3bx5xb57fssdvd4y@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> > Any objections against targeting v5.7-rc3 with this, assuming that 
> > there's no problems found during review and it passes about a week of 
> > testing?
> 
> Hi Ingo,
> 
> Due to other distractions, I unfortunately have been sitting on some of 
> these fixes for several months -- notice some of the long Reported-by 
> chains :-/
> 
> They're good small localized fixes and I would agree it makes sense to 
> target x86/urgent.
> 
> Thanks!

Ok, I've merged them for x86/urgent - with the small tweak to the merge 
plan that it would be for -rc4 next week - the patches are too fresh for 
-rc3 IMO.

Thanks,

	Ingo
