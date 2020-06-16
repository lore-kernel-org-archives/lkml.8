Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A4BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E40E20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agRdMFas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgFPL2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:28:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31347 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728176AbgFPL2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592306918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8XrojXvGsQrzvO/Ri1rEyqqDQsXzc/MuTUzoBCmek2U=;
        b=agRdMFaspM9Nwa54S/L6hn5jNs9/RrbGaKFjSlzSF9gePzO7yBMQhhNlM8LvrxfmipCVxU
        MNQVfVpEUqtUdmv7+bWbMr2ijVu3jZ+MzbvA89Nnz7zTJusOaOfo0iizK0sxyLAaLG2NUW
        NShuqMXBWC8dSV0sdLwoXXMHB+O/lNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-Ivfosb3VPqqUSd4F1p0T2w-1; Tue, 16 Jun 2020 07:28:35 -0400
X-MC-Unique: Ivfosb3VPqqUSd4F1p0T2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DF3E835B5A;
        Tue, 16 Jun 2020 11:28:33 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F32C378F0F;
        Tue, 16 Jun 2020 11:28:31 +0000 (UTC)
Subject: Re: [PATCH v4] x86/split_lock: Sanitize userspace and guest error
 output
To:     linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20200616112702.1703-1-prarit@redhat.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <f9d8edb6-97f7-13c2-008b-8be8ff69604a@redhat.com>
Date:   Tue, 16 Jun 2020 07:28:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200616112702.1703-1-prarit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was sent in error.

Sorry,

P.


On 6/16/20 7:27 AM, Prarit Bhargava wrote:
> There are two problems with kernel messages in fatal mode that were found
> during testing of guests and userspace programs.
> 
> The first is that no kernel message is output when the split lock detector
> is triggered with a userspace program.  As a result the userspace process
> dies from receiving SIGBUS with no indication to the user of what caused
> the process to die.
> 
> The second problem is that only the first triggering guest causes a kernel
> message to be output because the message is output with pr_warn_once().
> This also results in a loss of information to the user.
> 
> While fixing these I noticed that the same message was being output
> three times so I'm cleaning that up too.
> 
> Fix fatal mode output, and use consistent messages for fatal and
> warn modes for both userspace and guests.
> 
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> ---
> v2: Do not output a message if CPL 3 Alignment Check is turned on (xiaoyao.li)
> v3: refactor code (sean.j.christopherson)
> v4: Fix Sign off (sean.j.christopherson)
> 
>  arch/x86/kernel/cpu/intel.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 63926c94eb5f..3a373f0be674 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -1074,11 +1074,14 @@ static void split_lock_init(void)
>  	split_lock_verify_msr(sld_state != sld_off);
>  }
>  
> -static void split_lock_warn(unsigned long ip)
> +static bool handle_split_lock(unsigned long ip)
>  {
> -	pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
> +	pr_warn("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
>  			    current->comm, current->pid, ip);
>  
> +	if (sld_state != sld_warn)
> +		return false;
> +
>  	/*
>  	 * Disable the split lock detection for this task so it can make
>  	 * progress and set TIF_SLD so the detection is re-enabled via
> @@ -1086,18 +1089,13 @@ static void split_lock_warn(unsigned long ip)
>  	 */
>  	sld_update_msr(false);
>  	set_tsk_thread_flag(current, TIF_SLD);
> +	return true;
>  }
>  
>  bool handle_guest_split_lock(unsigned long ip)
>  {
> -	if (sld_state == sld_warn) {
> -		split_lock_warn(ip);
> +	if (handle_split_lock(ip))
>  		return true;
> -	}
> -
> -	pr_warn_once("#AC: %s/%d %s split_lock trap at address: 0x%lx\n",
> -		     current->comm, current->pid,
> -		     sld_state == sld_fatal ? "fatal" : "bogus", ip);
>  
>  	current->thread.error_code = 0;
>  	current->thread.trap_nr = X86_TRAP_AC;
> @@ -1108,10 +1106,10 @@ EXPORT_SYMBOL_GPL(handle_guest_split_lock);
>  
>  bool handle_user_split_lock(struct pt_regs *regs, long error_code)
>  {
> -	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
> +	if (regs->flags & X86_EFLAGS_AC)
>  		return false;
> -	split_lock_warn(regs->ip);
> -	return true;
> +
> +	return handle_split_lock(regs->ip);
>  }
>  
>  /*
> 

