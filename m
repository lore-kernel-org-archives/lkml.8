Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946DEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A922075B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHhPMGJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgH0BUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 21:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgH0BUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:20:16 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD72C0617A1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:20:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c19so2662260wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5FMcDpz0D9FOa8ovi1m1pj680ZF4vzx0JKLeakxCl8g=;
        b=sHhPMGJZKhoZl9E6ibc5sGV9yVoA1R5vn5BZkFW0CCwDBYCa48o7bsrdSnEtv1/1D3
         7DXFn3bID4AHUku/qfIy5qFu4dUJk2Leiv3wa85p68KTVksTRHMilsNa3WklAzglNTix
         ZDXCwkheHVRlVRMDMTAqu111C78EGMFzMJfvr6PL/mPbk2AmvxBsatqGSOWu9nsoKdAV
         lFmTUIbgQd8xhRcTQ185enQ4dz45R/ck5Cv1+ZcgeBxNb//Nj8dXGI4jP4DthiutU2Kp
         GZpmW7J/dSW5yFJQKfwFw4dBFAEFm5fujK1Fa3tq4TsTyL72hNr5KJ+6Tr36ADF8ge8L
         BrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5FMcDpz0D9FOa8ovi1m1pj680ZF4vzx0JKLeakxCl8g=;
        b=qnuzRWRTLceq6hlw2E7qbeliKMYtFB1Pt21+N980B7BluSXhHxkNE6Xeby9WaFiT8G
         YhKhlUpCLSOWFnrxXXh6EVXQ+TaQ5ImAzuHJEUBHwrYompZD8/vRNKJEVe9SJNu+Qc84
         iqPWjYe2rCNklUIZ5JfJZmMLKQ83EURfkkDhy2/x5WGr08YLWluaCjUw1aqCEwZ/OsBJ
         FXYjboEAEnKU/aMC6AVyLwWLSzWCn5PQgv+3wKY2Z3JTxzI8mh6v2xlvNwYZPkGRxH4c
         LgUaT5p/o0u+514hC2QxCC6iDihnNijuW13g98haGqGcr74DAm1WtOvgjIZjtlZ4InGH
         a2bA==
X-Gm-Message-State: AOAM533Cis6P3mRevILUqfKyZVzfaEr4x6eKkfnXYg+9bMWnbqsTRsk9
        HmXPaXnCxX8FF1YTPlSG/OcYeue5GaBp0v3zRk8=
X-Google-Smtp-Source: ABdhPJw5Y29uUy0y/pMbXcc6kgLPImFsUwAhGpSLVPDzQLhqCOt3z9Pn9Xdj6bUQs0ULVNz9wRdeg1p/FU8vhkAwR/U=
X-Received: by 2002:a1c:f70e:: with SMTP id v14mr9389274wmh.74.1598491214400;
 Wed, 26 Aug 2020 18:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593530334.git.vpillai@digitalocean.com> <c4556033-4d78-0419-0114-a17f68456ec8@amazon.com>
In-Reply-To: <c4556033-4d78-0419-0114-a17f68456ec8@amazon.com>
From:   Vineeth Pillai <vineethrp@gmail.com>
Date:   Wed, 26 Aug 2020 21:20:03 -0400
Message-ID: <CAOBnfPj_mbSJNAy8b50yZ1jN+aroSekfKNTPsG8f5WQFUbENEg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/16] Core scheduling v6
To:     Alexander Graf <graf@amazon.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

>
> As discussed during Linux Plumbers, here is a small repo with test
> scripts and applications that I've used to look at core scheduling
> unfairness:
>
>    https://github.com/agraf/schedgaps
>
Thanks for sharing :).

> Please let me know if it's unclear how to use it or if you see issues in
> your environment.
>
Will give it a try soon and let you know. Went through the
README quickly and documentation is very clear.

This is really helpful and would be really useful in future
testing as well.

Thanks,
Vineeth
