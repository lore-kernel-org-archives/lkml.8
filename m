Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10499C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D356420848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jOAECUUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732459AbgCCVM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:12:58 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45613 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732397AbgCCVM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 16:12:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id m15so2109201pgv.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 13:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5FXbiSS6phrCyBSlDdRJ6x/G1vIq9Bm0/o5FHfb1vIw=;
        b=jOAECUUuemFMG+jcbroZneMtc7qWtKzzWb6YZ9KudcoaFS9YHVa2rAlh8vcMqr9TJF
         /CXBV46A2COS8wJsUSXE7j8rLvZ5nCTjMeQVm9aZQAI51KRHRN/I6OyveCMeqjE6dvX/
         ER6p7yw2ITr+oI7Kmz3rEm8pIGLlYzTHjEVaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5FXbiSS6phrCyBSlDdRJ6x/G1vIq9Bm0/o5FHfb1vIw=;
        b=S7VsJf0jx+TXJCbMH8RehiRGiwej4/MMeZkJZtXjsMIvp/5Zc9sh8GhIeYYEA6y+bH
         BCD1eV1CorNNkLbCk8W8kH8S5ZoJUsmn+NtK1uuD5SCZAtV7LYO/GBwYMJ5WrzBenqWa
         8I9LQ4eDNYcfV3EudkD3u6OGV+oU976LynwlPy8NcURFFyjyULUkEcig0wa5h9W7Qocq
         dVLg2ejnNLJyexYanN7lrjvQejmZDTSppaa/PLeROwNvshVrQ3/AtU2SHF1C6i8Q3T9X
         rVFIajMRu8lJ7i5MGJhMZbG6U/vvDHIfSpXTGM1ul4nT536Nl9R6i8svFskZhf0yKLP1
         HfKQ==
X-Gm-Message-State: ANhLgQ0m/agaXNDajfklOD5C8GaPZxN1jJL5DtfDXYa6noZlUgUPCrXb
        GSfn4PWK/jru5gsWY6run6eLXw==
X-Google-Smtp-Source: ADFU+vucXyIb8FnssOZOLkbGPk1bO96Ow3P+bV2pc/F3360lz3zUkWYHVF36hCwUG1VnUGGhwoTMmg==
X-Received: by 2002:a63:ab04:: with SMTP id p4mr5861705pgf.37.1583269976999;
        Tue, 03 Mar 2020 13:12:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i5sm123701pju.42.2020.03.03.13.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 13:12:55 -0800 (PST)
Date:   Tue, 3 Mar 2020 13:12:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        david.abdurachmanov@gmail.com, luto@amacapital.net,
        oleg@redhat.com, aou@eecs.berkeley.edu, keith.packard@sifive.com,
        tycho@tycho.ws
Subject: Re: [PATCH] riscv: fix seccomp reject syscall code path
Message-ID: <202003031312.3EB46603@keescook>
References: <202003022042.2A99B9B0@keescook>
 <mhng-f926452f-8491-4deb-9721-a52487de676d@palmerdabbelt-glaptop1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-f926452f-8491-4deb-9721-a52487de676d@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 09:55:10AM -0800, Palmer Dabbelt wrote:
> On Mon, 02 Mar 2020 20:46:46 PST (-0800), keescook@chromium.org wrote:
> > On Sun, Feb 23, 2020 at 10:17:57AM -0700, Tycho Andersen wrote:
> > > On Sat, Feb 08, 2020 at 08:18:17AM -0700, Tycho Andersen wrote:
> > > > ...
> > > 
> > > Ping, any risc-v people have thoughts on this?
> > > 
> > > Tycho
> > 
> > Re-ping. :) Can someone please pick this up? Original patch here:
> > https://lore.kernel.org/lkml/20200208151817.12383-1-tycho@tycho.ws/
> 
> Sorry, the other messages didn't end up in my inbox.  I'll take a look, as this
> seems like a good candidate for rc5.

Awesome; thanks!

-Kees

-- 
Kees Cook
