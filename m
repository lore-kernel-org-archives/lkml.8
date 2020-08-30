Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D6DC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A148A2071B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598813694;
	bh=oKnUwGjJsiGgO8KlGy21Yqa8p6WQ/XzKhuhc/gaWpfw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lg3Y1GCp34LEWgL6zSqVROSBh++MKDUAEjcm2eyE1CwMLf1OLgMhmmhW/xyW9v+2Z
	 UseIIoZ3EztPJ5FNrDZ9qHRknIF7W7qXddvD77IfRckd6oYzvv+G+MTDt1GgQtz4kb
	 fMuPd9RJNLJUcsMhl3vbXul58GGTkfPgx8Tye3MA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgH3Sys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 14:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgH3Sym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 14:54:42 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C935C061236
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 11:54:41 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 12so2293633lfb.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 11:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcprhZbONDavwPjBHmv5QL5cg+ByZzLDxztuhPCGpmQ=;
        b=D0fmpEbcNJU8sts2qtgUM1dWuhNp4JNYRUSby6X6ORV6bFNbp7GfGxF+Aq3L4FvnHC
         elBEMqRwxJhhQbk+yzL/8H9LFCi6qwieeoZDjPTkVMjVAn99uYMkfDKiBOEX4aWMxgM8
         cyLNpWLJZSDVe+iwdazLLdiLq/HLA2T571Eh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcprhZbONDavwPjBHmv5QL5cg+ByZzLDxztuhPCGpmQ=;
        b=JX7i9zQdLeBEtXoZtykmFOUBomqhh4SHuMKNowtmjxW79f04JhXohb4AeW10byOCGC
         X5mRTB8xt9g4JnqB4V2HWGKKPRXeeMCFe6wlbhJ/gsj0+aETHVC9eRqgbU9z2UgIOVQ0
         j6avtNG9mleVopGUmfdYRYf+qdcVT7R2cCegD3H+u1JLRyf6Djw8OMfY/TD8KMWRTmQ3
         Yo3M3XnMN23k2V1hsUzp6q3vSyge/NFBtzn6ArO0YcvRrme+xWF/EFlZnXYuNBf/RuMj
         8Vwnwt3HDMlZV99a/CZg1OVH4Wlo2k370oKoEAasciMy93HOxEMOE1SCwkhn+GyH+aPd
         9oFw==
X-Gm-Message-State: AOAM531Q8BP5iRnjD8LyTMpFVcd/sR2sASusfISHkOGgwf6dvesyKt0H
        Q+u0UaK68/8qHXGFVhZlnRFHRTIy22J3uA==
X-Google-Smtp-Source: ABdhPJxxxGSKPjlgwFm0t+nNUyDkvL7Dy1Nwg30Y+33a5xHES9hjumxYNQXFljM1i49Wy2rKt4rk7A==
X-Received: by 2002:a05:6512:690:: with SMTP id t16mr3918249lfe.213.1598813677314;
        Sun, 30 Aug 2020 11:54:37 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id q20sm1097213ljj.42.2020.08.30.11.54.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2020 11:54:36 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 185so4246313ljj.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 11:54:36 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr3232461ljk.421.1598813675930;
 Sun, 30 Aug 2020 11:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <159881061564.27993.11909051048930389391.tglx@nanos> <159881061804.27993.16119786735164087221.tglx@nanos>
In-Reply-To: <159881061804.27993.16119786735164087221.tglx@nanos>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 30 Aug 2020 11:54:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi6ufj=O-PDu=HVYw0QXpK52GPWKJfBaU4Djr0h6OFpKg@mail.gmail.com>
Message-ID: <CAHk-=wi6ufj=O-PDu=HVYw0QXpK52GPWKJfBaU4Djr0h6OFpKg@mail.gmail.com>
Subject: Re: [GIT pull] sched/urgent for v5.9-rc2
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 11:04 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>  - Make is_idle_task() __always_inline to prevent the compiler from putting
>    it out of line into the wrong section because it's used inside noinstr
>    sections.

What completely broken compiler uninlined that single-instruction function?

I've obviously pulled this, but it sounds like there should be a
compiler bug-report for this insane behavior.

Or is Marco building the kernel without optimizations or something
like that? That has not been a supported model, for various good
reasons..

                     Linus
