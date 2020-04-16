Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E131C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 19:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B4C21BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 19:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="H5k+RhY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgDPT7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 15:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727827AbgDPT7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 15:59:23 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5969C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 12:59:23 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m13so4138507otf.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 12:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7WfBtoIVEC6/j56YyjZAfJnwgvU6tH//snMSSsZQdVE=;
        b=H5k+RhY3rqGx6ykjoJzaZK21rQLgeYa3k6y8fbOlbi2WteJHRLJi5EP/kAjemUxPcx
         9qwqpetBbT3EDhsDs8VkHDLV9VoNlGwqJlAHDoLRLm0olBD+RlI3SUK6C648J6kQpeGS
         r271tkeq6UGk+XKTV947ChBjo3Ga+UCN45UY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7WfBtoIVEC6/j56YyjZAfJnwgvU6tH//snMSSsZQdVE=;
        b=ZKAasGGPYI0DxFjDoBA5WjLBhaBX9QAOrjCeOeXtNe7c/+C46qQzyHX8CDQ9sBgDPV
         w0jfElbc1GmGGYwEFPUXIW8uMAN4JiQWbnmmLJEWJ8CAs7n0wNtTBd8L3hgHUALy6KKl
         HgEe/tLgpjX4wQSahVp200nKPst2lmFE9e/l4CyZv2daj5hv2TA6To7SWbB2yPVCJ5uC
         x6JWj3K/Um5tZOys1b8Bk4SDo0LigKqvxKQEF7SA3ScJ3FP/TNWL9fdkyJxPMZQvJc+K
         1G/T+HRv6eJwDzkw8uZ5279lem9kUgRgbiQwps2gYoNuee+M2YiNx54mFsHo6+OeLRwF
         289A==
X-Gm-Message-State: AGi0PuY52nRkmZ5kroOAsG4W3AJP3UnFpjKYrM4MpRQXqAeJXuWXh8g8
        IH1r61BI2QLJzQY8mCrOz4Kc0lt8rfziJM9ReiOfBQ==
X-Google-Smtp-Source: APiQypI7UkXURQxQBK+fW+I4P8ZYrI0brlWeIvLukyl6Upjgw4+FXuKkVVtwPjZ7LItpYuWCdZIRAZSo2Qk6fSH4UHI=
X-Received: by 2002:a05:6830:155a:: with SMTP id l26mr13773909otp.246.1587067162790;
 Thu, 16 Apr 2020 12:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <e942da7fd881977923463f19648085c1bfaa37f8.1583332765.git.vpillai@digitalocean.com>
 <20200416033804.GA5712@HP-G1>
In-Reply-To: <20200416033804.GA5712@HP-G1>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Thu, 16 Apr 2020 15:59:11 -0400
Message-ID: <CANaguZC+yKkPNcb65hOWjbhmpdP3zp8SdXf0xuvDeV9kEeqnsw@mail.gmail.com>
Subject: Re: [RFC PATCH 07/13] sched: Add core wide task selection and scheduling.
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Joel Fernandes <joel@joelfernandes.org>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Long Cui <long.cui@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Vineeth,
> An NULL pointer exception was found when testing V5 on top of stable
> v5.6.2. And we tried the patch Peter suggested, the NULL pointer
> was not found so far. We don't know if this change would help mitigate
> the symptom, but it should do no harm to test with this fix applied.
>

Thanks for the patch Chenyu!

I was also looking into this as part of addressing Peter's comments. I
shall include this patch in v6 along with addressing all the issues
that Peter pointed out in this thread.

Thanks,
Vineeth
