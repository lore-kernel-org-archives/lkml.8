Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB09DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924D6206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wztkq6T1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgFJPHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:07:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37514 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726081AbgFJPHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591801640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PWDev/u3hjr273VuifVX8zNUbNFXR9kYhrB8QSfR8HU=;
        b=Wztkq6T1GRWk5sDYJqYXfhL42pAlZjUex9Vo7VBGUQ8Af4iorp1oQJI09V7vvV8Rja17RK
        HNALMMXV/qffXMqObFnrGt+N86Y54mr0A6WApA1u1M0E88vN8Z75XayHcYoo1FRK/jhimL
        iWaTNldsiDjar4cqtB7cBrMv+fmQ+J8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-gdTGQtgkPYenzHkXd_Z-oA-1; Wed, 10 Jun 2020 11:07:13 -0400
X-MC-Unique: gdTGQtgkPYenzHkXd_Z-oA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46791107ACF6;
        Wed, 10 Jun 2020 15:07:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.117])
        by smtp.corp.redhat.com (Postfix) with SMTP id CACEC8FF62;
        Wed, 10 Jun 2020 15:07:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 10 Jun 2020 17:07:10 +0200 (CEST)
Date:   Wed, 10 Jun 2020 17:07:03 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     Jan Kratochvil <jan.kratochvil@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH? v2] powerpc: Hard wire PT_SOFTE value to 1 in gpr_get()
 too
Message-ID: <20200610150224.GA6793@redhat.com>
References: <20190917121256.GA8659@redhat.com>
 <20190917143753.GA12300@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917143753.GA12300@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

looks like this patch was forgotten.

Do you think this should be fixed or should we document that
PTRACE_GETREGS is not consistent with PTRACE_PEEKUSER on ppc64?


On 09/17, Oleg Nesterov wrote:
>
> I don't have a ppc machine, this patch wasn't even compile tested,
> could you please review?
> 
> The commit a8a4b03ab95f ("powerpc: Hard wire PT_SOFTE value to 1 in
> ptrace & signals") changed ptrace_get_reg(PT_SOFTE) to report 0x1,
> but PTRACE_GETREGS still copies pt_regs->softe as is.
> 
> This is not consistent and this breaks
> http://sourceware.org/systemtap/wiki/utrace/tests/user-regs-peekpoke
> 
> Reported-by: Jan Kratochvil <jan.kratochvil@redhat.com>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  arch/powerpc/kernel/ptrace.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 8c92feb..291acfb 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -363,11 +363,36 @@ static int gpr_get(struct task_struct *target, const struct user_regset *regset,
>  	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
>  		     offsetof(struct pt_regs, msr) + sizeof(long));
>  
> +#ifdef CONFIG_PPC64
> +	if (!ret)
> +		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> +					  &target->thread.regs->orig_gpr3,
> +					  offsetof(struct pt_regs, orig_gpr3),
> +					  offsetof(struct pt_regs, softe));
> +
> +	if (!ret) {
> +		unsigned long softe = 0x1;
> +		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &softe,
> +					  offsetof(struct pt_regs, softe),
> +					  offsetof(struct pt_regs, softe) +
> +					  sizeof(softe));
> +	}
> +
> +	BUILD_BUG_ON(offsetof(struct pt_regs, trap) !=
> +		     offsetof(struct pt_regs, softe) + sizeof(long));
> +
> +	if (!ret)
> +		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> +					  &target->thread.regs->trap,
> +					  offsetof(struct pt_regs, trap),
> +					  sizeof(struct user_pt_regs));
> +#else
>  	if (!ret)
>  		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
>  					  &target->thread.regs->orig_gpr3,
>  					  offsetof(struct pt_regs, orig_gpr3),
>  					  sizeof(struct user_pt_regs));
> +#endif
>  	if (!ret)
>  		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
>  					       sizeof(struct user_pt_regs), -1);
> -- 
> 2.5.0
> 

