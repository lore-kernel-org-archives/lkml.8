Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC9BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D3FB207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591757671;
	bh=HGerrB3rsN14/Bmxk8aDszzY8+afaPZgg24C/g+8cKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Mexe14OTna00Y+ANyPT8iwFmz4AIla175HtgTBq8cpxgKljwDri060pDFq7QNE7hB
	 Y8hA5Mnmg5lLMIRjlBMWxL4/llgCO6A+RMYcM5SnzhMutX4NFXxF/rU+vhwD2tA0qx
	 BNeYjVYwiCBPCrJLkByVaxY3VQ90NHJyXXTnlD68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFJCya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 22:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgFJCy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 22:54:27 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 165D620691
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591757666;
        bh=HGerrB3rsN14/Bmxk8aDszzY8+afaPZgg24C/g+8cKA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Byi1G3a2VJnZ0ke0XUMn5YDbiMuqHX2fkcH/qOteFehGlrXiHSMYe2ChWnmP9kRTb
         RDhdH4Yb05V/sQuTzke4YQdloW8x3+9L8rIZk8oM4+p/ullxbOnw+fbV2aueS61/Ng
         fmMf8+mwQx62lUoylu+x+ZM5tsTCU8rrPmGgZTP4=
Received: by mail-lj1-f181.google.com with SMTP id 9so579696ljv.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 19:54:26 -0700 (PDT)
X-Gm-Message-State: AOAM531tbUa/ywbcOqSnblqvvpw6Pd2QTErOfInYGm2iGhJXY02iFsQf
        tpvoRIyEitAJLXYQb8dufuJLbvucyKbIPsj+FW0=
X-Google-Smtp-Source: ABdhPJw5h/p4ZSswGrz0c5p/YBKNU1m3d44QnA01OG+hfFVYGGY+I9ldl/sbjIRf9N2LIzX6ACrwAuU6NdWlSPXQhDA=
X-Received: by 2002:a2e:5cc9:: with SMTP id q192mr571864ljb.66.1591757664456;
 Tue, 09 Jun 2020 19:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whQt69ApMkZF8b2Q2idMDgPpPETZeeOuZg59CrOO4025w@mail.gmail.com>
 <20200428091149.GB19958@linux.vnet.ibm.com> <20200428123914.GA27920@redhat.com>
 <20200504164724.GA28697@redhat.com>
In-Reply-To: <20200504164724.GA28697@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 10 Jun 2020 10:54:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQjtANxE-CB=iJmxYXwALsfhHo-16vw25V6SVr728nb3w@mail.gmail.com>
Message-ID: <CAJF2gTQjtANxE-CB=iJmxYXwALsfhHo-16vw25V6SVr728nb3w@mail.gmail.com>
Subject: Re: [PATCH] uprobes: ensure that uprobe->offset and ->ref_ctr_offset
 are properly aligned
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Security Officers <security@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On Tue, May 5, 2020 at 12:47 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> uprobe_write_opcode() must not cross page boundary; prepare_uprobe()
> relies on arch_uprobe_analyze_insn() which should validate "vaddr" but
> some architectures (csky, s390, and sparc) don't do this.
>
> We can remove the BUG_ON() check in prepare_uprobe() and validate the
> offset early in __uprobe_register(). The new IS_ALIGNED() check matches
> the alignment check in arch_prepare_kprobe() on supported architectures,
> so I think that all insns must be aligned to UPROBE_SWBP_INSN_SIZE.
>
> Another problem is __update_ref_ctr() which was wrong from the very
> beginning, it can read/write outside of kmap'ed page unless "vaddr" is
> aligned to sizeof(short), __uprobe_register() should check this too.
>
> Cc: stable@vger.kernel.org
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/events/uprobes.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index ece7e13f6e4a..cc2095607c74 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -867,10 +867,6 @@ static int prepare_uprobe(struct uprobe *uprobe, struct file *file,
>         if (ret)
>                 goto out;
>
> -       /* uprobe_write_opcode() assumes we don't cross page boundary */
> -       BUG_ON((uprobe->offset & ~PAGE_MASK) +
> -                       UPROBE_SWBP_INSN_SIZE > PAGE_SIZE);
> -
>         smp_wmb(); /* pairs with the smp_rmb() in handle_swbp() */
>         set_bit(UPROBE_COPY_INSN, &uprobe->flags);
>
> @@ -1166,6 +1162,15 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
>         if (offset > i_size_read(inode))
>                 return -EINVAL;
>
> +       /*
> +        * This ensures that copy_from_page(), copy_to_page() and
> +        * __update_ref_ctr() can't cross page boundary.
> +        */
> +       if (!IS_ALIGNED(offset, UPROBE_SWBP_INSN_SIZE))
> +               return -EINVAL;
> +       if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
> +               return -EINVAL;
> +
>   retry:
>         uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
>         if (!uprobe)
> @@ -2014,6 +2019,9 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
>         uprobe_opcode_t opcode;
>         int result;
>
> +       if (WARN_ON_ONCE(!IS_ALIGNED(vaddr, UPROBE_SWBP_INSN_SIZE)))
> +               return -EINVAL;
> +
>         pagefault_disable();
>         result = __get_user(opcode, (uprobe_opcode_t __user *)vaddr);
>         pagefault_enable();
> --
> 2.25.1.362.g51ebf55
>
>
Looks good to me, thx.

Reviewed-by: Guo Ren <guoren@kernel.org>

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
