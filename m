Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05EAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39B5207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+gdJ3Kk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732767AbgF3LAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:00:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57778 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732578AbgF3LAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593514850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YPlk3hHtIg/3QWwatoM9sTH8lwQ8W3Qj2pLZMQRNWLg=;
        b=U+gdJ3KkjXqCHGAZbdF8EWlf+TioLjJT0UdbBivshMr970ZGoWwITsjvQtPMX5zuEbHFCg
        VLkNSIFoc/wHRFT57Cq5jal7cqtccr1VgtsfZjp5zRw43KVn9BC4HtPvU7KV3zL3YBhKVR
        6jOhYXKh8oP14nz0c/BnEKaFuaq4zu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-DRmRpGz4MN2CHU7GK9keoA-1; Tue, 30 Jun 2020 07:00:45 -0400
X-MC-Unique: DRmRpGz4MN2CHU7GK9keoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4FA4188363A;
        Tue, 30 Jun 2020 11:00:41 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3D8260CD1;
        Tue, 30 Jun 2020 11:00:35 +0000 (UTC)
Subject: Re: [PATCH v5] x86/split_lock: Sanitize userspace and guest error
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
References: <20200616113250.2061-1-prarit@redhat.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <11733c3d-056a-e723-c4fe-ec3f55c1e94a@redhat.com>
Date:   Tue, 30 Jun 2020 07:00:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200616113250.2061-1-prarit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just re-pinging on this.

P.

On 6/16/20 7:32 AM, Prarit Bhargava wrote:
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
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
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
> v5: Fix Sign off (sean.j.christopherson)
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

