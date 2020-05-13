Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2690C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B45A8205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589412041;
	bh=rH9weNxUVC3H6iCIY+7g1Ga5uLTmK2j2FKixUf+qaC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sIH56UE9+N78lAZmbW1M5Uf/sDbPn26towIW6XWQnSqqefkZGUwRjbQW5DlLhsMc3
	 Irf8/wX/ytzGL60jM4Kv3zdNq8tUHJonimxPiW1juetNDq9fBoxutEE/SJTskcbheS
	 xv4zbCseJSMoyXYltcKjZMz/Zvq3i5JfPZvQDxgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732569AbgEMXUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732515AbgEMXUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:20:40 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574DDC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:20:38 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c21so989185lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=phWq6l4aTvr/C2K/X4+k/YrVnCjrPXRTWTh12+oYaOk=;
        b=cD3d6Z8Oy8/Dx9WXsRuTcoa6/5Rh9rx4ZXh8joWvH4poHn6SlmiaIW98FjAPsN6Nbh
         x66jaomRN8ZljFVlOmAhCKb3qMEmAXGGOLhPnCxRlO2Vc19b0KxaWqaBnUOu9g5IgaPv
         XmTXcJb6msXzq5HV1afcp377hyESwqrNggFac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phWq6l4aTvr/C2K/X4+k/YrVnCjrPXRTWTh12+oYaOk=;
        b=m6DU1DtmBwZYA4YvwDq9nGUTekJ7PEK5yTbceLPE16hBInlgCAjkbrEaNwLXOZF4kD
         rVmpIskAFewua7E9l6vdlGoVPWHFf8KFfH/t1zwcXw8J7IEClZ/IErhk+njfs9r6zpD8
         h2oA5lQNMcAOqe2SA1T9BUTgu3k6XUBcTuobKtOBJ9ClcKwH4oQbrrhpf/MboIJnmwXA
         kcH7nFI1bp7ttmdskGROlVPjJm8bGWum+jXHwuGQWGtMuawOMNTR7tfGSe2sZ4xfDuCS
         sEF5R6qHHZ4C+54CrqypK8DyvrduE6GhvP7z8g8CJdu8oO51yrYU3+eZdDpIMZNPm4FF
         FgTQ==
X-Gm-Message-State: AOAM531xvBME4DUv0YJZBUPvyjsoig++5ZjUBBHBpobQBdw95WPFFP1Z
        Czgq+WnDk7pioizMQ9CdSjKFRxjZNpk=
X-Google-Smtp-Source: ABdhPJw2UljkpS0od5zMOWhY4hvKFyZA5pWChn8xIfgK8kiq0Qr1mvrMYzxL/IqxEt4YdGpYvFWJyw==
X-Received: by 2002:a19:70d:: with SMTP id 13mr10853lfh.60.1589412035308;
        Wed, 13 May 2020 16:20:35 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id l26sm447901ljc.49.2020.05.13.16.20.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 16:20:34 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id c21so989107lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:20:33 -0700 (PDT)
X-Received: by 2002:a19:ed07:: with SMTP id y7mr1180765lfy.31.1589412033540;
 Wed, 13 May 2020 16:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de> <10c58b09-5ece-e49f-a7c8-2aa6dfd22fb4@iogearbox.net>
In-Reply-To: <10c58b09-5ece-e49f-a7c8-2aa6dfd22fb4@iogearbox.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 16:20:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJKo0GVixYLmqPn-Q22WFu0xHaBSjKEo7e7Yw72y5SPQ@mail.gmail.com>
Message-ID: <CAHk-=wjJKo0GVixYLmqPn-Q22WFu0xHaBSjKEo7e7Yw72y5SPQ@mail.gmail.com>
Subject: Re: clean up and streamline probe_kernel_* and friends v2
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 4:04 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Aside from comments on list, the series looks reasonable to me. For BPF
> the bpf_probe_read() helper would be slightly penalized for probing user
> memory given we now test on copy_from_kernel_nofault() first and if that
> fails only then fall back to copy_from_user_nofault(),

Again, no.

If you can't tell that one or the other is always the right thing,
then that function is simply buggy and wrong.

On sparc and on s390, address X can be _both_ a kernel address and a
user address. You need to specify which it is (by using the proper
function). The whole "try one first, then the other" doesn't work.
They may both "work", and by virtue of that, unless you can state
"yes, we always want user space" or "yes, we always want kernel", that
"try one or the other" isn't valid.

And it can be a real security issue. If a user program can be made to
read kernel memory when BPF validated things as a user pointer, it's
an obvious security issue.

But it can be a security issue the other way around too: if the BPF
code expects to get a kernel string, but user space can fool it into
reading a user string instead by mapping something of its own into the
user space address that aliases the kernel space address, then you can
presumably fool the BPF program to do bad things too (eg mess up any
BPF packet switching routines?).

So BPF really really really needs to specify which one it is. Not
specifying it and saying "whichever" is a bug, and a security issue.

             Linus
