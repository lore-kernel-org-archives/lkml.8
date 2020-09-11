Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1610C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F53A221E3
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJTZLEjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgIKH5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgIKH5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:57:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0E4C061756
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:57:34 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q4so1319646pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=D68YRpGe41uJ8+gFVfMwX0RCIFPEEX/t0OhKoAuLKXc=;
        b=lJTZLEjJEy0HzJ0cIARU4N8+44CV3NNjEz0dKZlMU89mCjRyRRq51QF8nmrKTchrPi
         pTt8dD+SDsn7OUoRlL1Rr0S1Qq6nPCSpemStoTw3aGTR6Eu2BRbiZUVb+yAJLbTIbqng
         jj3Qds88FIyOJBmxN+5hh2Fg6vjJpwkd4glIp4G7P9fed5lbJf0bwazJ+NkZRuEDe9Y0
         UUu5Ja9YVkKAjkNBP4pDmBqoDt5cPW7uSE3yri2/19xLmIylukiUWHukXaaFb5k/PKbZ
         EPULBUiiFi1SoqUqdnUslSw01ZEhG/DXqV4Z7gaD/NADBFBWtDLGVv0Lcx3TfxDMKKet
         k1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=D68YRpGe41uJ8+gFVfMwX0RCIFPEEX/t0OhKoAuLKXc=;
        b=qNm2rTiDPaRhD00dTcHbl2+IdQnVQPUhDHpj0swHrwEgczkkBn3kKh79qj9lDo4p5D
         dLKvclXWYUmRO0uD8KH7acSxEzZgRynaJUqvPDm+RTc/aT1kihaiaVzmM0Y2+hPQTkwz
         qUMm7mknz2cjhXPrgRRU+GSF3ZyH5hG6N3gEEFep7pOWdhJUP65hqRJrnuqgKeqJlevL
         MkUdLobaG1+bBzu1GgUrYhZdUTYgc0X4pNFaYNjTb1PIj5efu3XrwwaF/DZsf7Ii4e9c
         iqBKKxPCeS2KG7X2uF1QwnvZvriOVbfsGU+scQlkgLX7lg4MZkd2f3K3faXhhL7Je6XK
         jK6A==
X-Gm-Message-State: AOAM533A0GmAnlDp0U4siPMhXY5CSNkOhR7nr5ewZyZjRfhgKPtLxuyq
        7gvVjc+SzXwO3S/gpxivZeYmLA==
X-Google-Smtp-Source: ABdhPJw2e/NDEf8sEec/hL+0GhrxGhLwxTY+Q3W8tV8tDAOo79Alu00023BhM4cVcfk+4/R9Yw+60g==
X-Received: by 2002:a17:90a:f992:: with SMTP id cq18mr1124575pjb.172.1599811054028;
        Fri, 11 Sep 2020 00:57:34 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id m5sm1190506pjn.19.2020.09.11.00.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 00:57:33 -0700 (PDT)
Date:   Fri, 11 Sep 2020 00:57:32 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
cc:     Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kvm@vger.kernel.org
Subject: Re: [patch] KVM: SVM: Periodically schedule when unregistering
 regions on destroy
In-Reply-To: <alpine.DEB.2.23.453.2008251255240.2987727@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.23.453.2009110057300.3797679@chino.kir.corp.google.com>
References: <alpine.DEB.2.23.453.2008251255240.2987727@chino.kir.corp.google.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo, ping?

On Tue, 25 Aug 2020, David Rientjes wrote:

> There may be many encrypted regions that need to be unregistered when a
> SEV VM is destroyed.  This can lead to soft lockups.  For example, on a
> host running 4.15:
> 
> watchdog: BUG: soft lockup - CPU#206 stuck for 11s! [t_virtual_machi:194348]
> CPU: 206 PID: 194348 Comm: t_virtual_machi
> RIP: 0010:free_unref_page_list+0x105/0x170
> ...
> Call Trace:
>  [<0>] release_pages+0x159/0x3d0
>  [<0>] sev_unpin_memory+0x2c/0x50 [kvm_amd]
>  [<0>] __unregister_enc_region_locked+0x2f/0x70 [kvm_amd]
>  [<0>] svm_vm_destroy+0xa9/0x200 [kvm_amd]
>  [<0>] kvm_arch_destroy_vm+0x47/0x200
>  [<0>] kvm_put_kvm+0x1a8/0x2f0
>  [<0>] kvm_vm_release+0x25/0x30
>  [<0>] do_exit+0x335/0xc10
>  [<0>] do_group_exit+0x3f/0xa0
>  [<0>] get_signal+0x1bc/0x670
>  [<0>] do_signal+0x31/0x130
> 
> Although the CLFLUSH is no longer issued on every encrypted region to be
> unregistered, there are no other changes that can prevent soft lockups for
> very large SEV VMs in the latest kernel.
> 
> Periodically schedule if necessary.  This still holds kvm->lock across the
> resched, but since this only happens when the VM is destroyed this is
> assumed to be acceptable.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  arch/x86/kvm/svm/sev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1106,6 +1106,7 @@ void sev_vm_destroy(struct kvm *kvm)
>  		list_for_each_safe(pos, q, head) {
>  			__unregister_enc_region_locked(kvm,
>  				list_entry(pos, struct enc_region, list));
> +			cond_resched();
>  		}
>  	}
>  
> 
