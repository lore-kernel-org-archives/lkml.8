Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C359C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A2A206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592424953;
	bh=IB6scbkNzoMENHPFUn7fFpcXCGEt9MWQ7kgYmaQUswA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cJKv/TL9eTXeluIs6/afEqRu9FrKAKOkSYIoxZU71jVJ9P9PXOYbgAPozg0dHyrzD
	 nOhVgStCqArG49bb6wx3GghBw2xxRboG8cU83zpJvlD9cYbAzgyncjm6c8UBWMqQ+3
	 TB2WhA9dFypTgNMOOoiGp+busNp8pCy63t9nDPZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgFQUPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgFQUPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:15:51 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C71C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:15:51 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n23so4484126ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lI2Hh6Mc9lbq4P5SHOG2frOmNNisPciXDqLrKSi5quQ=;
        b=JRwdzkhIJDOrMpfZT45E/imRK0NnwIAVZMsxXA24BPG2uMtTMCs/0ZlIDtBzN/to8U
         +fuq9YHs51ZvvXMgQga51CzGBHv7TMJSAp8h9UUfFnVJRxBiZnIV+x52Ui634biatVxH
         mVXJrjlsQ3cjNy4mSkfNPuGE+YInAkmPcl62E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lI2Hh6Mc9lbq4P5SHOG2frOmNNisPciXDqLrKSi5quQ=;
        b=tb0/mCrUW68/pFmw8xd23R0X0bC5oaVJQ/bwSyKWqNU+YTxnXEa2w41zrDnv3K1BiP
         cP/QzTdspLg7iAe+XMLUek0dg7pARDTpaPIDi8hmN1lhGfBopBA2+myr1cNxSXpi4LCl
         OZLoeNC8jo15ZBLbTiGLlXWNPMo87l8GyY6S1DTj/L4f1MdQKY1s9fomMGxOcykcK04s
         /wezfspfPWjb1Kju/lwvGB7+BSfDHNepPwwwUEhc1AptXyFksT9jRSlU/XYk55O/l2fn
         NWC1+RJ7eYV8g1lVi09BzLIJ4kNF9sEbVqy7khiwM2d1F6MG5JkLBSjMJQFEYZP8ZM1u
         euGg==
X-Gm-Message-State: AOAM532KgATl3F6ypJWQd/jIgIATjrWeFBSRDBYuVN59U1S+t8WuHp3e
        WAwfFl5R9n4K+exzbBM9jODqlZ+uz1c=
X-Google-Smtp-Source: ABdhPJxJucVpf4uG1H0W6gIzbdYvuB7W3T6BIWATnbB4Z1UaOsKUEfZn0c3yKRXZ+zYtGzEytzxHww==
X-Received: by 2002:a05:651c:1193:: with SMTP id w19mr493862ljo.121.1592424949260;
        Wed, 17 Jun 2020 13:15:49 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id f129sm176813lfd.6.2020.06.17.13.15.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 13:15:48 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 9so4485974ljv.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:15:48 -0700 (PDT)
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr505029ljn.285.1592424947773;
 Wed, 17 Jun 2020 13:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200615221607.7764-1-peterx@redhat.com> <20200615221607.7764-8-peterx@redhat.com>
 <CAJF2gTSVSXO=phc1eeb-ZmDMrSDjSSLd3tN6ng_8n-pCSZh5zw@mail.gmail.com>
 <20200617154925.GC76766@xz-x1> <CAHk-=wi=58J7d5iyFyYyHrU+pzjWB55cit_LQCkSkavpH-trsg@mail.gmail.com>
 <20200617195807.GH76766@xz-x1>
In-Reply-To: <20200617195807.GH76766@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Jun 2020 13:15:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_V2Tps2QrMn20_W0OJF9xqNh52XSGA42s-ZJ8Y+GyKw@mail.gmail.com>
Message-ID: <CAHk-=wj_V2Tps2QrMn20_W0OJF9xqNh52XSGA42s-ZJ8Y+GyKw@mail.gmail.com>
Subject: Re: [PATCH 07/25] mm/csky: Use mm_fault_accounting()
To:     Peter Xu <peterx@redhat.com>
Cc:     Guo Ren <guoren@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 12:58 PM Peter Xu <peterx@redhat.com> wrote:
>
> But currently remote GUP will still do the page fault accounting on the remote
> task_struct, am I right?  E.g., when the get_user_pages_remote() is called with
> "tsk != current", it seems the faultin_page() will still do maj_flt/min_flt
> accounting for that remote task/thread?

Well, that would be a data race and fundamentally buggy.

It would be ok with something like ptrace (which only works when the
target is quiescent), but is completely wrong otherwise.

I guess it works fine in practice, and it's only statistics so even if
you were to have a data race it doesn't much matter, but it's
definitely conceptually very very wrong.

The fault stats should be about who does the fault (they are about the
_thread_) not about who the fault is done to (which is about the
_mm_).

Allocating the fault data to somebody else sounds frankly silly and
stupid to me, exactly because it's (a) racy and (b) not even
conceptually correct. The other thread literally _isn't_ doing a major
page fault, for crissake!

Now, there are some actual per-mm statistics too (the rss stuff etc),
and it's fundamentally harder exactly because of the shared data. See
the mm_counter stuff etc. Those are not about who does soemthing, they
are about the resulting MM state.

            Linus
