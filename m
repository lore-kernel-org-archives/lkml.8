Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB31C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AEB72078B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597307779;
	bh=WON/ejwuAOLIRcklKfzFj37axQddakk+egj2VgauEew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1/czplB2Bl1EEPKhqdeclfOIE0z0QtNiDdaJbnThbaLvDe8Q1R82UUF+dATBv2iD8
	 vF0wHEoSDRujLcBXhgozIfMdHrgz6OvTL5rJ5RzUe8YjHG0N3qTpeSMJUS0eRwbjuN
	 rOAmawqqrVsaRn8OG5VPo6D8y0MgwdZZAktF3yX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgHMIgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgHMIgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:36:17 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1738A20791
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597307777;
        bh=WON/ejwuAOLIRcklKfzFj37axQddakk+egj2VgauEew=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tBee+0gRDN8Wq12sUz7+NT+sK7KI2Woi8vFFwv/fzfdL/zbvXuGsYS8vSk6GDVdNJ
         JEC+kh+XmnhB9IznM3LjDH9afosqd5p12xj9aPV/aAR2InY7uv5sYPcarQaHI5REoU
         BS6+bBo7+hsxSwt/c/otU9JtxyjVzxLw7jj3RFyo=
Received: by mail-ot1-f52.google.com with SMTP id 93so4197252otx.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:36:17 -0700 (PDT)
X-Gm-Message-State: AOAM530ozlSy0oDpxcbait6OT7mPs0wIhLJGNqrucorwAFdLZCTj/eBB
        cqr877mzeLEc7IvQj55cfwvChAVDuu59Mv73aVE=
X-Google-Smtp-Source: ABdhPJzPE1yoRqgWQ/1nGSnRVk0FODJxQm7Bq5OY0G61ncLuc4hl3wcP2Olt1iBjF6okTcRINSRM2YYdvgrrmVVgBRk=
X-Received: by 2002:a9d:6251:: with SMTP id i17mr3148788otk.90.1597307776442;
 Thu, 13 Aug 2020 01:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200811163427.6edbf343@coco.lan> <20200811145524.GE2674@hirez.programming.kicks-ass.net>
 <20200811172738.2d632a09@coco.lan> <20200811160134.GA13652@linux-8ccs>
 <CAMj1kXF8fm=9CdQykqDbgYCJSP88ezMs3EOosCW+SDi+Lve0zg@mail.gmail.com>
 <20200812104005.GN2674@hirez.programming.kicks-ass.net> <20200812125645.GA8675@willie-the-truck>
 <20200812141557.GQ14398@arm.com> <20200812160017.GA30302@linux-8ccs>
 <CAMj1kXFfSLvujJYk4Em6T+UvAUDW3VX0BibsD43z30Q_TSsehg@mail.gmail.com> <20200812200019.GY3982@worktop.programming.kicks-ass.net>
In-Reply-To: <20200812200019.GY3982@worktop.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 13 Aug 2020 10:36:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEn5o_7OOqgcntOPCqBYmpY74OkGqQ_bUBJvHG6Q9GVLA@mail.gmail.com>
Message-ID: <CAMj1kXEn5o_7OOqgcntOPCqBYmpY74OkGqQ_bUBJvHG6Q9GVLA@mail.gmail.com>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 at 22:00, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Aug 12, 2020 at 06:37:57PM +0200, Ard Biesheuvel wrote:
> > I know there is little we can do at this point, apart from ignoring
> > the permissions - perhaps we should just defer the w^x check until
> > after calling module_frob_arch_sections()?
>
> My earlier suggestion was to ignore it for 0-sized sections.

Only they are 1 byte sections in this case.

We override the sh_type and sh_flags explicitly for these sections at
module load time, so deferring the check seems like a reasonable
alternative to me.
