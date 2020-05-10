Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F167BC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 21:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD21F20708
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 21:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="K7kiQedz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgEJV1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 17:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728823AbgEJV1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 17:27:45 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB4EC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 14:27:44 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id z90so6364769qtd.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AjJla7ef1KOTTwImARPcnvepPnsINer0cTmrGksfAhk=;
        b=K7kiQedzlUVkQxQmJUldUTnHzJ3a45gjghGi8fKcjYi94VuXrGQBjQqXQntOJWaZHa
         u32EfUywzsbHRpTKA1rIw3uPHF5OfyKzNcb/dVFblyMH4wkxTsgDk5HjOqB1PJiaVai9
         mTyxj3/sgh1VGBQsIR57Fs3A4jPvuD8rqVnLwRt2C9WFefv5Buw4sJEQGoK8Zd14F1c1
         6wmjUlUYHpq/ADAh5FANLrU8coI97xUgqnuhvFO2JhbOAAuGfrZ6l5qxh76EztcohwSr
         PIbUO1S2HsLKORAlkdbbe8gVe9JcYLqeKSsb44JaDznoPpzw4m6JhHhkcAd7Ap0f6N1Z
         bWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AjJla7ef1KOTTwImARPcnvepPnsINer0cTmrGksfAhk=;
        b=hibgtFKiaQzljOIEWz/gT+xn8sskVcMv70yigi5OZcZxP1Wp2J26Nizv78+EBpl9bD
         MWrKTtZrtc0uq/J89Yxi72F77cEwFWQ8yENK3PUqe1b783isGYHJTJge75PWKcrwK3M0
         B3H2UGJ9StBl3CMwjiNjWCNgi3KB7Ljjr8oEupLJc+SLWMX8KM7jRD1J929KTieYisnM
         aFYRh3cV85MdvidSzhAu86pPX4bbCkz9XY/nEb02IlNydKiyg/K+2h8CUK4KXEEjAzqT
         wtAUF/ieK+0OrLEMxdcqiPmFgyvWE1pxLzmN2EREyV7jj7A1VOpTyyfl+/hb8sU1gqGF
         8kBw==
X-Gm-Message-State: AGi0Pub5gro3U1JSEz6zeKvppGOmDCiMYGAIcbYK++2wjybA/LRWRlCF
        3O5FDQBwxbft664/+RaXmgJipiy/d1Sd7A==
X-Google-Smtp-Source: APiQypLkXsE6IrU7DeD/pU/2Ma4YByxhvAoLSqnDk+a3L5ueoZYzVOpQvaCCsMjG1Op6IniFakof8A==
X-Received: by 2002:ac8:f10:: with SMTP id e16mr13001033qtk.89.1589146062865;
        Sun, 10 May 2020 14:27:42 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c26sm6605618qkm.98.2020.05.10.14.27.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 May 2020 14:27:42 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Kmemleak infrastructure improvement for task_struct leaks and
 call_rcu() 
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200509094455.GA4351@gaia>
Date:   Sun, 10 May 2020 17:27:41 -0400
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3F734E14-8E37-4967-B080-A25D0C58199C@lca.pw>
References: <20200507171607.GD3180@gaia>
 <40B2408F-05DD-4A82-BF97-372EA09FA873@lca.pw> <20200509094455.GA4351@gaia>
To:     Catalin Marinas <catalin.marinas@arm.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 9, 2020, at 5:44 AM, Catalin Marinas <catalin.marinas@arm.com> =
wrote:
>=20
> On Thu, May 07, 2020 at 01:29:04PM -0400, Qian Cai wrote:
>> On May 7, 2020, at 1:16 PM, Catalin Marinas <catalin.marinas@arm.com> =
wrote:
>>> I don't mind adding additional tracking info if it helps with =
debugging.
>>> But if it's for improving false positives, I'd prefer to look deeper
>>> into figure out why the pointer reference graph tracking failed.
>>=20
>> No, the task struct leaks are real leaks. It is just painful to =
figure
>> out the missing or misplaced put_task_struct() from the kmemleak
>> reports at the moment.
>=20
> We could log the callers to get_task_struct() and put_task_struct(),
> something like __builtin_return_address(0) (how does this work if the
> function is inlined?). If it's not the full backtrace, it shouldn't =
slow
> down kmemleak considerably. I don't think it's worth logging only the
> first/last calls to get/put. You'd hope that put is called in reverse
> order to get.
>=20
> I think it may be better if this is added as a new allocation pointed =
to
> from kmemleak_object rather than increasing this structure since it =
will
> be added on a case by case basis. When dumping the leak information, =
it
> would also dump the get/put calls, in the order they were called. We
> could add some simple refcount tracking (++ for get, -- for put) to
> easily notice any imbalance.
>=20
> I'm pretty busy next week but happy to review if you have a patch ;).

I am still thinking about a more generic way for all those =
refcount-based leaks without needing of manual annotation of all those =
places. Today, I had another one,

unreferenced object 0xe6ff008924f28500 (size 128):
  comm "qemu-kvm", pid 4835, jiffies 4295141828 (age 6944.120s)
  hex dump (first 32 bytes):
    01 00 00 00 6b 6b 6b 6b 00 00 00 00 ad 4e ad de  ....kkkk.....N..
    ff ff ff ff 6b 6b 6b 6b ff ff ff ff ff ff ff ff  ....kkkk........
  backtrace:
    [<000000005ed1a868>] slab_post_alloc_hook+0x74/0x9c
    [<00000000c65ee7dc>] kmem_cache_alloc_trace+0x2b4/0x3d4
    [<000000009efa9e6e>] do_eventfd+0x54/0x1ac
    [<000000001146e724>] __arm64_sys_eventfd2+0x34/0x44
    [<0000000096fc3a61>] do_el0_svc+0x128/0x1dc
    [<000000005ae8f980>] el0_sync_handler+0xd0/0x268
    [<0000000043f2c790>] el0_sync+0x164/0x180

That is eventfd_ctx_fileget() / eventfd_ctx_put() pairs.=
