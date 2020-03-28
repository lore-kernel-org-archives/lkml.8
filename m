Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4E0C2D0E8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7174206F2
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmG8Fngn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgC1I6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 04:58:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38575 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgC1I6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:58:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id s1so14563724wrv.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=Hk5QBHZRLForL8IxdtPFDonNjjnSHHBgQoFEVQhsiQE=;
        b=bmG8FngnsfMDZyGz2Y6aVfpwS39pal1GzSzJT10vD/VQP8zANP3T8IvGfYv4Zjgi05
         /uzFC5g9p37PW1zl570eNkWfWRZZAFMA3Krt24bMpWObQ9PsMEFS+4nh0/vP8yhwPvlz
         2+3ggo6hW6g6JF2mB557BQRXc6RXD4lQ6w8WfZcIz0ynws/O2xREammWSbnIPzXlrjOS
         IiGXQ/2R2ir7JuMpoIn7FLct33kVvpCT9rC9RqFjYtfizOvPV494/gYxDMhRVhdCaVSQ
         JlQhXTqy2bDnlc2scjOFjUQ15JUqfhDS6JDYAZ005IrvdyOmSknQpYcB9VI1Fy+1Iktw
         KfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=Hk5QBHZRLForL8IxdtPFDonNjjnSHHBgQoFEVQhsiQE=;
        b=eXUE3E/OMi9RGMtvEKcevf++i8OT9tidoN4a8xitf19cqV0sOa7QbLwjKdo/nWG80j
         R9hYKR0H69JkUyq70gC24pDw72ejsNTEwG8d9VattMq+KByVa7r6JNl/vziU7+SIFWNU
         crfJsY7tuHsP8bjOQQOI9wYWmdoFgg4Og5dgRPc3FeZMTaQcvaV7v6fdeu8XTm1RL3Ie
         WuUIGMeVJ6654EJKP8KjUrS0/Z2H+AAcF/TOpoHE6kGNMoiKXxv/oj11h3eKW+dAw3NZ
         aB8nGz9nlgPALDeMQKB7ZGf1n6GhqTjB3w3O2Ymkck088ZquPt5JAidYvnpitHgWcJqt
         jSBQ==
X-Gm-Message-State: ANhLgQ1pB8gmCALzDs0JNewud5MI1RfS4cHHoYmViFtochft7Alpsc7C
        r+vj2a1eZ8DOc8kOauk7p6M=
X-Google-Smtp-Source: ADFU+vvjdn14hIYWcgsmK8E3RUBnSIQAXrVnIl8g3DoIgmCHozbkYVS3i+s4E4s0vbmRyZ/R2e0Ofg==
X-Received: by 2002:adf:b1c1:: with SMTP id r1mr3610121wra.337.1585385884481;
        Sat, 28 Mar 2020 01:58:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:903b:8e3c:b688:90ef])
        by smtp.gmail.com with ESMTPSA id 189sm7766207wme.31.2020.03.28.01.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 01:58:03 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3 01/10] mmap locking API: initial implementation as rwsem wrappers (Michel Lespinasse)
Date:   Sat, 28 Mar 2020 09:57:46 +0100
Message-Id: <20200328085746.4773-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327225102.25061-2-walken@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-27T15:50:53-07:00 Michel Lespinasse <walken@google.com> wrote:

> This change wraps the existing mmap_sem related rwsem calls into a new
> mmap locking API. There are two justifications for the new API:
> 
> - At first, it provides an easy hooking point to instrument mmap_sem
>   locking latencies independently of any other rwsems.
> 
> - In the future, it may be a starting point for replacing the rwsem
>   implementation with a different one, such as range locks.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>
> ---
>  include/linux/mm.h        |  1 +
>  include/linux/mmap_lock.h | 54 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>  create mode 100644 include/linux/mmap_lock.h
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c54fb96cb1e6..2f13c9198999 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -15,6 +15,7 @@
>  #include <linux/atomic.h>
>  #include <linux/debug_locks.h>
>  #include <linux/mm_types.h>
> +#include <linux/mmap_lock.h>
>  #include <linux/range.h>
>  #include <linux/pfn.h>
>  #include <linux/percpu-refcount.h>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> new file mode 100644
> index 000000000000..8b5a3cd56118
> --- /dev/null
> +++ b/include/linux/mmap_lock.h
> @@ -0,0 +1,54 @@
> +#ifndef _LINUX_MMAP_LOCK_H
> +#define _LINUX_MMAP_LOCK_H
> +
> +static inline void mmap_init_lock(struct mm_struct *mm)
> +{
> +	init_rwsem(&mm->mmap_sem);
> +}
> +
> +static inline void mmap_write_lock(struct mm_struct *mm)
> +{
> +	down_write(&mm->mmap_sem);
> +}
> +
> +static inline int mmap_write_lock_killable(struct mm_struct *mm)
> +{
> +	return down_write_killable(&mm->mmap_sem);
> +}
> +
> +static inline bool mmap_write_trylock(struct mm_struct *mm)
> +{
> +	return down_write_trylock(&mm->mmap_sem) != 0;
> +}
> +
> +static inline void mmap_write_unlock(struct mm_struct *mm)
> +{
> +	up_write(&mm->mmap_sem);
> +}
> +
> +static inline void mmap_downgrade_write_lock(struct mm_struct *mm)
> +{
> +	downgrade_write(&mm->mmap_sem);
> +}
> +
> +static inline void mmap_read_lock(struct mm_struct *mm)
> +{
> +	down_read(&mm->mmap_sem);
> +}
> +
> +static inline int mmap_read_lock_killable(struct mm_struct *mm)
> +{
> +	return down_read_killable(&mm->mmap_sem);
> +}
> +
> +static inline bool mmap_read_trylock(struct mm_struct *mm)
> +{
> +	return down_read_trylock(&mm->mmap_sem) != 0;
> +}
> +
> +static inline void mmap_read_unlock(struct mm_struct *mm)
> +{
> +	up_read(&mm->mmap_sem);
> +}
> +
> +#endif /* _LINUX_MMAP_LOCK_H */

Reviewed-by: SeongJae Park <sjpark@amazon.de>

> -- 
> 2.26.0.rc2.310.g2932bb562d-goog
> 
