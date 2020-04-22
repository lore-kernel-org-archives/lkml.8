Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F7BC55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 23:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE37206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 23:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ul4AvjVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgDVXyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgDVXyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 19:54:05 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D060C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 16:54:04 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y25so1977546pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 16:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9yta31YHLGTtMTc3kimrMC0tNHi4fPt9ZpXXfvJokHE=;
        b=ul4AvjVQXbGe+67+07L6i6vBhv+ePFHnNv5wOIO5OLBqKwlga7zXiy6xS1d0X/n/tF
         6woOlNdImmOPZMJChQsUQyygz5ZseUPmnZAKczKpT7Y7lInJ6k/DDJqqloDP2VpGFDPw
         OFtrm1ALOx3/hCMPr/YQ3m1N7xm3tLJ/pl95K3DRTQoOWwlka1VKxTJhNX6t7x3uramm
         2dyep6SUwSuJ79qzMc80b3OzgAHRlzEcC+sG84d0mATYPxu/tkZ16ivMuXJA1CHS9gCY
         zZTcPJxWLKTN7QTPUPa2eVcTdjKumsRqOxjD1k+RVCHPaHKtuxR9qW1L8MlMmMCCFv+Y
         LkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9yta31YHLGTtMTc3kimrMC0tNHi4fPt9ZpXXfvJokHE=;
        b=Kp9KRfQHKrk3lixXqxj48TAv5F0eOFUQvn2G+UvzRYqbhXM5f5V9zPyL3fyBW7m92i
         Ju/4oB+SRzWyt3e/bRnoQYw9oz9/O0oOWU1imRUq+r60WRArg0se2lo7HahS5yxedu+e
         s7MbLe6DFQRi0Bt6qs7qx3n/L4zl9KuqKL95C94YrVPQyq0tO+5xl7yzcEUOsEjcXdzB
         Cm076VKjDBNbi7cMVdvbh2I270bOxaiSNysuVtDfEUy3CvRgD7VqjrJLSCv2ZrpJMXFp
         lwy9n5HgaUSAsKuWi/h1YDL2e7RmnGDRs+w/UJZZ69u6QMg6Ahni6ivTDYh5Si+dDgN1
         oGYA==
X-Gm-Message-State: AGi0PuZKsoa/fP11CdUM5/jN+JsE4/mAmAoQpuL27VlecfWfzhOhMHno
        GZY6Zq9c8sDUf9em6CE/uKsWnw==
X-Google-Smtp-Source: APiQypIxgD2CWLnytM507AIaoaby+Reth9qe8JpsU5Egogw5Wrog+ZS/v8kJIWI3ShghE5eGkNfP8g==
X-Received: by 2002:aa7:8118:: with SMTP id b24mr1011016pfi.321.1587599643609;
        Wed, 22 Apr 2020 16:54:03 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id d20sm360096pjs.12.2020.04.22.16.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 16:54:02 -0700 (PDT)
Date:   Wed, 22 Apr 2020 16:53:56 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 03/12] scs: add support for stack usage debugging
Message-ID: <20200422235356.GA128062@google.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200421021453.198187-1-samitolvanen@google.com>
 <20200421021453.198187-4-samitolvanen@google.com>
 <20200422174602.GB3121@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422174602.GB3121@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 06:46:02PM +0100, Will Deacon wrote:
> > +static void scs_check_usage(struct task_struct *tsk)
> > +{
> > +	static unsigned long highest;
> > +	unsigned long used = __scs_used(tsk);
> > +	unsigned long prev;
> > +	unsigned long curr = highest;
> > +
> > +	while (used > curr) {
> > +		prev = cmpxchg(&highest, curr, used);
> 
> I think this can be cmpxchg_relaxed(), since we don't care about ordering
> here afaict.

Sure, I'll change this in v13. Thanks.

Sami
