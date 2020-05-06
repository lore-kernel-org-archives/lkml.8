Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D994C47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4502520735
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j1ofKvDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgEFCxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 22:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgEFCxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 22:53:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FBDC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 19:53:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id r14so287141pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 19:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1CtP5FNOcKefe/Fa1C1BLCGuo+JOUuFdH1Z8Djbibw0=;
        b=j1ofKvDTJMSEa9A9oHELSXXGIIxOkdPrWOa8yR7W1C2RzH/XUiycpjKUNifMfYbGbY
         jqsxiP0YRJ2+6zA+1+RJ8Lzd2koIEghHA2o0NMMfLLOllkEHZtGCIAa0RfZATsCjKM4o
         /UC40jJr8c5QZMH9kbGACTQaOfrDPHR9/TCik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1CtP5FNOcKefe/Fa1C1BLCGuo+JOUuFdH1Z8Djbibw0=;
        b=YtxFM4SvIS8kwXxSbnxL1oObffSTmhEVVMwIl1+0ej7iZw53dC6C11OH3hqM8y1Qu6
         qlPzCukM1bHAyJngMXVoZIOOozLhBq9XG195jq0wTu/bPDa/xahhyEUlLhDtfhmPJzfA
         +tanpYApo1AYAbM1oaKue6nfvNb/BZlCqySb+I/GKWWs366Ikq3kL9qqi2xQM2swilDc
         L4pr/TcNl5rSWy6aCKdYbXYCg3H9Sxjkj/Xyx7+Yi2s8wmWKTcnRb7aoS+Sw1UI+XiAm
         XyUKft3GTQkfyige1mVjD2V2pD0OFj+tP9/WfpGA/prkfyVqVb3KOlYYcVQUEEFHKNdS
         mkYw==
X-Gm-Message-State: AGi0PuYrX+GKSl8zslY+rXqlJuv6n4ASObdxdFLqrG9ON3S0Ew8AAZ7D
        OAP7i/tnuC+5ioyvv/qvWf3Myw==
X-Google-Smtp-Source: APiQypIxNUlmjtAUs1cla1nSjw6uo9XfK3/p4S7YPx37fzaZFOPefx3FkgGdn1P7/2EZYjoeU+NEJw==
X-Received: by 2002:a62:b611:: with SMTP id j17mr5971991pff.214.1588733592406;
        Tue, 05 May 2020 19:53:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w11sm417431pgj.4.2020.05.05.19.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 19:53:11 -0700 (PDT)
Date:   Tue, 5 May 2020 19:53:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        George Burgess <gbiv@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Kbuild: disable FORTIFY_SOURCE on clang-10
Message-ID: <202005051951.23FABC8C7@keescook>
References: <CAHmME9oMcfY4nwkknwN9c4rB-O7xD4GCAOFPoZCbdnq=034=Vw@mail.gmail.com>
 <20200505215503.691205-1-Jason@zx2c4.com>
 <CAKwvOdk32cDowvrqRPKDRpf2ZiXh=jVnBTmhM-NWD=Ownq9v3w@mail.gmail.com>
 <20200505222540.GA230458@ubuntu-s3-xlarge-x86>
 <CAHmME9qs0iavoBqd_z_7Xibyz7oxY+FRt+sHyy+sBa1wQc66ww@mail.gmail.com>
 <202005051617.F9B32B5526@keescook>
 <CAHmME9q3zFe4e1xnpptJ27zywGqngZK2K7LCVzDSoG__ht=fNA@mail.gmail.com>
 <CAKwvOdkrS-P_AS1azSCP-DVq_h8Dhb8YiLTfH=9zzEJQphZTcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkrS-P_AS1azSCP-DVq_h8Dhb8YiLTfH=9zzEJQphZTcA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 04:36:49PM -0700, Nick Desaulniers wrote:
> On Tue, May 5, 2020 at 4:22 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > On Tue, May 5, 2020 at 5:19 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > (Though as was mentioned, it's likely that FORTIFY_SOURCE isn't working
> > > _at all_ under Clang, so I may still send a patch to depend on !clang
> > > just to avoid surprises until it's fixed, but I haven't had time to
> > > chase down a solution yet.)
> 
> Not good.  If it's completely broken, turn it off, and we'll prioritize fixing.

The problem is what George mentioned: it's unclear how broken it is --
it may not be all uses. I haven't had time to finish the testing for it,
but it's on the TODO list. :)

-- 
Kees Cook
