Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83424C55181
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 02:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D0AE2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 02:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MCnsp+oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDVCKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 22:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgDVCKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 22:10:53 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F208C0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 19:10:53 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id g6so366632ybh.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 19:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2tQbdOPCxIE/K09Rk6AnWK5NVIGzgtGeQWhwa+aoWFg=;
        b=MCnsp+oim3XYeA5xLQ0O6mol7X2v17gfJ2/fvRp34u7NVtVAxV09gtDg/l4k2L4ROb
         riYMlKo5ay/ZMVbUJ7+bGwuQAGc78MaGRhc06tX5zCpyfaRmxOcEvTc+Mq96S2b0/0HN
         USL1HSbIGfPZHn5upNxuILkVltbfhf7jrmzj7ffY02kvdrfZHoVYJCb5uaXQ3Uv6XB+Q
         vUtcqm5soQpR51voh0kDtg80SiATM/wNgo1Hau5MNTSsxyawm42OIQow2Ee6qhG+V8WF
         cA7dAeRdOhYxaJv1/iSVFliUQWgtqmw6ALomBDlH6cA8BF/IcmjsO6rxCWTDHMoiBHY6
         xwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2tQbdOPCxIE/K09Rk6AnWK5NVIGzgtGeQWhwa+aoWFg=;
        b=X8GAgHY3AueU8imnHWn2Loo/Q9DTvlFsWNXU/N4QwjXnH4vD16ZnHfQOva5KUQoUMM
         UH6e3Gvz/XbiM/TcD4hJCn/MaWcq8IuPYAMo62rr6OnOkmxRzBB5KEFXf5J2xsR9Dj/H
         JauTAvtLc/eO77L5BNQJIQxp8+LjRi4V5qSwMQpf48JK21CawTA2THHZY4tjm4KpkzNe
         P4X/eYQEf0Hyz8V0ASu7kgM8uNyYsr2SlZkyumsXRN7b1nGXZB+9yX4fdad2KMrMwb08
         yio0DTMzMCEZPGZ74P224N0vkkdRcMLwxLspkz0ZYt3snIi2jb4HY+a9irmlO2d6VA58
         IU/w==
X-Gm-Message-State: AGi0PuawMAeyndhW0NRJfZrNM97q2rFl9iHhN149PxiC695pshO1XJLB
        kXyFNIfEZxpi0sUEWLatKRPQ7sVX2CoMI4oNzosqpg==
X-Google-Smtp-Source: APiQypJWt0jllq8PUpBD1WeSTR4j+afUjLDp5+ewhll1TBEqJx7nHX779bPW4eO07cAv45lmeAP5M8CBx5DfsZYBD1w=
X-Received: by 2002:a5b:383:: with SMTP id k3mr32955292ybp.332.1587521452409;
 Tue, 21 Apr 2020 19:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200422001422.232330-1-walken@google.com> <20200422001422.232330-10-walken@google.com>
In-Reply-To: <20200422001422.232330-10-walken@google.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Tue, 21 Apr 2020 19:10:39 -0700
Message-ID: <CANN689FQf3gMTTXr7vwYujvuoVNDHdRFWWwaBQAdhifeE=zBbg@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] mmap locking API: add mmap_assert_locked
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 5:14 PM Michel Lespinasse <walken@google.com> wrote:
> +static inline void mmap_assert_locked(struct mm_struct *mm)
> +{
> +       if (IS_ENABLED(CONFIG_LOCKDEP) && debug_locks)
> +               VM_BUG_ON_MM(!lockdep_is_held(&mm->mmap_sem), mm);
> +       else
> +               VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
> +}

Turns out this function definition does not work for !CONFIG_LOCKDEP
as lockdep_is_held is not defined in that case.

The following should work instead:

static inline void mmap_assert_locked(struct mm_struct *mm)
{
#ifdef CONFIG_LOCKDEP
        if (debug_locks) {
                VM_BUG_ON_MM(!lockdep_is_held(&mm->mmap_lock), mm);
                return;
        }
#endif
        VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
}
