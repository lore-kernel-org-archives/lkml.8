Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CDDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 649DF206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3WFT+H6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHSNYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgHSNQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:16:33 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E96C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:16:30 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o22so17653535qtt.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ukIFFNEkmWu6RobJHPqTePGGEQuwENadcCDhgJtfzhU=;
        b=j3WFT+H6DJHS7Om7raw3H42KBCXviTCmnvdRJkrbff7AwxiK4dOo8ZsHPWI1xzVbMW
         z4pnhgnMnJ8YISRBqVhlm6Fk/wjcTedAZUUHsJFLFumXcuCued1IwTvcCU6nAa+KkInI
         whgvYFJ4LFbKrI8TvpI6x/FTQ2bRQCeQXVO9YNlfAnTuywtuKTj93pJwvcX9pxlFiOCG
         ymS1/Wl7cjV5j1YrneNJRRE6vRc5sJU77xvKYDZcUvXUjXuALbXkMtk38meji6XYlCl2
         MrkbPGeyOBqRP2fAZzk3zv9RpLrqnui89nc8EL6Kj/fKEZw43VrfGnFVh3V7lcuw5QXP
         wqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ukIFFNEkmWu6RobJHPqTePGGEQuwENadcCDhgJtfzhU=;
        b=hN204Q4QsIwsb2mALHgwMyl+swkp51QD/NgbO/8JK1FW3+XORX8uEhZkmMu5ILO9X4
         OVoXKuN8EBX6VyaigUX1QM+uh9LcxaZUf9dfx/ZGIsgLGICrSjUqXC86mASgobWvB9s5
         aVCB5QIVDHcSXincCEt6H7nPMHfBILPrV64mX2Zo32p1eK87uIVIjbnqq/Sk9CXkljfK
         nFlzppVavDaL5NcD5zNJWoblywYY7Ipo57CZRx7MRiV5kZmNfOlMprLnCDF0se7ji75W
         Hrc7zTJidSinilDjw6nkdcNl04U2ephnxfQhkTfl9NIAfMJrQ5Y9JLhTWg4UyOopFT8w
         1iyw==
X-Gm-Message-State: AOAM532Zm6bFqp7H3gq6wydfAysF6gJFoc36T7ZttKkvPIfq+hhOQPK8
        krbFIjqzs1N27ENjbbefHjA=
X-Google-Smtp-Source: ABdhPJxjAVDucLlpJsFcN9VMNE8c4qYhCLipaYCs/n2o9ck1xUXg7Cd/tCNJ8HnylqqhsKF36TgRKg==
X-Received: by 2002:aed:3728:: with SMTP id i37mr22703331qtb.347.1597842989944;
        Wed, 19 Aug 2020 06:16:29 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 3sm24856186qkm.117.2020.08.19.06.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 06:16:29 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 19 Aug 2020 09:16:27 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] lib/string.c: Disable tree-loop-distribute-patterns
Message-ID: <20200819131627.GA3779903@rani.riverdale.lan>
References: <20200818234307.3382306-1-nivedita@alum.mit.edu>
 <CAHk-=wik-oXnUpfZ6Hw37uLykc-_P0Apyn2XuX-odh-3Nzop8w@mail.gmail.com>
 <20200819030442.GA3396810@rani.riverdale.lan>
 <CAHk-=wiJLvqS1_O+yAQSZr-Lj49HdJyLpt3J_nW=otHLfEN4RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiJLvqS1_O+yAQSZr-Lj49HdJyLpt3J_nW=otHLfEN4RA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 08:32:58PM -0700, Linus Torvalds wrote:
> On Tue, Aug 18, 2020 at 8:04 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> 
> > Might be worth optimizing strnlen etc with the word-at-a-time thing though.
> 
> Yeah, possibly. Except the kernel almost never uses strnlen for
> anything bigger. At least I haven't seen it very much in the profiles.

strscpy could be implemented as strnlen+memcpy. I'd think that wouldn't
be much slower, especially if strnlen is optimized and the arch has a
good implementation of memcpy?
