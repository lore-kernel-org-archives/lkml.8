Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71596C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35740206E7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g49FogxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbgIGQZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729826AbgIGQMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:12:35 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73993C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 09:12:35 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id v123so1555947qkd.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 09:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WvmZn600MofrCps3XWIGrVo6oOPy1OACJfE+3g8CYWg=;
        b=g49FogxWmUoGS9sBt6thrTNC76RLZknMUchZEhicseMdH8sp5fLU1fc5/SWbvAvnu+
         mGiZPetkwTvzp3trEJrX110uD+CQB4WBgVeWwnHtPiBFYSmPdJcaYiO/zA95WvmqUsx9
         EA/N9R/ftI8txfo7ENaXiTPdFTaedsxAabM58QWGpRUILOHofbgySEDoFpU04o8YNhgR
         74M76gUEePsmMhIVZoZ2LQhxfk4KUq2GiI2XKdqx4t9OVwTiRwqcgg6a8h/VcJnhInut
         L15+/ztJ2is8/XtEmp/7QcZys8IiXhh9JZ5zADiQvStOy6EScWqr1tp9ILktfnMwhuy7
         cEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WvmZn600MofrCps3XWIGrVo6oOPy1OACJfE+3g8CYWg=;
        b=JhM46uu99GDHfHfNgTUoplNeZh+N0EREHVqB3u7HGg1S9Zf6vD6Li7fPyZ/zqpKUVw
         rvD/DhSkDcr5qPaJ8h6kJxS1o2f+KtTgegNNmafQcIQdnsUSkNxPjZUAMXFocn4eQcDV
         tvrqMFcf9EKKXBpwrRLltJa+EOUwW7bv6+ZerFxZtPM3SvZYXtzX71VLrsl0x0F17u6I
         QLNxau1T80c19OkvJWtAVcVurjc7u8O74xU5H2G0uCPkXwwA8D9JL5EujrtghfNmsREo
         q4NbS2OdeUP3KKQjgSiwovKqD+nQPWZOuY6tYW8XF3wT8SmIBVIPSh7DmH2ecqoWX8qq
         M91w==
X-Gm-Message-State: AOAM530wvlDRAcXZBjnBuOmmvekYrrAEBwZVwbJYet2HPLs9Cb1t4MbQ
        NRkdfD+2zSuRRPjejQI6JYc=
X-Google-Smtp-Source: ABdhPJz86B9wIpFcAHJgj4+FBLduLncRx9Ylwf5JMcQJDvZyvyaA5eMhnRgju1FCv/rZaFAAQUKJUw==
X-Received: by 2002:a37:6f41:: with SMTP id k62mr18933946qkc.241.1599495152873;
        Mon, 07 Sep 2020 09:12:32 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o13sm10277412qtq.41.2020.09.07.09.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 09:12:32 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 7 Sep 2020 12:12:30 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] set clang minimum version to 10.0.1
Message-ID: <20200907161230.GA2149325@rani.riverdale.lan>
References: <20200902225911.209899-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902225911.209899-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 03:59:04PM -0700, Nick Desaulniers wrote:
> Adds a compile time #error to compiler-clang.h setting the effective
> minimum supported version to clang 10.0.1. A separate patch has already
> been picked up into the Documentation/ tree also confirming the version.
> 

Is 10.0.1 actually required or could it just check major version? I have
10.0.0 currently and at least x86 seems to be building fine.

Thanks.
