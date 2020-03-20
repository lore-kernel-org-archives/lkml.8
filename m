Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178CBC43332
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E081820663
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfeTpFNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgCTRtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:49:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45008 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726866AbgCTRtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584726559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQ/kl3k3iNBv74F3FBzAiK43NBYNWmyKSIiqcjfF37g=;
        b=GfeTpFNLVaQOXDwzsml7AjmudVp4xa4k7nOXQHufMai2mPN9N+DNc5xFYvMlQ6PKix+9s6
        7bKqxCWUP8pWZTb2hJw+KRWvkO+heTFHIjvAmnft09PJbDJMpLE2ENOYgYonBHQs4yg+tf
        DL/JGS+JEfrvn9MU2HghHk7F6mE2D8Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-cJMuLDRgMdu5-gK9KeiU1A-1; Fri, 20 Mar 2020 13:49:18 -0400
X-MC-Unique: cJMuLDRgMdu5-gK9KeiU1A-1
Received: by mail-wr1-f71.google.com with SMTP id d17so2968964wrw.19
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 10:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TQ/kl3k3iNBv74F3FBzAiK43NBYNWmyKSIiqcjfF37g=;
        b=pt9VDpd6C0zrBKBKrdsI5FAyOBY21eDLnI9As1aPVB0ZkULKXlpQx4cDZS7EEObikW
         kxKZrDoRMhJyIIv0PPd3bKRnofR/fHPZ+qShaCyjik6gn1mM8wX1ml3FgL8vhHTivKb7
         7iv4V6DHVuVhprQzlvK66TyV3jtz+iNe9qtFuPr/ARc6Gf8hW+zapLMmY7e9jGy1sy5d
         CxCMWgCWH1lI4XCpAoVgltobCgNFlD20CqiVzVAJ7T2OmDX4k0/QHII6V3KsI8fGE+1C
         x0MdYH9+NFTRlIahs0cDICL3CFOqBCmzj14bwGgQQQ0Cbo9KPye0YB1Dkc2rMgbTvFFP
         0JGQ==
X-Gm-Message-State: ANhLgQ0QNjejSrAOuaT0rKl653mZhlsCa7RC6Aes2wiqJv+VJ43QSu1c
        uvTdOUNrARIZMUTg5mf/X3hPjFb4aXSpK/rusnN8PwMu+4BtRXuWvSzYjIkU9mX4fsWI43kpMTE
        6LvD5elGerMbmB5hLfuWIw41J
X-Received: by 2002:a5d:5386:: with SMTP id d6mr5030754wrv.92.1584726555537;
        Fri, 20 Mar 2020 10:49:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuwrpJCSjtnao11u4mVs5NZYw5SWprvWCKktGMDqGolsFu1I3ESvR7jqa9fFsBJmL82OAvWKg==
X-Received: by 2002:a5d:5386:: with SMTP id d6mr5030716wrv.92.1584726555252;
        Fri, 20 Mar 2020 10:49:15 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
        by smtp.gmail.com with ESMTPSA id y11sm9198156wrd.65.2020.03.20.10.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 10:49:14 -0700 (PDT)
Subject: Re: [PATCH] KVM: LAPIC: Mark hrtimer for period or oneshot mode to
 expire in hard interrupt context
