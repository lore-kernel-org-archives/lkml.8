Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E50C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4862205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CYF6h+VX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgCJVYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:24:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45647 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgCJVYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:24:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id b22so20485pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 14:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/CkCVqmCtyVrNdTteJRfzqZVn1Fmayt+pRMN6dA6WQ=;
        b=CYF6h+VXHl19LIAYXl7Ey55sWNZwBlILMjJhtQIgPX7qIyptQACPY8ADJcC8vkk7rs
         qKvI3FOahK7tMELwmCKGa/+HTlWZKP5TdgfiYa/X+GJkJip2WfomYqZRQYsTrQ5Hngch
         g2pImAJOaAMtIXpjDSqdxUOAUvZDika1yd7LHzIT9rOOPpJM9O8ok7cMt+2RLpQyoMUF
         tW5WKuknRZhn9qCC1Ui95yzJKCKrC7BDohv5ZnBjfqWNf5gXXdNeOx11HPMorOT6wn1J
         /9X/0saUjVqBA20QrP9OmCf1FXmea04Sg+i8Ei/iV8UB/94MS0KfV4phcOvFKoZfRzmh
         9HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/CkCVqmCtyVrNdTteJRfzqZVn1Fmayt+pRMN6dA6WQ=;
        b=Q29VmvRKuei1bkwu9kCk5goPS7BALS3wc0tg0G0q4l48aU4RBVcT3SrtyL7iNxGiK6
         cDx/E3CS2QHIZblAV6WhQbpz7LjLXtvtYLup2DA+WV7CqGolNGFCmnhrZVRLYPuo8vYm
         2FjTxWgTlk1yK/a/UBsmeKWaVbsGkZKP+BPPg9RFxAC5y2HiqyFWrm64PTiQd2lJBySn
         PEPR0Omb8xqhI3aLFITi5irX3JCLzae6aDVt7l9XXqEZq7EMOwFYRfIqWLqhKnCCu6JP
         UXeiB6FfB1NKCIfvPeZ47LGRlqgHxNloRHdioN0oEansdnArCe4pBTzUnKB+Zi1GpxdC
         LXZw==
X-Gm-Message-State: ANhLgQ2VDBVaOeaTQuV2cQlHbRW8/EpUOonb/YEE8+1tH8qQEUeydGgV
        ZrhBj+fQRhmdhSpddVvCGwvdcvHv41JHQfIMJ0Ki3Q==
X-Google-Smtp-Source: ADFU+vsyB4qoVmgV0c59ceJcwRDR+0Y3qDAkeMfEVqTmD1WBNGc0yteZMQlHwBo26GHPkAffZi8qVaqbzUdt/sfg0To=
X-Received: by 2002:a17:90a:fe04:: with SMTP id ck4mr3730232pjb.29.1583875473395;
 Tue, 10 Mar 2020 14:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200305183939.256241-1-davidgow@google.com>
In-Reply-To: <20200305183939.256241-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 10 Mar 2020 14:24:22 -0700
Message-ID: <CAFd5g45XJLXYfXB-FJhFYnBYUdqM4ztC=p=Akj3+GbHXfHxzgQ@mail.gmail.com>
Subject: Re: [PATCH] um: Fix overlapping ELF segments when statically linked
To:     David Gow <davidgow@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 10:39 AM David Gow <davidgow@google.com> wrote:
>
> When statically linked, the .text section in UML kernels is not page
> aligned, causing it to share a page with the executable headers. As
> .text and the executable headers have different permissions, this causes
> the kernel to wish to map the same page twice (once as headers with r--
> permissions, once as .text with r-x permissions), causing a segfault,
> and a nasty message printed to the host kernel's dmesg:
>
> "Uhuuh, elf segment at 0000000060000000 requested but the memory is
> mapped already"
>
> By aligning the .text to a page boundary (as in the dynamically linked
> version in dyn.lds.S), there is no such overlap, and the kernel runs
> correctly.
>
> Signed-off-by: David Gow <davidgow@google.com>

I can confirm that I am seeing this problem as well. (I know we run
the same Linux distro; nevertheless, this is a real problem for some
population of users.)

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
