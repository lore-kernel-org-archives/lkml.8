Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BACCC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E19B2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5dBlrRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgAUOQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:16:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50074 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728794AbgAUOQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:16:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579616170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1Iox2UNBVPh44/eW8JBNmEf1nULR28PH79pAJpqy9k=;
        b=J5dBlrRqn0pVFKkyDM4Pvf2czwxdjg7l29LshGiXPGPCLwAFsHq1SDwOUIFuDBwzxi2RRt
        D/G1SvkKYSZA1HEPn/Yd5oj5IdUje16JNqCUuQZRwlYBGNNTQM7L83r1mj8uQDQc8s0hrM
        0qzOoT36YnyZmAoAuUBSDrIV38McpM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-UwunFtXcP4aITXC8es7Tag-1; Tue, 21 Jan 2020 09:16:06 -0500
X-MC-Unique: UwunFtXcP4aITXC8es7Tag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0A72800D4C;
        Tue, 21 Jan 2020 14:16:04 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4004F5DA60;
        Tue, 21 Jan 2020 14:16:02 +0000 (UTC)
Subject: Re: [PATCH] x86/iperm: remove unused pointers
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org
References: <1579596054-254032-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4c29cfaa-6b86-aeb5-7d81-f1f663f6f154@redhat.com>
Date:   Tue, 21 Jan 2020 09:16:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1579596054-254032-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/20 3:40 AM, Alex Shi wrote:
> No one use the prev/next pointers in its function after commit 22fe5b0439dd
> ("x86/ioperm: Move TSS bitmap update to exit to user work"). So better to
> remove them.
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Thomas Gleixner <tglx@linutronix.de> 
> Cc: Ingo Molnar <mingo@redhat.com> 
> Cc: Borislav Petkov <bp@alien8.de> 
> Cc: "H. Peter Anvin" <hpa@zytor.com> 
> Cc: x86@kernel.org 
> Cc: Andy Lutomirski <luto@kernel.org> 
> Cc: Rik van Riel <riel@surriel.com> 
> Cc: Dave Hansen <dave.hansen@intel.com> 
> Cc: Waiman Long <longman@redhat.com> 
> Cc: Marcelo Tosatti <mtosatti@redhat.com> 
> Cc: linux-kernel@vger.kernel.org 
> ---
>  arch/x86/kernel/process.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 61e93a318983..839b5244e3b7 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -615,12 +615,8 @@ void speculation_ctrl_update_current(void)
>  
>  void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
>  {
> -	struct thread_struct *prev, *next;
>  	unsigned long tifp, tifn;
>  
> -	prev = &prev_p->thread;
> -	next = &next_p->thread;
> -
>  	tifn = READ_ONCE(task_thread_info(next_p)->flags);
>  	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
>  

Acked-by: Waiman Long <longman@redhat.com>

