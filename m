Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12D3C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 18:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D42720767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 18:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iu/mivde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbgIASxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 14:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbgIASxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 14:53:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D292C061246
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 11:53:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u128so1334364pfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DW1zJLlrp+b/X5DsaUJywWHpm9f8YdypCEJotWWzal8=;
        b=iu/mivdeQ6AWpfUigREEipYqDA+JBPragzl35o9Nu9ycwxuP1pT/n/GUj28IBjGlJy
         tASUZD6UQpFduus8RxIUHnWDo/ii2QxBTb8+/rddFmc7Q2BvQtdvriL4oOcAbvX3fTik
         a3CX0t1k/eCXUbO98m4G5hAHF2rr9hmEGAwHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DW1zJLlrp+b/X5DsaUJywWHpm9f8YdypCEJotWWzal8=;
        b=WbDGwxrd3f9MQ++XytOkgWgxrXjk2hOkSmQOLn3cTGX/i40qP8TGRsjkdvftaBwFnz
         cYk0toDrmj5cBU3T/BzwB5E3tmdd3CSrcFsBJdOE1nSie/fF/J1k5FUTacGFCyhmWmhQ
         Wc1aN7CPArFGjEdwz9PkDxlOP8L1ioo2IWX3E0ij1xg+uGZwj6YnJaH025diwxOSDOvL
         lnbOd4k0Rwa73fcBXAs3PKPxn5piu7CRRsfvvnYq0+7Se+G+dpmX5Lq3xTj3SH7NK37p
         uv59mkgscdB8l8sSKt+tB6vkauqW/SXbum95xnv+rc1N8dAuiLPZPsqTPiWqh48iHrK2
         Gszg==
X-Gm-Message-State: AOAM531x0eujrFujf2BZgswUqYx6RsAjAH2ElL0ztuwtU8vvVbv5rA3z
        qlYUnwv/BBM6xbMYdSC0ZCwKgQ==
X-Google-Smtp-Source: ABdhPJw/YsKunmr1Z0dpXo1/zK3rMUMV+IlY1oP54bh4p+BaEO8LJP6shIZse5erSoELJy0YDj4+Gg==
X-Received: by 2002:a65:4187:: with SMTP id a7mr2642045pgq.102.1598986382061;
        Tue, 01 Sep 2020 11:53:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m19sm2192249pjq.18.2020.09.01.11.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:53:01 -0700 (PDT)
Date:   Tue, 1 Sep 2020 11:52:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 05/10] lkdtm: disable set_fs-based tests for
 !CONFIG_SET_FS
Message-ID: <202009011152.335EE467@keescook>
References: <20200827150030.282762-1-hch@lst.de>
 <20200827150030.282762-6-hch@lst.de>
 <CAHk-=wipbWD66sU7etETXwDW5NRsU2vnbDpXXQ5i94hiTcawyw@mail.gmail.com>
 <20200829092406.GB8833@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829092406.GB8833@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 11:24:06AM +0200, Christoph Hellwig wrote:
> On Thu, Aug 27, 2020 at 11:06:28AM -0700, Linus Torvalds wrote:
> > On Thu, Aug 27, 2020 at 8:00 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Once we can't manipulate the address limit, we also can't test what
> > > happens when the manipulation is abused.
> > 
> > Just remove these tests entirely.
> > 
> > Once set_fs() doesn't exist on x86, the tests no longer make any sense
> > what-so-ever, because test coverage will be basically zero.
> > 
> > So don't make the code uglier just to maintain a fiction that
> > something is tested when it isn't really.
> 
> Sure fine with me unless Kees screams.

If we don't have set_fs, we don't need the tests. :)

-- 
Kees Cook
