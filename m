Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9334DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5F822B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgFmpgJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgGTLJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgGTLJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:09:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC604C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 04:09:29 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f2so17382480wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 04:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtD27AzHPjp5ctCB4TnCpfZehd9FARDVSuneqwmIWdA=;
        b=lgFmpgJ+cozNYAJd8bmW/Tgj1KkReN3kUAGRoRoSJBZHzxg2jestmQ3wJxAO6ZsEaw
         Mdk7B8KSGIFOQQxemCmCpTpO2LvFls5YXEBsElq1EnpUG4or77eAhvSGgb5Gq/K21S7U
         35VFEvz2w1bP+Wag6I6Oid7iIhGR9w1aYdccXGqBphLREYcDNCkpOlsFX4kOjAxTvxCS
         alqeOZi933JqdHsvsm4ePn7WqKxN2wW0DKCgXqKS5tO6xW4znhmou2aYo1kli1M0GWY4
         IbQ1yjw6Q1SVnSVUAoJp4RkPgbY4m32bxDHqAa33SwzjtDfevOBHhpPgkDbiz7ZYN6nl
         eriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtD27AzHPjp5ctCB4TnCpfZehd9FARDVSuneqwmIWdA=;
        b=qP6ZbDJfQOkUAJHlBxMBofZmv02Pi73K9HpB6266rcJI6ER0Av4jpNQVo13Ct9g9x/
         F+pirIymEzj/SeA0yn4NG4jsLemA7GznQntjcoCrnCa7n7eRJo+6knQwhX3PjdIYax9M
         mN7qmBkLSFCxpzTlRsTH/kFMh0KRBHmpa3F8psxQLdA+nZpmmH/m2BK8hIoXHOinUCVb
         XKQ/1zvxDnGPyGZgtca/Xf4H47xAlU+R7EC9Sq2HcXOirij8g18tlNPcct1mt4R7qPwH
         9Yxf45r64rtuvwiH4rlWj7K/0TMaXGTC0nIv/+/9Vcvg5MweRzuJXeDkolgXz1EaToWW
         4/3g==
X-Gm-Message-State: AOAM5327ZGuO8kjN/VQ6owU+YLD9gg45JOXewGx3X/WSzwcZvRHfKytq
        BFXOreUWpeCpuEn6whtYlkPX1VwPQfGfDho8Quk=
X-Google-Smtp-Source: ABdhPJywafOCwvKu3ixkl8hVwowbKpQHckqYNaDq9UHJmYWu9rlxdUvKAbh6FtleJp2tv1vlBcww+ORSzMqFW3C9Slc=
X-Received: by 2002:adf:de12:: with SMTP id b18mr23342351wrm.390.1595243368551;
 Mon, 20 Jul 2020 04:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <c783b3890b6df669a72c7c4a3012950d009b8034.1593530334.git.vpillai@digitalocean.com>
 <871rl9r9xr.fsf@nanos.tec.linutronix.de> <20200720035359.GA4187092@google.com>
In-Reply-To: <20200720035359.GA4187092@google.com>
From:   Vineeth Pillai <vineethrp@gmail.com>
Date:   Mon, 20 Jul 2020 07:09:17 -0400
Message-ID: <CAOBnfPj6RjjCn4-+m0sNat30WGEGAVrxz2WHH8JOATEKxSbT5w@mail.gmail.com>
Subject: Re: [RFC PATCH 14/16] irq: Add support for core-wide protection of
 IRQ and softirq
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 11:54 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> These ifdeffery and checkpatch / command line parameter issues were added by
> Vineeth before he sent out my patch. I'll let him comment on these, agreed
> they all need fixing!
>
Will fix this in the next iteration. Regarding the __setup code,
I shamelessly copied it from page_alloc.c during development and
missed reviewing it before sending it out. All valid points and
will fix it with the next iteration.

Thanks,
Vineeth
