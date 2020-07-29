Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC539C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA67206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KppPfO/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgG2TaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2TaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:30:24 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950DCC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:30:24 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b186so3212566pfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+zYmnCJfLxuJg2cwgFMdsSt40MEJjpsqqzfD7mnTbHI=;
        b=KppPfO/rvMM9WWWE8xRY/rii5UYz5r2p8f0zpWnrZ9j8CgccRMK1cfeXC0e21JiJSV
         f2+Kq9IsIy9OB3Yix51SbciQafX0wVsWXxHlQ1qWpxsQwYdy0TyeJAYXEdOX9YWYUB58
         FhPJaGVWzk3r+WCbKW9ChpVQevhPbiGke+mOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+zYmnCJfLxuJg2cwgFMdsSt40MEJjpsqqzfD7mnTbHI=;
        b=SBfnKgpBdjDcxUH6OtNas3uJCerxBpguc5oFlcXY45+40YL9UzH09gTc7aFfZmteKB
         5b7nCZ9dlygAkruLn1TlQVpqfOI6hhDukyO8bsBfaejdia/FmWqlxtT1Mha9cdpIYJJh
         7gSELpXDsoCtJcIez05DnqdAsGjSIGXkdL2TpDkg6hnBWQ6O83Zaqw8jvkirkc6cjlos
         djuvO6eaBxnmVSj0jJGF2oulms/QSM490Ge4vhephYZNBzAa0n3f3Lomm4N7nR9QV21u
         337aOKO9xJXIGXbPVddtiOJN1xuTJCC3IG34LD6IOMOUTBdwl/YjL6MrrwIovyxF1BFB
         vcZg==
X-Gm-Message-State: AOAM533YXcL8RxeewiKZRX+a8pNDMhWB1+fBwvPWzK4T/jDoxosKSD8t
        CiJP5x57swDmHWZUD7x5Yfkd/w==
X-Google-Smtp-Source: ABdhPJx7u1X22KhhafaKwVFHSo36dX9khORNMsLaDOqLzK9kRKzWD/Iah4PUdZ32bVNOKG4Ovj1skg==
X-Received: by 2002:a05:6a00:10:: with SMTP id h16mr30601057pfk.214.1596051024148;
        Wed, 29 Jul 2020 12:30:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g18sm3387802pfk.40.2020.07.29.12.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 12:30:23 -0700 (PDT)
Date:   Wed, 29 Jul 2020 12:30:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     peterz@infradead.org
Cc:     David Howells <dhowells@redhat.com>, Will Deacon <will@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Paul Moore <paul@paul-moore.com>, edumazet@google.com,
        paulmck@kernel.org, shakeelb@google.com,
        James Morris <jamorris@linux.microsoft.com>,
        alex.huangjianhui@huawei.com, dylix.dailei@huawei.com,
        chenzefeng2@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] locking/refcount: Provide __refcount API to obtain
 the old value
Message-ID: <202007291229.0305C794@keescook>
References: <20200721195132.GJ10769@hirez.programming.kicks-ass.net>
 <202006142054.C00B3E9C9@keescook>
 <20200612183450.4189588-1-keescook@chromium.org>
 <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com>
 <544539.1595328664@warthog.procyon.org.uk>
 <202007211144.A68C31D@keescook>
 <3211866.1595933798@warthog.procyon.org.uk>
 <20200729111120.GA2638@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729111120.GA2638@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 01:11:20PM +0200, peterz@infradead.org wrote:
> Subject: locking/refcount: Provide __refcount API to obtain the old value
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Jul 29 13:00:57 CEST 2020
> 
> David requested means to obtain the old/previous value from the
> refcount API for tracing purposes.
> 
> Duplicate (most of) the API as __refcount*() with an additional
> 'int *' argument into which, if !NULL, the old value will be stored.
> 
> Requested-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This looks good to me. Thanks for poking at it!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
