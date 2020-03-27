Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834A2C2D0ED
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 05:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EDE20663
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 05:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uqmMlcSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgC0FJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 01:09:25 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38487 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgC0FJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 01:09:24 -0400
Received: by mail-yb1-f193.google.com with SMTP id 204so3911107ybw.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 22:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ohnZNgjDeOcrrgII3KrdEi2hNuGyHzs9U8pjD+WsuTc=;
        b=uqmMlcSLr/aJyGrLVFPoqWyksk03NI8a822IT0j0ft9YIBJiatFbXJVZy6u11D3R2c
         DgA+Pwgg5I3SZJYi//NjgjU+dinJO7EryHfQ72Vy7O7dQdldLL+/gP1clOCR82l3G8TV
         T7jTETFt3pV6NkuJLQ3NZFYesU3RfZWs18NSK0EcDemZpzM40PA3p6S72AYdbZwfGa36
         r/zkM6Yu9WLvaAWoSEGc1cxHfWvFirvTZvZHGzngBQu+YVpAKGu1qSTue1tboiV+r1at
         m/JShFaIse/ZGkCThuuAadKwrkWDi0Ps8aDb8YO8bji08z+Ysi5lVvks09p0W2KbJFFd
         6m+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ohnZNgjDeOcrrgII3KrdEi2hNuGyHzs9U8pjD+WsuTc=;
        b=fwch8QPKvgR7lpRzBRxmSm8ib8tgINyh8gpwtHtVCtrCsXUL69JqO73ymsrDo8sPzj
         tDhLZHNV88HtX2hDb1O5aelsQYplGmm+8QNvyttC5lqXnDpwyMd7BROA2/TvewoZE+S2
         Lyq0HfWbMNAIvTqnOyYcRslw/xNUuRkLKjM9PYT0Au2JIItE3g7BclM8CBXB/GxXNQp8
         clZGn1s4SzLU5wpMbwPGVp5Ug7VLqas8+WdgdC6LPdNSDGFg/Hijv8fvGI0o0s3SgnGp
         6H23G601osLuiTfS4kG8d2e1mwDyYZmgiqa0Pg+v7vaeu6ucNQlVuTzHtjsrCegzkTJi
         Ufsw==
X-Gm-Message-State: ANhLgQ2Tocpcrs/KSzQjs0cU1p9ktqPFpfr54dm1bLQqdNfosrNBvdrq
        d1SvIFYHVFcRwhJ9YvUpNcMTw6HrPJYU3Il1D4R71A==
X-Google-Smtp-Source: ADFU+vtpDbHudptQ7FfWw0e+/cwVeNaEqIblGpv1l/3zEkMwrkgEw3XL9Mjg3v3rXDPcpFZmqedQwIGQiCFyFXqU4YU=
X-Received: by 2002:a25:bb0c:: with SMTP id z12mr17920472ybg.253.1585285762971;
 Thu, 26 Mar 2020 22:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200327021058.221911-1-walken@google.com> <20200327021058.221911-8-walken@google.com>
 <20200327044647.wgfsmjy37n72dixe@linux-p48b>
In-Reply-To: <20200327044647.wgfsmjy37n72dixe@linux-p48b>
From:   Michel Lespinasse <walken@google.com>
Date:   Thu, 26 Mar 2020 22:09:09 -0700
Message-ID: <CANN689Hr972e_0+kujGxXPbCVTd7xnpBPZXDk2T3dwARnWENVQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] mmap locking API: add mmap_read_release() and mmap_read_unlock_non_owner()
To:     Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 9:48 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Thu, 26 Mar 2020, Michel Lespinasse wrote:
>
> >Add a couple APIs to allow splitting mmap_read_unlock() into two calls:
> >- mmap_read_release(), called by the task that had taken the mmap lock;
> >- mmap_read_unlock_non_owner(), called from a work queue.
> >
> >These apis are used by kernel/bpf/stackmap.c only.
>
> I'm not crazy about the idea generalizing such calls into an mm api.
> We try to stay away from non-owner semantics in locking - granted
> the IS_ENABLED(CONFIG_PREEMPT_RT) warning, but still.
>
> Could this give future users the wrong impression? What about just
> using rwsem calls directly in bpf?

I see what you mean and I certainly don't want to encourage any new
non-owner call sites to appear.... This bpf stackmap site is a small
pain point in my larger range locking patchset too.

I am not sure what is the proper response to it; the opposite side of
your argument could be that using a direct rwsem call there hides the
issue and makes it less likely for someone to fix it ? I don't have a
very strong opinion on this, as I think it can be argued either way...

But at a minimum, I think it'd be worth adding a comment asking people
not to add new call sites to the mmap_read_release() and
mmap_read_unlock_non_owner() APIs ?

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
