Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4493AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3522067B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591367742;
	bh=HeJJNEviIB/Kljkju5ktxmmDg7axI+Wh2Gn2UqqEqQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2AFY/DjjDTdFEhZBMT0c0oeX0A/VjWPbMi3RC5Q500YqmCjVUkCDhWv/41ljgJxzO
	 xfoUxydFzAgpLsJK08v3+x9uMGc+Rd+6TB/1ThnuHua50ot38Gs1FA8VWKAAKXQDL+
	 VGD9YHcNGin66etIHl/0Aass8IbFVtFqGa8YsiUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgFEOfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgFEOfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:35:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF070C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 07:35:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x6so9949951wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7cY7jvTBpKlrLsR6Ewr2LZdXdg4uEiCrmWXxPw0FX/g=;
        b=aDlRkTQJXe1BZJqNtHQwjcwzgqE8osCEb3i61Y0Rm27gGnjSXl75osKr7p00R1QvfN
         5GJGrHTP84j3BFFEt8cCRl4lBivsAfYH06eDKrwO7urkqJzGtGf70MgLZnTKLkZ3e/I8
         G0QHxmuXv742Q+phi7x9QkNJaqstxxVBgtOez6nmnssEumZmKjSia7XRzbsqhGVlvGHq
         IcLVDqIQk8DRzncE+SnwbrITkgYEEGzc+e6QWDISFfxvHq1ir4dvGA1GVyLD9jLZR2GB
         BfBKDcPX/OSsg9Bhl5b77R5A9d7W7/TMl+zBcAp/ZXOLASLVS+WLdQDAErEvrd/eufq7
         R+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7cY7jvTBpKlrLsR6Ewr2LZdXdg4uEiCrmWXxPw0FX/g=;
        b=XuNHTsyF54pA0leO/wxf81fckW+yi5ZhFAQJmi4HQtp5W3hmfmqhR5846uNyqqU0Ia
         mviZqDfrqx2QhcjyzoeDfJb0UpCrTkxVaZIhM52XdE0Mr00F7ec+buPXayRm+QN/f0La
         E3E3nT3Ws4khC/mtF+ex/3w5wJOKZFvYY+LuVHPoBzhW7TizoD5o10M+AgIwknN3LFns
         gNV0xAErWHWM8r9HBS8QHuI/PSqimIT05xKdFxhJAe7DDusnHIfQ/wMPo7YmqVmByqc5
         ILEVvJmW/aXGT5N7IF0ggXu9s3CuQG3B5s69EH9h1BVxqX1BVgWUv/+T4MlpbDVGloqG
         WuOQ==
X-Gm-Message-State: AOAM533HMOMrCuBsezU/hx6Q+2Y/xU5Khzfle782joYmAoMbQWq4Wcio
        ipXvDeaKpFQ4qz7L0nt6n/8=
X-Google-Smtp-Source: ABdhPJyjnKlpnC7ip65ebXdOSaluC+SNQGQlOMdVtP/HWb3NypSyzlzgXYYBIvqjxj58M2gch5WHDw==
X-Received: by 2002:a05:6000:341:: with SMTP id e1mr9917067wre.1.1591367739418;
        Fri, 05 Jun 2020 07:35:39 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c5sm13401495wrb.72.2020.06.05.07.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 07:35:38 -0700 (PDT)
Date:   Fri, 5 Jun 2020 16:35:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] compiler.h: Move instrumentation_begin()/end() into new
 <linux/instrumentation.h> header
Message-ID: <20200605143536.GA2577569@gmail.com>
References: <20200601130806.GA746506@gmail.com>
 <CAHk-=wgmXOFyiu6jZ8Dj8OAU7c0T0q-6RLygKC2tMiNfL7MQjQ@mail.gmail.com>
 <20200604071921.GA1361070@gmail.com>
 <20200604081928.GA570386@gmail.com>
 <20200604093801.GC2587@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604093801.GC2587@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jun 04, 2020 at 10:19:28AM +0200, Ingo Molnar wrote:
> > The tested v2 version of the patch also needed the include in 
> > asm-generic/bug.h (see the fix attached below), because for 
> > completeness the generic version was annotated as well - even though 
> > only x86 has objtool support for now.
> 
> x86/asm/bug.h includes asm-generic/bug.h.
> 
> x86 uses the generic bug infrastructure.

Yes, indeed. No change to the patch required (other than the 
changelog), both asm-generic/bug.h and x86/asm/bug.h make use of 
instrumentation_begin()/end(), so they both need the #include.

Thanks,

	Ingo
