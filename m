Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A98AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 348FA206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="a40M9wPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633960AbgDNVf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731763AbgDNVfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:35:20 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61889C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 14:35:19 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id b13so1312389oti.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 14:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnHk7VpBnwNwlRi2040XE6uitJWwqet8iTZkvolguqg=;
        b=a40M9wPTOSLU/0cGOlCpSJUUPUFrgOrvTKgRLRSYfYuZOzrVhoSZry+eneW9qww53t
         SJYvk3ffq/pNk5fcbHTaFpS7TJJ91ShgYNe3DoajUkQmvbG9EJ9oNB6WGbuwhKNxwbjO
         0uTt2TfuG++4SEP63a8g+exO08GnaRLoDo8EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnHk7VpBnwNwlRi2040XE6uitJWwqet8iTZkvolguqg=;
        b=K72mbdPp4YNsY3TTMsfL9RJlvovzQE6FqcvkF7EafYYh102143OZfIqJkd6PMXH/2n
         bdvyAoQIzTEfFhaoFfSfPv1iNnjRH6H32MfzqAnUlm4/mCrFuvN66jvyyMyIzusKbhNY
         pUzRYrAy79f9NK8cA+ht0PMwXhuxwKhbevCTC8JTrkhv73NRRPwzfLHOc1A+I5VQfY4o
         drZqz+8Qc/GDnn0lMKmnv98pZFs4+Wge9deHYL3HHT8thiVGwh0lFzZbTXjPAU3mZ1m3
         ZHLaZnMnsC7/+W4to0Buphg7obpFNPksD2HsJRSey9zwF/ddtxPBx8lqLAgIkvPfS08R
         86oA==
X-Gm-Message-State: AGi0PuZSLdRqaFIkFu4flojgzV1I7s1BhZ/4BEE5Y+S7GN35NtAEFfV4
        JKuhk5ZIi0bXO24Gq7AyUSAQ4XTDbGjmGGxVqlGDoQ==
X-Google-Smtp-Source: APiQypI6qQXAlBRHe5B9IMx4CI1nKnHqx8bIn0YBS5VQ3pwSBEPndm25wfn72CSzgVVXy729HPVi7V+ESKzncERVfQw=
X-Received: by 2002:a4a:dbc7:: with SMTP id t7mr19942420oou.57.1586900118509;
 Tue, 14 Apr 2020 14:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <855831b59e1b3774b11c3e33050eac4cc4639f06.1583332765.git.vpillai@digitalocean.com>
 <20200414113639.GS20730@hirez.programming.kicks-ass.net>
In-Reply-To: <20200414113639.GS20730@hirez.programming.kicks-ass.net>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Tue, 14 Apr 2020 17:35:07 -0400
Message-ID: <CANaguZDwK6bXvJabt5gS=kLMVsGNf97u50+1-v_t8bJxCrJ6sQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] sched: Core-wide rq->lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Aside from the fact that it's probably much saner to write this as:
>
>         rq->core_enabled = static_key_enabled(&__sched_core_enabled);
>
> I'm fairly sure I didn't write this part. And while I do somewhat see
> the point of disabling core scheduling for a core that has only a single
> thread on, I wonder why we care.
>
I think this change was to fix some crashes which happened due to
uninitialized rq->core if a sibling was offline during boot and is
onlined after coresched was enabled.

https://lwn.net/ml/linux-kernel/20190424111913.1386-1-vpillai@digitalocean.com/

I tried to fix it by initializing coresched members during a cpu online
and tearing it down on a cpu offline. This was back in v3 and do not
remember the exact details. I shall revisit this and see if there is a
better way to fix the race condition above.

Thanks,
Vineeth
