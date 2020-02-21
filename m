Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24B0C35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E2D2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjzTvRtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgBUQFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:05:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23993 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728130AbgBUQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582301102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b/XFBGDvO3UXFNECW6P4x7ADbFivKxUA9DrB33OKpco=;
        b=WjzTvRtKzRTq5zsdb4tDRrs26r0IxpM+lx6E1er697xfHJ+XO8V2YQ4BMLJ/w56Sw0BIot
        it09RaVOZd00/Sr4YmYIdwp3DXSiy8PsG1haPUQznYbPcByQalDxFIwCBZlJQf2t5h123A
        STYZv5aX80tAd2OiBq65wAV3sXcWohM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-GZPzp5fqM1OzzsI9NDh1EQ-1; Fri, 21 Feb 2020 11:05:00 -0500
X-MC-Unique: GZPzp5fqM1OzzsI9NDh1EQ-1
Received: by mail-wr1-f71.google.com with SMTP id p8so1221090wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b/XFBGDvO3UXFNECW6P4x7ADbFivKxUA9DrB33OKpco=;
        b=B6HoheHgY/hcqFNLatwRzUXYx3xdV5N45ixMxvHtlrkRwZsk72uXKw5ZKgeKERrCRp
         xEldtnzdNADn3ZAzsKCiOqPLDH9WurjHjI/3w5W5tRULDexQXuQtmYkcQ0zcJehXn2cp
         LCUXxrI1yg9XfpyBL1VBWI0fxihtxCCuUgwr3k9TcnSF6uC21Z4Hfqqb2BwcMgYCjdNe
         HZXpYXZMNmU9qbaFQwQg4FHemtyGPkc6UQyvyeEY9XmI0QDpW2GxSyHn1jpe+dtf1vN1
         6mDxejd14wpa0ZTVM0vDBtVolULOwAOPH8nFkB29br90uF04OUgiYuTS5K52/Avqwzih
         m5ow==
X-Gm-Message-State: APjAAAXfVgfqRt1dSVJGEXYcMfxhDPHV7I7JKD1uQNyiCh9Ya+VGCDyp
        AScyH2A8WHy1hQAkXHymE8v3qC/JswJtUdk4ymitSvvX1GXi//dP4zjwHN8fhpXgNpO4yroprvl
        TacrMjkbsaE7iUlBRQzzQHdab
X-Received: by 2002:adf:c453:: with SMTP id a19mr49870841wrg.341.1582301097009;
        Fri, 21 Feb 2020 08:04:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcNZy47AONFyMZVt1Po1fABbweri3/gLj6WIymqQWTWEqb3bitDkuCMdiuyDTbVITIsZ7gWA==
X-Received: by 2002:adf:c453:: with SMTP id a19mr49870335wrg.341.1582301089399;
        Fri, 21 Feb 2020 08:04:49 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
        by smtp.gmail.com with ESMTPSA id 25sm4424881wmi.32.2020.02.21.08.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 08:04:48 -0800 (PST)
Subject: Re: [PATCH] kvm: x86: svm: Fix NULL pointer dereference when AVIC not
 enabled
To:     Alex Williamson <alex.williamson@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, joro@8bytes.org,
        jon.grimm@amd.com
References: <1582296737-13086-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20200221083934.3ed38014@x1.home>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bad78ab6-45b6-5d8d-be36-2ff18a5373a2@redhat.com>
Date:   Fri, 21 Feb 2020 17:04:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200221083934.3ed38014@x1.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/20 16:39, Alex Williamson wrote:
> On Fri, 21 Feb 2020 08:52:17 -0600
> Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:
> 
>> Launching VM w/ AVIC disabled together with pass-through device
>> results in NULL pointer dereference bug with the following call trace.
>>
>>     RIP: 0010:svm_refresh_apicv_exec_ctrl+0x17e/0x1a0 [kvm_amd]
>>
>>     Call Trace:
>>      kvm_vcpu_update_apicv+0x44/0x60 [kvm]
>>      kvm_arch_vcpu_ioctl_run+0x3f4/0x1c80 [kvm]
>>      kvm_vcpu_ioctl+0x3d8/0x650 [kvm]
>>      do_vfs_ioctl+0xaa/0x660
>>      ? tomoyo_file_ioctl+0x19/0x20
>>      ksys_ioctl+0x67/0x90
>>      __x64_sys_ioctl+0x1a/0x20
>>      do_syscall_64+0x57/0x190
>>      entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> Investigation shows that this is due to the uninitialized usage of
>> struct vapu_svm.ir_list in the svm_set_pi_irte_mode(), which is
>> called from svm_refresh_apicv_exec_ctrl().
>>
>> The ir_list is initialized only if AVIC is enabled. So, fixes by
>> adding a check if AVIC is enabled in the svm_refresh_apicv_exec_ctrl().
>>
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=206579
>> Fixes: 8937d762396d ("kvm: x86: svm: Add support to (de)activate posted interrupts.")
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> ---
>>  arch/x86/kvm/svm.c | 3 +++
>>  1 file changed, 3 insertions(+)
> 
> Works for me, thanks Suravee!
> 
> Tested-by: Alex Williamson <alex.williamson@redhat.com>
> 
>>
>> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
>> index 19035fb..1858455 100644
>> --- a/arch/x86/kvm/svm.c
>> +++ b/arch/x86/kvm/svm.c
>> @@ -5222,6 +5222,9 @@ static void svm_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
>>  	struct vmcb *vmcb = svm->vmcb;
>>  	bool activated = kvm_vcpu_apicv_active(vcpu);
>>  
>> +	if (!avic)
>> +		return;
>> +
>>  	if (activated) {
>>  		/**
>>  		 * During AVIC temporary deactivation, guest could update
> 

Thanks to both of you.  I'll get it to Linus next Monday.

Paolo

