Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76F2C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86EA920716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UyJevSS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgICWrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbgICWrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 18:47:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D56C061246
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 15:47:34 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id g6so2162555pjl.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 15:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eFrstCXBN3HfrZebeISGA36KawHO68DuV5H+8+oCMrk=;
        b=UyJevSS3jZbv6N7QB5+swtwOzbQH8Mebfc6NiguMHEEa3zpvf2Fa8BOPsjRPafItrX
         94+boIdY0eIFAYNargKYhKvUD4q+qsol+8WhYmSNTTfQeUzQx66molHRZp0VKRR4pNjd
         TeTJKO1SkL6fNUa/+nF94zP8Ps5d09zjKGzZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eFrstCXBN3HfrZebeISGA36KawHO68DuV5H+8+oCMrk=;
        b=EB9YzfysEOFXCIIEpjAolPtQ/wrgnBc03iZ7yNWoJkXAfmIdt2ifw1NmTjuXaxyukl
         sYRRpP/CDSoV/1SFW7Mdfg7J986of6K1f83KBZD+8ILVT5NzURly/JPUaI+Q/Ahav6J+
         qlb8yxdVbW6Cuass1oHdnN78zoMtAuJ/3diyojkCbRo3d0gsjNkm0lzSCqGK4d1ywDYT
         AGvHX51ZAQHMX2QKfO6cnwQfaydabA1sYYyLxttlMBePDp/B48qmTU147oWLxTosNf7A
         npAS/S/+4RJN+OT4hD1COnmZXOzO7R75Zl98spPVvgNh+E25+XINyMrME4IjbN/dICtd
         NtLg==
X-Gm-Message-State: AOAM533GlFuSJMCNlIrkTWIfrKtRonHb3JrPKp3ya2+h9vfMZ9ChYCBr
        pWU5SgwAbwKVt8dhVQno7qJQEQ==
X-Google-Smtp-Source: ABdhPJxBUddtcfqLuFrofAmKe3Wkr2dCSnES8MsReM+zYAT8LfVgd6BWIelLMAoy/r1/rEVW2WoePA==
X-Received: by 2002:a17:90b:889:: with SMTP id bj9mr5382384pjb.101.1599173254469;
        Thu, 03 Sep 2020 15:47:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s198sm3700589pgc.4.2020.09.03.15.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:47:33 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:47:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 27/28] x86, relocs: Ignore L4_PAGE_OFFSET relocations
Message-ID: <202009031546.4854633F7@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-28-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-28-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:52PM -0700, Sami Tolvanen wrote:
> L4_PAGE_OFFSET is a constant value, so don't warn about absolute
> relocations.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Any other details on this? I assume this is an ld.lld-ism. Any idea why
this is only a problem under LTO? (Or is this an LLVM integrated
assembler-ism?) Regardless, yes, let's nail it down:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
