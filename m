Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDABC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9414A2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYFXRr95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbgFIPah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:30:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49109 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729027AbgFIPae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591716633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wGxRHo37DUWltmqxVTCqF+4Rh476hZizMv40WbrLKUk=;
        b=EYFXRr95zYucfXj2XDHB3vG6FlgG+lhxbwKOJd/DaIZ3xlAaFbhZVplu0CbwT9xJUzsbuu
        2nVL/QKBMNbQTbX9i2uNCRcNw+ygrqKoupVbFJORPoy5wNhMBO1dsBzySe716mPRzZnVu2
        X81yYncgdrBcKPXeMFYddm8wLNuk9gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-NsbE5nCNPHSLrjQlepNvhA-1; Tue, 09 Jun 2020 11:30:31 -0400
X-MC-Unique: NsbE5nCNPHSLrjQlepNvhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82EB51940920;
        Tue,  9 Jun 2020 15:30:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.154])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2BCFE5C1D2;
        Tue,  9 Jun 2020 15:30:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  9 Jun 2020 17:30:28 +0200 (CEST)
Date:   Tue, 9 Jun 2020 17:30:20 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Guo Ren <guoren@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: ensure that uprobe->offset and ->ref_ctr_offset
 are properly aligned
Message-ID: <20200609153020.GB17951@redhat.com>
References: <CAHk-=whQt69ApMkZF8b2Q2idMDgPpPETZeeOuZg59CrOO4025w@mail.gmail.com>
 <20200428091149.GB19958@linux.vnet.ibm.com>
 <20200428123914.GA27920@redhat.com>
 <20200504164724.GA28697@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504164724.GA28697@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like this patch was forgotten...

Should I resend it?

On 05/04, Oleg Nesterov wrote:
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
>  	if (ret)
>  		goto out;
>  
> -	/* uprobe_write_opcode() assumes we don't cross page boundary */
> -	BUG_ON((uprobe->offset & ~PAGE_MASK) +
> -			UPROBE_SWBP_INSN_SIZE > PAGE_SIZE);
> -
>  	smp_wmb(); /* pairs with the smp_rmb() in handle_swbp() */
>  	set_bit(UPROBE_COPY_INSN, &uprobe->flags);
>  
> @@ -1166,6 +1162,15 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
>  	if (offset > i_size_read(inode))
>  		return -EINVAL;
>  
> +	/*
> +	 * This ensures that copy_from_page(), copy_to_page() and
> +	 * __update_ref_ctr() can't cross page boundary.
> +	 */
> +	if (!IS_ALIGNED(offset, UPROBE_SWBP_INSN_SIZE))
> +		return -EINVAL;
> +	if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
> +		return -EINVAL;
> +
>   retry:
>  	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
>  	if (!uprobe)
> @@ -2014,6 +2019,9 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
>  	uprobe_opcode_t opcode;
>  	int result;
>  
> +	if (WARN_ON_ONCE(!IS_ALIGNED(vaddr, UPROBE_SWBP_INSN_SIZE)))
> +		return -EINVAL;
> +
>  	pagefault_disable();
>  	result = __get_user(opcode, (uprobe_opcode_t __user *)vaddr);
>  	pagefault_enable();
> -- 
> 2.25.1.362.g51ebf55
> 

