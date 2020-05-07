Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40374C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE5120659
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="va8IcNz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgEGOgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbgEGOgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:36:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69437C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:36:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s8so6693257wrt.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2cUePzGWzDDGYMdSJecoGhzZI0bICDSzA7fgbQwoVdI=;
        b=va8IcNz8I2zqjE9CHsCzAnM6YWsHCkT+6BNuJ8fRsAg/QlH3lUCW+YkNknR8VqSvOG
         E/IC3lRkd0ZwHQalan9TG1D4/w2fUTyiZGxS/Q17YpXKcCbyWWsxSxx0xFlWxdzfx+ut
         ysYussSGR3GqsKtZzvNvKz5uEtHfKa8FYgUcDiMWE1hpFlB7r3M6eaEtZRKXOjsn7QfN
         oORfrpfCEN3NfkyQRARTPBZf4GQ7PEgSTsKIsFDcD3penmf6YN2IBJ8mFLFunzaBnjmu
         tuILSOMKhNChWN19gJNhOvmcEv+JElMcVgODP4coW1YiN9SIPkaGu9JYdaOSup2+p4YN
         6M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2cUePzGWzDDGYMdSJecoGhzZI0bICDSzA7fgbQwoVdI=;
        b=GhanfNXz/bdnVYCgEFpcQIxOj62/vZJulzunEQECG/ZQYIpYrv1tOdZ1FAfrCW/n/5
         Cj6i213ftHvzYm9rPl/x8HuZFMOEBPlV+sBWlcxEWV1uVjDbAuZiHKtJ1NJ1sHkFnWl0
         c8PnI0Yl9RJKlDI1oh8QG44bAccstFjtuWBScDyAOrjcolWH6VrzfCXxGAbXl2ABUGfU
         ibIqjeHhiVqof4elRe+GOLrPqdI7wVBKYEWeo+PPNz7BZoQ+wn72+dvxyR93QLdsowZX
         4q3SFbJYszTG1khszk8XkC7zPAA9Te+Ki+vzD8FaRIvD5twyY3ow0TVdtb4tAYLbx8ty
         QZcA==
X-Gm-Message-State: AGi0PubO24QTmqdQgnqK0OaIAM5rk9lBiERNJYwQrXEV/qaQQnzEv/yi
        MH6cftFaeoy4gBT0V009SFNrKQ==
X-Google-Smtp-Source: APiQypIg/E6o9sgqmhLM4Cgv9qszquDB3MDl0xGyH0m0ulxsGd7+lcGC7cQvQySga4gTWRe+HpOBog==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr15498170wrq.171.1588862197885;
        Thu, 07 May 2020 07:36:37 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id h17sm8450409wmm.6.2020.05.07.07.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 07:36:37 -0700 (PDT)
Date:   Thu, 7 May 2020 15:36:33 +0100
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     David Brazdil <dbrazdil@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] arm64: kvm: Unify users of HVC instruction
Message-ID: <20200507143633.GA169263@google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
 <20200430144831.59194-2-dbrazdil@google.com>
 <878si3j13w.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878si3j13w.wl-maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 May 2020 at 15:01:07 (+0100), Marc Zyngier wrote:
> >  /*
> > - * u64 __kvm_call_hyp(void *hypfn, ...);
> > + * u64 __kvm_call_hyp(unsigned long arg, ...);
> >   *
> >   * This is not really a variadic function in the classic C-way and care must
> >   * be taken when calling this to ensure parameters are passed in registers
> >   * only, since the stack will change between the caller and the callee.
> > - *
> > - * Call the function with the first argument containing a pointer to the
> > - * function you wish to call in Hyp mode, and subsequent arguments will be
> > - * passed as x0, x1, and x2 (a maximum of 3 arguments in addition to the
> > - * function pointer can be passed).  The function being called must be mapped
> > - * in Hyp mode (see init_hyp_mode in arch/arm/kvm/arm.c).  Return values are
> > - * passed in x0.
> > - *
> > - * A function pointer with a value less than 0xfff has a special meaning,
> > - * and is used to implement hyp stubs in the same way as in
> > - * arch/arm64/kernel/hyp_stub.S.
> 
> I don't think any of this becomes obsolete with this patch (apart from
> the reference to 32bit), and only changes with patch #2. Or am I
> misunderstanding something?

Nope, I think you're right. To be fair, this patch has changed quite
a bit since the first version (which did change that comment a little
later IIRC), but David has done all the hard work on top so I'll let
him answer that one.

And David, feel free to take the authorship for this patch -- I barely
recognize it (for the better), so it's more than fair if you get the
credit :)

Thanks,
Quentin
