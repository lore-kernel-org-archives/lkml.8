Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6A2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A8C20720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oUV4qdW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgGJPv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGJPv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:51:59 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6667C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 08:51:58 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k4so2404573pld.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DQese5NC62g6R1leDp/qCM4i5r8CiSVoueHjPxDj68o=;
        b=oUV4qdW6mPV9TACal8VDQwPXp4TfiKZooo6GketEaLJGMrLHYVY3V9ARqO6vVO5YpV
         Qxh7B5tKgZDkBBQ2tKs6I+p2JwDy5eTqh660pHJNkoJngvOK+NJQUr1HlUg+yX/2EiRx
         h2JmBIyslnxwJ/i802vUWOdAgTbhVmWPqwZU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DQese5NC62g6R1leDp/qCM4i5r8CiSVoueHjPxDj68o=;
        b=CXvP4Bj5AlOzFkM6ic9T+32qvVPJoiSVKrzsUrrB8c6YAG9Em014EZ3L5VdJbrVmWi
         5OB8/FrVZvYv4SEmdC+dN0ViC3O2Rdh3ZmaavXEZan67NEf29EhLkZMs5jJZJ6XCNSh3
         kyrf9Xsop8uEhVYWB6moLKWTdFIYZgW67ZdSxEhNdoXf7lkXUrqIVFFak+EjjIYYqoZp
         9ihcAFOGYToYAPXeW9ViOuFMz/mm/cOSqH5N8EFfFHM/amwXz3yR+HZ1m9XGO4yVuRhO
         3O3l16MnBMu7zxnqcPcgrtwU9y2bRgmD1rduU/ifDPHfa73PRAa3TCa8gUNuQVkCmbQY
         duqw==
X-Gm-Message-State: AOAM533jj5w51FOeAXByPc1PwhyGexN12dgSuL//MTLHsrftGP51CMpg
        7Vq3/AH2IW3Va1J4oujeK4XG4Q==
X-Google-Smtp-Source: ABdhPJxdBmulO3UZ7ab+Reja0ySreW+1xomJB1W1FlNI+5HWxnZ5HGistj70iTcj9697BSVCBEi/7g==
X-Received: by 2002:a17:90b:94f:: with SMTP id dw15mr6530095pjb.199.1594396318409;
        Fri, 10 Jul 2020 08:51:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c71sm6755425pje.32.2020.07.10.08.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 08:51:57 -0700 (PDT)
Date:   Fri, 10 Jul 2020 08:51:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH RFC] kprobes: Remove MODULES dependency
Message-ID: <202007100849.9FA1E414A@keescook>
References: <20200709234521.194005-1-jarkko.sakkinen@linux.intel.com>
 <20200710193257.4eeb19e9cd042d99cbca7f9a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710193257.4eeb19e9cd042d99cbca7f9a@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 07:32:57PM +0900, Masami Hiramatsu wrote:
> On Fri, 10 Jul 2020 02:45:19 +0300
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > +#ifdef CONFIG_MODULES
> >  	/* Lock modules while optimizing kprobes */
> >  	mutex_lock(&module_mutex);
> > +#endif
> 
> Hmm, can you reduce these "#ifdef CONFIG_MODULE"s ?
> 
> e.g. 
> 
> #ifdef CONFIG_MODULES
> static void lock_modules(void)
> {
> 	mutex_lock(&module_mutex);
> }
> ...
> #else
> #define lock_modules() do { } while (0)
> ...
> #endif

I prefer using "static inline" for no-op functions just because they
will maintain argument type validation by the compiler regardless of the
CONFIG state (though it doesn't really matter here since it's void).

#else
static inline lock_modules(void) { }
#endif

-- 
Kees Cook
