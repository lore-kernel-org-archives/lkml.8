Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58235C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C1E820737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898160AbgDOMjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:39:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60740 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369922AbgDOMiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:38:19 -0400
Received: from ip5f5bd698.dynamic.kabel-deutschland.de ([95.91.214.152] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jOhJ2-0004cX-9y; Wed, 15 Apr 2020 12:38:16 +0000
Date:   Wed, 15 Apr 2020 14:38:15 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] clone3: fix cgroup argument sanity check
Message-ID: <20200415123815.qrc7m2ddboh645uo@wittgenstein>
References: <20200412202533.GA29554@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200412202533.GA29554@asgard.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 10:25:33PM +0200, Eugene Syromiatnikov wrote:
> Checking that cgroup field value of struct clone_args is less than 0
> is useless, as it is defined as unsigned 64-bit integer.  Moreover,
> it doesn't catch the situations where its higher bits are lost during
> the assignment to the cgroup field of the cgroup field of the internal
> struct kernel_clone_args (where it is declared as signed 32-bit
> integer), so it is still possible to pass garbage there.  A check
> against INT_MAX solves both these issues.
> 
> Fixes: ef2c41cf38a7559b ("clone3: allow spawning processes into cgroups")
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Applied, thanks!
Christian
