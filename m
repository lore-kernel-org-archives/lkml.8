Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90710C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1E420752
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XynwaO9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbgEDQru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 12:47:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33291 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729643AbgEDQrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588610868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mqG4NiZOzEfqHtOMWsB/ZvHqz1Pp83h0dHQmV0QkakI=;
        b=XynwaO9iMmA6NFsjGHQICXwaz+gS9BdigwUMsaTch2oeJdu8XLMsyeYnlJ680DBcmDG2fL
        N0M+sXfBeY18kHQ3w7QZ+b5lks2KlFdJG6/NxGPPpsQgKsNMJSMHAymxo0zuzqkhCcZ9l5
        qoW3m3YKC9sVu3ovCu+RioQyUo8KV2k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-wlbjV_jAOcK_KhmpkK5-yA-1; Mon, 04 May 2020 12:47:46 -0400
X-MC-Unique: wlbjV_jAOcK_KhmpkK5-yA-1
Received: by mail-wm1-f69.google.com with SMTP id h184so97762wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 09:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mqG4NiZOzEfqHtOMWsB/ZvHqz1Pp83h0dHQmV0QkakI=;
        b=Vjrjp3mjpvUSiVoZpM+TPlYmPGZn4ipbCiU8CPntP3EHY9IT1NiHNdAo+oN5q0StGg
         3NNI7FTTy+QXEZ+dUIvA1SWXfYgMe7zPpaz54Nt7RhzeYtYa5QbzC7y1bH5yxPfywoER
         FsIy5A1eG5jG0lPyICPknNikQGujmLxUpb4MLXzwAn59Sa80QPZjUoeEkduqIpiqGlm4
         dz5ZHxBtDN3p+/FtoBo7FBHVeoTf3xg5fRKBJIHsTQZAldbpFJtuN5O35uk4BHY8vDRY
         tufwF/MIvGqDXQ1ulP6ri/9Wsq3sUL8R6wd2VNJLVIkU3ozLulH7XtgFXUvycY5PF0wF
         dC6Q==
X-Gm-Message-State: AGi0PuZC7r3MNpPNsxlEzVp0NQRMt89hao3Gb6vpCEndODaJYQpYH/u0
        RHmP1OSGEMZX+Xq3YfZ2bB5HcONGtCBBt4eZufKe1DIPwcotHqlHFbt2eAUSeAyEg6MmuSVw4xD
        3qGU3g2JV/uvtsQZZrZgb1onp
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr15413158wmd.67.1588610865738;
        Mon, 04 May 2020 09:47:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypLDRC0oKvIrSTpQybtrO+sKCnZxuLzQYC4jjIPDre77gM0GB81TEH4UGwNEonZVOzx3VaVo3w==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr15413134wmd.67.1588610865542;
        Mon, 04 May 2020 09:47:45 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id a9sm40312wmm.38.2020.05.04.09.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 09:47:45 -0700 (PDT)
Subject: Re: [PATCH] x86: Fix RCU list usage to avoid false positive warnings
To:     madhuparnabhowmik10@gmail.com, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, bhelgaas@google.com,
        sean.j.christopherson@intel.com, cai@lca.pw, paulmck@kernel.org,
        joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        frextrite@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-pci@vger.kernel.org
References: <20200430192932.13371-1-madhuparnabhowmik10@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c992b7f-c6c7-44a6-fa5a-c3512646de05@redhat.com>
Date:   Mon, 4 May 2020 18:47:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200430192932.13371-1-madhuparnabhowmik10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/20 21:29, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> Use list_for_each_entry() instead of list_for_each_entry_rcu() whenever
> spinlock or mutex is always held.
> Otherwise, pass cond to list_for_each_entry_rcu().
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> ---
>  arch/x86/kernel/nmi.c          | 2 +-
>  arch/x86/kvm/irq_comm.c        | 3 ++-
>  arch/x86/pci/mmconfig-shared.c | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index 6407ea21fa1b..999dc6c134d2 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -195,7 +195,7 @@ void unregister_nmi_handler(unsigned int type, const char *name)
>  
>  	raw_spin_lock_irqsave(&desc->lock, flags);
>  
> -	list_for_each_entry_rcu(n, &desc->head, list) {
> +	list_for_each_entry(n, &desc->head, list) {
>  		/*
>  		 * the name passed in to describe the nmi handler
>  		 * is used as the lookup key
> diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
> index c47d2acec529..5b88a648e079 100644
> --- a/arch/x86/kvm/irq_comm.c
> +++ b/arch/x86/kvm/irq_comm.c
> @@ -258,7 +258,8 @@ void kvm_fire_mask_notifiers(struct kvm *kvm, unsigned irqchip, unsigned pin,
>  	idx = srcu_read_lock(&kvm->irq_srcu);
>  	gsi = kvm_irq_map_chip_pin(kvm, irqchip, pin);
>  	if (gsi != -1)
> -		hlist_for_each_entry_rcu(kimn, &kvm->arch.mask_notifier_list, link)
> +		hlist_for_each_entry_rcu(kimn, &kvm->arch.mask_notifier_list, link,
> +					srcu_read_lock_held(&kvm->irq_srcu))
>  			if (kimn->irq == gsi)
>  				kimn->func(kimn, mask);
>  	srcu_read_unlock(&kvm->irq_srcu, idx);
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index 6fa42e9c4e6f..a096942690bd 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -797,7 +797,7 @@ int pci_mmconfig_delete(u16 seg, u8 start, u8 end)
>  	struct pci_mmcfg_region *cfg;
>  
>  	mutex_lock(&pci_mmcfg_lock);
> -	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list)
> +	list_for_each_entry(cfg, &pci_mmcfg_list, list)
>  		if (cfg->segment == seg && cfg->start_bus == start &&
>  		    cfg->end_bus == end) {
>  			list_del_rcu(&cfg->list);
> 

For KVM parts, if the x86 maintainers want to apply the whole patch,

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