To:     zhe.he@windriver.com, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org
References: <1584687967-332859-1-git-send-email-zhe.he@windriver.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a2eb9c9e-b8db-6d17-82b2-70014324f02a@redhat.com>
Date:   Fri, 20 Mar 2020 18:49:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584687967-332859-1-git-send-email-zhe.he@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/20 08:06, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> apic->lapic_timer.timer was initialized with HRTIMER_MODE_ABS_HARD but
> started later with HRTIMER_MODE_ABS, which may cause the following warning
> in PREEMPT_RT kernel.
> 
> WARNING: CPU: 1 PID: 2957 at kernel/time/hrtimer.c:1129 hrtimer_start_range_ns+0x348/0x3f0
> CPU: 1 PID: 2957 Comm: qemu-system-x86 Not tainted 5.4.23-rt11 #1
> Hardware name: Supermicro SYS-E300-9A-8C/A2SDi-8C-HLN4F, BIOS 1.1a 09/18/2018
> RIP: 0010:hrtimer_start_range_ns+0x348/0x3f0
> Code: 4d b8 0f 94 c1 0f b6 c9 e8 35 f1 ff ff 4c 8b 45
>       b0 e9 3b fd ff ff e8 d7 3f fa ff 48 98 4c 03 34
>       c5 a0 26 bf 93 e9 a1 fd ff ff <0f> 0b e9 fd fc ff
>       ff 65 8b 05 fa b7 90 6d 89 c0 48 0f a3 05 60 91
> RSP: 0018:ffffbc60026ffaf8 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: ffff9d81657d4110 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000006cc7987bcf RDI: ffff9d81657d4110
> RBP: ffffbc60026ffb58 R08: 0000000000000001 R09: 0000000000000010
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000006cc7987bcf
> R13: 0000000000000000 R14: 0000006cc7987bcf R15: ffffbc60026d6a00
> FS: 00007f401daed700(0000) GS:ffff9d81ffa40000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000ffffffff CR3: 0000000fa7574000 CR4: 00000000003426e0
> Call Trace:
> ? kvm_release_pfn_clean+0x22/0x60 [kvm]
> start_sw_timer+0x85/0x230 [kvm]
> ? vmx_vmexit+0x1b/0x30 [kvm_intel]
> kvm_lapic_switch_to_sw_timer+0x72/0x80 [kvm]
> vmx_pre_block+0x1cb/0x260 [kvm_intel]
> ? vmx_vmexit+0xf/0x30 [kvm_intel]
> ? vmx_vmexit+0x1b/0x30 [kvm_intel]
> ? vmx_vmexit+0xf/0x30 [kvm_intel]
> ? vmx_vmexit+0x1b/0x30 [kvm_intel]
> ? vmx_vmexit+0xf/0x30 [kvm_intel]
> ? vmx_vmexit+0x1b/0x30 [kvm_intel]
> ? vmx_vmexit+0xf/0x30 [kvm_intel]
> ? vmx_vmexit+0xf/0x30 [kvm_intel]
> ? vmx_vmexit+0x1b/0x30 [kvm_intel]
> ? vmx_vmexit+0xf/0x30 [kvm_intel]
> ? vmx_vmexit+0x1b/0x30 [kvm_intel]
> ? vmx_vmexit+0xf/0x30 [kvm_intel]
> ? vmx_vmexit+0x1b/0x30 [kvm_intel]
> ? vmx_vmexit+0xf/0x30 [kvm_intel]
> ? vmx_vmexit+0x1b/0x30 [kvm_intel]
> ? vmx_vmexit+0xf/0x30 [kvm_intel]
> ? vmx_sync_pir_to_irr+0x9e/0x100 [kvm_intel]
> ? kvm_apic_has_interrupt+0x46/0x80 [kvm]
> kvm_arch_vcpu_ioctl_run+0x85b/0x1fa0 [kvm]
> ? _raw_spin_unlock_irqrestore+0x18/0x50
> ? _copy_to_user+0x2c/0x30
> kvm_vcpu_ioctl+0x235/0x660 [kvm]
> ? rt_spin_unlock+0x2c/0x50
> do_vfs_ioctl+0x3e4/0x650
> ? __fget+0x7a/0xa0
> ksys_ioctl+0x67/0x90
> __x64_sys_ioctl+0x1a/0x20
> do_syscall_64+0x4d/0x120
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f4027cc54a7
> Code: 00 00 90 48 8b 05 e9 59 0c 00 64 c7 00 26 00 00
>       00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00
>       00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff
>       73 01 c3 48 8b 0d b9 59 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007f401dae9858 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00005558bd029690 RCX: 00007f4027cc54a7
> RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000000000000d
> RBP: 00007f4028b72000 R08: 00005558bc829ad0 R09: 00000000ffffffff
> R10: 00005558bcf90ca0 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 00005558bce1c840
> --[ end trace 0000000000000002 ]--
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  arch/x86/kvm/lapic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index e3099c6..929511e 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1715,7 +1715,7 @@ static void start_sw_period(struct kvm_lapic *apic)
>  
>  	hrtimer_start(&apic->lapic_timer.timer,
>  		apic->lapic_timer.target_expiration,
> -		HRTIMER_MODE_ABS);
> +		HRTIMER_MODE_ABS_HARD);
>  }
>  
>  bool kvm_lapic_hv_timer_in_use(struct kvm_vcpu *vcpu)
> 

Queued, thanks.

Paolo

