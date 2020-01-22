Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B5CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56602465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgAVIul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 03:50:41 -0500
Received: from mga17.intel.com ([192.55.52.151]:21206 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgAVIuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:50:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 00:50:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,348,1574150400"; 
   d="scan'208";a="220243214"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by orsmga008.jf.intel.com with ESMTP; 22 Jan 2020 00:50:36 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] perf/core: fix mlock accounting in perf_mmap()
In-Reply-To: <5145CBD8-9CBA-4B26-B48E-2E974E42A28E@fb.com>
References: <20200117234503.1324050-1-songliubraving@fb.com> <87blqybknz.fsf@ashishki-desk.ger.corp.intel.com> <5145CBD8-9CBA-4B26-B48E-2E974E42A28E@fb.com>
Date:   Wed, 22 Jan 2020 10:50:35 +0200
Message-ID: <878slzc1t0.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Liu <songliubraving@fb.com> writes:

> Actually, I think this is cleaner. 

I don't think multiple conditional blocks are cleaner, at least in this
case.

> diff --git i/kernel/events/core.c w/kernel/events/core.c
> index 2173c23c25b4..debd84fcf9cc 100644
> --- i/kernel/events/core.c
> +++ w/kernel/events/core.c
> @@ -5916,14 +5916,18 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>          */
>         user_lock_limit *= num_online_cpus();
>
> -       user_locked = atomic_long_read(&user->locked_vm) + user_extra;
> +       user_locked = atomic_long_read(&user->locked_vm);
>
>         if (user_locked > user_lock_limit) {
> +               /* charge all to pinned_vm */
> +               extra = user_extra;
> +               user_extra = 0;
> +       } else if (user_lock + user_extra > user_lock_limit)

You probably mean "user_locked" here.

>                 /*
>                  * charge locked_vm until it hits user_lock_limit;
>                  * charge the rest from pinned_vm
>                  */
> -               extra = user_locked - user_lock_limit;
> +               extra = user_locked + user_extra - user_lock_limit;

To me, this is a bit harder to read.

>                 user_extra -= extra;
>         }
>
> Alexander, does this look good to you? 

I like to think of this as: we charge the pages to locked_vm until we
exhaust user_lock_limit, and the rest we charge to pinned_vm. Everything
else are just corner cases, and they fit into the same general case. When
we start calculating each corner case in its own block, we just multiply
the potential errors. And there have been errors in this particular path
before. So, the shorter, and the fewer the "if...else if..." statements,
the better it looks to me. Otherwise, it's a matter of preference.

Thanks,
--
Alex
