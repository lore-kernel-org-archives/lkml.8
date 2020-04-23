Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A55C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A58220767
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CdFotNnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgDWSJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbgDWSJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:09:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D972FC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:09:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d17so3292731pgo.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KWVTVR9QPt8YpEnS6+rG3cx9IAZdQ2Peqca4Ud6UmSY=;
        b=CdFotNnqSpurMKkIu6CgBx6OkkmuS4dmePbH5JYO6Yb24rHfaG6bv/j6W3gwVuvGlR
         64PbSSNPaH8ceQMVqvMs5BZdL4WabMg/+3TPoVNadaUwZ1CIY5Ft1srs/S6AInLWxtLR
         iKNcf7yWw+tp7Mv+in+N3g014ylhLnJOJ++nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KWVTVR9QPt8YpEnS6+rG3cx9IAZdQ2Peqca4Ud6UmSY=;
        b=mPdczvYm+5zJAcLxfcXc6PFPyFSyKigl7PL3wdFA6b88VnoIFt3Rgnbi0eaW59AOrS
         IsjkxVxypbaujGs1m0hKXKCTAD6l1re0WcteuhtLG9QhzOeR6scr9bVEsKduLKPxbKsf
         ggDtqXobPJQth4IQ+2gQt1B8QRzZYU4ETX4ynLQemK0Oudc6YmJAo5X42kGcF9C3uc5y
         ccsiZ8/dOcYUcWQJUGk+Vf1gcj/z6OH88r/i+WYi/7kDWROcMW9qp4fD/e7GAmmOhdE+
         A5SvWvWmU5jSK0H2OzkUNvU0JMWXOcNVVy1mrdqaBg9zNDswlOFvUSQgbMBCS7XY1gY/
         HLPw==
X-Gm-Message-State: AGi0PuYPJykMOwqsKVmY8ALoAx+wbJV50so+/9oaJvRS/RquLzv6/Qxn
        OUHbMJ0+8vGWQjUKr464RcACJw==
X-Google-Smtp-Source: APiQypLMPu77yfYvTCVDe2sNxmi176/dfhJmzHOmLBk67EV18fTOD0x11gPSr7XgMYCWAsHYZmXLuw==
X-Received: by 2002:a63:5c01:: with SMTP id q1mr4899728pgb.177.1587665367464;
        Thu, 23 Apr 2020 11:09:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d184sm3152431pfc.130.2020.04.23.11.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 11:09:25 -0700 (PDT)
Date:   Thu, 23 Apr 2020 11:09:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 01/12] add support for Clang's Shadow Call Stack (SCS)
Message-ID: <202004231108.1AC704F609@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200421021453.198187-1-samitolvanen@google.com>
 <20200421021453.198187-2-samitolvanen@google.com>
 <202004221052.489CCFEBC@keescook>
 <20200422180040.GC3121@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422180040.GC3121@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 07:00:40PM +0100, Will Deacon wrote:
> On Wed, Apr 22, 2020 at 10:54:45AM -0700, Kees Cook wrote:
> > On Mon, Apr 20, 2020 at 07:14:42PM -0700, Sami Tolvanen wrote:
> > > +void scs_release(struct task_struct *tsk)
> > > +{
> > > +	void *s;
> > > +
> > > +	s = __scs_base(tsk);
> > > +	if (!s)
> > > +		return;
> > > +
> > > +	WARN_ON(scs_corrupted(tsk));
> > > +
> > 
> > I'd like to have task_set_scs(tsk, NULL) retained here, to avoid need to
> > depend on the released task memory getting scrubbed at a later time.
> 
> Hmm, doesn't it get zeroed almost immediately by kmem_cache_free() if
> INIT_ON_FREE_DEFAULT_ON is set? That seems much better than special-casing
> SCS, as there's a tonne of other useful stuff kicking around in the
> task_struct and treating this specially feels odd to me.

That's going to be an uncommon config except for the most paranoid of
system builders. :) Having this get wiped particular thing wiped is just
a decent best practice for what is otherwise treated as a "secret", just
like crypto routines wipe their secrets before free().

-- 
Kees Cook
