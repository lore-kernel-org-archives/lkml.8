Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B50C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 02:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10BCC206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 02:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fc24JXCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgGHCt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 22:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgGHCt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 22:49:28 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2189CC08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 19:49:28 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 1so1599012pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 19:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oDMKuoobK+wqThSWZV2fTvhky7fucypql6WSexq7SY4=;
        b=Fc24JXCHjbpqPEpvXryUfcnNyA2mmorz14N9RlzXJsBnaQdTLSB+0vNa2gElwKFTBq
         tROEvAxBpwQpNioPsPuphSsbqPGoxKoyKPyUpdbez8qBRHjTBthA8AQIgNXX6dxW8AOP
         CRHvVbQFe8l2sTYGW/NR2veeV54tHy6AMZ1cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oDMKuoobK+wqThSWZV2fTvhky7fucypql6WSexq7SY4=;
        b=VM+PYXnGV7kcrQZ9AGpi2Lr7ghmHWrtYZQ6nAjeXWRxYb8GYFBTkcfOH6rSjSEpnqc
         dHw/Zi7EO/c+OX7FPMWRQgNBOlkILxRhasJkL1aKwwiNYUMmY//CkW+YVGWGUnxl0OTN
         bbmkioe+JuRYDU/OAV1pR9SRe59wi5VuqY41/3X01MxKjHbqTfsIEXH7YueA/y4ThwWK
         24YZ7yEMH3vXBn2hP7ca4U9/mMnRWEcxQd4VtOhOCq0Y/zHke+G+5iTP6h7EiRL9qFzx
         hsOgEMXIQ3CBRZ7exnS667qvCkNoAdBIwYqwa9z54nA2T7rKUO6MPSbV2N4suygC4jan
         gvqA==
X-Gm-Message-State: AOAM530jfNqlQeG0K10iIO/aTlDMQPYCfRO2IoWsUQzrT4hKW8/4AvAY
        X0tue2lXrdIIruYN71IwOD1g+A==
X-Google-Smtp-Source: ABdhPJy17KyAApy//tmd0auIXDpzf4SJ5j36NacgxMqfw+6L7OOFclQs7+UZzPNkKGPt/n7+60qswA==
X-Received: by 2002:a63:5110:: with SMTP id f16mr46362138pgb.377.1594176567609;
        Tue, 07 Jul 2020 19:49:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c187sm23031520pfc.146.2020.07.07.19.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 19:49:26 -0700 (PDT)
Date:   Tue, 7 Jul 2020 19:49:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Terrell <nickrterrell@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
        linux-kbuild@vger.kernel.org, x86@kernel.org,
        gregkh@linuxfoundation.org, Petr Malat <oss@malat.biz>,
        Kernel Team <Kernel-team@fb.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Patrick Williams <patrickw3@fb.com>, rmikey@fb.com,
        mingo@kernel.org, Patrick Williams <patrick@stwcx.xyz>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Norbert Lange <nolange79@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>
Subject: Re: [PATCH v6 2/8] lib: prepare xxhash for preboot environment
Message-ID: <202007071947.5E9723AF48@keescook>
References: <20200707034604.1539157-1-nickrterrell@gmail.com>
 <20200707034604.1539157-3-nickrterrell@gmail.com>
 <20200707215925.GA1591079@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707215925.GA1591079@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 05:59:25PM -0400, Arvind Sankar wrote:
> On Mon, Jul 06, 2020 at 08:45:58PM -0700, Nick Terrell wrote:
> > From: Nick Terrell <terrelln@fb.com>
> > 
> > Don't export symbols if XXH_PREBOOT is defined.
> > 
> > This change is necessary to get xxhash to work in a preboot environment,
> > which is needed to support zstd-compressed kernels.
> 
> The usual way to do it is by adding -D__DISABLE_EXPORTS to the CFLAGS, which will
> cause EXPORT_SYMBOL to be stubbed out. Doesn't that work here?

This is quite rare, actually:

$ git grep DISABLE_EXPORTS
arch/s390/purgatory/Makefile:CFLAGS_sha256.o := -D__DISABLE_EXPORTS
arch/x86/boot/compressed/kaslr.c:#define __DISABLE_EXPORTS
arch/x86/purgatory/Makefile:CFLAGS_sha256.o := -D__DISABLE_EXPORTS
drivers/firmware/efi/libstub/Makefile: -D__DISABLE_EXPORTS
include/linux/export.h:#if !defined(CONFIG_MODULES) || defined(__DISABLE_EXPORTS)

But yes, it seems that would be the better approach.

-- 
Kees Cook
